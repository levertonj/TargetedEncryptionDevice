#include "eth_ocm_phy.h"
#include <stdio.h>

static eth_ocm_phy_profile* eth_ocm_phy_profile_array[ETH_OCM_PHY_MAX_PROFILES] = {0}; 

static int eth_ocm_wait(int base);

void eth_ocm_set_phy_addr(int base, int phyad, int reg){
    phyad &= ETH_OCM_MIIADDRESS_FIAD_MSK; 
    reg = reg << ETH_OCM_MIIADDRESS_RGAD_OFST; 
    reg &= ETH_OCM_MIIADDRESS_RGAD_MSK;
    phyad |= reg;
    IOWR_ETH_OCM_MIIADDRESS(base, phyad); 
}

void eth_ocm_write_phy_reg(int base, int phyad, int reg, int data){
    eth_ocm_set_phy_addr(base, phyad, reg);
    IOWR_ETH_OCM_MIITX_DATA(base, data);
    IOWR_ETH_OCM_MIICOMMAND(base, ETH_OCM_MIICOMMAND_WCTRLDATA_MSK);
    eth_ocm_wait(base);
}

int  eth_ocm_read_phy_reg(int base, int phyad, int reg){
    int result;

    eth_ocm_set_phy_addr(base, phyad, reg);
    IOWR_ETH_OCM_MIICOMMAND(base, ETH_OCM_MIICOMMAND_RSTAT_MSK);
    eth_ocm_wait(base);
    result = IORD_ETH_OCM_MIIRX_DATA(base);
    return result;
}

int eth_ocm_phy_add_profile(eth_ocm_phy_profile *profile){
    int i;
    i = 0;

    for(i=0;i<ETH_OCM_PHY_MAX_PROFILES;i++){
        if(eth_ocm_phy_profile_array[i] == 0){
            eth_ocm_phy_profile_array[i] = profile;
            i = ETH_OCM_PHY_MAX_PROFILES;
            return 0;
        }
    }

    return -1;
}

static int eth_ocm_wait(int base){
    int temp;
    int i;
    i = 0;
    temp = 1;
    while(temp && i<1000){
        temp = IORD_ETH_OCM_MIISTATUS(base);
        #if(ETH_OCM_DBG_LVL > 0)
        if(temp & ETH_OCM_MIISTATUS_NVALID_MSK)
            printf("Invalid bit set in MII Status register\n");
        #endif
        temp &= ETH_OCM_MIISTATUS_BUSY_MSK;
        i++;
    }

    #if(ETH_OCM_DBG_LVL > 0)
    if(i == 1000)
        printf("[eth_ocm_set_phy_reg] Failed waiting for MII module to be ready!\n");
    #endif
        
    return temp;
    
}

/**
 * Performs PHY initialization and determines link duplex.
 * This is fully vendor specific depending on the PHY you are using.
 *
 * @param  dev Pointer to eth_ocm_dev struct which contains needed base address
 * @return 1 if Link is established in Full duplex.
 *         0 if Link is established in Half duplex.
 */
int eth_ocm_phy_init(eth_ocm_dev *dev){
    int duplex;     /* 1 = full ; 0 = half*/
    int phyid;
    int phyid2;
    int oui;    // PHY organizationally unique ID
    int mdl;    // PHY model
    int rev;    // PHY rev
    int dat;
    int phyadd;
    int base;
    int found;
    eth_ocm_phy_profile *profile;
    // determine PHY speed: This is PHY dependent and you need to change
    // this according to your PHY's specifications
    duplex = 1;
    dat = 0;
    found = 0;
    base = dev->base;

    // Add internal PHY profiles
    eth_ocm_phy_profiles_init();

    // ------------------------------
    // PHY detection
    // ------------------------------
    phyid = eth_ocm_read_phy_reg(base, dat, ETH_OCM_PHY_ADDR_PHY_ID1);
    for (dat = 0x00; dat < 0xff; dat++){
        phyid = eth_ocm_read_phy_reg(base, dat, ETH_OCM_PHY_ADDR_PHY_ID1);
        phyid2 = eth_ocm_read_phy_reg(base, dat, ETH_OCM_PHY_ADDR_PHY_ID2);

        if (phyid != phyid2 && (phyid2 != 0xffff)){ // Found the PHY
            // Extract phy info
            oui = phyid << 6;
            oui |= ((phyid2 >> 10) & 0x003F);
            mdl = ((phyid2 >> 4) & 0x03F);
            rev = (phyid2 & 0x000F);
            #if(ETH_OCM_DBG_LVL > 0)
            printf("[eth_ocm_phy_init] Found PHY:\n"
                    "  Address: 0x%x\n"
                    "  OUI: 0x%x\n"
                    "  Model: 0x%x\n"
                    "  Rev: 0x%x\n",
                    dat, oui, mdl, rev);
            #endif
            phyadd = dat;
            dat = 0xff; // end loop
            found = 1;
        }
    }

    if(!found){
        #if(ETH_OCM_DBG_LVL > 0)
        printf("[eth_ocm_phy_init] NO PHY FOUND!\n");
        #endif
        return 0;
    }


    // A PHY was found, let's move on
    // Lookup PHY in table
    found = 0;
    for(dat=0;(dat<ETH_OCM_PHY_MAX_PROFILES) && (eth_ocm_phy_profile_array[dat] != 0); dat++){
        profile = eth_ocm_phy_profile_array[dat];
        // We compare oui & model number but not rev.
        if( (profile->oui == oui) && (profile->model_number == mdl)){
            // Found a match in the table
            found = 1;
            #if(ETH_OCM_DBG_LVL > 0)
            printf("[eth_ocm_phy_init] Found PHY: %s\n", profile->name);
            #endif
        }
    }

    if(!found){
        #if(ETH_OCM_DBG_LVL > 0)
        printf("[eth_ocm_phy_init] Could not find matching PHY profile!\n");
        #endif
        return 0;
    }

    dev->phyadd = phyadd;
    // Call the config function if provided
    if(profile->phy_cfg != NULL)
        profile->phy_cfg(dev);

    // Issue a PHY reset here and wait for the link
    // autonegotiation complete again... this takes several SECONDS(!)
    // so be very careful not to do it frequently
/*
    // perform this when PHY is configured in loopback or has no link yet.
    if( ((eth_ocm_read_phy_reg(base, phyadd, ETH_OCM_PHY_ADDR_CONTROL)& PCS_CTL_rx_slpbk) != 0) ||
         ((eth_ocm_read_phy_reg(base, phyadd, ETH_OCM_PHY_ADDR_STATUS) & PCS_ST_an_done) == 0) ) {
        eth_ocm_write_phy_reg(base, phyadd, ETH_OCM_PHY_ADDR_CONTROL,PCS_CTL_an_enable | PCS_CTL_sw_reset);    // send PHY reset command
        dprintf("[eth_ocm_phy_init] PHY Reset\n" );
    }
    */
    
    if(!(eth_ocm_read_phy_reg(base, phyadd, ETH_OCM_PHY_ADDR_STATUS)& PCS_ST_an_done)) {
        #if(ETH_OCM_DBG_LVL > 0)
        printf("[eth_ocm_phy_init] Waiting on PHY link...");
        #endif
        dat=0;
        while( (eth_ocm_read_phy_reg(base, phyadd, ETH_OCM_PHY_ADDR_STATUS) & PCS_ST_an_done) == 0 ){
            if( dat++ > ETH_OCM_PHY_TIMEOUT_THRESHOLD) {
                #if(ETH_OCM_DBG_LVL > 0)
                printf(" Autoneg FAILED, continuing anyway ...\n");
                #endif
                break;
            }
        }
        #if(ETH_OCM_DBG_LVL > 0)
        printf("OK. x=%d, PHY STATUS=%04x\n",dat, eth_ocm_read_phy_reg(base, phyadd, ETH_OCM_PHY_ADDR_STATUS));
        #endif
    }

    if(profile->duplex_status_read != NULL){
        duplex = profile->duplex_status_read(dev) & 0x01;
    }else{
        dat = eth_ocm_read_phy_reg(base, phyadd, profile->status_reg_location);
        duplex = (dat >> profile->duplex_bit_location) & 0x01;
    }

    #if(ETH_OCM_DBG_LVL > 0)
    printf("[eth_ocm_phy_init] Full Duplex is %d\n", duplex);
    #endif

    return duplex;
}


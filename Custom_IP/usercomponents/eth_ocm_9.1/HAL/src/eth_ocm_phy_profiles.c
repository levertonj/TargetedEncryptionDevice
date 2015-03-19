#include "eth_ocm_phy.h"

// ********************
// Intel LXT972A 10/100
// ********************
#ifdef ETH_OCM_PHY_SUPPORT_LXT972A
static eth_ocm_phy_profile profile_LXT972A = {
    /* PHY name */
	"Intel/Cortina Systems LXT972A 10/100 PHY",
	/* PHY OUI (Organizationally Unique Identififier) */
	0x04DE,
	/* PHY model number */
	0x0E,
	/* PHY revision number */
	0x02,
	/* Location of PHY Specific Status Register */
	0x11,
	/* Location of Duplex Status bit in PHY Specific Status Register */
	0x09,
	/* Function pointer to execute additional initialization */
	NULL,
	/* Function pointer to read duplex status */
	NULL
};
#endif


// ***************
// Marvell 88E1111
// ***************
#ifdef ETH_OCM_PHY_SUPPORT_MVL88E1111
static alt_32 phy_cfg_MVL88E1111(eth_ocm_dev *dev){
    int duplex;     /* 1 = full ; 0 = half*/
    int dat;
    int phyadd;
    int base;

    duplex = 1;
    dat = 0;
    phyadd = 0;
    base = dev->base;
    phyadd = dev->phyadd;

    // Disable 1000BASE-T Autonegotiation
    dat = eth_ocm_read_phy_reg(base, phyadd, 0x09);
    dat &= 0xFCFF;
    eth_ocm_write_phy_reg(base, phyadd, 0x09, dat);    
    // Restart autonegotiation
    dat = eth_ocm_read_phy_reg(base, phyadd, ETH_OCM_PHY_ADDR_CONTROL);
    dat |=  PCS_CTL_an_restart;
    eth_ocm_write_phy_reg(base, phyadd, ETH_OCM_PHY_ADDR_CONTROL, dat);
    
    return 0;
}

static eth_ocm_phy_profile profile_MVL88E1111 = {
	/* PHY name */
	"Marvell 88E1111 10/100/1000 PHY",
	/* PHY OUI (Organizationally Unique Identififier) */
	0x005043,
	/* PHY model number */
	0x0c,
	/* PHY revision number */
	0x02,
	/* Location of PHY Specific Status Register */
	0x11,
	/* Location of Duplex Status bit in PHY Specific Status Register */
	13,
	/* Function pointer to execute additional initialization */
	phy_cfg_MVL88E1111,
	/* Function pointer to read duplex status */
	NULL
};
#endif // ifdef ETH_OCM_PHY_SUPPORT_MVL88E1111

#ifdef ETH_OCM_PHY_SUPPORT_DP83848C
static eth_ocm_phy_profile profile_DP83848C = {
	/* PHY name */
	"National DP83848C 10/100 PHY",
	/* PHY OUI (Organizationally Unique Identififier) */
	0x080017,
	/* PHY model number */
	0x09,
	/* PHY revision number */
	0x00,
	/* Location of PHY Specific Status Register */
	0x10,
	/* Location of Duplex Status bit in PHY Specific Status Register */
	0x02,
	/* Function pointer to execute additional initialization */
	NULL,
	/* Function pointer to read duplex status */
	NULL
};
#endif


// ***************
// Vitesse VCS8641
// ***************
#ifdef ETH_OCM_PHY_SUPPORT_VSC8641
static alt_32 phy_cfg_VSC8641(eth_ocm_dev *dev){
    int duplex;     /* 1 = full ; 0 = half*/
    int dat;
    int phyadd;
    int base;
    // determine PHY speed: This is PHY dependent and you need to change
    // this according to your PHY's specifications
    duplex = 1;
    dat = 0;
    phyadd = 0;
    base = dev->base;
    phyadd = dev->phyadd;

    // Run required script (Vitesse screw-up)
    eth_ocm_write_phy_reg(base, phyadd, 31, 0x52B5);
    eth_ocm_write_phy_reg(base, phyadd, 16, 0xAF8A);
        
    eth_ocm_write_phy_reg(base, phyadd, 18, 0x0000);

    dat = eth_ocm_read_phy_reg(base, phyadd, 17);
    dat = (dat & ~0x000C) | 0x0008;
    eth_ocm_write_phy_reg(base, phyadd, 17, dat);

    eth_ocm_write_phy_reg(base, phyadd, 16, 0x8F8A);
    eth_ocm_write_phy_reg(base, phyadd, 16, 0xAF86);

    dat = eth_ocm_read_phy_reg(base, phyadd, 18);
    dat = (dat & ~0x000C) | 0x0008;
    eth_ocm_write_phy_reg(base, phyadd, 18, dat);

    eth_ocm_write_phy_reg(base, phyadd, 17, 0x0000);

    eth_ocm_write_phy_reg(base, phyadd, 16, 0x8F86);
    eth_ocm_write_phy_reg(base, phyadd, 16, 0xAF82);

    eth_ocm_write_phy_reg(base, phyadd, 18, 0x0000);

    dat = eth_ocm_read_phy_reg(base, phyadd, 17);
    dat = (dat & ~0x0180) | 0x0100;
    eth_ocm_write_phy_reg(base, phyadd, 17, dat);

    eth_ocm_write_phy_reg(base, phyadd, 16, 0x8F82);
    eth_ocm_write_phy_reg(base, phyadd, 31, 0x0000);
    //End of Vitesse screw-up script

    // Disable 1000BASE-T Autonegotiation
    dat = eth_ocm_read_phy_reg(base, phyadd, 0x09);
    dat &= 0xFCFF;
    eth_ocm_write_phy_reg(base, phyadd, 0x09, dat);    
    // Restart autonegotiation
    dat = eth_ocm_read_phy_reg(base, phyadd, ETH_OCM_PHY_ADDR_CONTROL);
    dat |=  PCS_CTL_an_restart;
    eth_ocm_write_phy_reg(base, phyadd, ETH_OCM_PHY_ADDR_CONTROL, dat);

    return 0;
}

static eth_ocm_phy_profile profile_VSC8641 = {
	/* PHY name */
	"Vitesse VSC8641 10/100/1000 PHY",
	/* PHY OUI (Organizationally Unique Identififier) */
	0x1C1,
	/* PHY model number */
	0x03,
	/* PHY revision number */
	0x01,
	/* Location of PHY Specific Status Register */
	0x1C,
	/* Location of Duplex Status bit in PHY Specific Status Register */
	0x05,
	/* Function pointer to execute additional initialization */
	phy_cfg_VSC8641,
	/* Function pointer to read duplex status */
	NULL
};
 
#endif // ETH_OCM_PHY_SUPPORT_VSC8641

void eth_ocm_phy_profiles_init(){
#ifdef ETH_OCM_PHY_SUPPORT_LXT972A
    eth_ocm_phy_add_profile(&profile_LXT972A);
#endif

#ifdef ETH_OCM_PHY_SUPPORT_MVL88E1111
    eth_ocm_phy_add_profile(&profile_MVL88E1111);
#endif

#ifdef ETH_OCM_PHY_SUPPORT_DP83848C
    eth_ocm_phy_add_profile(&profile_DP83848C);
#endif

#ifdef ETH_OCM_PHY_SUPPORT_VSC8641
    eth_ocm_phy_add_profile(&profile_VSC8641);
#endif
}


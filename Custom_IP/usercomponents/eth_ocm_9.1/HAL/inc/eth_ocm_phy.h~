#ifndef __ETH_OCM_PHY_H__
#define __ETH_OCM_PHY_H__

#include "eth_ocm_regs.h"
#include "eth_ocm.h"

/* Enumeration of commonly-used PHY registers */
#define ETH_OCM_PHY_ADDR_CONTROL    0x0
#define ETH_OCM_PHY_ADDR_STATUS     0x1
#define ETH_OCM_PHY_ADDR_PHY_ID1    0x2
#define ETH_OCM_PHY_ADDR_PHY_ID2    0x3
#define ETH_OCM_PHY_ADDR_ADV        0x4
#define ETH_OCM_PHY_ADDR_PHY_REMADV 0x5

#define ETH_OCM_PHY_TIMEOUT_THRESHOLD   100000

// If the user hasn't specified how many PHY
// types to allow, we'll use 5
#ifndef ETH_OCM_PHY_MAX_PHY_TYPES
    #define ETH_OCM_PHY_MAX_PHY_TYPES   5
#endif

enum {
        PCS_CTL_speed1           = 1<<6,        // speed select
        PCS_CTL_speed0           = 1<<13,       
        PCS_CTL_fullduplex       = 1<<8,        // fullduplex mode select
        PCS_CTL_an_restart       = 1<<9,        // Autonegotiation restart command
        PCS_CTL_isolate          = 1<<10,       // isolate command
        PCS_CTL_powerdown        = 1<<11,       // powerdown command
        PCS_CTL_an_enable        = 1<<12,       // Autonegotiation enable
        PCS_CTL_rx_slpbk         = 1<<14,       // Serial Loopback enable
        PCS_CTL_sw_reset         = 1<<15        // perform soft reset
        
};

/** PCS Status Register Bits. IEEE 801.2 Clause 22.2.4.2
 */
enum {
        PCS_ST_has_extcap   = 1<<0,             // PHY has extended capabilities registers       
        PCS_ST_rx_sync      = 1<<2,             // RX is in sync (8B/10B codes o.k.)
        PCS_ST_an_ability   = 1<<3,             // PHY supports autonegotiation
        PCS_ST_rem_fault    = 1<<4,             // Autonegotiation completed
        PCS_ST_an_done      = 1<<5
        
};

/* PHY structure for PHY detection */
typedef struct eth_ocm_phy_profile_struct{

    /* PHY name - (whatever you want to call it) */
    char name[80];

    /* PHY OUI (Organizationally Unique Identififier) 
     * This is the concatenation of bits [15:0] of register 2 and bits [15:10]
     * of register 3. (i.e. oui = {reg2[15:0],reg3[15:10]})*/
    alt_u32 oui;

    /* PHY model number (Bits[9:4] of register 3)*/
    alt_u8 model_number;

    /* PHY revision number (Bits 3:0] of register 3*/
    alt_u8 revision_number;

    /* Location (register index) of PHY Specific Status Register 
     * (which register will tell us duplex status)*/
    alt_u8 status_reg_location;

    /* Location of Duplex Status bit in PHY Specific Status Register */
    alt_u8 duplex_bit_location;

    /* Function pointer to execute additional initialization. This function 
     * will be called before attempting to discover duplex status. */
    alt_32 (*phy_cfg)(eth_ocm_dev *dev);
	
	/** Function pointer to read the duplex status from the PHY. 
      * Set this function pointer to your own function if the PHY's duplex
      * status cannot be determined using the PHY specific status register
      * and bit locations listed above. This function should return 1 if
      * the PHY is in Full Duplex mode or 0 if Half Duplex.
	  **/
	alt_u32 (*duplex_status_read)(eth_ocm_dev *dev);
    
} eth_ocm_phy_profile;

#ifdef __cplusplus
extern "C" {
#endif

void eth_ocm_set_phy_addr(int base, int phyad, int reg);
void eth_ocm_write_phy_reg(int base, int phyad, int reg, int data);
int  eth_ocm_read_phy_reg(int base, int phyad, int reg);
int  eth_ocm_phy_add_profile(eth_ocm_phy_profile *profile); 
void eth_ocm_phy_profiles_init();

#ifdef __cplusplus
}
#endif



#endif  //__ETH_OCM_PHY_H__

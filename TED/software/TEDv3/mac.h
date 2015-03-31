/*----------------------------------------------------------------
//                                                              //
//  mac.h                                                       //
//                                                              //
//  This file is part of the Targeted Encryption Device.        //
//  A fourth year Computer Engineering design project completed //
//  for the partial fulfilment of requirements of a degree of   //
//  Bachelor Computer Engineering in the Electrical and         //
//  Computer Engineering Department at the Royal Military       //
//  College of Canada.											//
//                                                              //
//                                                              //
//  Description                                                 //
//  Defines for the 88e1111 PHY interface, including all        //
//  registers.													//
//                                                              //
//  Author(s):                                                  //         
//      - Blake Mackey, blake@brashendeavours.com               //         
//      - Jason Leverton, jason@kogfuy.com                      //         
//                                                              //         
//////////////////////////////////////////////////////////////////         
//                                                              //         
// Copyright (C) 2015 Authors                                   //         
//                                                              //         
// This source file may be used and distributed without         //         
// restriction provided that this copyright statement is not    //         
// removed from the file and that any derivative work contains  //         
// the original copyright notice and the associated disclaimer. //         
//                                                              //         
// This source file is free software; you can redistribute it   //         
// and/or modify it under the terms of the GNU Lesser General   //         
// Public License as published by the Free Software Foundation; //         
// either version 2.1 of the License, or (at your option) any   //         
// later version.                                               //         
//                                                              //         
// This source is distributed in the hope that it will be       //         
// useful, but WITHOUT ANY WARRANTY; without even the implied   //
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      //
// PURPOSE.  See the GNU Lesser General Public License for more //
// details.                                                     //
//                                                              //
----------------------------------------------------------------*/


#ifndef MAC_H_
#define MAC_H_

/* MAC configuration registers */
typedef struct MAC_t {
        unsigned int      rev;                  /* 0x00  */
        unsigned int      scratch;              /* 0x01  */
        unsigned int      command_config;       /* 0x02  */
        unsigned int      mac_0;                /* 0x03  */
        unsigned int      mac_1;                /* 0x04  */
        unsigned int      frm_length;           /* 0x05  */
        unsigned int      pause_quant;          /* 0x06  */
        unsigned int      rx_section_empty;     /* 0x07  */
        unsigned int      rx_section_full;      /* 0x08  */
        unsigned int      tx_section_empty;     /* 0x09  */
        unsigned int      tx_section_full;      /* 0x0a  */
        unsigned int      rx_almost_empty;      /* 0x0b  */
        unsigned int      rx_almost_full;       /* 0x0c  */
        unsigned int      tx_almost_empty;      /* 0x0d  */
        unsigned int      tx_almost_full;       /* 0x0e  */
        unsigned int      mdio_addr0;           /* 0x0f  */
        unsigned int      mdio_addr1;           /* 0x10  */
        unsigned int      holdoff_quant;        /* 0x11  */
        unsigned int   	  reserved0[5];         /* 0x12-0x16      */
        unsigned int      tx_ipg_length;        /* 0x17         */
        unsigned int  	  statistics_counters0[34]; /* 0x18-0x39        */
        unsigned int      tx_command;           /* 0x3a           */
        unsigned int      rx_command;           /* 0x3b           */
        unsigned int   	  statistics_counters1[3]; /* 0x3c-0x3e     */
        unsigned int      reserved1;            /* 0x3f          */        
        unsigned int      hash_table[64];           /* 0x40-0x7f     */
        unsigned int      mdio_PHY_CR;           /* 0x80       Control register            */
        unsigned int      mdio_PHY_SR;           /* 0x81       Status register             */
        unsigned int      mdio_PHY_PHYID1;       /* 0x82       PHY ID 1                    */
        unsigned int      mdio_PHY_PHYID2;       /* 0x83       PHY ID 2                    */
        unsigned int      mdio_PHY_ACR;          /* 0x84       Advertisement control reg   */
        unsigned int      mdio_PHY_LPAR;         /* 0x85       Link partner ability reg    */
        unsigned int      mdio_PHY_ANER;         /* 0x86       Auto-neg Expansion reg      */
        unsigned int      mdio_PHY_NPTR;         /* 0x87       Next page transmit reg      */
        unsigned int      mdio_PHY_LPNPR;        /* 0x88       Link partner next page reg  */
        unsigned int      mdio_PHY_CTRL1000;     /* 0x89       1000BASE-T control          */
        unsigned int      mdio_PHY_STAT1000;     /* 0x8a       1000BASE-T status           */
        unsigned int      mdio_reserved0;        /* 0x8b  */
        unsigned int      mdio_reserved1;        /* 0x8c  */
        unsigned int      mdio_reserved2;        /* 0x8d  */
        unsigned int      mdio_reserved3;        /* 0x8e  */
        unsigned int      mdio_PHY_ESR;  	  	 /* 0x8f		    Extended status register    */
        unsigned int      mdio_PHY_PHYSCR;	  	 /* 0x90		    PHY specific control reg    */
        unsigned int      mdio_PHY_PHYSSR;	  	 /* 0x91		    PHY specific status reg     */
        unsigned int      mdio_PHY_IER;          /* 0x92       Interrupt enable reg        */
        unsigned int      mdio_PHY_ISR;          /* 0x93       Interrupt status reg        */
        unsigned int      mdio_PHY_EPHYSCR;      /* 0x94       Extended PHY spec cont reg  */
        unsigned int      mdio_PHY_RERRCOUNTER;  /* 0x95       Receive error counter       */
        unsigned int      mdio_PHY_EXTADD;       /* 0x96       Extended address            */
        unsigned int      mdio_PHY_GSR;          /* 0x97       Global status register      */
        unsigned int      mdio_PHY_LEDCR;        /* 0x98       LED control register        */
        unsigned int      mdio_PHY_LEDOR;        /* 0x99       LED override register       */
        unsigned int      mdio_PHY_EPHYSC2R;     /* 0x9a       Ext PHY spec control 2 reg  */
        unsigned int      mdio_PHY_EPHYSSR;      /* 0x9b       Ext PHY specific stat reg   */
        unsigned int      mdio_PHY_MDISR;        /* 0x9c       Virtual cable tester        */
        unsigned int      mdio_PHY_EXTADD2;      /* 0x9d       Extended address 2 register */
        unsigned int      mdio_reserved4;        /* 0x9e  */
        unsigned int      mdio_PHY_NCONFIG;      /* 0x9f       Network interface config    */
        unsigned int      mdio2_PHY_CR;          /* 0xa0       Control register            */
        unsigned int      mdio2_PHY_SR;          /* 0xa1       Status register             */
        unsigned int      mdio2_PHY_PHYID1;      /* 0xa2       PHY ID 1                    */
        unsigned int      mdio2_PHY_PHYID2;      /* 0xa3       PHY ID 2                    */
        unsigned int      mdio2_PHY_ACR;         /* 0xa4       Advertisement control reg   */
        unsigned int      mdio2_PHY_LPAR;        /* 0xa5       Link partner ability reg    */
        unsigned int      mdio2_PHY_ANER;        /* 0xa6       Auto-neg Expansion reg      */
        unsigned int      mdio2_PHY_NPTR;        /* 0xa7       Next page transmit reg      */
        unsigned int      mdio2_PHY_LPNPR;       /* 0xa8       Link partner next page reg  */
        unsigned int      mdio2_PHY_CTRL1000;    /* 0xa9       1000BASE-T control          */
        unsigned int      mdio2_PHY_STAT1000;    /* 0xaa       1000BASE-T status           */
        unsigned int      mdio2_reserved0;       /* 0xab  */
        unsigned int      mdio2_reserved1;       /* 0xac  */
        unsigned int      mdio2_reserved2;       /* 0xad  */
        unsigned int      mdio2_reserved3;       /* 0xae  */
        unsigned int      mdio2_PHY_ESR;  	  	 /* 0xaf		    Extended status register    */
        unsigned int      mdio2_PHY_PHYSCR;	  	 /* 0xb0		    PHY specific control reg    */
        unsigned int      mdio2_PHY_PHYSSR;	  	 /* 0xb1		    PHY specific status reg     */
        unsigned int      mdio2_PHY_IER;         /* 0xb2       Interrupt enable reg        */
        unsigned int      mdio2_PHY_ISR;         /* 0xb3       Interrupt status reg        */
        unsigned int      mdio2_PHY_EPHYSCR;     /* 0xb4       Extended PHY spec cont reg  */
        unsigned int      mdio2_PHY_RERRCOUNTER; /* 0xb5       Receive error counter       */
        unsigned int      mdio2_PHY_EXTADD;      /* 0xb6       Extended address            */
        unsigned int      mdio2_PHY_GSR;         /* 0xb7       Global status register      */
        unsigned int      mdio2_PHY_LEDCR;       /* 0xb8       LED control register        */
        unsigned int      mdio2_PHY_LEDOR;       /* 0xb9       LED override register       */
        unsigned int      mdio2_PHY_EPHYSC2R;    /* 0xba       Ext PHY spec control 2 reg  */
        unsigned int      mdio2_PHY_EPHYSSR;     /* 0xbb       Ext PHY specific stat reg   */
        unsigned int      mdio2_PHY_MDISR;       /* 0xbc       Virtual cable tester        */
        unsigned int      mdio2_PHY_EXTADD2;     /* 0xbd       Extended address 2 register */
        unsigned int      mdio2_reserved4;       /* 0xbe  */
        unsigned int      mdio2_PHY_NCONFIG;     /* 0xbf       Network interface config    */
} MAC_t;

//Define offset for command and config
#define CC_TX_ENA             0x00000001      /*  */
#define CC_RX_ENA             0x00000002      /*  */
#define CC_XON_GEN            0x00000004      /*  */
#define CC_ETH_SPEED          0x00000008      /*  */
#define CC_PROMIS_EN          0x00000010      /*  */
#define CC_PAD_EN             0x00000020      /*  */
#define CC_CRC_FWD            0x00000040      /*  */
#define CC_PAUSE_FWD          0x00000080      /*  */
#define CC_PAUSE_IGNORE		  0x00000100	    /*  */
#define CC_TX_ADDR_INS        0x00000200      /*  */
#define CC_HD_ENA             0x00000400      /*  */
#define CC_EXCESS_COL         0x00000800      /*  */
#define CC_LATE_COL           0x00001000      /*  */
#define CC_SW_RESET           0x00002000      /*  */
#define CC_MHASH_SEL          0x00004000      /*  */
#define CC_LOOP_ENA           0x00008000      /*  */
#define CC_TXADDR0            0x00010000
#define CC_TXADDR1            0x00020000
#define CC_TXADDR2            0x00040000
#define CC_MAGIC_ENA          0x00080000
#define CC_SLEEP              0x00100000
#define CC_WAKEUP             0x00200000
#define CC_XOFF_GEN           0x00400000
#define CC_CNTL_FROM_ENA      0x00800000
#define CC_NO_LGTH_CHECK      0x01000000
#define CC_ENA_10             0x02000000
#define CC_RX_ERR_DISC        0x04000000
#define CC_DISABLE_READ       0x08000000
#define CC_CNT_RESET          0x80000000

unsigned char macInit(volatile MAC_t* targetMAC, unsigned char SW_Status);
void macPrintRegs(volatile MAC_t* targetMAC);

#endif /* MAC_H_ */

/*----------------------------------------------------------------
//                                                              //
//  phy.h                                                       //
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
#ifndef __PHY_H__
#define __PHY_H__

#include "mac.h"

#define PHY_CR            	0x00        /* Control register            */
#define PHY_SR            	0x01        /* Status register             */
#define PHY_PHYID1          0x02        /* PHY ID 1                    */
#define PHY_PHYID2          0x03        /* PHY ID 2                    */
#define PHY_ACR             0x04        /* Advertisement control reg   */
#define PHY_LPAR            0x05        /* Link partner ability reg    */
#define PHY_ANER            0x06        /* Auto-neg Expansion reg      */
#define PHY_NPTR            0x07        /* Next page transmit reg      */
#define PHY_LPNPR           0x08        /* Link partner next page reg  */
#define PHY_CTRL1000        0x09        /* 1000BASE-T control          */
#define PHY_STAT1000        0x0a        /* 1000BASE-T status           */
#define PHY_ESR  	  		  0x0f		    /* Extended status register    */
#define PHY_PHYSCR	  		0x10		    /* PHY specific control reg    */
#define PHY_PHYSSR	  		0x11		    /* PHY specific status reg     */
#define PHY_IER             0x12        /* Interrupt enable reg        */
#define PHY_ISR             0x13        /* Interrupt status reg        */
#define PHY_EPHYSCR         0x14        /* Extended PHY spec cont reg  */
#define PHY_RERRCOUNTER     0x15        /* Receive error counter       */
#define PHY_EXTADD          0x16        /* Extended address            */
#define PHY_GSR             0x17        /* Global status register      */
#define PHY_LEDCR           0x18        /* LED control register        */
#define PHY_LEDOR           0x19        /* LED override register       */
#define PHY_EPHYSC2R        0x1a        /* Ext PHY spec control 2 reg  */
#define PHY_EPHYSSR         0x1b        /* Ext PHY specific stat reg   */
#define PHY_MDISR           0x1c        /* Virtual cable tester        */
#define PHY_EXTADD2         0x1d        /* Extended address 2 register */
#define PHY_NCONFIG         0x1f        /* Network interface config    */

//Define bit masks for control register.
#define CR_RESV             0x003f      /* Unused...                   */
#define CR_SPEED1000		0x0040      /* MSB of Speed (1000)         */
#define CR_CTST             0x0080      /* Collision test              */
#define CR_FULLDPLX         0x0100      /* Full duplex                 */
#define CR_ANRESTART        0x0200      /* Auto negotiation restart    */
#define CR_ISOLATE          0x0400      /* Disconnect DP83840 from PHY */
#define CR_PDOWN            0x0800      /* Powerdown the DP83840       */
#define CR_ANENABLE         0x1000      /* Enable auto negotiation     */
#define CR_SPEED100         0x2000      /* Select 100Mbps              */
#define CR_LOOPBACK         0x4000      /* TXD loopback bits           */
#define CR_RESET            0x8000      /* Reset the DP83840           */
//End of bit masks for control register.

//Define bit masks for control register.
#define PHYSCR_MDI_LSB      0x0020      /* LSB of Speed MDI            */
#define PHYSCR_MDI_MSB      0x0040      /* MSB of Speed MDI            */
//End of bit masks for control register.

//Define bit masks for status register.
#define SR_ERCAP            0x0001      /* Ext-reg capability          */
#define SR_JCD              0x0002      /* Jabber detected             */
#define SR_LSTATUS          0x0004      /* Link status                 */
#define SR_ANEGCAPABLE      0x0008      /* Able to do auto-negotiation */
#define SR_RFAULT           0x0010      /* Remote fault detected       */
#define SR_ANEGCOMPLETE     0x0020      /* Auto-negotiation complete   */
#define SR_RESV             0x00c0      /* Reserved...                 */
#define SR_ESTATEN		    0x0100	    /* Extended Status in R15      */
#define SR_100HALF2         0x0200      /* Can do 100BASE-T2 HDX       */
#define SR_100FULL2         0x0400      /* Can do 100BASE-T2 FDX       */
#define SR_10HALF           0x0800      /* Can do 10mbps, half-duplex  */
#define SR_10FULL           0x1000      /* Can do 10mbps, full-duplex  */
#define SR_100HALF          0x2000      /* Can do 100mbps, half-duplex */
#define SR_100FULL          0x4000      /* Can do 100mbps, full-duplex */
#define SR_100BASE4         0x8000      /* Can do 100mbps, 4k packets  */
//End of bit masks for  status register.

/* Advertisement control register. */
#define ADVERTISE_SLCT          0x001f  /* Selector bits               */
#define ADVERTISE_CSMA          0x0001  /* Only selector supported     */
#define ADVERTISE_10HALF        0x0020  /* Try for 10mbps half-duplex  */
#define ADVERTISE_1000XFULL     0x0020  /* Try for 1000BASE-X full-duplex */
#define ADVERTISE_10FULL        0x0040  /* Try for 10mbps full-duplex  */
#define ADVERTISE_1000XHALF     0x0040  /* Try for 1000BASE-X half-duplex */
#define ADVERTISE_100HALF       0x0080  /* Try for 100mbps half-duplex */
#define ADVERTISE_1000XPAUSE    0x0080  /* Try for 1000BASE-X pause    */
#define ADVERTISE_100FULL       0x0100  /* Try for 100mbps full-duplex */
#define ADVERTISE_1000XPSE_ASYM 0x0100  /* Try for 1000BASE-X asym pause */
#define ADVERTISE_100BASE4      0x0200  /* Try for 100mbps 4k packets  */
#define ADVERTISE_PAUSE_CAP     0x0400  /* Try for pause               */
#define ADVERTISE_PAUSE_ASYM    0x0800  /* Try for asymetric pause     */
#define ADVERTISE_RESV          0x1000  /* Unused...                   */
#define ADVERTISE_RFAULT        0x2000  /* Say we can detect faults    */
#define ADVERTISE_LPACK         0x4000  /* Ack link partners response  */
#define ADVERTISE_NPAGE         0x8000  /* Next page bit               */

#define ADVERTISE_FULL (ADVERTISE_100FULL | ADVERTISE_10FULL | \
			ADVERTISE_CSMA)
#define ADVERTISE_ALL (ADVERTISE_10HALF | ADVERTISE_10FULL | \
                       ADVERTISE_100HALF | ADVERTISE_100FULL)

/* Link partner ability register. */
#define LPA_SLCT                0x001f  /* Same as advertise selector  */
#define LPA_10HALF              0x0020  /* Can do 10mbps half-duplex   */
#define LPA_1000XFULL           0x0020  /* Can do 1000BASE-X full-duplex */
#define LPA_10FULL              0x0040  /* Can do 10mbps full-duplex   */
#define LPA_1000XHALF           0x0040  /* Can do 1000BASE-X half-duplex */
#define LPA_100HALF             0x0080  /* Can do 100mbps half-duplex  */
#define LPA_1000XPAUSE          0x0080  /* Can do 1000BASE-X pause     */
#define LPA_100FULL             0x0100  /* Can do 100mbps full-duplex  */
#define LPA_1000XPAUSE_ASYM     0x0100  /* Can do 1000BASE-X pause asym*/
#define LPA_100BASE4            0x0200  /* Can do 100mbps 4k packets   */
#define LPA_PAUSE_CAP           0x0400  /* Can pause                   */
#define LPA_PAUSE_ASYM          0x0800  /* Can pause asymetrically     */
#define LPA_RESV                0x1000  /* Unused...                   */
#define LPA_RFAULT              0x2000  /* Link partner faulted        */
#define LPA_LPACK               0x4000  /* Link partner acked us       */
#define LPA_NPAGE               0x8000  /* Next page bit               */

#define LPA_DUPLEX		(LPA_10FULL | LPA_100FULL)
#define LPA_100			(LPA_100FULL | LPA_100HALF | LPA_100BASE4)

/* Expansion register for auto-negotiation. */
#define EXPANSION_NWAY          0x0001  /* Can do N-way auto-nego      */
#define EXPANSION_LCWP          0x0002  /* Got new RX page code word   */
#define EXPANSION_ENABLENPAGE   0x0004  /* This enables npage words    */
#define EXPANSION_NPCAPABLE     0x0008  /* Link partner supports npage */
#define EXPANSION_MFAULTS       0x0010  /* Multiple faults detected    */
#define EXPANSION_RESV          0xffe0  /* Unused...                   */

#define ESTATUS_1000_TFULL	0x2000	/* Can do 1000BT Full */
#define ESTATUS_1000_THALF	0x1000	/* Can do 1000BT Half */

#define EPHYSCR_LOOPBACK	0x4000	/*Line loopback enable */

/* N-way test register. */
#define NWAYTEST_RESV1          0x00ff  /* Unused...                   */
#define NWAYTEST_LOOPBACK       0x0100  /* Enable loopback for N-way   */
#define NWAYTEST_RESV2          0xfe00  /* Unused...                   */

/* 1000BASE-T Control register */
#define ADVERTISE_1000FULL      0x0200  /* Advertise 1000BASE-T full duplex */
#define ADVERTISE_1000HALF      0x0100  /* Advertise 1000BASE-T half duplex */

/* 1000BASE-T Status register */
#define LPA_1000LOCALRXOK       0x2000  /* Link partner local receiver status */
#define LPA_1000REMRXOK         0x1000  /* Link partner remote receiver status */
#define LPA_1000FULL            0x0800  /* Link partner 1000BASE-T full duplex */
#define LPA_1000HALF            0x0400  /* Link partner 1000BASE-T half duplex */

/* 1000BT control */
#define MII_1000BASETCONTROL_FULLDUPLEXCAP	0x0200
#define MII_1000BASETCONTROL_HALFDUPLEXCAP	0x0100

unsigned int phyInit(unsigned char PHYID, volatile MAC_t* targetMII, unsigned char SW_Status);
void phyPrintStatus(char PHYID,  volatile MAC_t* MAC);

#endif //__PHY_H__

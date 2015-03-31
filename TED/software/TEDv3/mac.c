/*----------------------------------------------------------------
//                                                              //
//  mac.c                                                       //
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
//  Functions for Targeted Encryption Device					//
//	Ethernet MAC module											//
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
#include "phy.h"
#include "sw.h"
#include "mac.h"

unsigned char macInit(volatile MAC_t* targetMAC, unsigned char SW_Status){
	  unsigned short control = 0;
	  switch (SW_Status & SPD_MSK) {
	    case 0: //Speed 10 Selected
	      printf("[mac.c]\tSpeed 10 selected\n");
	      //Register 4
	        //Advertisement control register
	          control = targetMAC->mdio_PHY_ACR;
	        //Don't advertise anything
	          control &= ~(ADVERTISE_10HALF | ADVERTISE_10FULL | ADVERTISE_100HALF | ADVERTISE_100FULL);
	        //Advertise 10mbps
	          control |= (ADVERTISE_10HALF | ADVERTISE_10FULL);
	        //Write changes
	          targetMAC->mdio_PHY_ACR = control;

	      //Register 9
	        //1000BT control register
	          control = targetMAC->mdio_PHY_CTRL1000;
	        //Don't advertise anything
	          control &= ~(MII_1000BASETCONTROL_FULLDUPLEXCAP | MII_1000BASETCONTROL_HALFDUPLEXCAP);
	        //Advertise 10mbps

	        //Write changes
	          targetMAC->mdio_PHY_CTRL1000 = control;

	      //Register 0
	        //base control register
	          control = targetMAC->mdio_PHY_CR;
	        //Don't advertise anything
	          control &= !(CR_SPEED1000 | CR_SPEED100);
	        //Advertise 10mbps
	          //10mbps = "00"
	        //Write changes
	          targetMAC->mdio_PHY_CR = control;

	          control = targetMAC->command_config;
	          control &= ~(CC_ETH_SPEED);
	          control |= (CC_ENA_10);
	          targetMAC->command_config = control;
	          printf("HERE");



	      break;
	    case 1: //Speed 100 Selected
	      printf("[mac.c]\tSpeed 100 selected\n");
	      //Register 4
	        //Advertisement control register
	          control = targetMAC->mdio_PHY_ACR;
	        //Don't advertise anything
	          control &= ~(ADVERTISE_10HALF | ADVERTISE_10FULL | ADVERTISE_100HALF | ADVERTISE_100FULL);
	        //Advertise 100mbps
	          control |= (ADVERTISE_100HALF | ADVERTISE_100FULL);
	        //Write changes
	          targetMAC->mdio_PHY_ACR = control;

	      //Register 9
	        //1000BT control register
	    	  control = targetMAC->mdio_PHY_CTRL1000;
	        //Don't advertise anything
	          control &= ~(MII_1000BASETCONTROL_FULLDUPLEXCAP | MII_1000BASETCONTROL_HALFDUPLEXCAP);
	        //Advertise 100mbps

	        //Write changes
	          targetMAC->mdio_PHY_CTRL1000 = control;

	      //Register 0
	        //base control register
	          control = targetMAC->mdio_PHY_CR;
	        //Don't advertise anything
	          control &= ~(CR_SPEED1000 | CR_SPEED100);
	        //Advertise 10mbps
	          //100mbps = "01"
	          control |= (CR_SPEED100);
	        //Write changes
	          targetMAC->mdio_PHY_CR = control;

	          control = targetMAC->command_config;
	          control &= ~(CC_ETH_SPEED | CC_ENA_10);
	          targetMAC->command_config = control;

	      break;
	    case 2: //Speed 1000 Selected
	      printf("[mac.c]\tSpeed 1000 selected\n");
	      //Register 4
	        //Advertisement control register
	      	  control = targetMAC->mdio_PHY_ACR;
	        //Don't advertise anything
	          control &= ~(ADVERTISE_10HALF | ADVERTISE_10FULL | ADVERTISE_100HALF | ADVERTISE_100FULL);
	        //Advertise 1000mbps

	        //Write changes
	          targetMAC->mdio_PHY_ACR = control;

	      //Register 9
	        //1000BT control register
	          control = targetMAC->mdio_PHY_CTRL1000;
	        //Don't advertise anything
	          control &= ~(MII_1000BASETCONTROL_FULLDUPLEXCAP | MII_1000BASETCONTROL_HALFDUPLEXCAP);
	        //Advertise 100mbps
	          control |= (MII_1000BASETCONTROL_FULLDUPLEXCAP | MII_1000BASETCONTROL_HALFDUPLEXCAP);
	        //Write changes
	          targetMAC->mdio_PHY_CTRL1000 = control;

	      //Register 0
	        //base control register
	          control = targetMAC->mdio_PHY_CR;
	        //Don't advertise anything
	          control &= ~(CR_SPEED1000 | CR_SPEED100);
	        //Advertise 10mbps
	          //100mbps = "01"
	          control |= (CR_SPEED1000);
	        //Write changes
	          targetMAC->mdio_PHY_CR = control;

	          control = targetMAC->command_config;
	          control &= ~(CC_ENA_10);
	          control |= CC_ETH_SPEED;
	          targetMAC->command_config = control;

	      break;
	    default:
	      printf("[mac.c]\tInvalid speed selected\n");
	      printf("[mac.c]\tInitialize interface (FAILURE)\n");
	      return 1;
	      break;
	  }

	  if(SW_Status & DUP_MSK){
	    //Enable FULL DUPLEX mode!
	    printf("[mac.c]\tFull-duplex selected\n");
	    //Register 4
	      //Advertisement control register
	    	control = targetMAC->mdio_PHY_ACR;
	      //Don't advertise half duplex!
	        control &= ~(ADVERTISE_10HALF | ADVERTISE_100HALF);
	      //Write changes
	        targetMAC->mdio_PHY_ACR = control;

	    //Register 9
	      //1000BT control register
	        control = targetMAC->mdio_PHY_CTRL1000;
	      //Don't advertise helf duplex!
	        control &= ~(MII_1000BASETCONTROL_HALFDUPLEXCAP);
	      //Write changes
	        targetMAC->mdio_PHY_CTRL1000 = control;


	    //Register 0
	      //base control register
	        control = targetMAC->mdio_PHY_CR;
	      //Engage Duplex
	        control |= (CR_FULLDPLX);
	      //Write changes
	        targetMAC->mdio_PHY_CR = control;

		  control = targetMAC->command_config;
		  control &= ~(CC_HD_ENA);
		  targetMAC->command_config = control;

	  } else {
	    //Enable HALF DUPLEX mode!
	    printf("[mac.c]\tHalf-duplex selected\n");
	    //Register 4
	      //Advertisement control register
    		control = targetMAC->mdio_PHY_ACR;
	      //Don't advertise full duplex!
	        control &= ~(ADVERTISE_10FULL | ADVERTISE_100FULL);
	      //Write changes
	        targetMAC->mdio_PHY_ACR = control;

	    //Register 9
	      //1000BT control register
	        control = targetMAC->mdio_PHY_CTRL1000;
	      //Don't advertise helf duplex!
	        control &= ~(MII_1000BASETCONTROL_FULLDUPLEXCAP);
	      //Write changes
	        targetMAC->mdio_PHY_CTRL1000 = control;

	    //Register 0
	      //base control register
	        control = targetMAC->mdio_PHY_CR;
	      //Say no to duplex
	        control &= ~(CR_FULLDPLX);
	      //Write changes
	        targetMAC->mdio_PHY_CR = control;

		  control = targetMAC->command_config;
		  control |= (CC_HD_ENA);
		  targetMAC->command_config = control;
	  }

	  if(SW_Status & XO_MSK){
	    //Enable Auto-crossover mode!
	    printf("[mac.c]\tAuto-crossover selected\n");
	    //Register 16
	      //PHY Specific Control register
	    	control = targetMAC->mdio_PHY_PHYSCR;
	      //Change to auto-crossover!
	        control |= (PHYSCR_MDI_MSB | PHYSCR_MDI_LSB);
	      //Write changes
	        targetMAC->mdio_PHY_PHYSCR = control;

	  } else {
	    //Disable auto-crossover mode!
	    printf("[mac.c]\tNon-crossover selected\n");
	    //Register 16
	      //PHY Specific Control register
	    	control = targetMAC->mdio_PHY_PHYSSR;
	      //Disable auto-crossover, straight across!
	        control &= ~(PHYSCR_MDI_MSB | PHYSCR_MDI_LSB);
	      //Write changes
	        targetMAC->mdio_PHY_PHYSSR = control;
	  }

	  if(SW_Status & AN_MSK){
	    //Enable auto-negotiation!
	    printf("[mac.c]\tAuto-negotiation selected\n");
	    //Register 4
	      //Advertisement control register
			control = targetMAC->mdio_PHY_ACR;
	      //Advertise everything
	        control |= (ADVERTISE_10HALF | ADVERTISE_10FULL | ADVERTISE_100HALF | ADVERTISE_100FULL);
	      //Write changes
	        targetMAC->mdio_PHY_ACR = control;

	    //Register 9
	      //1000BT control register
	        control = targetMAC->mdio_PHY_CTRL1000;
	      //Advertise everything
	        control |= (MII_1000BASETCONTROL_FULLDUPLEXCAP | MII_1000BASETCONTROL_HALFDUPLEXCAP);
	      //Write changes
	        targetMAC->mdio_PHY_CTRL1000 = control;

	    //Register 0
	      //base control register
	        control = targetMAC->mdio_PHY_CR;
	      //auto-negotiation on!
	        control |= (CR_ANENABLE);
	      //Write changes
	        targetMAC->mdio_PHY_CR = control;

	  } else {
	    //Disable auto-crossover mode!
	    printf("[mac.c]\tAuto-negotiation unselected\n");
	    //Register 0
	      //base control register
	    	control = targetMAC->mdio_PHY_CR;
	      //auto-negotiation on!
	        control &= ~(CR_ANENABLE);
	      //Write changes
	        targetMAC->mdio_PHY_CR = control;
	  }

	  // Write to register 20 of the PHY chip to set up delay for input/output clk
	  targetMAC->mdio_PHY_EPHYSCR |= 0x0082;

	  control = targetMAC->command_config;
	  control |= (CC_PROMIS_EN | CC_PAD_EN);
	  control &= ~(CC_CRC_FWD | CC_PAUSE_FWD | CC_PAUSE_IGNORE | CC_TX_ADDR_INS);
	  targetMAC->command_config = control;

	  targetMAC->mdio_PHY_CR |= (CR_ANRESTART | CR_RESET);

  printf("[mac.c]\tInitialize interface (SUCCESS)\n");
  return 0;

  printf("[mac.c]\tInitialize interface (FAILURE)\n");
  return 1;
}

void macPrintRegs(volatile MAC_t* targetMAC){
  /* Mode Register */
  printf("\tRevision Reg:\t\t0x%.8x\n", (unsigned int) targetMAC->rev);

  /* Interrupt Source Register */
  printf("\tScratch Reg:\t\t0x%.8x\n", (unsigned int) targetMAC->scratch);

  /* Interrupt Mask Register */
  printf("\tCommand Config  Reg:\t\t0x%.8x\n", (unsigned int) targetMAC->command_config);

  /* Back to Back Inter Packet Gap Register */
  printf("\tMAC0 Reg: \t\t\t0x%.8x\n", (unsigned int) targetMAC->mac_0);

  /* Non Back to Back Inter Packet Gap Register 1 */
  printf("\tMAC1 Reg: \t\t\t0x%.8x\n", (unsigned int) targetMAC->mac_1);

  /* Non Back to Back Inter Packet Gap Register 2 */
  printf("\tFrame Length Reg: \t\t0x%.8x\n", (unsigned int) targetMAC->frm_length);

  /* Packet Length Register (min. and max.) */
  printf("\tPause Quant Reg: \t\t0x%.8x\n", (unsigned int) targetMAC->pause_quant);

  /* Collision and Retry Configuration Register */
  printf("\tMDIO0 Reg: \t\t0x%.8x\n", (unsigned int) targetMAC->mdio_addr0);

  /* Transmit Buffer Descriptor Number Register */
  printf("\tMDIO1 Reg: \t\t0x%.8x\n", (unsigned int) targetMAC->mdio_addr1);

  /* Control Module Mode Register */
  printf("\tHoldoff Quant Reg: \t\t0x%.8x\n", (unsigned int) targetMAC->holdoff_quant);

  /* MII Mode Register */
  printf("\tTX IPG Reg: \t\t0x%.8x\n", (unsigned int) targetMAC->tx_ipg_length);

  /* MII Command Register */
  printf("\tTX Command Reg:\t\t0x%.8x\n", (unsigned int) targetMAC->tx_command);

  /* MII Address Register */
  printf("\tRX Command Reg:\t\t0x%.8x\n", (unsigned int) targetMAC->rx_command);
}

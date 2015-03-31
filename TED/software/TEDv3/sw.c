/*----------------------------------------------------------------
 //                                                              //
 //  sw.c                                b                       //
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
#include "sw.h"

unsigned char swInit(volatile SW_t* targetSW) {
  targetSW->DDR = 0x00000000;
  targetSW->EDGE_CAP = 0x00000000;
  targetSW->IRQ_MASK = 0x00000000;

  if ((targetSW->DDR == 0) && (targetSW->EDGE_CAP == 0)
      && (targetSW->IRQ_MASK == 0)) {

    printf("[sw.c]\tInitialize switches (SUCCESS)\n");
    return 0;
  } else {
    printf("[sw.c]\tInitialize switches (FAILURE)\n");
    return 1;
  }
}

void swPrintStatus(volatile SW_t* targetSW) {
  int bitnum;
  int bitset;
  unsigned int data;
  data = targetSW->DATA;
  for (bitnum = 0; bitnum < 18; bitnum++) {
    bitset = !!(data & (1 << bitnum));
    switch (bitnum) {
    case 0:
      printf("\t\tbit%d:\t%d \tBLACK (lsb speed (10/100/1000))\n", bitnum,
          bitset);
      break;
    case 1:
      printf("\t\tbit%d:\t%d \tBLACK (msb speed (10/100/1000))\n", bitnum,
          bitset);
      break;
    case 2:
      printf("\t\tbit%d:\t%d \tBLACK (full duplex enable)\n", bitnum, bitset);
      break;
    case 3:
      printf("\t\tbit%d:\t%d \tBLACK (crossover enable)\n", bitnum, bitset);
      break;
    case 4:
      printf("\t\tbit%d:\t%d \tBLACK (autonegotiate)\n", bitnum, bitset);
      break;
    case 5:
      printf("\t\tbit%d:\t%d \tBLACK (crypto enable)\n", bitnum, bitset);
      break;
    case 6:
      printf("\t\tbit%d:\t%d \tRED (lsb speed (10/100/1000))\n", bitnum,
          bitset);
      break;
    case 7:
      printf("\t\tbit%d:\t%d \tRED (msb speed (10/100/1000))\n", bitnum,
          bitset);
      break;
    case 8:
      printf("\t\tbit%d:\t%d \tRED (full duplex enable)\n", bitnum, bitset);
      break;
    case 9:
      printf("\t\tbit%d:\t%d \tRED (crossover enable)\n", bitnum, bitset);
      break;
    case 10:
      printf("\t\tbit%d:\t%d \tRED (autonegotiate)\n", bitnum, bitset);
      break;
    case 11:
      printf("\t\tbit%d:\t%d \tRED (crypto enable)\n", bitnum, bitset);
      break;
    case 17:
      printf("\t\tbit%d:\t%d \tDEBUG MODE\n\n", bitnum, bitset);
      break;
    default:
      break;
    }
  }
}

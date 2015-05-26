/*----------------------------------------------------------------
//                                                              //
//  printpacket.h                                               //
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
//  Defines for the printpacket function. 						//
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

void PrintPacket(unsigned char * frameStart, unsigned int frameLength){
	 unsigned char * stringP = frameStart;
	 int i = 0;
	 int j = 0;
	 printf("Inspecting packet... Address: 0x%08.8x, Length: %d bytes.\n", frameStart, frameLength);
	 printf("             0  1  2  3  4  5  6  7   8  9  a  b  c  d  e  f\n");
	 printf("0x%08.8x  ", frameStart + i);
	 for(i=0; i < frameLength; i++){

		 if (j++ == 8){
			 j = 0;
			 printf(" ");
		 }
		 if (i%16 == 0 && i != 0){
			 printf("\n0x%08.8x  ", frameStart + i);
			 j = 1;
		 }
		 printf("%2.2x ", *(stringP + i));
	 }
	 printf("\n");
}

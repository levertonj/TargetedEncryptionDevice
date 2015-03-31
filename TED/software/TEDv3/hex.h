/*----------------------------------------------------------------
//                                                              //
//  hex.h                                                        //
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

#ifndef HEX_H_
#define HEX_H_

#define HEX_DATA            	0x00        /* Data on hex      */

typedef struct{
	unsigned short blackFrames;
	unsigned short redFrames;
}HEX_t;

unsigned int hexInit(HEX_t* hex);

#endif /* HEX_H_ */

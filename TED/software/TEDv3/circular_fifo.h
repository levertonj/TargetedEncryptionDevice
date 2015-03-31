/*----------------------------------------------------------------
//                                                              //
//  circular_fifo.c                                             //
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
//  Definition of structs and supporting functions for a        //
//  circular queue.                                             //
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

#ifndef CIRCULAR_FIFO_H_
#define CIRCULAR_FIFO_H_

#include <unistd.h>

struct FIFO {
	uint size;
	uint available;
	uint ReadPos;
	uint WritePos;
};

void initialize_fifo(struct FIFO* myFIFO, uint mySize);
unsigned char available(struct FIFO myFIFO);
void add_to_fifo(struct FIFO* myFIFO);
void remove_from_fifo(struct FIFO* myFIFO);

#endif /* CIRCULAR_FIFO_H_ */

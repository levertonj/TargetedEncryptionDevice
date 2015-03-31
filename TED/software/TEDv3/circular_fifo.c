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
//  Implementation and supporting functions for a circular      //
//  queue.                                                      //
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
#include "circular_fifo.h"

void initialize_fifo(struct FIFO* myFIFO, uint mySize){
	myFIFO->size = mySize;
	myFIFO->ReadPos = 0;
	myFIFO->WritePos = 0;
	myFIFO->available = mySize -1;
}

unsigned char available(struct FIFO myFIFO){
	//If ReadPos == WritePos, the queue is empty.
	if (myFIFO.ReadPos == myFIFO.WritePos){
		return myFIFO.size - 1;
	} else if (myFIFO.WritePos > myFIFO.ReadPos) {
		return myFIFO.size - (1 + myFIFO.WritePos - myFIFO.ReadPos);
	} else {
		return myFIFO.size - (1 + myFIFO.WritePos + myFIFO.size - myFIFO.ReadPos);
	}
	//Otherwise, the queue currently has WritePos - ReadPos elements in it if WritePos > ReadPos,
	//and WritePos + SIZE - ReadPos elements if WritePos < ReadPos.
}

void add_to_fifo(struct FIFO* myFIFO){
	myFIFO->WritePos = (myFIFO->WritePos + 1) % myFIFO->size;
	myFIFO->available -= 1;
}

void remove_from_fifo(struct FIFO* myFIFO){
	myFIFO->ReadPos = (myFIFO->ReadPos + 1) % myFIFO->size;
	myFIFO->available += 1;
}



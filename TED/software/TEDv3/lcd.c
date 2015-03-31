/*----------------------------------------------------------------
//                                                              //
//  lcd.c                                                       //
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
//  Initialization routines for the DE2-115 Board				//
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

#include <stdio.h>
#include "system.h"
#include <altera_up_avalon_character_lcd.h>
#include "Target_Constants.h"

unsigned int lcdInit(alt_up_character_lcd_dev* lcd){
	char* string[20];
	lcd = alt_up_character_lcd_open_dev("/dev/lcd");
	if (lcd == NULL){
		printf("[lcd.c]\tInitialize interface (FAILURE)\n");
		return 1;
	}
	alt_up_character_lcd_init (lcd);
	alt_up_character_lcd_cursor_off(lcd);
	sprintf(string, "%d.%d.%d.%d", IP_SRC_ADDRESS1);
	alt_up_character_lcd_string(lcd, string);
	alt_up_character_lcd_set_cursor_pos(lcd, 0, 1);
	sprintf(string, "%d.%d.%d.%d", IP_DST_ADDRESS1);
	alt_up_character_lcd_string(lcd, string);
	printf("[lcd.c]\tInitialize interface (SUCCESS)\n");
	return 0;


}

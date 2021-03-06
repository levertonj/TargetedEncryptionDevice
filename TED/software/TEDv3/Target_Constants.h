/*
 * Target_Constants.h
 *
 *  Created on: Mar 12, 2015
 *      Author: Count
 */

#ifndef PACKETPROCESSOR_RED_TARGET_CONSTANTS_H_
#define PACKETPROCESSOR_RED_TARGET_CONSTANTS_H_

//#define TOP
//TOP
#ifdef TOP
	#define IP_SRC_ADDRESS1 10,0,0,5
	#define IP_DST_ADDRESS1 172,16,0,5
#else
//BOTTOM
	#define IP_SRC_ADDRESS1 172,16,0,5
	#define IP_DST_ADDRESS1 10,0,0,5
#endif

#define SRC_PORT1 0,0 //23
#define DST_PORT1 0,0 //80

#define IP_SRC_ADDRESS2 0xac,0x10,0x23,0x03 //172.16.0.3
#define IP_DST_ADDRESS2 0xac,0x10,0x24,0x04 //172.16.0.4
#define SRC_PORT2 0x00,0x17 //23
#define DST_PORT2 0x00,0x50 //80

#define IP_SRC_ADDRESS3 0xac,0x10,0x25,0x05 //172.16.0.5
#define IP_DST_ADDRESS3 0xac,0x10,0x26,0x04 //172.16.0.4
#define SRC_PORT3 0x00,0x17 //23
#define DST_PORT3 0x00,0x50 //80

#define ETH_HEADER_SIZE 		14
#define IP_HEADER_SIZE 			20
#define TRANSPORT_HEADER_SIZE 	20

#define IP_SOURCE_OFFSET 		12
#define IP_DEST_OFFSET 			16
#define PORT_SOURCE_OFFSET		00 + offset
#define PORT_DEST_OFFSET 		02

#endif /* PACKETPROCESSOR_RED_TARGET_CONSTANTS_H_ */

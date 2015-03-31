/*
 * Header_Template.h
 *
 *  Created on: Mar 15, 2015
 *      Author: Count
 */

#ifndef HEADER_TEMPLATE_H_
#define HEADER_TEMPLATE_H_

typedef struct ethernetHeader {
	unsigned char eth_src[6];
	unsigned char eth_dst[6];
	unsigned char eth_protocol[2];
} eth_h;

typedef struct internetHeader {
	unsigned char verIHL[1];
	unsigned char ipBuff[1];
	unsigned char totalLength[2];
	unsigned char packetID[2];
	unsigned char ipBuff1[3];
	unsigned char protocol[1];
	unsigned char ipChkSm[2];
	unsigned char ip_src[4];
	unsigned char ip_dst[4];
} ip_h;

typedef struct transportHeader {
	unsigned char src_port[2];
	unsigned char dst_port[2];
	unsigned char tcpBuff[8];
	unsigned char tcp_length[1]; //Most Significant 4 bits of this value.
} tran_h ;

typedef struct udpHeader {
	unsigned char src_port[2];
	unsigned char dst_port[2];
	unsigned char length[2];
} udp_h ;


#endif /* HEADER_TEMPLATE_H_ */

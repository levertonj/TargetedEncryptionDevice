#ifndef PACKETPROCESSOR_RED_RX_H_
#define PACKETPROCESSOR_RED_RX_H_

#include "Header_Template.h"
#include "TargetList.h"

typedef struct adminData {
	unsigned char key8[1];
	unsigned char key16[2];
	unsigned char key32[4];
	unsigned char triggers[144];
} admin_h ;

typedef struct icmp {

} icmp_h;

unsigned char PacketProcessor_Red_Rx(void * packet);
int Ipv4PacketRed(eth_h* eth);
int IcmpPacketRed(ip_h* ip);
int AdminPacket(ip_h* ip);
TARGET* ProcessAdminPacket(admin_h* admin, TARGET* headNumber);

#endif /* PACKETPROCESSOR_RED_RX_PACKETPROCESSOR_H_ */

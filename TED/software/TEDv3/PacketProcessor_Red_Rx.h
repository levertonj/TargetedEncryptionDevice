#ifndef PACKETPROCESSOR_RED_RX_H_
#define PACKETPROCESSOR_RED_RX_H_

#include "Header_Template.h"
#include "TargetList.h"

typedef struct adminData {
	unsigned char key8[1];
	unsigned char key16[2];
	unsigned char key32[4];

	unsigned char ipsrc1[4];
	unsigned char ipdst1[4];
	unsigned char srcport1[2];
	unsigned char dstport1[2];

	unsigned char ipsrc2[4];
	unsigned char ipdst2[4];
	unsigned char srcport2[2];
	unsigned char dstport2[2];

	unsigned char ipsrc3[4];
	unsigned char ipdst3[4];
	unsigned char srcport3[2];
	unsigned char dstport3[2];
} admin_h ;

typedef struct icmp {

} icmp_h;

unsigned char PacketProcessor_Red_Rx(void * packet);
int Ipv4PacketRed(eth_h* eth);
int IcmpPacketRed(ip_h* ip);
int AdminPacket(ip_h* ip);
TARGET* ProcessAdminPacket(admin_h* admin, TARGET* headNumber);

#endif /* PACKETPROCESSOR_RED_RX_PACKETPROCESSOR_H_ */

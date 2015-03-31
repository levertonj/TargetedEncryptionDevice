#ifndef PACKETPROCESSOR_BLACK_RX_H_
#define PACKETPROCESSOR_BLACK_RX_H_

#include "Header_Template.h"

PacketProcessor_Black_Rx(void * packet);
int Ipv4PacketBlack(eth_h * eth);
int IcmpPacketBlack(ip_h * ip);

#endif

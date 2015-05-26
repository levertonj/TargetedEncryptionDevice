#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#include "PacketProcessor_Black_Rx.h"
#include "TargetList.h"
#include "Target_Constants.h"
#include "DecryptCheck.h"

#ifdef DEBUG
 #define D if(1)
#else
 #define D if(0)
#endif

/*
-------------------------------------------------------------------------------
Function: 		portDecrypt

Description:	Returns a 1 if a source port matches a port in the target
				list

Parameters:		1. List Head
				2. Destination Source Port

Returns:		1 = match found
				0 = no matches
-------------------------------------------------------------------------------
 */
int PortDecrypt(TARGET* listHead, tran_h * tran) {
	TARGET* pWalker=listHead;

	while(pWalker != NULL) {
		if ((tran->dst_port[0] == pWalker->dstPort[0]) && (tran->dst_port[0] == pWalker->dstPort[1])) {
			return 1;
		}
		pWalker=pWalker->nextTargetNumber;
	}

	return 0;
}
/*
-------------------------------------------------------------------------------
Function: 		ipDecrypt

Description:	Returns a 1 if a destination IP and source IP addresses match a
				port in the target list.  This is a little different than


Parameters:		1. Pointer to linked list
				2. Source IP address
				3. Destination IP address


Returns:		1 = match found
				0 = no matches
-------------------------------------------------------------------------------
 */
int IpDecrypt(TARGET* listHead,ip_h* ip) {
	TARGET* pWalker=listHead;
	int i;
	D printf("\Src: %d.%d.%d.%d, ",ip->ip_src[0],ip->ip_src[1],ip->ip_src[2],ip->ip_src[3]);

	while(pWalker != NULL) {
		if ((ip->ip_src[0] == pWalker->dstHost[0]) && (ip->ip_src[1] == pWalker->dstHost[1]) && (ip->ip_src[2] == pWalker->dstHost[2]) && (ip->ip_src[3] == pWalker->dstHost[3])) {
			D printf("found target!\n");
			return 1;
		}
		pWalker=pWalker->nextTargetNumber;
	}
	D printf("no valid target found, forwarding.\n");
	return 0;

}

/*
-------------------------------------------------------------------------------
Function: 		natDecrypt

Description:	NAT is a special condition that will require 3 conditions
				to be met before it is decided whether or not to decrypt
					1. Target Destination IP Address
					2. Target Destination Port Number
					3. Target Source Port Number

Parameters:		1. listHead
				2. Destination IP Address
				3. Destination Port
				4. Source Port

Returns:		1 = match found
				0 = no matches
-------------------------------------------------------------------------------
 */
int NatDecrypt(TARGET* listHead, ip_h* ip, tran_h* tran ) {
	TARGET* pWalker=listHead;

	while(pWalker != NULL) {
		if ((ip->ip_dst[0] == pWalker->dstHost[0]) && (ip->ip_dst[1] == pWalker->dstHost[1]) && (ip->ip_dst[2] == pWalker->dstHost[2]) && (ip->ip_dst[3] == pWalker->dstHost[3])) {
			if ((tran->dst_port[0] == pWalker->dstPort[0]) && (tran->dst_port[0] == pWalker->dstPort[1])) {
				if ((tran->src_port[0] == pWalker->srcPort[0]) && (tran->src_port[0] == pWalker->srcPort[1])) {
					return 1;
				}
			}
		}
		pWalker=pWalker->nextTargetNumber;
	}
	return 0;
}

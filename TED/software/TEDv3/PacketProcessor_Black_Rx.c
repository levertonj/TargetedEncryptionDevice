#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#include "Header_Template.h"
#include "TargetList.h"
#include "PacketProcessor_Black_Rx.h"
#include "DecryptCheck.h"
#include "Target_Constants.h"
#include "crypto.h"


#ifdef DEBUG_B
#define B if(1)
#else
#define B if(0)
#endif

PacketProcessor_Black_Rx(void * packet) {
	 /*
	-------------------------------------------------------------------------------
	Variable Declarations
	-------------------------------------------------------------------------------
	*/

	int offset = 0;
	int decryptFound = 0;
	int ipHeaderSize = 0;
	int transportHeaderSize = 0;
	int opMode = 0;
	int dataLength = 0;
	unsigned int injectionVector;
	unsigned char saltMSB;
	unsigned char saltLSB;
	extern TARGET* headNumber;
	extern volatile CRYPTO_t * Decryptor;

		//opMode = 0,1,2
		//0 = IP Targeting
		//1 = Port Targeting
		//2 = IP:Port Targetting
		//3 = NAT Targetting

	ip_h * ip;
	eth_h * eth;
	tran_h * tran;
	udp_h * udp;

	 /*
	-------------------------------------------------------------------------------
	Get Header Values
	-------------------------------------------------------------------------------
	*/
		void *packet_pointer = &packet;

		 /*
		-------------------------------------------------------------------------------
		Link Layer
		-------------------------------------------------------------------------------
		*/
		eth = (eth_h*) packet_pointer;
		packet_pointer += ETH_HEADER_SIZE;

		 /*
		-------------------------------------------------------------------------------
		Network Layer
		-------------------------------------------------------------------------------
		*/
		ip = (ip_h*) packet_pointer;
		if(ip->verIHL != 0x45) {
			ipHeaderSize = (ip->verIHL[0]-69)*4;
		}
		ipHeaderSize += IP_HEADER_SIZE;
		packet_pointer += ipHeaderSize;

		 /*
		-------------------------------------------------------------------------------
		Transport Layer
		-------------------------------------------------------------------------------
		*/
		tran = (tran_h*) packet_pointer;
		if ((*(char*)ip->protocol) == 0x11) {
			udp = (udp_h*) tran;
			transportHeaderSize = 8;
		} else if ((*(char*)ip->protocol) == 0x06) {
			transportHeaderSize = 20;
			if (tran->tcp_length[0] != 50) {
				transportHeaderSize += (tran->tcp_length[0] - 50) * (4 / 10);
			}
		}

		 /*
		-------------------------------------------------------------------------------
		Data
		-------------------------------------------------------------------------------
		*/
		dataLength = ((int) (256 * ip->totalLength[0]) + (int) ip->totalLength[1])
				- (transportHeaderSize + ipHeaderSize);

		packet_pointer += transportHeaderSize;

	 /*
	-------------------------------------------------------------------------------
	Dissect Packet
	-------------------------------------------------------------------------------
	*/
	B printf("\nTesting TED Packet coming through BLACK:\n");
	if(Ipv4PacketBlack(eth)) {
		B printf("\tIPV4 found, keep checking\n");
		if(!IcmpPacketBlack(ip)) {
			switch(opMode) {
				case 0 :
					if(IpDecrypt(headNumber,ip)) {
						decryptFound = 1;
					}
					break;

				case 1 :
					if(PortDecrypt(headNumber,tran)) {
						decryptFound = 1;
					}
					break;

				case 2 :

					if(IpDecrypt(headNumber,ip) && PortDecrypt(headNumber,tran)) {
						decryptFound = 1;
					}
					break;

				case 3 :
					if(NatDecrypt(headNumber,ip,tran)) {
						decryptFound = 1;
					}
					break;

				default:
					break;
			} //switch(opMode) end

			if(decryptFound == 1) {
				B printf("\tBeginning decryption:\n");
				//salt is the packet ID which is

				saltMSB = ip->packetID[0];
				saltLSB = ip->packetID[1];

				injectionVector = (saltMSB << 24) | (saltLSB << 16)
						| (saltMSB << 8) | saltLSB;

				B printf("\t\tIP ID is 0x%x%x", saltMSB, saltLSB);
				Decryptor->injectionVector = injectionVector;
				B printf(", Decryptor IV is 0x%.8x\n", Decryptor->injectionVector);

				Decryptor->readStart = (unsigned int) packet_pointer;
				Decryptor->writeStart = (unsigned int) packet_pointer;
				Decryptor->transferLength = (unsigned int) dataLength;
				B printf("\t\tDecryptor read start is 0x%.8x\n", Decryptor->readStart);
				B printf("\t\tDecryptor write start is 0x%.8x\n", Decryptor->writeStart);
				B printf("\t\tDecryptor length is %d\n", Decryptor->transferLength);

				B printf("\t\tStarted decryption");
				Decryptor->control = DECRYPT;
				while(Decryptor->status != 0){
					B printf(".");
				}
				B printf(". DONE!\n");
			}

		}//ICMP check
		else {
			///////////////////////////////////
			//ICMP packet processing goes here
			///////////////////////////////////
		}
	} //If to check ipv4
	else {
		//not ipv4 -> Forward
	}

}



/*
-------------------------------------------------------------------------------
Function: 		Ipv4PacketBlack

Description:	Tests if the received packet is an IPv4 packet.

Parameters:		1. eth struct

Returns:		Returns 1 if Admin Packet Detected.
				Returns 0 for all other cases.
-------------------------------------------------------------------------------
*/

int Ipv4PacketBlack(eth_h* eth) {
	B printf("\tpacket type : 0x%0.2x%0.2x", eth->eth_protocol[0],
				eth->eth_protocol[1]);
	if (eth->eth_protocol[0] == 0x08 && eth->eth_protocol[1] == 0x00) {
		B printf(" is a valid type, keep checking\n");
		return 1;
	} else {
		B printf(" is not a valid type, forwarding.\n");
		return 0;
	}

}

/*
-------------------------------------------------------------------------------
Function: 		IcmpPacketBlack

Description:	Tests if the received packet is an ICMP packet.

Parameters:		1. ip struct

Returns:		Returns 1 if ICMP Packet Detected.
				Returns 0 for all other cases.
-------------------------------------------------------------------------------
*/

int IcmpPacketBlack(ip_h* ip) {
	B printf("\tProtocol: 0x%x, ", *(char*)ip->protocol);
	if ((*(char*)ip->protocol) == 0x01) {
		B printf("ICMP, forwarding.\n");
		return 1;
	} else {
		B printf("NOT ICMP, keep checking\n");
		return 0;
	}

}

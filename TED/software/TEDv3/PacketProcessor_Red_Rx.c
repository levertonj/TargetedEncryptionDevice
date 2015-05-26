#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#include "Header_Template.h"
#include "TargetList.h"
#include "PacketProcessor_Red_Rx.h"
#include "Target_Constants.h"
#include "EncryptCheck.h"
#include "crypto.h"
#include "altera_up_avalon_character_lcd.h"
#include "lcd.h"
#include "unistd.h"

#ifdef DEBUG_R
#define R if(1)
#else
#define R if(0)
#endif

///////////////////////////////////////////////////////////////////////////////
//
//     Test Packet Data, meant to simulate byte addressable memory. (Big Endian)
//
///////////////////////////////////////////////////////////////////////////////
//0: aa aa aa aa aa aa bb bb
//1: bb bb bb bb cc cc dd ee
//2: ff ff gg gg hh hh ii jj
//3: kk kk ll ll ll ll mm mm
//4: mm mm

//a = src mac
//b = dst mac
//c = protocol
//d = version / IHL
//f = total length
//g = id
//j = protocol (ICMP, TCP, UDP)
//k = checksum
//l = source IP
//m = destin IP

unsigned char PacketProcessor_Red_Rx(void * packet) {

	/*
	 -------------------------------------------------------------------------------
	 Variable Declarations
	 -------------------------------------------------------------------------------
	 */

	int encryptFound = 0;
	int ipHeaderSize = 0;
	int transportHeaderSize = 0;
	int opMode = 0;
	int dataLength = 0;
	unsigned char saltMSB;
	unsigned char saltLSB;
	extern TARGET* headNumber;
	extern volatile CRYPTO_t * Encryptor;
	extern volatile alt_up_character_lcd_dev* LCD;

	//opMode = 0,1,2
	//0 = IP Targeting
	//1 = Port Targeting
	//2 = IP:Port Targetting
	//3 = NAT Targetting

	ip_h * ip;
	eth_h * eth;
	tran_h * tran;
	admin_h *admin;
	udp_h * udp;

	/*
	 -------------------------------------------------------------------------------
	 Initialize the Linked List
	 -------------------------------------------------------------------------------
	 */
	//	TARGET* headNumber = NULL;
	//	headNumber = InitializeTargetList(headNumber);
	//	headNumber = PrintTargetList(headNumber);
	/*
	 -------------------------------------------------------------------------------
	 Get Header Values
	 -------------------------------------------------------------------------------
	 */
	void* packet_pointer = packet;

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
	if (ip->verIHL != 0x45) {
		ipHeaderSize = (ip->verIHL[0] - 69) * 4;
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
		transportHeaderSize = 4* (tran->tcp_length[0] >> 4);
	}

	/*
	 -------------------------------------------------------------------------------
	 Data
	 -------------------------------------------------------------------------------
	 */
	dataLength = ((int) (256 * ip->totalLength[0]) + (int) ip->totalLength[1])
			- (transportHeaderSize + ipHeaderSize);
	//printf("DL: %x\n", (unsigned int) dataLength);
	packet_pointer += transportHeaderSize;

	/*
	 -------------------------------------------------------------------------------
	 Dissect Packet
	 -------------------------------------------------------------------------------
	 */

	R printf("\nTesting TED Packet coming through RED:\n");
	if (AdminPacket(ip)) {
		R printf("\tAdmin packet found\n");
		admin = (admin_h*) packet_pointer;
		headNumber = ProcessAdminPacket(admin, headNumber);
		return 1;
	} else {
		if ((Ipv4PacketRed(eth) == 1) && (dataLength != 0)) {
			R printf("\tIPV4 found, keep checking\n");
			if (!IcmpPacketRed(ip)) {
				encryptFound = 0;
				switch (opMode) {
				case 0:
					if (IpEncrypt(headNumber, ip)) {
						encryptFound = 1;
					}
					break;

				case 1:
					if (PortEncrypt(headNumber, tran)) {
						encryptFound = 1;
					}
					break;

				case 2:
					if (IpEncrypt(headNumber, ip)
							&& PortEncrypt(headNumber, tran)) {
						encryptFound = 1;
					}
					break;

				case 3:
					if (NatEncrypt(headNumber, ip, tran)) {
						encryptFound = 1;
					}
					break;

				default:
					break;
				} //switch(opMode) end

				if (encryptFound == 1) {
					R printf("\tBeginning encryption:\n");
					//salt is the packet ID which is

					saltMSB = ip->packetID[0];
					saltLSB = ip->packetID[1];

					R printf("\t\tIP ID is 0x%x%x", saltMSB, saltLSB);
					Encryptor->injectionVector = (saltMSB << 24) | (saltLSB << 16) | (saltMSB << 8) | saltLSB;;
					R printf(", Encryptor IV is 0x%.8x\n", Encryptor->injectionVector);

					Encryptor->readStart = (unsigned int) packet_pointer;
					Encryptor->writeStart = (unsigned int) packet_pointer;
					Encryptor->transferLength = (unsigned int) dataLength;
					R printf("\t\tEncryptor read start is 0x%.8x\n", Encryptor->readStart);
					R printf("\t\tEncryptor write start is 0x%.8x\n", Encryptor->writeStart);
					R printf("\t\tEncryptor length is %d\n", Encryptor->transferLength);

					R printf("\t\tStarted encryption");
					Encryptor->control = ENCRYPT;
					R printf(". DONE!\n");
					return 2;

				} else {
					//no encryption -> Forward
				}

			} //ICMP check
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
	return 0;
}

	/*
	 -------------------------------------------------------------------------------
	 Function: 		AdminPacket

	 Description:	Tests if the received packet is an admin packet.
p
	 Parameters:		1. ip Struct

	 Returns:		Returns 1 if Admin Packet Detected.
	 Returns 0 for all other cases.
	 -------------------------------------------------------------------------------
	 */

	int AdminPacket(ip_h* ip) {
		if ((*(unsigned int*)(ip->ip_dst)) == 0x0a0a0a0a){
		//if (ip->ip_dst[0] == 0x0a && ip->ip_dst[1] == 0x0a
		//		&& ip->ip_dst[2] == 0x0a && ip->ip_dst[3] == 0x0a) {
			return 1;
		} else {
			return 0;
		}

	}

	/*
	 -------------------------------------------------------------------------------
	 Function: 		Ipv4PacketRed

	 Description:	Tests if the received packet is an IPv4 packet.

	 Parameters:		1. eth struct

	 Returns:		Returns 1 if Admin Packet Detected.
	 Returns 0 for all other cases.
	 -------------------------------------------------------------------------------
	 */

	int Ipv4PacketRed(eth_h* eth) {
		R printf("\tpacket type : 0x%.2x%.2x", eth->eth_protocol[0], eth->eth_protocol[1]);
		if ((*(unsigned short*)(eth->eth_protocol)) == 0x0008){
		//if (eth->eth_protocol[0] == 0x08 && eth->eth_protocol[1] == 0x00) {
			R printf(" is a valid type, keep checking\n");
			return 1;
		} else {
			R printf(" is not a valid type, forwarding.\n");
			return 0;
		}

	}

	/*
	 -------------------------------------------------------------------------------
	 Function: 		IcmpPacketRed

	 Description:	Tests if the received packet is an ICMP packet.

	 Parameters:		1. ip struct

	 Returns:		Returns 1 if ICMP Packet Detected.
	 Returns 0 for all other cases.
	 -------------------------------------------------------------------------------
	 */

	int IcmpPacketRed(ip_h* ip) {
		R printf("\tProtocol: 0x%x, ", *(char*)ip->protocol);
		if ((*(char*)ip->protocol) == 0x01) {
			R printf("ICMP, forwarding.\n");
			return 1;
		} else {
			R printf("NOT ICMP, keep checking\n");
			return 0;
		}

	}

	/*
	 -------------------------------------------------------------------------------
	 Function: 		ProcessAdminPacket

	 Description:	Extracts data from an admin packet and applies it to the system

	 Parameters:		1. admin struct
	 2. TARGET head

	 Returns:		The head of the target linked list.
	 -------------------------------------------------------------------------------
	 */

	TARGET* ProcessAdminPacket(admin_h* admin, TARGET* headNumber) {
		extern volatile CRYPTO_t * Encryptor;
		extern volatile alt_up_character_lcd_dev* LCD;
		char* string[20];
		int i;
		R printf("Admin Trigger: \n");


		R printf("\tKey8: %x\n", admin->key8[0]);
		R printf("\tKey16: %x\n", (admin->key16[0] << 8 ) | admin->key16[1]);
		R printf("\tKey32: %x\n", (admin->key32[0] << 24 ) |(admin->key32[1] << 16 ) | (admin->key32[2] << 8 ) | admin->key32[3]);
		R printf("\tIpSrc: %x.%x.%x.%x\n", admin->ipsrc1[0], admin->ipsrc1[1], admin->ipsrc1[2],admin->ipsrc1[3]);
		R printf("\tIpDst: %x.%x.%x.%x\n", admin->ipdst1[0], admin->ipdst1[1], admin->ipdst1[2],admin->ipdst1[3]);
		R printf("\tPtSrc: %x\n", (admin->srcport1[0] << 8 ) | admin->srcport1[1]);
		R printf("\tPtDst: %x\n", (admin->dstport1[0] << 8 ) | admin->dstport1[1]);

		headNumber->nextTargetNumber = NULL;

		headNumber = AddTarget(headNumber, 0, admin->ipsrc1,
				 admin->ipdst1, admin->srcport1,
				 admin->dstport1);
		headNumber = AddTarget(headNumber, 1, admin->ipsrc2,
				 admin->ipdst2, admin->srcport2,
				 admin->dstport2);
		headNumber = AddTarget(headNumber, 2, admin->ipsrc3,
				 admin->ipdst3, admin->srcport3,
				 admin->dstport3);


		R printf("\n");
		R printf("Old key8key16: 0x%08x\n", (unsigned int)Encryptor->key8key16);
		Encryptor->key8key16 = (((admin->key8[0]) << 16) | ((admin->key16[1]) << 8) | (admin->key16[0]));
		R printf("New key8key16: 0x%08x\n", (unsigned int)Encryptor->key8key16);
		R printf("Old key32: 0x%08x\n", (unsigned int)Encryptor->key32);
		Encryptor->key32 = (((admin->key32[3]) << 24) | ((admin->key32[2]) << 16) | ((admin->key32[1]) << 8) | ((admin->key32[0])));
		R printf("New key32: 0x%08x\n", (unsigned int)Encryptor->key32);
		R printf("LCD: %x",&LCD);

		alt_up_character_lcd_set_cursor_pos(LCD, 0, 0);
		alt_up_character_lcd_string(LCD, "                ");
		alt_up_character_lcd_set_cursor_pos(LCD, 0, 0);
		sprintf(string, "%d.%d.%d.%d", headNumber->nextTargetNumber->srcHost[0], headNumber->nextTargetNumber->srcHost[1], headNumber->nextTargetNumber->srcHost[2], headNumber->nextTargetNumber->srcHost[3]);
		alt_up_character_lcd_string(LCD, string);
		alt_up_character_lcd_set_cursor_pos(LCD, 0, 1);
		alt_up_character_lcd_string(LCD, "                ");
		alt_up_character_lcd_set_cursor_pos(LCD, 0, 1);
		sprintf(string, "%d.%d.%d.%d", headNumber->nextTargetNumber->dstHost[0], headNumber->nextTargetNumber->dstHost[1], headNumber->nextTargetNumber->dstHost[2], headNumber->nextTargetNumber->dstHost[3]);
		alt_up_character_lcd_string(LCD, string);

		return headNumber;

	}

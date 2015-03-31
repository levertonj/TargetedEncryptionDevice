#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#include "Header_Template.h"
#include "TargetList.h"
#include "PacketProcessor_Red_Rx.h"
#include "Target_Constants.h"
#include "EncryptCheck.h"
#include "crypto.h"

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
	int injectionVector = 0;
	extern TARGET* headNumber;
	extern volatile CRYPTO_t * Encryptor;

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

	R printf("\nTesting TED Packet coming through RED:\n");
	if (AdminPacket(ip)) {
		R printf("\tAdmin packet found\n");
		admin = (admin_h*) packet_pointer;
		headNumber = ProcessAdminPacket(admin, headNumber);
		return 1;
	} else {
		if (Ipv4PacketRed(eth)) {
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

					injectionVector = (saltMSB << 24) | (saltLSB << 16)
							| (saltMSB << 8) | saltLSB;

					R printf("\t\tIP ID is 0x%x%x", saltMSB, saltLSB);
					Encryptor->injectionVector = injectionVector;
					R printf(", Encryptor IV is 0x%.8x\n", Encryptor->injectionVector);

					Encryptor->readStart = (unsigned int) packet_pointer;
					Encryptor->writeStart = (unsigned int) packet_pointer;
					Encryptor->transferLength = (unsigned int) dataLength;
					R printf("\t\tEncryptor read start is 0x%.8x\n", Encryptor->readStart);
					R printf("\t\tEncryptor write start is 0x%.8x\n", Encryptor->writeStart);
					R printf("\t\tEncryptor length is %d\n", Encryptor->transferLength);

					R printf("\t\tStarted encryption");
					Encryptor->control = ENCRYPT;
					while(Encryptor->status != 0){
						R printf(".");
					}
					R printf(". DONE!\n");

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

	 Parameters:		1. ip Struct

	 Returns:		Returns 1 if Admin Packet Detected.
	 Returns 0 for all other cases.
	 -------------------------------------------------------------------------------
	 */

	int AdminPacket(ip_h* ip) {
		if (ip->ip_dst[0] == 0x0a && ip->ip_dst[1] == 0x0a
				&& ip->ip_dst[2] == 0x0a && ip->ip_dst[3] == 0x0a) {
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
		R printf("\tpacket type : 0x%0.2x%0.2x", eth->eth_protocol[0],
					eth->eth_protocol[1]);
		if (eth->eth_protocol[0] == 0x08 && eth->eth_protocol[1] == 0x00) {
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

		//encryptor ->key8 = admin->key8
		int i;
		for (i = 0; i < 12; i++) {
			R printf("Admin Trigger %x", admin->triggers[0 + i]);
			unsigned char ip_source_target[4] = { admin->triggers[0 + i * 8],
					admin->triggers[1 + i * 8], admin->triggers[2 + i * 8],
					admin->triggers[3 + i * 8] };
			unsigned char ip_destination_target[4] = {
					admin->triggers[4 + i * 8], admin->triggers[5 + i * 8],
					admin->triggers[6 + i * 8], admin->triggers[7 + i * 8] };
			unsigned char port_source_target[2] = { admin->triggers[8 + i * 8],
					admin->triggers[9 + i * 8] };
			unsigned char port_destination_target[2] = { admin->triggers[10
					+ i * 8], admin->triggers[11 + i * 8] };

			headNumber = AddTarget(headNumber, i + 3, ip_source_target,
					ip_destination_target, port_source_target,
					port_destination_target);
		}

		return headNumber;

	}

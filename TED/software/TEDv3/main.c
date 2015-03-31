/*
 * TEDv3.c
 *
 *  Created on: Feb 19, 2015
 *      Author: Brash
 */

#include "system.h"
#include "sys/alt_stdio.h"
#include "sys/alt_irq.h"
#include <unistd.h>
#include <stdio.h>
#include "altera_up_avalon_character_lcd.h"
#include "mac.h"
#include "phy.h"
#include "sw.h"
#include "hex.h"
#include "crypto.h"
#include "led.h"
#include "list.h"
#include "altera_avalon_sgdma.h"
#include "PacketProcessor_Black_Rx.h"
#include "PacketProcessor_Red_Rx.h"
#include "TargetList.h"
#include "circular_fifo.h"
#include "altera_avalon_sgdma_regs.h"
#include "altera_avalon_sgdma_descriptor.h"

#define	RED_PHY				16
#define BLACK_PHY			17
#define SUCCESS				0
#define FAILURE				1
#define HALT				{printf("[TED.c]\tHalting\n");return 1;}
#define EBADF 9         /* Bad file number */

#define DEFAULT_KEY8		0x1
#define DEFAULT_KEY16		0x2
#define DEFAULT_KEY32		0x3

#define BUFFER_SIZE				1540
#define NUMBER_BUFFERS			24

//#define	DEBUG_I
//#define	DEBUG_D
//#define	DEBUG_R
//#define	DEBUG_B

// Initial Bootup
#ifdef DEBUG_I
 #define I if(1)
#else
 #define I if(0)
#endif

//General Debug
#ifdef DEBUG_D
 #define D if(1)
#else
 #define D if(0)
#endif

// Global Variables

// Allocate descriptors in the descriptor_memory (onchip memory)
alt_sgdma_descriptor red_rx_descriptor[NUMBER_BUFFERS]  		__attribute__ (( section ( ".descriptor_mem" ), aligned(4))) = {0};
alt_sgdma_descriptor red_tx_descriptor[NUMBER_BUFFERS]			__attribute__ (( section ( ".descriptor_mem" ), aligned(4))) = {0};
alt_sgdma_descriptor black_rx_descriptor[NUMBER_BUFFERS]  		__attribute__ (( section ( ".descriptor_mem" ), aligned(4))) = {0};
alt_sgdma_descriptor black_tx_descriptor[NUMBER_BUFFERS]		__attribute__ (( section ( ".descriptor_mem" ), aligned(4))) = {0};

// Create frame buffers in each direction
unsigned char red_to_black_frame[NUMBER_BUFFERS][BUFFER_SIZE] 	__attribute__ (( section ( ".red_to_black_memory" ))) = {};
unsigned char black_to_red_frame[NUMBER_BUFFERS][BUFFER_SIZE] 	__attribute__ (( section ( ".black_to_red_memory" )))= {};

volatile MAC_t* Black_Interface = (volatile MAC_t *) BLACK_INTERFACE_BASE;
volatile MAC_t* Red_Interface   = (volatile MAC_t *) RED_INTERFACE_BASE;
volatile SW_t*  Switches        = (volatile SW_t *) INPUT_PORT_BASE;
volatile HEX_t* HEX             = (volatile HEX_t *) HEX_BASE;
volatile CRYPTO_t * Encryptor 	= (volatile CRYPTO_t *) TED_ENCRYPTOR_BASE;
volatile CRYPTO_t * Decryptor 	= (volatile CRYPTO_t *) TED_DECRYPTOR_BASE;
volatile LED_t * LEDs			= (volatile LED_t *) OUTPUT_PORT_BASE;
volatile alt_up_character_lcd_dev* LCD;

// Create sgdma transmit and receive devices
alt_sgdma_dev * RedRx;
alt_sgdma_dev * RedTx;
alt_sgdma_dev * BlackRx;
alt_sgdma_dev * BlackTx;

TARGET* headNumber = NULL;

int main(void)
{
/*
-------------------------------------------------------------------------------
Initialize the Linked List
-------------------------------------------------------------------------------
*/
	headNumber = InitializeTargetList(headNumber);
	headNumber = PrintTargetList(headNumber);

	int i;

	struct FIFO RedRx_FIFO;
	initialize_fifo(&RedRx_FIFO, NUMBER_BUFFERS);
	struct FIFO RedTx_FIFO;
	initialize_fifo(&RedTx_FIFO, NUMBER_BUFFERS);
	struct FIFO BlackRx_FIFO;
	initialize_fifo(&BlackRx_FIFO, NUMBER_BUFFERS);
	struct FIFO BlackTx_FIFO;
	initialize_fifo(&BlackTx_FIFO, NUMBER_BUFFERS);

	I printf("RedRx available: %d\n", RedRx_FIFO.available);
	I printf("RedTx available: %d\n", RedTx_FIFO.available);
	I printf("BlackRx available: %d\n", BlackRx_FIFO.available);
	I printf("BlackTx available: %d\n", BlackTx_FIFO.available);

	char fstRedRx 	= -1;
	char fstRedTx 	= -1;
	char fstBlackRx = -1;
	char fstBlackTx = -1;
	char nxtRedRx	= 0;
	char nxtRedTx	= 0;
	char nxtBlackRx	= 0;
	char nxtBlackTx	= 0;

	I printf("[TED.c]\tStarting Initialization\n");

	//Initialize Crypto
 	printf("[TED.c]\tInitialize Crypto\n");
 	printf("[TED.c]\t\tInitialize Encryptor\n");
 	Encryptor->key8key16 = (DEFAULT_KEY8 << 16) | (DEFAULT_KEY16);
 	printf ("[TED.c]\t\tKey8 and Key16 set to: 0x%.8x\n", Encryptor->key8key16);
 	Encryptor->key32 = DEFAULT_KEY32;
 	printf ("[TED.c]\t\tKey32 set to: 0x%.8x\n", Encryptor->key32);
 	printf("[TED.c]\t\tInitialize Encryptor (SUCCESS)\n");
 	printf("[TED.c]\t\tInitialize Decryptor\n");
 	Decryptor->key8key16 = (DEFAULT_KEY8 << 16) | (DEFAULT_KEY16);
 	printf ("[TED.c]\t\tKey8 and Key16 set to: 0x%.8x\n", Encryptor->key8key16);
 	Decryptor->key32 = DEFAULT_KEY32;
 	printf ("[TED.c]\t\tKey32 set to: 0x%.8x\n", Encryptor->key32);
 	printf("[TED.c]\t\tInitialize Decryptor (SUCCESS)\n");
 	printf("[TED.c]\tInitialize Crypto (SUCCESS)\n");

	//Initialize LEDs
 	I printf("[TED.c]\tInitialize LEDs\n");
	if (ledInit(LEDs) != SUCCESS) HALT

    //Initialize switches for desired link settings
 	I printf("[TED.c]\tInitialize Switches\n");
	if (swInit(Switches) != SUCCESS) HALT
	swPrintStatus(Switches);
	LEDs->DATA |= 0x2;

	//Bring up the HEX display counter
	I printf("[TED.c]\tInitialize Hex display\n");
	if (hexInit(HEX) != SUCCESS) HALT
	HEX->redFrames = 0;
	HEX->blackFrames = 0;
	LEDs->DATA |= 0x4;

	//Bring up the LCD
	I printf("[TED.c]\tInitialize LCD\n");
	if (lcdInit(LCD) != SUCCESS) HALT
	LEDs->DATA |= 0x8;

	//Bring up the Red Interface
	I printf("[TED.c]\tInitialize Red Interface MAC\n");
	// Initialize the MAC address
	Red_Interface->mac_0 = 0x116E6001;
	Red_Interface->mac_1 = 0x00000F02;
	// Specify the addresses of the PHY devices to be accessed through MDIO interface
	Red_Interface->mdio_addr0 = 0x10;
	Red_Interface->mdio_addr1 = 0x10;
	if (macInit(Red_Interface, ((Switches->DATA) >> RED_OFFSET)& 0x3F) != SUCCESS) HALT
	macPrintRegs(Red_Interface);
	Red_Interface->pause_quant = 0xffff;
	Red_Interface->rx_section_empty = 4096 - 16;
	Red_Interface->rx_section_full = 0;
	Red_Interface->tx_section_empty = 2048 - 16;
	Red_Interface->tx_section_full = 0;
	Red_Interface->rx_almost_empty = 8;
	Red_Interface->rx_almost_full = 8;
	Red_Interface->tx_almost_empty = 8;
	Red_Interface->tx_almost_full = 8;
	Red_Interface->holdoff_quant = 0x00ff;
	I printf("Pause Quant : 0x%.4x\n",Red_Interface->pause_quant);
	I printf("RX Empty : 0x%.4x\n",Red_Interface->rx_section_empty);
	I printf("RX Full : 0x%.4x\n",Red_Interface->rx_section_full);
	I printf("TX Empty : 0x%.4x\n",Red_Interface->tx_section_empty);
	I printf("TX Full : 0x%.4x\n",Red_Interface->tx_section_full);
	I printf("RX Almost Empty 0x%.4x\n",Red_Interface->rx_almost_empty);
	I printf("RX Almost full 0x%.4x\n",Red_Interface->rx_almost_full);
	I printf("TX Almost Empty 0x%.4x\n",Red_Interface->tx_almost_empty);
	I printf("TX Almost full 0x%.4x\n",Red_Interface->tx_almost_full);

	// Open the RedRx DMA receive device
	RedRx = alt_avalon_sgdma_open ("/dev/red_rx");
	if (RedRx == NULL) {
		I printf("Error: could not open RedRx DMA receive device\n");
		return -1;
	} else I printf("Opened RedRx DMA receive device\n");
	// Open the RedTx DMA transmit device
	RedTx = alt_avalon_sgdma_open ("/dev/red_tx");
	if (RedTx == NULL) {
		I printf("Error: could not open RedTx DMA transmit device\n");
		return -1;
	} else I printf("Opened RedTx DMA transmit device\n");
	for (i = 0; i < NUMBER_BUFFERS-1; i++){
		red_rx_descriptor[i].next = &red_rx_descriptor[i+1];
		red_tx_descriptor[i].next = &red_tx_descriptor[i+1];
	}
	red_rx_descriptor[NUMBER_BUFFERS-1].next = &red_rx_descriptor[0];
	red_tx_descriptor[NUMBER_BUFFERS-1].next = &red_tx_descriptor[0];
	//Done With the Red Interface!


	LEDs->DATA |= 0x10;

	//Bring up the Black interface
	I printf("[TED.c]\tInitialize Black Interface MAC\n");
	// Initialize the MAC address
	Black_Interface->mac_0 = 0x116E6001;
	Black_Interface->mac_1 = 0x00000F02;
	// Specify the addresses of the PHY devices to be accessed through MDIO interface
	Black_Interface->mdio_addr0 = 0x11;
	Black_Interface->mdio_addr1 = 0x11;
	if (macInit(Black_Interface, ((Switches->DATA) >> BLACK_OFFSET)& 0x3F) != SUCCESS) HALT
	macPrintRegs(Black_Interface);
	Black_Interface->pause_quant = 0xffff;
	Black_Interface->rx_section_empty = 4096 - 16;
	Black_Interface->rx_section_full = 0;
	Black_Interface->tx_section_empty = 2048 - 16;
	Black_Interface->tx_section_full = 0;
	Black_Interface->rx_almost_empty = 8;
	Black_Interface->rx_almost_full = 8;
	Black_Interface->tx_almost_empty = 8;
	Black_Interface->tx_almost_full = 8;
	Black_Interface->holdoff_quant = 0x00ff;
	I printf("Pause Quant : 0x%.4x\n",Black_Interface->pause_quant);
	I printf("RX Empty : 0x%.4x\n",Black_Interface->rx_section_empty);
	I printf("RX Full : 0x%.4x\n",Black_Interface->rx_section_full);
	I printf("TX Empty : 0x%.4x\n",Black_Interface->tx_section_empty);
	I printf("TX Full : 0x%.4x\n",Black_Interface->tx_section_full);
	I printf("RX Almost Empty 0x%.4x\n",Black_Interface->rx_almost_empty);
	I printf("RX Almost full 0x%.4x\n",Black_Interface->rx_almost_full);
	I printf("TX Almost Empty 0x%.4x\n",Black_Interface->tx_almost_empty);
	I printf("TX Almost full 0x%.4x\n",Black_Interface->tx_almost_full);
	// Open the BlackRx DMA receive device
	BlackRx = alt_avalon_sgdma_open ("/dev/black_rx");
	if (BlackRx == NULL) {
		return -1;
	} else I printf("Opened BlackRx DMA receive device\n");
	// Open the BlackTx DMA transmit device
	BlackTx = alt_avalon_sgdma_open ("/dev/black_tx");
	if (BlackTx == NULL) {

		return -1;
	} else I printf("Opened BlackTx DMA transmit device\n");
	for (i = 0; i < NUMBER_BUFFERS-1; i++){
		black_rx_descriptor[i].next = &black_rx_descriptor[i+1];
		black_tx_descriptor[i].next = &black_tx_descriptor[i+1];
	}
	black_rx_descriptor[NUMBER_BUFFERS-1].next = &black_rx_descriptor[0];
	black_tx_descriptor[NUMBER_BUFFERS-1].next = &black_tx_descriptor[0];
	//Done With the Black Interface!
	LEDs->DATA |= 0x20;

	//Linked list initialization
	struct frame_list availableListRed, rxListRed, inspectListRed, controlListRed, encryptListRed, readyTxListRed, txListRed;
	struct frame_list availableListBlack, rxListBlack, inspectListBlack, controlListBlack, encryptListBlack, readyTxListBlack, txListBlack;
	struct list_head *pos, *q;
	struct frame_list *tmp;
	INIT_LIST_HEAD(&availableListRed.list);
	INIT_LIST_HEAD(&rxListRed.list);
	INIT_LIST_HEAD(&inspectListRed.list);
	INIT_LIST_HEAD(&controlListRed.list);
	INIT_LIST_HEAD(&encryptListRed.list);
	INIT_LIST_HEAD(&readyTxListRed.list);
	INIT_LIST_HEAD(&txListRed.list);
	INIT_LIST_HEAD(&availableListBlack.list);
	INIT_LIST_HEAD(&rxListBlack.list);
	INIT_LIST_HEAD(&inspectListBlack.list);
	INIT_LIST_HEAD(&encryptListBlack.list);
	INIT_LIST_HEAD(&readyTxListBlack.list);
	INIT_LIST_HEAD(&txListBlack.list);
	//Spool up the available lists
	struct frame_list temp[NUMBER_BUFFERS*2];
	for(i = 0; i < NUMBER_BUFFERS; i++){
		temp[i].frameStart			= &(red_to_black_frame[i]);
		temp[i].frameLength 		= 0;
		temp[i].payloadLength 		= 0;
		temp[i].payloadStart		= 0;

		temp[i+NUMBER_BUFFERS].frameStart		= &(black_to_red_frame[i]);
		temp[i+NUMBER_BUFFERS].frameLength 		= 0;
		temp[i+NUMBER_BUFFERS].payloadLength 	= 0;
		temp[i+NUMBER_BUFFERS].payloadStart		= 0;

		// add the new items 'temp' to the list of items in the availableList
		list_add_tail(&(temp[i].list), &(availableListRed.list));
		list_add_tail(&(temp[i+NUMBER_BUFFERS].list), &(availableListBlack.list));
	}

	i = 0;
	I printf("\nRed Available List\n");
	for (pos = (&availableListRed.list)->next, q = pos->next; pos != (&availableListRed.list); pos = q, q = pos->next){
		 tmp = list_entry(pos, struct frame_list, list);
		 I printf("Address of %d is: %x\n", i++, tmp->frameStart);
	}
	i = 0;
	I printf("\nBlack Available List\n");
	for (pos = (&availableListBlack.list)->next, q = pos->next; pos != (&availableListBlack.list); pos = q, q = pos->next){
		 tmp = list_entry(pos, struct frame_list, list);
		 I printf("Address of %d is: %x\n", i++, tmp->frameStart);
	}

	//Wait for both interfaces to establish link
	while (((Black_Interface->mdio_PHY_PHYSSR & 0x400) != 0x400) || ((Red_Interface->mdio_PHY_PHYSSR & 0x400) != 0x400)){
    };
	LEDs->DATA |= 0xC0;

	IOWR_ALTERA_AVALON_SGDMA_CONTROL(RED_RX_BASE, 0);
	IOWR_ALTERA_AVALON_SGDMA_CONTROL(BLACK_RX_BASE, 0);
	I printf("Red Rx Control: %8x\n", (IORD_ALTERA_AVALON_SGDMA_CONTROL(RED_RX_BASE)));
	I printf("Black Rx Control: %8x\n", (IORD_ALTERA_AVALON_SGDMA_CONTROL(BLACK_RX_BASE)));
	I printf("Red Tx Control: %8x\n", (IORD_ALTERA_AVALON_SGDMA_CONTROL(RED_TX_BASE)));
	I printf("Black Tx Control: %8x\n", (IORD_ALTERA_AVALON_SGDMA_CONTROL(BLACK_TX_BASE)));
	I printf("BLK 0x%.4x\n", Black_Interface->mdio_PHY_PHYSSR);
	I printf("RED 0x%.4x\n", Red_Interface->mdio_PHY_PHYSSR);

	// Enable read and write transfers, gigabit Ethernet operation, and CRC forwarding
	Black_Interface->command_config |= (CC_TX_ENA | CC_RX_ENA);
	Red_Interface->command_config 	|= (CC_TX_ENA | CC_RX_ENA);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	SUPER LOOP BEGINS HERE
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	unsigned int led_count = 0;
	while (1){
		//LED Heartbeat!
		led_count++;
		if (led_count > 1000){
			LEDs->DATA ^= 0x100;
		}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	1.	Inspect nodes from availableList*.list pump them into the respective rx descriptors, then move nodes to the rxList*.list
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		D printf("\n----------Available List\n");
		D printf("-----Red\n");
		fstRedRx = -1;
		for (pos = (&availableListRed.list)->next, q = pos->next; pos != (&availableListRed.list); pos = q, q = pos->next){
			tmp = list_entry(pos, struct frame_list, list);

			if(RedRx_FIFO.available == 1){
				//No SPACE!
				break;
			} else {

				//We have available room on the List, and Available Buffer Room
				if (fstRedRx == -1){
					fstRedRx = RedRx_FIFO.WritePos;
				}

				if (RedRx_FIFO.WritePos == (RedRx_FIFO.size - 1)){
					nxtRedRx = 0;
				} else {
					nxtRedRx = (RedRx_FIFO.WritePos + 1);
				}
				//Construct and send new descriptors
				alt_avalon_sgdma_construct_stream_to_mem_desc(&red_rx_descriptor[RedRx_FIFO.WritePos],&red_rx_descriptor[nxtRedRx],tmp->frameStart,0,0);
			}

			D printf("Available Space: %d,  \tRed WP: %d, \Red Nxt: %d,  \tAddr: 0x%08.8x\n", RedRx_FIFO.available, RedRx_FIFO.WritePos, nxtRedRx, tmp->frameStart);
			D printf("New Desc C: %x, S: %x, Next Desc C: %x, S: %x\n\n", red_rx_descriptor[RedRx_FIFO.WritePos].control, red_rx_descriptor[RedRx_FIFO.WritePos].status, red_rx_descriptor[nxtRedRx].control, red_rx_descriptor[nxtRedRx].status);
			list_move_tail(&(tmp->list), &(rxListRed.list));

			//Increment the write position
			add_to_fifo(&RedRx_FIFO);
		}
		//Check if we actually made a new list of descriptors
		if(fstRedRx != -1){
			D printf("REDRX BASE C: %x\n", (IORD_ALTERA_AVALON_SGDMA_CONTROL(RED_RX_BASE)));
			D printf("REDRX BASE S: %x\n", (IORD_ALTERA_AVALON_SGDMA_STATUS(RED_RX_BASE)));
			while ((IORD_ALTERA_AVALON_SGDMA_STATUS(RED_RX_BASE)) & 0x10 != 0){
				D printf("F");
			};
			alt_avalon_sgdma_do_async_transfer(RedRx,&red_rx_descriptor[fstRedRx]);
		}

		D printf("-----Black\n");
		fstBlackRx = -1;
		for (pos = (&availableListBlack.list)->next, q = pos->next; pos != (&availableListBlack.list); pos = q, q = pos->next){
			tmp = list_entry(pos, struct frame_list, list);

			if(BlackRx_FIFO.available == 1){
				//No SPACE!
				break;
			} else {

				//We have available room on the List, and Available Buffer Room
				if (fstBlackRx == -1){
					fstBlackRx = BlackRx_FIFO.WritePos;
				}

				if (BlackRx_FIFO.WritePos == (BlackRx_FIFO.size - 1)){
					nxtBlackRx = 0;
				} else {
					nxtBlackRx = (BlackRx_FIFO.WritePos + 1);
				}
				//Construct and send new descriptors
				alt_avalon_sgdma_construct_stream_to_mem_desc(&black_rx_descriptor[BlackRx_FIFO.WritePos],&black_rx_descriptor[nxtBlackRx],tmp->frameStart,0,0);
			}

			D printf("Available Space: %d,  \tBlack WP: %d, \Black Nxt: %d,  \tAddr: 0x%08.8x\n", BlackRx_FIFO.available, BlackRx_FIFO.WritePos, nxtBlackRx, tmp->frameStart);
			D printf("New Desc C: %x, S: %x, Next Desc C: %x, S: %x\n\n", black_rx_descriptor[BlackRx_FIFO.WritePos].control, black_rx_descriptor[BlackRx_FIFO.WritePos].status, black_rx_descriptor[nxtBlackRx].control, black_rx_descriptor[nxtBlackRx].status);
			list_move_tail(&(tmp->list), &(rxListBlack.list));

			//Increment the write position
			add_to_fifo(&BlackRx_FIFO);
		}
		//Check if we actually made a new list of descriptors
		if(fstBlackRx != -1){
			D printf("BlackRX BASE C: %x\n", (IORD_ALTERA_AVALON_SGDMA_CONTROL(BLACK_RX_BASE)));
			D printf("BlackRX BASE S: %x\n", (IORD_ALTERA_AVALON_SGDMA_STATUS(BLACK_RX_BASE)));
			while ((IORD_ALTERA_AVALON_SGDMA_STATUS(BLACK_RX_BASE)) & 0x10 != 0){
				D printf("f");
			};
			alt_avalon_sgdma_do_async_transfer(BlackRx,&black_rx_descriptor[fstBlackRx]);
		}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	2.	Check the rxList*.list for received frames, then move nodes to the inspectList*.list
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		D printf("\n----------Rx List\n");
		D printf("-----Red\n");
		for (pos = (&rxListRed.list)->next, q = pos->next; pos != (&rxListRed.list); pos = q, q = pos->next){

			if((red_rx_descriptor[RedRx_FIFO.ReadPos].control & ALTERA_AVALON_SGDMA_DESCRIPTOR_CONTROL_OWNED_BY_HW_MSK) != 0){
				break;
			}
			D printf ("red_rx_descriptor[%d].control: %x\tred_rx_descriptor[%d].status: %x\t", RedRx_FIFO.ReadPos, red_rx_descriptor[RedRx_FIFO.ReadPos].control, red_rx_descriptor[RedRx_FIFO.ReadPos].status);
			tmp = list_entry((&rxListRed.list)->next, struct frame_list, list);
			tmp->frameLength = (unsigned short) red_rx_descriptor[RedRx_FIFO.ReadPos].actual_bytes_transferred;
			D printf("Received frame, start: 0x%08.8x length: %d\n", tmp->frameStart, tmp->frameLength);

			list_move_tail(&(tmp->list), &(inspectListRed.list));

			//Increment the read position
			remove_from_fifo(&RedRx_FIFO);
			HEX->redFrames += 1;
		}

		D printf("-----Black\n");
		for (pos = (&rxListBlack.list)->next, q = pos->next; pos != (&rxListBlack.list); pos = q, q = pos->next){

			if((black_rx_descriptor[BlackRx_FIFO.ReadPos].control & ALTERA_AVALON_SGDMA_DESCRIPTOR_CONTROL_OWNED_BY_HW_MSK) != 0){
				break;
			}
			D printf ("black_rx_descriptor[%d].control: %x\tblack_rx_descriptor[%d].status: %x\t", BlackRx_FIFO.ReadPos, black_rx_descriptor[BlackRx_FIFO.ReadPos].control, black_rx_descriptor[BlackRx_FIFO.ReadPos].status);
			tmp = list_entry((&rxListBlack.list)->next, struct frame_list, list);
			tmp->frameLength = (unsigned short) black_rx_descriptor[BlackRx_FIFO.ReadPos].actual_bytes_transferred;
			D printf("Received frame, start: 0x%08.8x length: %d\n", tmp->frameStart, tmp->frameLength);

			list_move_tail(&(tmp->list), &(inspectListBlack.list));

			//Increment the read position
			remove_from_fifo(&BlackRx_FIFO);
			HEX->blackFrames += 1;
		}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	3.	Inspect all frames in the inspectList*.list, doing one of three things:
//				A) Determining they are control frame, moving it to the controlList*.list
//				B) Determining they are an encryptable frame, stamping the payload data/IV, then moving to the encryptList*.list
//				C) Determining they are a non-encryptable frame, and just shuffling it to the readyTxList*.list
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		D printf("\n----------Inspect List\n");
		D printf("-----Red\n");
		uint packetNumber;

		packetNumber = 0;
		for (pos = (&inspectListRed.list)->next, q = pos->next; pos != (&inspectListRed.list); pos = q, q = pos->next){
			 tmp = list_entry(pos, struct frame_list, list);

			 PrintPacket(tmp->frameStart, tmp->frameLength);
			 D printf("Frame Addr: %x\n", tmp->frameStart+2);
			 if (PacketProcessor_Red_Rx((tmp->frameStart)+2) == 2){
				 list_move_tail(&(tmp->list), &(availableListRed.list));
			 } else {
				 list_move_tail(&(tmp->list), &(readyTxListRed.list));
			 }
		}

		D printf("-----Black\n");
		for (pos = (&inspectListBlack.list)->next, q = pos->next; pos != (&inspectListBlack.list); pos = q, q = pos->next){
			 tmp = list_entry(pos, struct frame_list, list);

			 PrintPacket(tmp->frameStart, tmp->frameLength);
			 D printf("Frame Addr: %x\n", tmp->frameStart+2);
			 PacketProcessor_Black_Rx((tmp->frameStart)+2);
			 list_move_tail(&(tmp->list), &(readyTxListBlack.list));
		}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	4.	Inspect all controlList*.list frames, adding to the access control data structure, zeroing the frame and then moving
//				it to the availableList*.list
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		D printf("-----Control List\n");
		D printf("-------Red\n");
		for (pos = (&controlListRed.list)->next, q = pos->next; pos != (&controlListRed.list); pos = q, q = pos->next){
			 tmp = list_entry(pos, struct frame_list, list);

			 list_move_tail(&(tmp->list), &(availableListRed.list));
		}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	5.	Inspect the encryptList*.list, encrypting the first frame, waiting for encryptor to finish, then moving the frame to
//				the readyTxList.list
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		D printf("-----Encrypt List\n");
		D printf("-------Red\n");
		for (pos = (&encryptListRed.list)->next, q = pos->next; pos != (&encryptListRed.list); pos = q, q = pos->next){
			 tmp = list_entry(pos, struct frame_list, list);

			 list_move_tail(&(tmp->list), &(readyTxListBlack.list));
		}

		D printf("-------Black\n");
		for (pos = (&encryptListBlack.list)->next, q = pos->next; pos != (&encryptListBlack.list); pos = q, q = pos->next){
			 tmp = list_entry(pos, struct frame_list, list);

			 list_move_tail(&(tmp->list), &(readyTxListRed.list));
		}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	6.	Inspect nodes from readyTxList*.list pump them into the respective tx descriptors, then move nodes to the txList*.list
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		D printf("\n----------ReadyTx List\n");
		D printf("-----Red\n");
		fstBlackTx = -1;
		for (pos = (&readyTxListRed.list)->next, q = pos->next; pos != (&readyTxListRed.list); pos = q, q = pos->next){
			tmp = list_entry(pos, struct frame_list, list);
			if(BlackTx_FIFO.available == 1){
				//No SPACE!
				break;
			} else {
				//We have available room on the List, and Available Buffer Room
				if (fstBlackTx == -1){
					fstBlackTx = BlackTx_FIFO.WritePos;
				}
				if (BlackTx_FIFO.WritePos == (BlackTx_FIFO.size - 1)){
					nxtBlackTx = 0;
				} else {
					nxtBlackTx = (BlackTx_FIFO.WritePos + 1);
				}
				//Construct and send new descriptors
				alt_avalon_sgdma_construct_mem_to_stream_desc(&black_tx_descriptor[BlackTx_FIFO.WritePos],&black_tx_descriptor[nxtBlackTx],tmp->frameStart,tmp->frameLength,0,1,1,0);
			}

			D printf("Available Space: %d,  \tBlack WP: %d, \Black Nxt: %d,  \tAddr: 0x%08.8x\n", BlackTx_FIFO.available, BlackTx_FIFO.WritePos, nxtBlackTx, tmp->frameStart);
			D printf("New Desc C: %x, S: %x, Next Desc C: %x, S: %x\n\n", black_tx_descriptor[BlackTx_FIFO.WritePos].control, black_tx_descriptor[BlackTx_FIFO.WritePos].status, black_tx_descriptor[nxtBlackTx].control, black_tx_descriptor[nxtBlackTx].status);
			list_move_tail(&(tmp->list), &(txListBlack.list));

			//Increment the write position
			add_to_fifo(&BlackTx_FIFO);
		}
		//Check if we actually made a new list of descriptors
		if(fstBlackTx != -1){
			D printf("RedTX BASE: %x\n", (IORD_ALTERA_AVALON_SGDMA_CONTROL(RED_TX_BASE)));
			D printf("RedTX BASE: %x\n", (IORD_ALTERA_AVALON_SGDMA_STATUS(RED_TX_BASE)));
			while ((*(unsigned int*)(BlackTx->base) & 0x10) == 0x10){};
			alt_avalon_sgdma_do_async_transfer(BlackTx,&black_tx_descriptor[fstBlackTx]);
		}


		D printf("-------Black\n");
		fstRedTx = -1;
		for (pos = (&readyTxListBlack.list)->next, q = pos->next; pos != (&readyTxListBlack.list); pos = q, q = pos->next){
			tmp = list_entry(pos, struct frame_list, list);
			if(RedTx_FIFO.available == 1){
				//No SPACE!
				break;
			} else {
				//We have available room on the List, and Available Buffer Room
				if (fstRedTx == -1){
					fstRedTx = RedTx_FIFO.WritePos;
				}
				if (RedTx_FIFO.WritePos == (RedTx_FIFO.size - 1)){
					nxtRedTx = 0;
				} else {
					nxtRedTx = (RedTx_FIFO.WritePos + 1);
				}
				//Construct and send new descriptors
				alt_avalon_sgdma_construct_mem_to_stream_desc(&red_tx_descriptor[RedTx_FIFO.WritePos],&red_tx_descriptor[nxtRedTx],tmp->frameStart,tmp->frameLength,0,1,1,0);
			}

			D printf("Available Space: %d,  \tRed WP: %d, \Red Nxt: %d,  \tAddr: 0x%08.8x\n", RedTx_FIFO.available, RedTx_FIFO.WritePos, nxtRedTx, tmp->frameStart);
			D printf("New Desc C: %x, S: %x, Next Desc C: %x, S: %x\n\n", red_tx_descriptor[RedTx_FIFO.WritePos].control, red_tx_descriptor[RedTx_FIFO.WritePos].status, red_tx_descriptor[nxtBlackTx].control, red_tx_descriptor[nxtRedTx].status);
			list_move_tail(&(tmp->list), &(txListRed.list));

			//Increment the write position
			add_to_fifo(&RedTx_FIFO);
		}
		//Check if we actually made a new list of descriptors
		if(fstRedTx != -1){
			D printf("BlackTX BASE: %x\n", (IORD_ALTERA_AVALON_SGDMA_CONTROL(BLACK_TX_BASE)));
			D printf("BlackTX BASE: %x\n", (IORD_ALTERA_AVALON_SGDMA_STATUS(BLACK_TX_BASE)));
			while ((*(unsigned int*)(RedTx->base) & 0x10) == 0x10){};
			alt_avalon_sgdma_do_async_transfer(RedTx,&red_tx_descriptor[fstRedTx]);
		}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	7.	Check the txList*.list for transmitted frames, then move  respective nodes to the availableList*.list
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		D printf("\n----------Tx List List\n");
		D printf("-----Red\n");
		for (pos = (&txListBlack.list)->next, q = pos->next; pos != (&txListBlack.list); pos = q, q = pos->next){

			if((black_tx_descriptor[BlackTx_FIFO.ReadPos].control & ALTERA_AVALON_SGDMA_DESCRIPTOR_CONTROL_OWNED_BY_HW_MSK) != 0){
				break;
			}
			D printf ("black_tx_descriptor[%d].control: %x\t", BlackTx_FIFO.ReadPos, black_tx_descriptor[BlackTx_FIFO.ReadPos].control);
			tmp = list_entry((&txListBlack.list)->next, struct frame_list, list);
			tmp->frameLength = (unsigned short) black_tx_descriptor[BlackTx_FIFO.ReadPos].actual_bytes_transferred;
			D printf("Transmitted frame, start: 0x%08.8x length: %d\n", tmp->frameStart, tmp->frameLength);
			list_move_tail(&(tmp->list), &(availableListRed.list));
			//Increment the read position
			remove_from_fifo(&BlackTx_FIFO);
		}

		D printf("-----Black\n");
		for (pos = (&txListRed.list)->next, q = pos->next; pos != (&txListRed.list); pos = q, q = pos->next){

			if((red_tx_descriptor[RedTx_FIFO.ReadPos].control & ALTERA_AVALON_SGDMA_DESCRIPTOR_CONTROL_OWNED_BY_HW_MSK) != 0){
				break;
			}
			D printf ("red_tx_descriptor[%d].control: %x\t", RedTx_FIFO.ReadPos, red_tx_descriptor[RedTx_FIFO.ReadPos].control);
			tmp = list_entry((&txListRed.list)->next, struct frame_list, list);
			tmp->frameLength = (unsigned short) red_tx_descriptor[RedTx_FIFO.ReadPos].actual_bytes_transferred;
			D printf("Transmitted frame, start: 0x%08.8x length: %d\n", tmp->frameStart, tmp->frameLength);
			list_move_tail(&(tmp->list), &(availableListBlack.list));
			//Increment the read position
			remove_from_fifo(&RedTx_FIFO);

		}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	DONE
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}
	return 0;
}

void PrintPacket(unsigned char * frameStart, uint frameLength){
	 unsigned char * stringP = frameStart;
	 int i = 0;
	 int j = 0;
	 D printf("\nInspecting packet... Address: 0x%08.8x, Length: %d bytes.\n", frameStart, frameLength);
	 D printf("             0  1  2  3  4  5  6  7   8  9  a  b  c  d  e  f\n");
	 D printf("0x%08.8x  ", frameStart + i);
	 for(i=0; i < frameLength; i++){

		 if (j++ == 8){
			 j = 0;
			 D printf(" ");
		 }
		 if (i%16 == 0 && i != 0){
			 D printf("\n0x%08.8x  ", frameStart + i);
			 j = 1;
		 }
		 D printf("%2.2x ", *(stringP + i));
	 }
	 D printf("\n");
}

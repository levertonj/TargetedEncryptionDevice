/*----------------------------------------------------------------
 //                                                              //
 //  main.c                                                      //
 //                                                              //
 //  This file is part of the Targeted Encryption Device.        //
 //  A fourth year Computer Engineering design project completed //
 //  for the partial fulfilment of requirements of a degree of   //
 //  Bachelor Computer Engineering in the Electrical and         //
 //  Computer Engineering Department at the Royal Military       //
 //  College of Canada.											 //
 //                                                              //
 //                                                              //
 //  Description                                                 //
 //  Testbench to prove the efficacy of the TED crypto module	 //
 //  versus a software implementation of the same algorithm		 //
 //                                                              //
 //  Author(s):                                                  //
 //      - Blake Mackey, blake@brashendeavours.com               //
 //      - Jason Leverton, jason@kogfuy.com                      //
 //                                                              //
 //////////////////////////////////////////////////////////////////
 //                                                              //
 // Copyright (C) 2015 Authors                                   //
 //                                                              //
 // This source file may be used and distributed without         //
 // restriction provided that this copyright statement is not    //
 // removed from the file and that any derivative work contains  //
 // the original copyright notice and the associated disclaimer. //
 //                                                              //
 // This source file is free software; you can redistribute it   //
 // and/or modify it under the terms of the GNU Lesser General   //
 // Public License as published by the Free Software Foundation; //
 // either version 2.1 of the License, or (at your option) any   //
 // later version.                                               //
 //                                                              //
 // This source is distributed in the hope that it will be       //
 // useful, but WITHOUT ANY WARRANTY; without even the implied   //
 // warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      //
 // PURPOSE.  See the GNU Lesser General Public License for more //
 // details.                                                     //
 //                                                              //
 ----------------------------------------------------------------*/

#include <stdio.h>
#include "system.h"

#define ENCRYPT 1
#define DECRYPT 3

//Declare the struct for the memory mapped crypto hardware
struct crypto_t {
	unsigned int control;
	unsigned int status;
	unsigned int readStart;
	unsigned int writeStart;
	unsigned int transferLength;
	unsigned int injectionVector;
	unsigned int key8key16;
	unsigned int key32;
};

//Declare globals in specific memory locations
unsigned int plaintext_A[512] __attribute__ ((section (".incoming_memory")));
unsigned int encrypted_A[512] __attribute__ ((section (".outgoing_memory")));
unsigned int decrypted_A[512] __attribute__ ((section (".incoming_memory")));

unsigned int plaintext_B[512] __attribute__ ((section (".incoming_memory")));
unsigned int encrypted_B[512] __attribute__ ((section (".outgoing_memory")));
unsigned int decrypted_B[512] __attribute__ ((section (".incoming_memory")));

//Declare the global pointer to the memory mapped crypto
struct crypto_t * Crypto = (struct crypto_t *) CRYPTO_MODULE_BASE;


int main() {

	//Declare an ordinary count
	int count;

	//Byte transfer length, injection vector, and keys.
	int transferLength = 1500;
	unsigned int injectionvector = 0xdeadbeef;
	unsigned char key8 = 0xa6;
	unsigned short key16 = 0xbeef;
	unsigned int key32 = 0x1245678;

	//Declare timestamps
	unsigned int hardwareEncryptStartTime, hardwareEncryptStopTime,
			hardwareDecryptStartTime, hardwareDecryptStopTime;
	unsigned int softwareEncryptStartTime, softwareEncryptStopTime,
			softwareDecryptStartTime, softwareDecryptStopTime;

	//2048 bytes to possibly transfer
	char largest_payload[] =
			"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec mi non arcu commodo porttitor. Nullam maximus mollis tortor. \
Sed lacinia eros tortor, porta consectetur sem facilisis in. Nulla nibh mauris, sagittis et nibh in, sollicitudin sodales nisl. Vestibulum sed egestas \
odio, nec tempus erat. Cras non tortor sagittis, consectetur arcu a, tincidunt magna. Integer vel gravida odio. Fusce posuere nibh a lacus tincidunt \
maximus. Pellentesque porttitor dolor nec rutrum efficitur. Etiam commodo erat ligula, imperdiet rutrum massa interdum vitae. Fusce vulputate mattis \
tincidunt. Proin lobortis est volutpat hendrerit tincidunt. Etiam mattis nisl sed orci sodales, vitae fringilla quam molestie. Pellentesque venenatis \
sapien augue, id lacinia felis mollis luctus. Maecenas nec lacinia odio. Phasellus lorem erat, iaculis eu dictum ac, rutrum vitae sapien. Curabitur \
dignissim ut enim eget malesuada. Etiam tincidunt erat ante, eget ullamcorper sapien hendrerit quis. Cras finibus elit at orci accumsan semper. Etiam \
convallis mollis nisi vel semper. Proin laoreet vulputate est, sed pellentesque enim volutpat et. Vestibulum tempor ipsum nec efficitur faucibus. Quisque \
ut fringilla orci, consectetur convallis urna. Nullam vestibulum sodales odio porttitor mollis. Proin viverra arcu mauris, vel congue ante semper non. \
Donec nec maris bibendum, suscipit mi vel, congue nisl. Suspendisse sit amet porta ipsum, vel dignissim magna. In aliquam arcu at mi dictum consectetur. \
Donec massa nunc.";

	//Initialize the p/aintext memories
	memcpy(plaintext_A, largest_payload, transferLength);
	memcpy(plaintext_B, largest_payload, transferLength);

	//Initialize the timer
	alt_timestamp_start();

	//Program the hardware crypto module
	Crypto->readStart = &plaintext_A[0];
	Crypto->writeStart = &encrypted_A[0];
	Crypto->transferLength = transferLength;
	Crypto->injectionVector = injectionvector;
	Crypto->key8key16 = key8 << 16 | key16;
	Crypto->key32 = key32;

	//Print out the original memory location
	printf("Beginning hardware crypto!\n\n");
	printf("Plaintext: ");
	for (count = 0; count < transferLength; count++) {
		printf("%c", *(((char*) &plaintext_A[0]) + count));
	}
	printf("\n");

	//Start the timer, and start the encryption function
	hardwareEncryptStartTime = alt_timestamp();
	Crypto->control = ENCRYPT;

	//Spin until crypto indicates done, then stamp the stop time
	while ((Crypto->status & 0x1) == 1) {
	}
	hardwareEncryptStopTime = alt_timestamp();

	//Print the encrypted string and time delta
	printf("\nEncrypted: ");
	for (count = 0; count < transferLength; count++) {
		printf("%c", *(((char*) &encrypted_A[0]) + count));
	}
	printf("\n\nEncryption done! Hardware encryption time was %.12fs!\n\n",
			((double) (hardwareEncryptStopTime - hardwareEncryptStartTime)
					/ (double) alt_timestamp_freq()));

	//Prepare the decryption of the encrypted string to another lcoation
	Crypto->readStart 	= &encrypted_A[0];
	Crypto->writeStart 	= &decrypted_A[0];

	//Start the timer, and the decryption
	hardwareDecryptStartTime = alt_timestamp();
	Crypto->control = DECRYPT;

	//Spin until crypto indicates done, then stamp the stop time
	while ((Crypto->status & 0x1) == 1) {
	}

	//Print the decrypted string and time delta
	hardwareDecryptStopTime = alt_timestamp();
	printf("Decrypted: ");
	for (count = 0; count < transferLength; count++) {
		printf("%c", *(((char*) &decrypted_A[0]) + count));
	}
	printf("\n\nDecryption done! Hardware decryption time was %.12fs!\n",
			((double) (hardwareDecryptStopTime - hardwareDecryptStartTime)
					/ (double) alt_timestamp_freq()));
	printf("Done hardware crypto!\n\n");

	//Print out the original memory location
	printf("Beginning software crypto!\n");
	printf("Plaintext: ");
	for (count = 0; count < transferLength; count++) {
		printf("%c", *(((char*) &plaintext_B[0]) + count));
	}
	printf("\n");

	//Start the timer, and the software encryption
	softwareEncryptStartTime = alt_timestamp();
	CryptoProcedure(0, &plaintext_B[0], &encrypted_B[0], transferLength, 0xdeadbeef,
			0xa6, 0xbeef, 0x1245678);

	//Print the encrypted string and time delta
	softwareEncryptStopTime = alt_timestamp();
	printf("\nEncrypted: ");
	for (count = 0; count < transferLength; count++) {
		printf("%c", *(((char*) &encrypted_B[0]) + count));
	}
	printf(
			"\n\nSoftware encryption done! Processor encryption time was %.12fs!\n\n",
			((double) (softwareEncryptStopTime - softwareEncryptStartTime)
					/ (double) alt_timestamp_freq()));

	//Start the timer, and the decryption
	softwareDecryptStartTime = alt_timestamp();
	CryptoProcedure(1, &encrypted_B[0], &decrypted_B[0], transferLength, 0xdeadbeef,
			0xa6, 0xbeef, 0x1245678);

	//Print the decrypted string and time delta
	softwareDecryptStopTime = alt_timestamp();
	printf("Decrypted: ");
	for (count = 0; count < transferLength; count++) {
		printf("%c", *(((char*) &decrypted_B[0]) + count));
	}
	printf(
			"\n\nSoftware decryption done! Software decryption time was %.12fs!\n",
			((double) (softwareDecryptStopTime - softwareDecryptStartTime)
					/ (double) alt_timestamp_freq()));
	printf("Done software crypto!\n\n");

	//Print the summary
	printf(
			"******************************************************************************************************************\n");
	printf(
			"*                                                     Summary                                                    *\n");
	printf(
			"******************************************************************************************************************\n");
	printf(
			"* Software encryption time: %.12fs\t\tSoftware decryption time: %.12fs\t\t*\n",
			((double) (softwareEncryptStopTime - softwareEncryptStartTime)
					/ (double) alt_timestamp_freq()),
			((double) (softwareDecryptStopTime - softwareDecryptStartTime)
					/ (double) alt_timestamp_freq()));
	printf(
			"* Hardware encryption time: %.12fs\t\tHardware decryption time: %.12fs\t\t*\n",
			((double) (hardwareEncryptStopTime - hardwareEncryptStartTime)
					/ (double) alt_timestamp_freq()),
			((double) (hardwareDecryptStopTime - hardwareDecryptStartTime)
					/ (double) alt_timestamp_freq()));
	printf(
			"* Encryption speedup      : %3.6f\t\t\tDecryption speedup      : %3.6f\t\t*\n",
			(double) (softwareEncryptStopTime - softwareEncryptStartTime)
					/ (double) (hardwareEncryptStopTime
							- hardwareEncryptStartTime),
			(double) (softwareDecryptStopTime - softwareDecryptStartTime)
					/ (double) (hardwareDecryptStopTime
							- hardwareDecryptStartTime));
	printf(
			"******************************************************************************************************************\n");
	return 0;
}

//////////////////////////////////////////////////////////////////////////////////////////////
//Function: Software cryptographic function
//
//	Desc:	Encrypts/Decrypts a specified amount of bytes using from one address to a second
//			address using an injection vector, as well as 3 cryptographic keys.
//	Input:	The same variables used to initialize the hardware crypto, very self-documented
//	Output:	An encrypted or decrypted byte array at the specified memory location
//////////////////////////////////////////////////////////////////////////////////////////////
void CryptoProcedure(unsigned char control, unsigned int * readstart,
						unsigned int * writestart, unsigned int transferlength,
						unsigned int injectionvector, unsigned char key8, unsigned short key16,
						unsigned int key32) {

	unsigned int key8_32 	= (key8 << 24) | (key8 << 16) | (key8 << 8) | (key8);
	unsigned int key16_32 	= (key16 << 16) | (key16);
	unsigned int key32_32 	= (key32);
	unsigned int injectionvector_32 = injectionvector;
	unsigned int * writeaddress = (void*) ((unsigned int) writestart
			& (unsigned int) 0xfffffffc);
	unsigned int * readaddress = (void*) ((unsigned int) readstart
			& (unsigned int) 0xfffffffc);
	unsigned int rotationcounter = 0;

	unsigned int byteswritten = 0;

	if (control == 0) {
		switch ((unsigned int) readstart & 0x3) {
		case (0x0):
			if (transferlength == 3) {
				injectionvector_32 = (*readaddress & 0xff000000)
						| ((*readaddress ^ injectionvector_32 ^ key8_32
								^ key16_32 ^ key32_32) & 0x00ffffff);
				*writeaddress = injectionvector_32;
				byteswritten += 3;
			} else if (transferlength == 2) {
				injectionvector_32 = (*readaddress & 0xffff0000)
						| ((*readaddress ^ injectionvector_32 ^ key8_32
								^ key16_32 ^ key32_32) & 0x0000ffff);
				*writeaddress = injectionvector_32;
				byteswritten += 2;
			} else if (transferlength == 1) {
				injectionvector_32 = (*readaddress & 0xffffff00)
						| ((*readaddress ^ injectionvector_32 ^ key8_32
								^ key16_32 ^ key32_32) & 0x000000ff);
				*writeaddress = injectionvector_32;
				byteswritten += 1;
			} else {
				injectionvector_32 = (*readaddress ^ injectionvector_32
						^ key8_32 ^ key16_32 ^ key32_32);
				*writeaddress = injectionvector_32;
				byteswritten += 4;
			}
			break;
		case (0x1):
			if (transferlength == 2) {
				injectionvector_32 = (*readaddress & 0xff0000ff)
						| ((*readaddress ^ injectionvector_32 ^ key8_32
								^ key16_32 ^ key32_32) & 0x00ffff00);
				*writeaddress = injectionvector_32;
				byteswritten += 2;
			} else if (transferlength == 1) {
				injectionvector_32 = (*readaddress & 0xffff00ff)
						| ((*readaddress ^ injectionvector_32 ^ key8_32
								^ key16_32 ^ key32_32) & 0x0000ff00);
				*writeaddress = injectionvector_32;
				byteswritten += 1;
			} else {
				injectionvector_32 = (*readaddress & 0x000000ff)
						| ((*readaddress ^ injectionvector_32 ^ key8_32
								^ key16_32 ^ key32_32) & 0xffffff00);
				*writeaddress = injectionvector_32;
				byteswritten += 3;
				;
			}
			break;
		case (0x2):
			if (transferlength == 1) {
				injectionvector_32 = (*readaddress & 0xff00ffff)
						| ((*readaddress ^ injectionvector_32 ^ key8_32
								^ key16_32 ^ key32_32) & 0x00ff0000);
				*writeaddress = injectionvector_32;
				byteswritten += 1;
			} else {
				injectionvector_32 = (*readaddress & 0x0000ffff)
						| ((*readaddress ^ injectionvector_32 ^ key8_32
								^ key16_32 ^ key32_32) & 0xffff0000);
				*writeaddress = injectionvector_32;
				byteswritten += 2;
			}
			break;
		case (0x3):
			injectionvector_32 = (*readaddress & 0x00ffffff)
					| ((*readaddress ^ injectionvector_32 ^ key8_32 ^ key16_32
							^ key32_32) & 0xff000000);
			*writeaddress = injectionvector_32;
			byteswritten += 1;
			break;
		}

		readaddress += 0x1;
		writeaddress += 0x1;

		while (byteswritten < transferlength) {
			rotationcounter += 1;
			key32_32 = (key32_32 >> 1) | (key32_32 << 31);
			if ((rotationcounter & 0x1f) == 0x1) {
				key16_32 = (key16_32 >> 1) | (key16_32 << 31);
			}
			if ((rotationcounter & 0x7f) == 0x1) {
				key8_32 = (key8_32 >> 1) | (key8_32 << 31);
			}
			switch (transferlength - byteswritten) {
			case (3):
				injectionvector_32 = (*readaddress & 0xff000000)
						| ((*readaddress ^ injectionvector_32 ^ key8_32
								^ key16_32 ^ key32_32) & 0x00ffffff);
				*writeaddress = injectionvector_32;
				byteswritten += 3;
				break;
			case (2):
				injectionvector_32 = (*readaddress & 0xffff0000)
						| ((*readaddress ^ injectionvector_32 ^ key8_32
								^ key16_32 ^ key32_32) & 0x0000ffff);
				*writeaddress = injectionvector_32;
				byteswritten += 2;
				break;
			case (1):
				injectionvector_32 = (*readaddress & 0xffffff00)
						| ((*readaddress ^ injectionvector_32 ^ key8_32
								^ key16_32 ^ key32_32) & 0x000000ff);
				*writeaddress = injectionvector_32;
				byteswritten += 1;
				break;
			default:
				injectionvector_32 = (*readaddress ^ injectionvector_32
						^ key8_32 ^ key16_32 ^ key32_32);
				*writeaddress = injectionvector_32;
				byteswritten += 4;
				break;
			}
			readaddress += 0x1;
			writeaddress += 0x1;
		}
	} else if (control == 1) {
		switch ((unsigned int) readstart & 0x3) {
		case (0x0):
			if (transferlength == 3) {
				*writeaddress = (*readaddress & 0xff000000)
						| ((*readaddress ^ injectionvector_32 ^ key8_32
								^ key16_32 ^ key32_32) & 0x00ffffff);
				injectionvector_32 = *readaddress;
				byteswritten += 3;
			} else if (transferlength == 2) {
				*writeaddress = (*readaddress & 0xffff0000)
						| ((*readaddress ^ injectionvector_32 ^ key8_32
								^ key16_32 ^ key32_32) & 0x0000ffff);
				injectionvector_32 = *readaddress;
				byteswritten += 2;
			} else if (transferlength == 1) {
				*writeaddress = (*readaddress & 0xffffff00)
						| ((*readaddress ^ injectionvector_32 ^ key8_32
								^ key16_32 ^ key32_32) & 0x000000ff);
				injectionvector_32 = *readaddress;
				byteswritten += 1;
			} else {
				*writeaddress = (*readaddress ^ injectionvector_32 ^ key8_32
						^ key16_32 ^ key32_32);
				injectionvector_32 = *readaddress;
				byteswritten += 4;
			}
			break;
		case (0x1):
			if (transferlength == 2) {
				*writeaddress = (*readaddress & 0xff0000ff)
						| ((*readaddress ^ injectionvector_32 ^ key8_32
								^ key16_32 ^ key32_32) & 0x00ffff00);
				injectionvector_32 = *readaddress;
				byteswritten += 2;
			} else if (transferlength == 1) {
				*writeaddress = (*readaddress & 0xffff00ff)
						| ((*readaddress ^ injectionvector_32 ^ key8_32
								^ key16_32 ^ key32_32) & 0x0000ff00);
				injectionvector_32 = *readaddress;
				byteswritten += 1;
			} else {
				*writeaddress = (*readaddress & 0x000000ff)
						| ((*readaddress ^ injectionvector_32 ^ key8_32
								^ key16_32 ^ key32_32) & 0xffffff00);
				injectionvector_32 = *readaddress;
				byteswritten += 3;
				;
			}
			break;
		case (0x2):
			if (transferlength == 1) {
				*writeaddress = (*readaddress & 0xff00ffff)
						| ((*readaddress ^ injectionvector_32 ^ key8_32
								^ key16_32 ^ key32_32) & 0x00ff0000);
				injectionvector_32 = *readaddress;
				byteswritten += 1;
			} else {
				*writeaddress = (*readaddress & 0x0000ffff)
						| ((*readaddress ^ injectionvector_32 ^ key8_32
								^ key16_32 ^ key32_32) & 0xffff0000);
				injectionvector_32 = *readaddress;
				byteswritten += 2;
			}
			break;
		case (0x3):
			*writeaddress = (*readaddress & 0x00ffffff)
					| ((*readaddress ^ injectionvector_32 ^ key8_32 ^ key16_32
							^ key32_32) & 0xff000000);
			injectionvector_32 = *readaddress;
			byteswritten += 1;
			break;
		}

		readaddress += 0x1;
		writeaddress += 0x1;

		while (byteswritten < transferlength) {
			rotationcounter += 1;
			key32_32 = (key32_32 >> 1) | (key32_32 << 31);
			if ((rotationcounter & 0x1f) == 0x1) {
				key16_32 = (key16_32 >> 1) | (key16_32 << 31);
			}
			if ((rotationcounter & 0x7f) == 0x1) {
				key8_32 = (key8_32 >> 1) | (key8_32 << 31);
			}
			switch (transferlength - byteswritten) {
			case (3):
				*writeaddress = (*readaddress & 0xff000000)
						| ((*readaddress ^ injectionvector_32 ^ key8_32
								^ key16_32 ^ key32_32) & 0x00ffffff);
				injectionvector_32 = *readaddress;
				byteswritten += 3;
				break;
			case (2):
				*writeaddress = (*readaddress & 0xffff0000)
						| ((*readaddress ^ injectionvector_32 ^ key8_32
								^ key16_32 ^ key32_32) & 0x0000ffff);
				injectionvector_32 = *readaddress;
				byteswritten += 2;
				break;
			case (1):
				*(unsigned int*) writeaddress = (*readaddress & 0xffffff00)
						| ((*readaddress ^ injectionvector_32 ^ key8_32
								^ key16_32 ^ key32_32) & 0x000000ff);
				injectionvector_32 = *readaddress;
				byteswritten += 1;
				break;
			default:
				*(unsigned int*) writeaddress = (*readaddress
						^ injectionvector_32 ^ key8_32 ^ key16_32 ^ key32_32);
				injectionvector_32 = *readaddress;
				byteswritten += 4;
				break;
			}
			readaddress += 0x1;
			writeaddress += 0x1;
		}
	}
}

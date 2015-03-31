/*
 * TargetList.h
 *
 *  Created on: Mar 12, 2015
 *      Author: Count
 */

#ifndef TARGETLIST_H_
#define TARGETLIST_H_

typedef struct TARGET_TAG {
	int targetNumber;
	unsigned char srcHost[4];
	unsigned char dstHost[4];
	unsigned char srcPort[2];
	unsigned char dstPort[2];
	struct TARGET_TAG* nextTargetNumber;
} TARGET;

TARGET* InitializeTargetList(TARGET* listHead);
TARGET* AddTarget (TARGET* listHead, int,unsigned char*,unsigned char* dstHost,unsigned char* srcPort,unsigned char* dstPort);
TARGET* PrintTargetList (TARGET* listHead);

#endif /* PACKETPROCESSOR_RED_TARGETLIST_H_ */

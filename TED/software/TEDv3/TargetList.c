/*
 * TargetList.c
 *
 *  Created on: Mar 12, 2015
 *      Author: Count
 */
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#include "TargetList.h"
#include "Target_Constants.h"

/*
-------------------------------------------------------------------------------
Function: 		InitializeTargetList

Description:	Hardcoded Target values.

Parameters:		1. ListHead


Returns:		TARGET pointer to the first element in the linked list.
				Returns itself if list is empty.
-------------------------------------------------------------------------------
*/

TARGET* InitializeTargetList(TARGET* listHead) {

	unsigned char ipsrc1[] = {IP_SRC_ADDRESS1};
	unsigned char ipdst1[] = {IP_DST_ADDRESS1};
	unsigned char srcport1[] = {SRC_PORT1};
	unsigned char dstport1[] = {DST_PORT1};

	unsigned char ipsrc2[] = {IP_SRC_ADDRESS2};
	unsigned char ipdst2[] = {IP_DST_ADDRESS2};
	unsigned char srcport2[] = {SRC_PORT2};
	unsigned char dstport2[] = {DST_PORT2};

	unsigned char ipsrc3[] = {IP_SRC_ADDRESS3};
	unsigned char ipdst3[] = {IP_DST_ADDRESS3};
	unsigned char srcport3[] = {SRC_PORT3};
	unsigned char dstport3[] = {DST_PORT3};

	listHead = AddTarget(listHead,0,ipsrc1,ipdst1,srcport1,dstport1);
	listHead = AddTarget(listHead,1,ipsrc2,ipdst2,srcport2,dstport2);
	listHead = AddTarget(listHead,2,ipsrc3,ipdst3,srcport3,dstport3);

	return listHead;
}



/*
-------------------------------------------------------------------------------
Function: 		AddTarget

Description:	Adds a target to the end of the link list.
				Use Zero for a "not applicable"

Parameters:		1. ListHead
				2. Target Number (Target Index)
				2. Source Host Address
				3. Destination Host Address
				4. Source Port
				5. Destination Port

Returns:		1 = match found
				0 = no matches
-------------------------------------------------------------------------------
*/

TARGET* AddTarget (TARGET* listHead, int targetNumber, unsigned char* srcHost,unsigned char* dstHost,  unsigned char* srcPort, unsigned char* dstPort) {
  static int lastTargetNumber = 0;
  TARGET* pWalker = listHead;
  TARGET* newTarget = NULL;
  int i,j,k,m = 0;

  if (pWalker != NULL)
	   while (pWalker->nextTargetNumber != NULL)
			 pWalker=pWalker->nextTargetNumber;

  newTarget = (TARGET*) malloc(sizeof(TARGET));

  //Initialize new node
  newTarget->targetNumber = ++lastTargetNumber;

  for(i=0;i<4;i++)
	   newTarget->srcHost[i] = srcHost[i];
  for(j=0;j<4;j++)
	   newTarget->dstHost[j] = dstHost[j];
  for(k=0;k<2;k++)
	   newTarget->srcPort[k] = srcPort[k];
  for(m=0;m<2;m++)
	   newTarget->dstPort[m] = dstPort[m];

  newTarget->nextTargetNumber = NULL;

  //Link new node in list and return head if the list is not empty
  if (pWalker != NULL)
  {
	  pWalker->nextTargetNumber = newTarget;
	  return listHead;
  }
  //Return only node if list is empty
  else
	  return newTarget;
}

/*
-------------------------------------------------------------------------------
Function: 		PrintTargetList

Description:	Prints Linked List Contents.  Purely for debugging.

Parameters:		1. ListHead

Returns:		Target pointer to the first element in the linked list.
-------------------------------------------------------------------------------
*/

TARGET* PrintTargetList (TARGET* listHead) {

TARGET* pWalker=listHead;
int i=0;

	while(pWalker != NULL) {
		printf("Target Number: %d\n", pWalker->targetNumber);

		printf("Source Address: ");
		for(i=0;i<4;i++)
			printf("0x%x",pWalker->srcHost[i]);
		printf("\n");

		printf("Destination Address: ");
		for(i=0;i<4;i++)
			printf("0x%x", pWalker->dstHost[i]);
		printf("\n");

		printf("Source Port: ");
		for(i=0;i<2;i++)
			printf("0x%x", pWalker->srcPort[i]);
		printf("\n");

		printf("Destination Port: ");
		for(i=0;i<2;i++)
			printf("0x%x", pWalker->dstPort[i]);
		printf("\n");

		pWalker=pWalker->nextTargetNumber;

		printf("\n");
	}

return listHead;
}

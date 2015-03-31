#ifndef DECRYPTCHECK_H_
#define DECRYPTCHECK_H_

	int PortDecrypt(TARGET* listHead, tran_h * tran);
	int IpDecrypt(TARGET* listHead, ip_h* ip);
	int NatDecrypt(TARGET* listHead, ip_h* ip, tran_h* tran );

#endif

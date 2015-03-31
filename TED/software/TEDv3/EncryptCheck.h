#ifndef ENCRYPTCHECK_H_
#define ENCRYPTCHECK_H_

	int PortEncrypt(TARGET* listHead, tran_h* tran);
	int IpEncrypt(TARGET* listHead, ip_h* ip);
	int NatEncrypt(TARGET* listHead, ip_h* ip, tran_h* tran);

#endif

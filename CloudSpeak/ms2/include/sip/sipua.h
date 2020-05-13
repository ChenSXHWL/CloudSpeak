/*******************************************************************
*
*    DESCRIPTION:Copyright(c) Xiamen Dnake electronic technology co., LTD
*
*    AUTHOR:dgw
*
*    HISTORY:
*
*    DATE:2016-10-13
*
*******************************************************************/
#ifndef _SIPUA_H_
#define _SIPUA_H_

#ifdef __cplusplus
extern "C" {
#endif

/************************************************************************/
/* 	宏定义																*/
/************************************************************************/
/* sip msg */
#define  SIP_100_TRYING						100
#define  SIP_180_RINGING					180
#define  SIP_181_CALL_IS_BEING_FORWARDED	181
#define  SIP_182_QUEUED						182
#define  SIP_183_SESSION_PROGRESS			183
#define  SIP_200_OK							200
#define  SIP_202_ACCEPTED					202
#define  SIP_300_MULTIPLE_CHOICES			300
#define  SIP_301_MOVED_PERMANENTLY			301
#define  SIP_302_MOVED_TEMPORARILY			302
#define  SIP_305_USE_PROXY					305
#define  SIP_380_ALTERNATIVE_SERVICE		380
#define  SIP_400_BAD_REQUEST				400
#define  SIP_401_UNAUTHORIZED				401
#define  SIP_402_PAYMENT_REQUIRED			402
#define  SIP_403_FORBIDDEN					403
#define  SIP_404_NOT_FOUND					404
#define  SIP_405_METHOD_NOT_ALLOWED			405
#define  SIP_406_NOT_ACCEPTABLE				406
#define  SIP_407_PROXY_AUTH_REQUIRED		407
#define  SIP_408_REQUEST_TIMEOUT			408
#define  SIP_409_CONFLICT					409
#define  SIP_410_GONE						410
#define  SIP_411_LENGTH_REQUIRED			411
#define  SIP_412_PRECONDITION_FAILED		412
#define  SIP_413_REQUEST_TOO_LARGE			413
#define  SIP_414_REQUEST_URI_TOO_LONG		414
#define  SIP_415_UNSUPPORTED_MEDIA			415
#define  SIP_416_UNSUPPORTED_URI			416
#define  SIP_417_RESOURCE_PRIORITY			417
#define  SIP_420_BAD_EXTENSION				420
#define  SIP_421_EXTENSION_REQUIRED			421
#define  SIP_422_SESSION_TIMER_TOO_SMALL	422
#define  SIP_423_INTERVAL_TOO_BRIEF			423
#define  SIP_423_REGISTRATION_TOO_BRIEF		423
#define  SIP_480_TEMPORARILY_UNAVAILABLE	480
#define  SIP_481_NO_TRANSACTION				481
#define  SIP_481_NO_CALL					481
#define  SIP_482_LOOP_DETECTED				482
#define  SIP_483_TOO_MANY_HOPS				483
#define  SIP_484_ADDRESS_INCOMPLETE			484
#define  SIP_485_AMBIGUOUS					485
#define  SIP_486_BUSY_HERE					486
#define  SIP_487_REQUEST_TERMINATED			487
#define  SIP_487_REQUEST_CANCELLED			487
#define  SIP_488_NOT_ACCEPTABLE				488
#define  SIP_489_BAD_EVENT					489
#define  SIP_490_REQUEST_UPDATED			490
#define  SIP_491_REQUEST_PENDING			491
#define  SIP_493_UNDECIPHERABLE				493
#define  SIP_494_SECAGREE_REQUIRED			494
#define  SIP_500_INTERNAL_SERVER_ERROR		500
#define  SIP_501_NOT_IMPLEMENTED			501
#define  SIP_502_BAD_GATEWAY				502
#define  SIP_503_SERVICE_UNAVAILABLE		503
#define  SIP_504_GATEWAY_TIME_OUT			504
#define  SIP_505_VERSION_NOT_SUPPORTED		505
#define  SIP_513_MESSAGE_TOO_LARGE			513
#define  SIP_580_PRECONDITION				580
#define  SIP_600_BUSY_EVERYWHERE			600
#define  SIP_603_DECLINE					603
#define  SIP_604_DOES_NOT_EXIST_ANYWHERE	604
#define  SIP_606_NOT_ACCEPTABLE				606
#define  SIP_687_DIALOG_TERMINATED			687


#define  SIPUA_CALL_INVITE					1
#define  SIPUA_CALL_RINGING					2
#define  SIPUA_CALL_ANSWERED				3
#define  SIPUA_CALL_ACK						4
#define  SIPUA_CALL_RELEASED				5
#define  SIPUA_MESSAGE_NEW					6
#define  SIPUA_MESSAGE_ANSWERED				7
#define  SIPUA_REGISTRATION_FAILURE			8
#define  SIPUA_REGISTRATION_SUCCESS			9
#define  SIPUA_CALL_REQUESTFAILURE			10



#define IP_ADDR_LEN					(128)
#define IP_PORT_LEN					(10)
#define USER_NAME_MAX_LEN			(32)
#define PASSWORD_MAX_LEN			(20)

#define SDP_BUF_LEN					(2048)
#define MAX_ID_SIZE					(9)

#define REG_EXPIRES_MAX				(300)	//注册的过期时间最大值 300s
#define REG_EXPIRES_MIN				(5)		//注册的过期时间最小值 5s

#define SIP_OPT_EXPIRES_DEFAULT		(30)	//option的心跳默认 30s
#define SIP_REG_EXPIRES_DEFAULT		(30)	//REG的心跳默认 30s

#define SIP_LOCAL_PORT 				(5060)
#define RTP_LOCAL_PORT_A			(9900) 		//rtp　媒体本地端口
#define RTP_LOCAL_PORT_V 			(10002) 	//rtp ,video 端口

#define	SIP_PTHREAD_TIMEOUT 		(200)	//200ms

#define SIP_MSG_LEN_MAX				(1024)
#define SIP_RES_LEN_MAX				(2)



/************************************************************************/
/* 	自定义类型															*/
/************************************************************************/
typedef int (*SendEvent)(int nEvent, void *body);


typedef struct {
	char body[SIP_MSG_LEN_MAX];			//sip消息

}SipMsg;

typedef struct {
	char sipProxy[IP_ADDR_LEN];			//sip服务器
	char sipPort[IP_PORT_LEN];			//sip端口
	char sipPasswd[PASSWORD_MAX_LEN];	//sip密码
	char sipUserName[USER_NAME_MAX_LEN];//sip用户
	char sipOutbound[IP_ADDR_LEN];		//sip中继服务器与端口
	char sipBitrate[IP_PORT_LEN];		//sip视频波特率
	char stunIp[IP_ADDR_LEN];			//STUN服务器
	char stunPort[IP_PORT_LEN];			//STUN端口
}SipCfg;

typedef struct {
	bool_t registerStatus;
	bool_t logout;
	bool_t runing;
	char remoteIp[IP_ADDR_LEN];
	char localip[IP_ADDR_LEN];
	int cid[MAX_ID_SIZE];	//Call Id
	int did[MAX_ID_SIZE];	//Dialog Id
	int tid[MAX_ID_SIZE];	//Transactions Id
	int regId;
	int remotePortA;
	int remotePortV;
	int localPortA;//RTP_PORT_AUDIO, RTP_PORT_VIDEO
	int localPortV;
	int regRemain;
	int regExpires;
	int optRemain;
	SendEvent sendEvent;
}SipTalk;


/************************************************************************/
/*	提供外部接口函数													*/
/************************************************************************/
MS2_PUBLIC bool_t SIPUA_Create(SipTalk *sip);
MS2_PUBLIC bool_t SIPUA_Destroy(void);
MS2_PUBLIC void SIPUA_Listeners(void * arg);
MS2_PUBLIC bool_t SIPUA_Register(SipCfg *cfg,int expires);
MS2_PUBLIC bool_t SIPUA_UnRegister(void);
MS2_PUBLIC bool_t SIPUA_DoInvite(const char *srcUrl,const char *destUrl);
MS2_PUBLIC void SIPUA_DoCallAnswer(void);
MS2_PUBLIC void SIPUA_DoReleaseAll(void);
MS2_PUBLIC bool_t SIPUA_DoInstantMsg(const char *srcUrl,const char *destUrl,const char *body);
MS2_PUBLIC void SIPUA_GetLocalIp4eXosip(char *localip);
MS2_PUBLIC void SIPUA_SetLocalIp(const char *localip);
MS2_PUBLIC const char *SIPUA_GetLocalIp(void);
MS2_PUBLIC const char *SIPUA_GetRemoteIP(void);
MS2_PUBLIC int SIPUA_GetRemotePortV(void);
MS2_PUBLIC int SIPUA_GetRemotePortA(void);
MS2_PUBLIC bool_t SIPUA_GetRegisterStatus(void);

#ifdef __cplusplus
}
#endif
#endif /* _SIPUA_H_ */

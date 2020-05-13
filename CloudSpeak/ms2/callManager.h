//
//  callManager.h
//  EverTalk
//
//  Created by dgw on 17/03/15.
//  Copyright © 2016年 dnake. All rights reserved.
//

#ifndef CALLMANAGER_H_
#define CALLMANAGER_H_

#if TARGET_OS_IPHONE
#import "ms2log.h"
#endif

#include "mediastreamer2/mediastream.h"
#include <sip/sipua.h>
/************************************************************************/
/* 	宏定义																*/
/************************************************************************/
#define IP_ADDR_LEN			(128)
#define	MAXBUF   			(256)
#define USER_NAME_MAX_LEN	(32)
#define PASSWORD_MAX_LEN	(20)
#define URL_MAX_LEN			(128)
#define MSG_LEN_MAX			(1024)
#define TIME_MAX_LEN		(32)



/* config parameter */
#define CONFIG_PKT_JIB_A			60		/* -1:disable,unit:millisecond*/
#define CONFIG_PKT_JIB_V			90		/* -1:disable,unit:millisecond*/
#define CONFIG_REG_EXPIRES_VALUE	300		/* expires value for registration*/
#define CONFIG_ECHO_CHANCEL			1		/* 1:true 0:false */
#define CONFIG_RTP_BITRATE			0		/* Bitrate */


#define CONFIG_MUL_WAIT_TIMER		(200)	//200ms

#define TIMER_TICK					(200)	//间隔200ms
#define NWTYPE_DURATION_TIME		(150)	//30s = 150*(TIMER_TICK/1000)
#define WAN_OUTGOING_CALL_TIME		(5)		//1s  = 5 *(TIMER_TICK/1000)
#define LAN_QUERY_DEVICE_TIME		(15)	//2s  = 10 *(TIMER_TICK/1000)每次间隔200ms
#define CALL_ANSWER_TIME			(1)		//0.2s = 1 *(TIMER_TICK/1000)每次间隔200ms
#define CALL_ACK_TIME				(30)	//6s = 30 *(TIMER_TICK/1000)每次间隔200ms
#define AUDIO_STEAM_ALIVE			(60)	//12s = 60 *(TIMER_TICK/1000)每次间隔200ms


#define RTP_TYPE_AUDIO		(1)
#define RTP_TYPE_VIDEO		(2)


#define TIMER_TYPE_IDLE				(0)
#define TIMER_TYPE_QUERY_DEVICE		(1)
#define TIMER_TYPE_USEING_WAN_CALL	(2)
#define TIMER_TYPE_CLEAR_NET_DATA	(3)


//APP与设备端的会话管理
#define SESSION_MODE_NULL			0
#define SESSION_MODE_INCOMING_CALL	1
#define SESSION_MODE_MONITOR		2
#define SESSION_MODE_QUERY			3

//呼叫状态管理
#define CALL_STATUS_IDLE			0
#define CALL_STATUS_INVITE			1
#define CALL_STATUS_ALERTING		2
#define CALL_STATUS_CONNECTED		3
#define CALL_STATUS_TERMINATING		4
#define CALL_STATUS_TERMINATED		5


#define STREAM_STATUS_A_STARTING	1
#define STREAM_STATUS_A_STARTED     2
#define STREAM_STATUS_V_STARTING	3
#define STREAM_STATUS_V_STARTED     4


#define SENDIMSG_STATUS_IDLE		0
#define SENDIMSG_STATUS_QUERY		1
#define SENDIMSG_STATUS_ACK			2

//call release reason
#define REL_RES_NORMAL_LOCAL			0
#define REL_RES_NORMAL_OTHER_SIDE		1
#define REL_RES_ERR_IOTC_REMOTE_TIMEOUT	2
#define REL_RES_ERR_RECV_DATA_TIMEOUT	3

/* Video direction */
#define VIDEO_DIR_SEND_ONLY		0
#define VIDEO_DIR_RECV_ONLY		1

/* Payload type */
#define RTP_PT_PTIME_PCMU		"ptime=20;"	//20ms
#define RTP_PT_PTIME_PCMA		"ptime=20;"	//20ms
#define RTP_PT_PTIME_G729		"ptime=20;"	//20ms

#define NETWORK_NAME_WIFI		"wifi"
#define NETWORK_NAME_MOBILE		"mobile"

/* mic spk*/
#define MIC_VOL_MUTE			0.0001
#if TARGET_OS_IPHONE
#define MIC_VOL_DEFAULT			1.0
#elif ANDROID
#define MIC_VOL_DEFAULT			0.3
#endif
#define SPK_VOL_MUTE			0.0
#define SPK_VOL_DEFAULT			1.2
#define SEND_MSG_MAX			5



/************************************************************************/
/* 	自定义类型																*/
/************************************************************************/
typedef struct {
	bool running;
	bool takcfg;

}SysCfg;

typedef struct{
	char callId[USER_NAME_MAX_LEN];
	char srcUrl[URL_MAX_LEN];
	char destUrl[URL_MAX_LEN];
}Url;

typedef struct {
	AudioStream *audioStream;
	VideoStream *videoStream;

	int sessionMode;
	int callStatus;
	int streamStatus;
	int callReleaseReason;
	int autoSnapshotFlag;
	char snapshotName[MAXBUF];
	int networkType;
	char callId[USER_NAME_MAX_LEN];
	char srcUrl[URL_MAX_LEN];
	char destUrl[URL_MAX_LEN];
	char mulUrl[URL_MAX_LEN];
	char host[URL_MAX_LEN];
	char time[TIME_MAX_LEN];
	float micVol;
	float spkVol;

	unsigned long videoWindowobj;
	
}CallData;

typedef struct{
	int status;
	char body[MSG_LEN_MAX];
	char callId[USER_NAME_MAX_LEN];
	char srcUrl[URL_MAX_LEN];
	char destUrl[URL_MAX_LEN];
	char mulUrl[URL_MAX_LEN];
}ImsgData;

typedef struct{
	char lanQueryDevice;
	char wanOutgoingCall;
	char netDataExpires;
	char callAnswer;
	char callAck;
	char audioStreamAlive;
}CmTimer;



//iscall network data
typedef struct {
	char remoteip[IP_ADDR_LEN];
	int localPortA;
	int localPortV;
	char networkType;
	char available;
	Url sUrl;
}NwCfg;

typedef struct {
	char localip[IP_ADDR_LEN];
	char broadcastip[IP_ADDR_LEN];
	char nwName[USER_NAME_MAX_LEN];
}NwData;

typedef struct {
    char active[32];
    char type[32];
    char id[32];
    char url[256];
    char br_url[64];
    char tick[32];
}MulticastData;

#endif /* CALLMANAGER_H_ */

//
//  cmatchCode.m
//  EverTalk
//
//  Created by dgw on 16/6/25.
//  Copyright © 2016年 dnake. All rights reserved.
//
#if TARGET_OS_IPHONE
#import <Foundation/Foundation.h>
#endif
#include <net/if.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <sys/select.h>
#include <unistd.h>

#include <sys/wait.h>
#include <arpa/inet.h>
#if ANDROID 
#include <linux/if_ether.h>
#include <iostream>
#include "tinyxml/dxml.h"

#include "JniCommon.h"
#include "CallManager.h"

#ifdef __cplusplus
extern "C" {
#endif

#elif TARGET_OS_IPHONE
#import <netinet/in.h>
#import "ms2common.h"
#import "callManager.h"
#endif




/************************************************************************/
/* 	宏定义																*/
/************************************************************************/
#define XML_SET_VALUE(_ELEM,_CFG)	if((val = xml->getText(_ELEM)) != NULL){strcpy(_CFG,val);}

#define MATCH_ADDR_PORT			9902
#define mMAXBUF					512
#define mSOCKET_WAIT_COUNT  	8		//8*CONFIG_MATCH_WAIT_TIMER = 4S
#define CONFIG_MATCH_WAIT_TIMER 500000 	//500ms


/************************************************************************/
/* 	自定义类型																*/
/************************************************************************/



/************************************************************************/
/* 	提供外部引用变量															*/
/************************************************************************/

/************************************************************************/
/*	定义静态变量/函数															*/
/************************************************************************/
static struct sockaddr_in mMatchCodeAddr,mLocalAddr,mClientAddr;
static int 	mSockFd = 0;
static fd_set  mReadfds;	/*select 指令fd集*/
static socklen_t mAddrLen = 0;
static struct	timeval mTv = {0};
static char mSocketWaitCount = 0;
static int mRet;
static bool mSocketStart = false;

/************************************************************************/
/*	引用外部变量/函数															*/
/************************************************************************/
extern CallData		callData;
extern NwCfg		nwCfg;
extern ImsgData 	imsgData;
extern SipCfg		sipCfg;

extern char Cm_SendEventNotification(int nEvent, const char *msgBody,int nValue);
extern int Cm_InstantMsgSend(const char *callId,int networkType,const char *body);
extern const char *Cm_GetLocalIp(void);

/************************************************************************/
/*	函数实现开始															*/
/************************************************************************/
static void getMatchCodeIp(char *src){

	char *p = 0;

	strcpy(src,Cm_GetLocalIp());
	p = src;

	p += strlen(p);   /*从右边字符开始*/
	while(*p != '.'){
		*p = '\0';
		p--;
	}

	*(++p) = '1';

	MUL_LOGI("getMatchCodeIp: %s",src);

}


void CdevMatchCode_Listeners(void * arg) {

	while(mSocketWaitCount && mSocketStart){

		/* 保存返回值 */
		mRet = 0;

		/*设置select阻塞时间*/
		mTv.tv_sec  = 0;
		mTv.tv_usec = CONFIG_MATCH_WAIT_TIMER;


		/* 用select函数之前先把集合清零 */
		FD_ZERO(&mReadfds);

		/* 把要检测的句柄socket加入到集合里 */
		FD_SET(mSockFd, &mReadfds);

		MUL_LOGI("Clan_MatchCodeListeners loop");

		/* timeout设置为null，即select将一直被阻塞，直到sockFd上发生了事件 */
        mRet = select((mSockFd + 1), &mReadfds, NULL,NULL, &mTv);
		if ( mRet < 0) {

			MUL_LOGE("Match socket select error ......");

		}else if(mRet == 0) {

			MUL_LOGE("Match socket timeout(%d) ......",mSocketWaitCount);

			mSocketWaitCount --;

			continue ;
		}

		/*查询是否真的有可读数据*/
		if (FD_ISSET(mSockFd, &mReadfds) < 0) {

			MUL_LOGE("select ERR!!");
			continue ;
		}

		char buffer[mMAXBUF];
		int len=0;

		bzero(buffer, mMAXBUF);

		/* 读取socket句柄里的数据 */
		/*clientAddr:因为是组播，所以服务器地址信息可以不管，如果是点播的，一定要 加上服务器socket地址信息*/
		len = (int)recvfrom(mSockFd, buffer, mMAXBUF, 0, (struct sockaddr *) &mClientAddr, &mAddrLen);
		if(len <= 0 || len >= mMAXBUF){
			MUL_LOGE("msg_r: L=%d ERR!",len);
			continue ;
		}


		/* 收到的信息为自己发送的则返回 */
		if (strcmp(Cm_GetLocalIp(), inet_ntoa(mClientAddr.sin_addr)) == 0) {
			MUL_LOGI("continue,ip %s =? %s",Cm_GetLocalIp(),inet_ntoa(mClientAddr.sin_addr));
			continue ;
		}

		buffer[len] = 0;
		MUL_LOGI("msg_r: L=%d,%s",len, buffer);


		/* 检查接收包的头和尾*/
//		int i = 0;
		char temp[XML_PARSE_HEAD_MAX_LEN];
		memset(temp,0,XML_PARSE_HEAD_MAX_LEN);
		memcpy(temp,buffer,strlen(XML_PARSE_HEAD));
		if(strcmp(temp,XML_PARSE_HEAD) != 0){

			MUL_LOGE("XML_PARSE_HEAD err");
			continue ;
		}

		memset(temp,0,XML_PARSE_HEAD_MAX_LEN);
		memcpy(temp,&buffer[len-strlen(XML_PARSE_TAIL)-1],strlen(XML_PARSE_TAIL));
		if(strcmp(temp,XML_PARSE_TAIL) != 0){

			MUL_LOGE("XML_PARSE_TAIL err");
			continue ;
		}

		/*发送消息到gui*/
		Cm_SendEventNotification(EVENT_INSTANT_MSG,buffer,len);

		//退出sock
		mSocketWaitCount = 0;
	}

	close(mSockFd);
	mSockFd = 0;
	MUL_LOGI("Clan_MatchCodeListeners end");
}

void CdevMatchCode_SendMsg(const char *body){

	MUL_LOGI("msg_s: %s",body);

	char matchCodeIp[IP_ADDR_LEN] = {0};
	getMatchCodeIp(matchCodeIp);

	/* 创建UDP套接口 */
	mMatchCodeAddr.sin_family	  = AF_INET;
	mMatchCodeAddr.sin_port		  = htons(MATCH_ADDR_PORT);
	mMatchCodeAddr.sin_addr.s_addr = inet_addr(matchCodeIp);

	if (sendto(mSockFd, body, strlen(body), 0, (struct sockaddr*) &mMatchCodeAddr, mAddrLen) < 0) {
		MUL_LOGE( "MatchCodeSend sendto error ...");
	}
}

void CdevMatchCode_Init(const char *body){

	MUL_LOGI("Clan_MatchCodeInit()");

	mAddrLen = sizeof(mMatchCodeAddr);

	bzero(&mMatchCodeAddr, mAddrLen);
	bzero(&mLocalAddr, mAddrLen);
	bzero(&mClientAddr, mAddrLen);

	mSocketStart = false;

	/* 检查mSockFd*/
	while(mSockFd){

        MUL_LOGE("mSockFd existing!!");
		usleep(200000);
	}

	mSocketWaitCount = 0;

	/*
	 * step1:创建socket
	 */
	if ((mSockFd = socket(AF_INET, SOCK_DGRAM, IPPROTO_IP)) < 0) {
		MUL_LOGE("Create multicast socket error...");
		return;
	}


	/*
	 * step2:设置接收参数
	 */
	mLocalAddr.sin_family = AF_INET;
	mLocalAddr.sin_port = htons(MATCH_ADDR_PORT);
	mLocalAddr.sin_addr.s_addr = htonl(INADDR_ANY);

	/* 绑定套接口 */
	if (bind(mSockFd, (struct sockaddr *) &mLocalAddr, sizeof(mLocalAddr)) < 0) {
		MUL_LOGE("Bind error...");
	}


	mSocketWaitCount = mSOCKET_WAIT_COUNT;
	mSocketStart = true;
}


#if ANDROID
#ifdef __cplusplus
}
#endif
#endif

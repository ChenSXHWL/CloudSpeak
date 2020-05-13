//
//  Cmulticast.m
//  EverTalk
//
//  Created by dgw on 17/3/16.
//  Copyright © 2017年 dnake. All rights reserved.
//
#if TARGET_OS_IPHONE
#import <Foundation/Foundation.h>
#endif
#include <net/if.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <sys/select.h>
#include <sys/ioctl.h>
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
#import "packUnpackImsg.h"
#endif

#if 1//CONFIG_SIP_ENABLE
/************************************************************************/
/* 	宏定义																*/
/************************************************************************/
#define MULTI_ADDR_IP		"238.9.9.1"
#define BROADCAST_ADDR_IP	"255.255.255.255"
#define MULTI_ADDR_PORT		(8400)

#define XML_SET_VALUE(_ELEM,_CFG)	if((val = xml->getText(_ELEM)) != NULL){strcpy(_CFG,val);}

/************************************************************************/
/* 	自定义类型																*/
/************************************************************************/


/************************************************************************/
/* 	提供外部引用变量															*/
/************************************************************************/

/************************************************************************/
/*	定义静态变量/函数															*/
/************************************************************************/
static int 	sockFd = 0;							//组播socket
static struct 	ip_mreq 	mreq;					//组播参数
static struct 	sockaddr_in multiAddr, localAddr,clientAddr,broadcastAddr;	//本地，远程地址信息
//static struct 	in_addr 	localInterface;
static struct	timeval tv;
static fd_set  readfds,writefds,exfds;	/*select 指令fd集*/
static socklen_t addrLen = 0;

static MulticastData mulData = {0};
static char saveTick[32]={0};
static char saveId[32]={0};

/************************************************************************/
/*	引用外部变量/函数															*/
/************************************************************************/
extern CallData		callData;
extern NwCfg		nwCfg;
extern ImsgData		imsgData;
extern SipCfg		sipCfg;
extern CmTimer		cmTimer;

extern char Cm_SendEventNotification(int nEvent, const char *msgBody,int nValue);
extern int Cm_OutgoingCall(const char *callId,int networkType);
extern int Cm_InstantMsgSend(const char *callId,int networkType,const char *body);
extern const char *Cm_GetLocalIp(void);
extern bool Cm_GetTestOnlyServer(void);
/************************************************************************/
/*	函数实现开始															*/
/************************************************************************/
static void Cmulticast_DoDiscover(const char *user){

#if ANDROID
	dxml *xml = new dxml();
    xml->setText("/event/active","discover");
    xml->setText("/event/type","req");
    xml->setText("/event/id",user);
    const char *buffer = xml->data();
#else
    
    const char *buffer = [packImsg setDiscover:user];
#endif
	//发送组播查询请求
	if(sockFd){
		if (sendto(sockFd, buffer, strlen(buffer), 0, (struct sockaddr*) &multiAddr, addrLen) < 0) {
			MUL_LOGE( "multicast sendto error ...");
		}

		if (sendto(sockFd, buffer, strlen(buffer), 0, (struct sockaddr*) &broadcastAddr, addrLen) < 0) {
			MUL_LOGE( "broadcast sendto error ...");
		}
	}else {
		MUL_LOGE( "call user socket invalid ...");
	}

	MUL_LOGI("msg_s:%s",buffer);
#if ANDROID
	delete xml;
#endif
}
void Cmulticast_DoQuery(const char *user){

	Cmulticast_DoDiscover(user);
}

static void Cmulticast_DoDiscoverAck(const char *id, const char *localip){

	if(strlen(localip)<=1){
		MUL_LOGE( "DoDiscoverAck strlen(localip)=%d err!!",strlen(localip));
		return;
	}

#if ANDROID
    dxml *xml = new dxml();
    const char *buffer = NULL;
    char url[URL_MAX_LEN]={0};

    sprintf(url,"sip:%s@%s", id, localip);

    xml->setText("/event/active","discover");
    xml->setText("/event/type","ack");
    xml->setText("/event/id",id);
    xml->setText("/event/url",url);

    buffer = xml->data();
#else
    char url[URL_MAX_LEN]={0};
    sprintf(url,"sip:%s@%s", id, localip);
    const char *buffer = [packImsg setDiscoverAck:url uid:id];
#endif
    
	if(sockFd){
		/*clientAddr表示将ACK消息发送回给src地址（clientAddr.sin_addr）*/
		if (sendto(sockFd, buffer, strlen(buffer), 0, (struct sockaddr*) &clientAddr, addrLen) < 0) {
			MUL_LOGE("Multicast sendto ack error!!");
		}
	}else {
		MUL_LOGE( "call user socket invalid!!");
	}

	MUL_LOGI("msg_s: %s\n", buffer);
#if ANDROID
	delete xml;
#endif
}

static void Cmulticast_DoSearchAck(const char *id, const char *localip){

#if ANDROID
    dxml *xml = new dxml();
    const char *buffer = NULL;

    xml->setText("/event/active","search");
    xml->setText("/event/type","ack");
    xml->setText("/event/id",id);
    xml->setText("/event/ip",localip);
    xml->setText("/event/mac","00:00:00:00:00:00");

    buffer = xml->data();
#else
    const char *buffer = [packImsg setSearchAck:localip uid:id];
#endif
    
	if(sockFd){
		if (sendto(sockFd,buffer, strlen(buffer), 0, (struct sockaddr*) &clientAddr, addrLen) < 0) {
			MUL_LOGE("Multicast sendto ack error...");
		}
	}else {
		MUL_LOGE( "call user socket invalid ...");
	}

	MUL_LOGI("msg_s:%d %s\n", strlen(buffer),buffer);
    
#if ANDROID
	delete xml;
#endif
}

static void Cmulticast_DoRcvDevAlarm(const char *id, const char *tick){
	 MUL_LOGW("Cmulticast_DoRcvDevAlarm");
	if((strcmp(tick, saveTick) == 0) && (strcmp(id, saveId) == 0)){
		MUL_LOGW("tick = saveTick");
		return;
	}
	strcpy(saveTick,tick);
	strcpy(saveId,id);
#if ANDROID
    dxml *xml = new dxml();
    const char *buffer = NULL;

    xml->setText("/params/event_url","/wifi/device_alarm");
    xml->setText("/params/type","req");
    xml->setText("/params/device_id",id);
    xml->setText("/params/tick",tick);

    buffer = xml->data();
    
#else
    const char *buffer = [packImsg setRcvDevAlarm:tick uid:id];
#endif
    
    Cm_SendEventNotification(EVENT_INSTANT_MSG,buffer,(int)strlen(buffer));
    
#if ANDROID
    delete xml;
#endif
}


/******************************************************************
 * 函数名称：void * Listeners(void * arg)
 * 函数说明：本地组播通讯线程，用于监听本地呼叫与用户查询
 * 参数：线程参数
 ******************************************************************/
void Cmulticast_Listeners(void * arg) {

	/* 接收并解析所有发送到本机GROUP_PORT端口上的数据 */
	FD_ZERO(&readfds);
	FD_ZERO(&writefds);
	FD_ZERO(&exfds);
	FD_SET(sockFd, &readfds);

	/* timeout设置为null，即select将一直被阻塞，直到sockFd上发生了事件 */
	if (select((sockFd + 1), &readfds, &writefds,&exfds, &tv) < 0) {
		MUL_LOGI("Multicast socket select error ......");
	}

	/*查询数据*/
	if (FD_ISSET(sockFd, &readfds) < 0) {

		MUL_LOGE("select ERR!!");
		return ;
	}

	char buffer[MAXBUF];
	int len=0;

	bzero(buffer, MAXBUF);

	/*clientAddr:因为是组播，所以服务器地址信息可以不管，如果是点播的，一定要 加上服务器socket地址信息*/
	len = (int)recvfrom(sockFd, buffer, MAXBUF, 0, (struct sockaddr *) &clientAddr, &addrLen);
	if(len <= 0 || len >= MAXBUF){
		MUL_LOGE("msg_r: L=%d ERR!",len);
		return ;
	}

	/* 收到的信息为自己发送的则返回 */
	if (strcmp(Cm_GetLocalIp(), inet_ntoa(clientAddr.sin_addr)) == 0) {
		MUL_LOGI("continue,ip %s =? %s",Cm_GetLocalIp(),inet_ntoa(clientAddr.sin_addr));
		return ;
	}

	if(Cm_GetTestOnlyServer()){
		MUL_LOGI("continue,testOnlyServer");
		return ;
	}

	buffer[len] = 0;
	MUL_LOGI("msg_r:ip=%s L=%d,%s",inet_ntoa(clientAddr.sin_addr),len, buffer);

#if ANDROID
	dxml *xml = new dxml();
	xml->load(buffer);

    const char * val = NULL;
    memset(&mulData,0,sizeof(mulData));

	XML_SET_VALUE("/event/active", mulData.active);
	XML_SET_VALUE("/event/type",   mulData.type);
	XML_SET_VALUE("/event/id",	   mulData.id);
	XML_SET_VALUE("/event/url",    mulData.url);
	XML_SET_VALUE("/event/broadcast_url", mulData.br_url);
	XML_SET_VALUE("/event/device_id", mulData.id);
	XML_SET_VALUE("/event/tick", mulData.tick);
#else
    memset(&mulData,0,sizeof(mulData));
    [packImsg parseMulMsg:buffer mul_data:&mulData];
    
#endif
	/* 收到对方的req/ack应答 */
	if ((strcmp(mulData.active, "discover") == 0)
			&& (strcmp(mulData.type, "req") == 0)
			&& (strcmp(mulData.id, sipCfg.sipUserName) == 0)) {

		/* 收到查询请求，应答ack */
		Cmulticast_DoDiscoverAck(mulData.id,Cm_GetLocalIp());

	}else if ((strcmp(mulData.active, "discover") == 0)
			&& (strcmp(mulData.type, "ack") == 0)
			&& ((strcmp(mulData.id, callData.callId) == 0) || (strcmp(mulData.id, imsgData.callId) == 0))
			&& (strlen(mulData.url) > 0)) {

		//关闭查询定时器
		cmTimer.lanQueryDevice = 0;

		if(callData.sessionMode == SESSION_MODE_MONITOR
				&& (callData.networkType == NETWORK_TYPE_QUERY)
				&& callData.callStatus == CALL_STATUS_INVITE){

			/* 向对方发起一个invite邀请 */
			strcpy(callData.mulUrl,mulData.url);
			Cm_OutgoingCall(callData.callId,NETWORK_TYPE_LAN);

		}else if(imsgData.status == SENDIMSG_STATUS_QUERY
				&& imsgData.callId[0] != 0
				&& strlen(imsgData.body) > 1){

			//此时imsgData.callId不使用的，只是为了做兼容性。
			strcpy(imsgData.mulUrl,mulData.url);
			Cm_InstantMsgSend(imsgData.callId,NETWORK_TYPE_LAN,imsgData.body);
		}
	}else if ((strcmp(mulData.active, "broadcast_data") == 0)
			&& (strcmp(mulData.type, "req") == 0)
			&& (strcmp(mulData.br_url, "device_alarm") == 0)
			&& strlen(mulData.id) > 0
			&& strlen(mulData.tick) > 0){

		/* 收到报警消息,转发到GUI层 */
		Cmulticast_DoRcvDevAlarm(mulData.id,mulData.tick);

	}else if ((strcmp(mulData.active, "search") == 0)
			&& (strcmp(mulData.type, "req") == 0)){

		/* 收到查询请求，应答ack */
		Cmulticast_DoSearchAck(sipCfg.sipUserName,Cm_GetLocalIp());
	}
#if ANDROID
	delete xml;
#endif
}

void Cmulticast_Init(void){

	MUL_LOGI("Cmulticast_Init()");

	addrLen = sizeof(struct sockaddr_in);/*地址结构长度*/

	bzero(&multiAddr, addrLen);
	bzero(&broadcastAddr, addrLen);
	bzero(&localAddr, addrLen);
	bzero(&clientAddr, addrLen);
	bzero(&mreq, sizeof(struct ip_mreq));

	/*
	 * step1:创建socket
	 */
	if ((sockFd = socket(AF_INET, SOCK_DGRAM, IPPROTO_IP)) <= 0) {
		MUL_LOGE("Create multicast socket error...");
		return;
	}

	/*
	 * step2:设置发送参数：
	 */
	//组播组的IP地址和端口
	multiAddr.sin_family	  = AF_INET;
	multiAddr.sin_port		  = htons(MULTI_ADDR_PORT);
	multiAddr.sin_addr.s_addr = inet_addr(MULTI_ADDR_IP);

	//禁止组播回环
	unsigned char 	loop = 0;	/*0:禁止回送，1:允许回送*/
	if (setsockopt(sockFd, IPPROTO_IP, IP_MULTICAST_LOOP, &loop, sizeof(loop)) < 0) {
		MUL_LOGE("Set setsockopt:IP_MULTICAST_LOOP error...");
		return;
	}

	//设置广播参数
	broadcastAddr.sin_family=AF_INET;
	broadcastAddr.sin_port=htons(MULTI_ADDR_PORT);
	broadcastAddr.sin_addr.s_addr = inet_addr(BROADCAST_ADDR_IP);

	//设置套接字描述符支持广播
	int so_broadcast=1;
	if (setsockopt(sockFd,SOL_SOCKET,SO_BROADCAST,&so_broadcast,sizeof(so_broadcast)) < 0) {
		MUL_LOGE("Set SO_BROADCAST error...");
		return;
	}
	/*
	 * step3:设置接收参数
	 */

	//设置端口复用,即允许多个应用绑定同一个本地端口接收数据包。
	int reuse = 1;	/*端口绑定重用标志*/
	if (setsockopt(sockFd, SOL_SOCKET, SO_REUSEADDR, &reuse, sizeof(reuse)) < 0) {
		MUL_LOGE("Set SO_REUSEADDR error...");
		return;
	}

	//绑定本地端口
	localAddr.sin_family      = AF_INET;				/*IPV4协议族*/
	localAddr.sin_port        = htons(MULTI_ADDR_PORT); /*绑定的端口*/
	localAddr.sin_addr.s_addr = htonl(INADDR_ANY);		/*绑定在本地的所有地址上,INADDR_ANY表示能接收组播数据包*/

	if (bind(sockFd, (struct sockaddr *) &localAddr, sizeof(localAddr)) < 0) {
		MUL_LOGE("Bind error...");
		return;
	}

	//设置本地ip加入组播表,即加入一个多播组
	mreq.imr_multiaddr.s_addr = inet_addr(MULTI_ADDR_IP);
	mreq.imr_interface.s_addr = inet_addr(Cm_GetLocalIp());//htonl(INADDR_ANY);	//INADDR_ANY表示使用默认组播接口

	if (setsockopt(sockFd, IPPROTO_IP, IP_ADD_MEMBERSHIP, &mreq, sizeof(mreq)) < 0) {
		MUL_LOGE("setsockopt:IP_ADD_MEMBERSHIP");
		return;
	}


	/*设置select阻塞时间*/
	tv.tv_sec  = 0;
	tv.tv_usec = CONFIG_MUL_WAIT_TIMER * 1000;

}


void Cmulticast_Exit(void){

	/* 离开一个多播组 */
	setsockopt(sockFd, IPPROTO_IP, IP_DROP_MEMBERSHIP,&mreq, sizeof(mreq));
	/* 关闭socket */
	close(sockFd);
	MUL_LOGI("Cmulticast_Exit()!!");
}

#endif
#if ANDROID
#ifdef __cplusplus
}
#endif
#endif

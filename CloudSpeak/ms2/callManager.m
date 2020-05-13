//
//  callManager.cpp
//  EverTalk
//
//  Created by dgw on 17/03/15.
//  Copyright ? 2017年 dnake. All rights reserved.
//
#if TARGET_OS_IPHONE
#import <Foundation/Foundation.h>
#import "AYAnalysisXMLData.h"

#import "ms2common.h"
#import "callManager.h"
#import "packUnpackImsg.h"

#elif ANDROID
#include <unistd.h>
#include "JniCommon.h"
#include "CallManager.h"

#ifdef __cplusplus
extern "C" {
#endif
#endif

#if 1//CONFIG_SIP_ENABLE
/************************************************************************/
/* 	宏定义																*/
/************************************************************************/

#define 	DUMP_MSG_STR(_msg) case (_msg) :return #_msg;

/************************************************************************/
/*	引用外部变量/函数															*/
/************************************************************************/
#if ANDROID
extern jclass gJclAndroidVideoWindowImpl;	//全局视频播放对象对象class
extern jclass gJclAudio;
#endif


extern void Cmulticast_Init(void);
extern void Cmulticast_Exit(void);
extern void Cmulticast_DoQuery(const char *user);
extern void Cmulticast_Listeners(void * arg);

extern void CdevMatchCode_SendMsg(const char *body);
extern void CdevMatchCode_Listeners(void * arg);
extern void CdevMatchCode_Init();

#if ANDROID
extern void jni_manager_Sendmsg(int nEvent, const char *msgBody);
extern void jni_manager_CleanThreadEnv(void);
extern unsigned long jni_manager_GetVideoWindow(void);
extern void jni_manager_SetVideoWindow(unsigned long obj);

#elif TARGET_OS_IPHONE
extern void parseImsg(NSDictionary *userinfo,const char *msgBody);
#endif
/************************************************************************/
/* 	自定义类型																*/
/************************************************************************/
typedef struct {
	int evType;
	int len;
	char msgBody[MSG_LEN_MAX];
}call_event_t;

typedef void (*cbFacility)(int nEvent, const char *msgBody);


/************************************************************************/
/* 	提供外部引用变量/函数														*/
/************************************************************************/
SipCfg		sipCfg = {0};
NwCfg		nwCfg  = {0};
NwData		nwData = {0};
CallData	callData = {0};
ImsgData	imsgData = {0};
SysCfg		sysCfg	 = {0};
CmTimer		cmTimer  = {0};

bool testOnlyServer  = false;
float micVol = MIC_VOL_DEFAULT;

int Cm_OutgoingCall(const char *callId,int networkType);
int Cm_CallRelease(int msg);

/************************************************************************/
/*	定义静态变量/函数															*/
/************************************************************************/
#if ANDROID
static cbFacility pcbFacility = NULL;
static call_event_t callEvent[SEND_MSG_MAX] = {0};
#endif
static unsigned long window_id= 0;//全局视频播放对象对象class
static float saveSpkVol = SPK_VOL_DEFAULT;
static float saveMicVol = MIC_VOL_DEFAULT;

static bool isFirstCallStart = true;

static int Cm_GetCallStatus(void);
/************************************************************************/
/*	引用外部变量/函数															*/
/************************************************************************/

/************************************************************************/
/*函数实现开始																*/
/************************************************************************/
#if ANDROID
static void Cm_RegFacilityCB(cbFacility  pAppCb){
	if( pAppCb != NULL )
		pcbFacility = pAppCb;
}

static void Cm_DeregFacilityCB(void){
	pcbFacility = NULL;
}

static bool Cm_IsFacilityBusy(void){

	return ((pcbFacility == NULL) ? false:true);
}


static bool Cm_SendFacilityMessage(void){
	char i;

	for(i = 0;i < SEND_MSG_MAX; i++){
		if(callEvent[i].evType > 0){
			pcbFacility(callEvent[i].evType, callEvent[i].msgBody);
			memset(&callEvent[i],0,sizeof(call_event_t));
		}
	}

	return true;
}

static bool Cm_SetFacilityMessage(int nEvent, const char *msgBody,int nMsgLen){
	char i;

	for(i = 0;i < SEND_MSG_MAX; i++){
		if(callEvent[i].evType == 0){

			callEvent[i].evType = nEvent;

			if(nMsgLen > 0 && nMsgLen < MSG_LEN_MAX){

				memcpy(callEvent[i].msgBody,msgBody,nMsgLen);
				callEvent[i].len = nMsgLen;
			}
			break;
		}
	}

	if(i >= SEND_MSG_MAX){
		MED_LOGE("SetEventNotification err!!");
		return false;
	}

	return true;
}

char Cm_SendEventNotification(int nEvent, const char *msgBody,int nMsgLen){
	int enResult = -1;

	MED_LOGI("nEvent %d Len %d",nEvent,nMsgLen);

	Cm_SetFacilityMessage(nEvent,msgBody,nMsgLen);

	if(Cm_IsFacilityBusy()){
		MED_LOGW("Cm_IsFacilityBusy() err!!");
		return enResult;
	}

	Cm_RegFacilityCB(&jni_manager_Sendmsg);

	Cm_SendFacilityMessage();

	Cm_DeregFacilityCB();

	return enResult;
}
#endif

#if TARGET_OS_IPHONE
/************************************************************************/
/* 	  																    */
/************************************************************************/
void Cm_RegisterUser(void);
int Cm_InstantMsgSend(const char *callId,int networkType,const char *body);
void Cm_SetLocalIp(const char *loadIp,const char *broadcastIp,const char *nwName);

/************************************************************************/
/* 	  																    */
/************************************************************************/
static const char * dump_sendMsg2Gui(int msg)
{
    switch(msg)
    {
            DUMP_MSG_STR(EVENT_CALL_ANSWER)
            DUMP_MSG_STR(EVENT_CALL_RINGING)
            DUMP_MSG_STR(EVENT_CALL_CLOSED)
            DUMP_MSG_STR(EVENT_REGISTRATION)
            DUMP_MSG_STR(EVENT_REGISTRATION_FAILURE)
            DUMP_MSG_STR(EVENT_CALL_ACK)
            DUMP_MSG_STR(EVENT_CALL_CANCELLED)
            DUMP_MSG_STR(EVENT_CALL_INVITE)
            DUMP_MSG_STR(EVENT_MESSAGE_NEW)
            DUMP_MSG_STR(EVENT_CALL_RELEASED)
            DUMP_MSG_STR(EVENT_CALL_SERVERFAILURE)
            DUMP_MSG_STR(EVENT_CALL_PROCEEDING)
            DUMP_MSG_STR(EVENT_CALL_PICKED)
            DUMP_MSG_STR(EVENT_CALL_UNLOCK)
            DUMP_MSG_STR(EVENT_CALL_STATUS)
            DUMP_MSG_STR(EVENT_INSTANT_MSG)
            
        default:
            break;
    }
    
    return "unknown";
}


#pragma mark - 发送消息到GUI
void Cm_sendMsg2Gui(int nEvent, const char *msgBody,int nMsgLen) {
    
    MED_LOGI("sendMsg2Gui:%s",dump_sendMsg2Gui(nEvent));
    
    if(nEvent == EVENT_INSTANT_MSG){
        
        NSDictionary *userinfo;
        if(strlen(msgBody)){
//            userinfo = [packImsg parseImsg:msgBody];
            userinfo = [AYAnalysisXMLData analysisXMLWithListenVideo:[NSString stringWithUTF8String:msgBody]];
            
        }
        
        NSLog(@"userinfo====%@", userinfo);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"event_instant_msg" object:nil userInfo:userinfo];
    }else if(nEvent == EVENT_CALL_INVITE){
        NSString *callId=[NSString stringWithUTF8String:msgBody];
        NSDictionary *userinfo=@{@"callId": callId};

        [[NSNotificationCenter defaultCenter] postNotificationName:@"event_call_invite" object:nil userInfo:userinfo];
    }else if(nEvent == EVENT_CALL_RINGING){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"event_call_ringing" object:nil userInfo:nil];
    }else if(nEvent == EVENT_CALL_ANSWER){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"event_call_answer" object:nil userInfo:nil];
    }else if(nEvent == EVENT_CALL_CLOSED){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"event_call_close" object:nil userInfo:nil];
    }else if(nEvent == EVENT_CALL_STATUS){
        
        NSString *status=[NSString stringWithUTF8String:msgBody];
        NSDictionary *userinfo=@{@"status": status};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"event_call_status" object:nil userInfo:userinfo];
        
    }else if(nEvent == EVENT_REGISTRATION){
        
        NSString *status=[NSString stringWithUTF8String:msgBody];
        NSDictionary *userinfo=@{@"registration": status};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"event_registration" object:nil userInfo:userinfo];
        
    }
}

char Cm_SendEventNotification(int nEvent, const char *msgBody,int nMsgLen){
    int enResult = -1;
    
    Cm_sendMsg2Gui(nEvent,msgBody,nMsgLen);
    
    return enResult;
}



#pragma mark - 对码添加设备
void sendImsgMatchAddDev(const char* ssid ,const char* ssidPwd ,const char* authmode,  const char*  encryptType,const char* user_id,const char* dev_id,const char*sip_psw,const char*sip_server){
    
    // send msg
    Cm_MatchMsgSend([packImsg matchAddDev:ssid ssidPwd:ssidPwd authmode:authmode encryptType:encryptType user_id:user_id dev_id:dev_id sip_psw:sip_psw sip_server:sip_server]);
}
    
//手动添加设备
void sendImsgAddDev(const char* callId){
        
    // send msg
    Cm_InstantMsgSend(callId,NETWORK_TYPE_QUERY,[packImsg queryDevInfo:callId user_id:sipCfg.sipUserName]);
}

//查询设备信息
void sendImsgQueryDevInfo(const char *callId){
    
    Cm_InstantMsgSend(callId,NETWORK_TYPE_QUERY,[packImsg queryDevInfo:callId user_id:sipCfg.sipUserName]);
}

//查询用户信息
void sendImsgQueryUserInfo(const char *callId){
        
    Cm_InstantMsgSend(callId,NETWORK_TYPE_QUERY,[packImsg queryUserInfo:callId user_id:sipCfg.sipUserName]);
}
//添加用户
void sendImsgAddUser(const char *callId,const char * devPwd ,const char * user_id, const char *user_type){
        
    Cm_InstantMsgSend(callId,NETWORK_TYPE_QUERY,[packImsg addUser:callId devPwd:devPwd admin_id:sipCfg.sipUserName user_id:user_id user_type:user_type]);
}
  
//删除用户
void sendImsgDelUser(const char *callId,const char * devPwd ,const char * user_id){
        
    Cm_InstantMsgSend(callId,NETWORK_TYPE_QUERY,[packImsg delUser:callId devPwd:devPwd admin_id:sipCfg.sipUserName user_id:user_id]);
}
    
//修改设备密码
void sendImsgChangeDevicePwd(const char *callId,const char * oldPwd ,const char * newPwd){
    
    Cm_InstantMsgSend(callId,NETWORK_TYPE_QUERY,[packImsg changeDevicePwd:callId user_id:sipCfg.sipUserName oldPwd: oldPwd newPwd:newPwd]);
}

//修改设备sip帐号
void sendImsgChangeDeviceId(const char *callId,const char * dev_pwd ,const char * dev_new_id,const char * sip_pwd,const char * sip_serv){
    
    Cm_InstantMsgSend(callId,NETWORK_TYPE_QUERY,[packImsg changeDeviceId:callId dev_pwd:dev_pwd user_id:sipCfg.sipUserName dev_new_id: dev_new_id sip_pwd:sip_pwd sip_serv:sip_serv]);
}
    
//查询设备sip帐号
void sendImsgQueryDeviceId(const char *callId){

    Cm_InstantMsgSend(callId,NETWORK_TYPE_QUERY,[packImsg queryDeviceId:callId user_id:sipCfg.sipUserName ]);
}
    
    
// 获得开锁时间
void sendImsGetLockTime(const char * callId) {
    // send msg
    Cm_InstantMsgSend(callId,NETWORK_TYPE_QUERY,[packImsg getLockTime:callId user_id:sipCfg.sipUserName]);
}

// 设置开锁时间
void sendImsSetLockTime(const char * callId ,const char *devPwd ,const char* callLimit ,const char* bitrate ,const char*unlockTi){

    // send msg
    Cm_InstantMsgSend(callId,NETWORK_TYPE_QUERY,[packImsg setLockTime:sipCfg.sipUserName dev_id:callId devPwd:devPwd callLimit:callLimit bitrate:bitrate unlockTi:unlockTi]);
    
}

// 配置WIFI
void sendImsSetWifi(const char * callId ,const char *devPwd,const char*wifiHot,const char* wifiPwd) {

    // send msg
    Cm_InstantMsgSend(callId,NETWORK_TYPE_QUERY,[packImsg setWifi:callId devPwd:devPwd user_id:sipCfg.sipUserName authmode:"0" encryptType:"0" wifiHot:wifiHot wifiPwd:wifiPwd]);
}

// 门口机固件升级
void sendImsSetVerUpdate(const char * callId ,const char *devPwd , const char*devModel,const char* latestVersion ,const char* isForce ,const char* downLoadUrl,const char* md5) {
    
    // send msg
    Cm_InstantMsgSend(callId,NETWORK_TYPE_QUERY,[packImsg setVersionUpdate:devModel latestVersion:latestVersion isForce:isForce  downLoadUrl:downLoadUrl md5:md5]);
}

//通话中开关视频
void sendSetDevVideo(const char *onOff) {
    Cm_InstantMsgSend(callData.callId,NETWORK_TYPE_QUERY,[packImsg setDevVideo:callData.callId user_id:sipCfg.sipUserName onOff:onOff]);
}

//系统配置
void Cm_SetSipCfg(const char *sipProxy,const char *sipUserName,const char *sipPasswd) {

	if(strlen(sipProxy) < 2 || sipUserName==NULL||strlen(sipUserName)< 1){
		MED_LOGE("Cm_SetSipCfg ERR!!");
		return ;
	}

	strcpy(sipCfg.sipProxy,sipProxy);		//sip服务器地址
	strcpy(sipCfg.sipUserName,sipUserName);	//sip用户
	strcpy(sipCfg.sipPasswd,sipPasswd);		//sip密码

	memset(&nwCfg,0,sizeof(nwCfg));
	memset(&imsgData,0,sizeof(imsgData));

	MED_LOGI("Cm_SetSipCfg sipProxy:%s sipUserName:%s",sipCfg.sipProxy,sipCfg.sipUserName);

	sysCfg.takcfg = true;
	Cm_RegisterUser();
}

void Cm_SetNetWData(const char *loadIp,const char *broadcastIp,const char *nwName){

	Cm_SetLocalIp(loadIp,broadcastIp,nwName);

	if(sysCfg.takcfg){
		Cm_RegisterUser();
	}
}
#endif

static void Cm_SetCallStatus(int value){

	callData.callStatus = value;

	MED_LOGI("SetCallStatus %d\n",value);
}

static int Cm_GetCallStatus(void){

	MED_LOGI("GetCallStatus %d\n",callData.callStatus);

	return callData.callStatus;
}

const char *Cm_GetLocalIp(void){

	if(strlen(nwData.localip) == 0){
		MED_LOGW("Cm_GetLocalIp is null!!");
	}

	MED_LOGI("Cm_GetLocalIp %s",nwData.localip);

	return nwData.localip;
}

void Cm_SetLocalIp(const char *loadIp,const char *broadcastIp,const char *nwName){

	MED_LOGI("Cm_SetLocalIp %s  %s %s",loadIp,broadcastIp,nwName);
    
    if(strlen(loadIp) > 16){
        MED_LOGE("Cm_SetLocalIp ERR!!");
        return ;
    }
    
    
	memset(&nwCfg,0,sizeof(nwCfg));
	Cm_CallRelease(EVENT_CALL_CLOSED);
	memset(&nwData,0,sizeof(nwData));

	strcpy(nwData.localip,loadIp);
	strcpy(nwData.broadcastip,broadcastIp);
	strcpy(nwData.nwName,nwName);
}


void Cm_SetTestOnlyServer(bool value){

	testOnlyServer = value;
	MED_LOGI("Cm_SetTestOnlyServer %d",testOnlyServer);
}

bool Cm_GetTestOnlyServer(void){

	MED_LOGI("Cm_GetTestOnlyServer %d",testOnlyServer);

	return testOnlyServer;
}



#pragma mark - MS2模块设置音频参数
static bool Cm_IsFloatEqual(float num1, float num2){

	if(((num1-num2) > -0.000001)&& ((num1-num2) < 0.000001) )
		return true;

	return false;
}
bool Cm_SetMicVol(float vol){

	if(Cm_GetCallStatus() >= CALL_STATUS_TERMINATING){
		 MED_LOGW("Cm_SetMicVol error %d",Cm_GetCallStatus());
		 return false;
	}

	if(!Cm_IsFloatEqual(vol, MIC_VOL_MUTE)){
        saveMicVol = vol;
	}

	callData.micVol = vol;
    if(callData.audioStream){
        MED_LOGI("Cm_SetMicVol:%f",vol);

        audio_stream_set_mic_vol(callData.audioStream,vol);

        return true;
    }else{
        MED_LOGW("Cm_SetMicVol(%f) ERR!!",vol);
    }

    return false;
}

bool Cm_SetSpkVol(float vol){

	if(Cm_GetCallStatus() >= CALL_STATUS_TERMINATING){
		MED_LOGW("Cm_SetSpkVol error %d",Cm_GetCallStatus());
		 return false;
	}


	if(!Cm_IsFloatEqual(vol, SPK_VOL_MUTE)){
		saveSpkVol = vol;
	}

	callData.spkVol = vol;

    if(callData.audioStream){

        audio_stream_set_spk_vol(callData.audioStream,vol);

        return true;
    }else{
        MED_LOGW("Cm_SetSpkVol ERR!!");
    }

    return false;
}

float Cm_GetMicVol(void){

    if(callData.audioStream){

        return audio_stream_get_mic_vol(callData.audioStream);
    }
    return 0;
}

float Cm_GetSpkVol(void){

    if(callData.audioStream){

        return audio_stream_get_spk_vol(callData.audioStream);
    }
    return 0;
}

void Cm_SetAppMicMute(const char * mute){

    MED_LOGI("Cm_SetAppMicMute %s",mute);

    if(strcmp(mute,"1") == 0){

        Cm_SetMicVol(MIC_VOL_MUTE);

    }else{

        Cm_SetMicVol(saveMicVol);
    }
}

void Cm_SetAppSpkMute(const char * mute){

    MED_LOGI("Cm_SetAppSpkMute %s",mute);

    if(strcmp(mute,"1") == 0){

        Cm_SetSpkVol(SPK_VOL_MUTE);

    }else{

        Cm_SetSpkVol(saveSpkVol);
    }
}

#pragma mark - MS2模块快照功能
static void Cm_SetSnapshotFileName(char * snapshotName,int len,const char *fileName){

    struct timeval tpstart;
    gettimeofday(&tpstart,NULL);

    snprintf(snapshotName,len,
             "%s_%ld.jpg",
             fileName,
             (long)tpstart.tv_usec);

    MED_LOGI("Cm_SetSnapshotFileName(%d): %s",strlen(snapshotName),snapshotName);
}

void Cm_videoSnapshot(const char *fileName){

    //当正在关闭底层库时不去截图
    if(Cm_GetCallStatus() == CALL_STATUS_TERMINATING
       || Cm_GetCallStatus() == CALL_STATUS_TERMINATED){
        
        MED_LOGW("Cm_videoSnapshot err!!");
        return ;
    }

/*
	if(callData.autoSnapshotFlag == 0 && (callData.sessionMode == SESSION_MODE_INCOMING_CALL)){
    	MED_LOGI("Cm_videoSnapshot(%d): %s",strlen(fileName),fileName);

    	callData.autoSnapshotFlag = 1;
    	strcpy(callData.snapshotName,fileName);

    	return ;
    }
*/
    if(callData.videoStream){

        char snapshotName[MAXBUF] = {0};

        Cm_SetSnapshotFileName(snapshotName,sizeof(snapshotName),fileName);

        video_stream_shapshot(callData.videoStream,snapshotName);
    }
}


unsigned long Cm_GetVideoWindow(void){

    MED_LOGI("get window_id 0x%lx",window_id);
    return window_id;
}

void Cm_SetVideoWindow(unsigned long obj){

    MED_LOGI("set window_id 0x%lx",obj);
    window_id = obj;

    if (callData.videoStream && callData.videoStream->window_id && obj) {
        callData.videoStream->window_id = obj;
        video_stream_set_native_window_id(callData.videoStream, obj);
    }
}


void Cm_SaveNwCfg(const char *srcUrl,const char *destUrl,const char *callId,int networkType){

	strcpy(nwCfg.sUrl.srcUrl,srcUrl);
	strcpy(nwCfg.sUrl.destUrl,destUrl);
	strcpy(nwCfg.sUrl.callId,callId);
	nwCfg.networkType = networkType;
	nwCfg.available = 1;
	MED_LOGI("save nwCfg:callId %s, srcUrl %s, destUrl %s networkType %d", callId,srcUrl,destUrl,networkType);
}

int Cm_InstantMsgSend(const char *callId,int networkType,const char *body){

	int result = EXIT_FAILURE;

	if(USER_NAME_MAX_LEN <= strlen(callId)){
		MED_LOGE("callId len(%d) ERR!!",strlen(callId));
		return result;
	}

	if(strlen(body) >= MSG_LEN_MAX){

		MED_LOGE("body len(%d) ERR!!",strlen(body));
		return result;
	}


	MED_LOGI("Cm_InstantMsgSend: callId %s networkType %d available %d nwName %s",
			callId,networkType,nwCfg.available,nwData.nwName);

	/* 初始化 状态*/
	imsgData.status = SENDIMSG_STATUS_IDLE;

	//如果是mobile网络直接发起外网通信
	//或者在只使用外网服务器时直接发起外网通信
	if(strcmp(nwData.nwName,NETWORK_NAME_MOBILE) == 0
			|| Cm_GetTestOnlyServer()){

		networkType = NETWORK_TYPE_WAN;
		/* 配置imsgData */
		strcpy(imsgData.callId,callId);
		strcpy(imsgData.body,body);
	}


	/* 发送查询消息 */
	//没有保存网络或者是call id不同则要重新查询
	if((networkType == NETWORK_TYPE_QUERY)
			&&((nwCfg.available == 0) || (strcmp(nwCfg.sUrl.callId, callId) != 0))){

		memset(&nwCfg,0,sizeof(nwCfg));
		memset(&imsgData,0,sizeof(imsgData));

		/* 配置imsgData */
		strcpy(imsgData.callId,callId);
		strcpy(imsgData.body,body);

		imsgData.status = SENDIMSG_STATUS_QUERY;
#if CONFIG_MULTICAST_ENABLE && ANDROID
		//只有wifi网络才做局域网查询
		if(strcmp(nwData.nwName,NETWORK_NAME_WIFI) == 0){
            
			/* 发送lan查询消息 */
			Cmulticast_DoQuery(callId);
			//打开查询定时器
			cmTimer.lanQueryDevice = LAN_QUERY_DEVICE_TIME;
		}
#endif
		/* 如果服务器注册成功则直接发送数据*/
		if(SIPUA_GetRegisterStatus()){
			sprintf(imsgData.srcUrl, "sip:%s@%s", sipCfg.sipUserName, sipCfg.sipProxy);
			sprintf(imsgData.destUrl, "sip:%s@%s", callId, sipCfg.sipProxy);

			SIPUA_DoInstantMsg(imsgData.srcUrl,imsgData.destUrl,imsgData.body);
		}

		return EXIT_SUCCESS;
	}


	/* 如果保存的网络类型是有效的就直接发数据 */
	if((networkType == NETWORK_TYPE_QUERY)
		&&(nwCfg.available == 1)
		&&(strcmp( nwCfg.sUrl.callId,callId) == 0)){

		//使用保存的URL
		strcpy(imsgData.srcUrl,nwCfg.sUrl.srcUrl);
		strcpy(imsgData.destUrl,nwCfg.sUrl.destUrl);
		strcpy(imsgData.body,body);

	}else if(networkType == NETWORK_TYPE_LAN){

		//关闭定时器
		cmTimer.lanQueryDevice = 0;
		cmTimer.wanOutgoingCall = 0;

		sprintf(imsgData.srcUrl, "sip:%s@%s", sipCfg.sipUserName, Cm_GetLocalIp());
		strcpy(imsgData.destUrl, imsgData.mulUrl);

	}else if(networkType == NETWORK_TYPE_WAN){

		sprintf(imsgData.srcUrl, "sip:%s@%s", sipCfg.sipUserName, sipCfg.sipProxy);
		sprintf(imsgData.destUrl, "sip:%s@%s", callId, sipCfg.sipProxy);
	}

	/*发送消息*/
	SIPUA_DoInstantMsg(imsgData.srcUrl,imsgData.destUrl,imsgData.body);

	/*保存网络配置*/
	Cm_SaveNwCfg(imsgData.srcUrl,imsgData.destUrl,callId,networkType);

    /* 清除数据 */
	memset(&imsgData,0,sizeof(imsgData));

	/* 若无通话时，30S后清除保存的网络配置 */
	if(Cm_GetCallStatus() == CALL_STATUS_IDLE ){

		cmTimer.netDataExpires = NWTYPE_DURATION_TIME;
	}


	return EXIT_SUCCESS;
}



#pragma mark - MS2模块流数据工作
static int Cm_StreamStop(void){

    MED_LOGI("Cm_StreamStop()");
    sip_audio_stream_stop(callData.audioStream);
    sip_video_stream_stop(callData.videoStream);

    return 0;
}

int Cm_StreamStart(bool bStartAudio, bool bStartVideo,unsigned long window_id){

    if(bStartVideo && window_id
       && (callData.videoStream == NULL)
       && (callData.streamStatus != STREAM_STATUS_V_STARTING)){
    	
    	if(SIPUA_GetRemotePortV() <= 0){
    		MED_LOGE("videoStream ERR!! %d",SIPUA_GetRemotePortV());
    		return -1;
    	}


        callData.streamStatus = STREAM_STATUS_V_STARTING;
        callData.videoStream = sip_video_stream_start(RTP_LOCAL_PORT_V,
												SIPUA_GetRemoteIP(),
												SIPUA_GetRemotePortV(),
												VIDEO_PT_CODEC_H264,
												0,
												window_id);
        callData.streamStatus = STREAM_STATUS_V_STARTED;
    
        if (callData.videoStream == NULL) {
        	 MED_LOGE("callData.videoStream == null %ld",window_id);
            return -1;
        }
        
        MED_LOGI("videoStream is succeeded!");
        
    }else if(bStartVideo){
       MED_LOGE("videoStream ERR!! %ld  %p Status %d",window_id,callData.videoStream,callData.streamStatus);
    }
    
    //sip_audio_stream_start 会阻塞，所以要Cm_GetCallStatus判断
    if(bStartAudio
           && (callData.audioStream == NULL)
           && (callData.streamStatus != STREAM_STATUS_A_STARTING)){
        
    	if(SIPUA_GetRemotePortA() <= 0){
			MED_LOGE("audioStream ERR!! %d",SIPUA_GetRemotePortA());
			return -1;
		}
        callData.streamStatus = STREAM_STATUS_A_STARTING;
            
        callData.audioStream = sip_audio_stream_start(RTP_LOCAL_PORT_A,
        												SIPUA_GetRemoteIP(),
														SIPUA_GetRemotePortA(),
            											RTP_PT_CODEC_PCMU,
            											CONFIG_PKT_JIB_A);
        callData.streamStatus = STREAM_STATUS_A_STARTED;
      
        if (callData.audioStream == NULL) {
            MED_LOGE("callData.audioStream == null");
            return -1;
        }
        
        if(isFirstCallStart){
            //android界面在全屏切换时就不需要设置音量了，所以只在第一次打开视频界面时才需要设置默认音量
            isFirstCallStart = false;
            Cm_SetSpkVol(callData.spkVol);
            Cm_SetMicVol(callData.micVol);
        }
        
        MED_LOGI("audioStream is succeeded!");
        
    }else if(bStartAudio){
        MED_LOGE("audioStream ERR!! %p Status %d",callData.audioStream,callData.streamStatus);
    }

    return 0;

}


static void Cm_SendDtmf(char dtmf){

	if(callData.audioStream){
		MED_LOGI("Cm_SendDtmf %c\n",dtmf);
		audio_stream_send_dtmf(callData.audioStream,dtmf,DTMF_TYPE_RFC2833);
	}
}

static int Cm_OpenStream(bool bStartAudio, bool bStartVideo){

    if(Cm_StreamStart(bStartAudio,bStartVideo,Cm_GetVideoWindow()) < 0){
        MED_LOGW("Cm_OpenStream err!!");
        return -1;
    }

    return 0;
}
bool Cm_OpenVideo(unsigned long obj){

    if(Cm_GetCallStatus() < CALL_STATUS_ALERTING ){
        MED_LOGE("Cm_OpenVideo err!!");
        return false;
    }

    Cm_SetVideoWindow(obj);

#if ANDROID
	//设置CLASS
	ms_set_class(&gJclAndroidVideoWindowImpl);

	ms_set_audio_class(&gJclAudio);
#endif

    //打开视频流
    Cm_OpenStream(false,true);


    return true;
}


static bool Cm_CallInit(int mode,const char *callId,int networkType){

	if(Cm_GetCallStatus() != CALL_STATUS_IDLE )
	{
		MED_LOGE("Cm_CallInit(%d) err!!",Cm_GetCallStatus());
		return false;
	}

	memset(&callData,0,sizeof(callData));
	isFirstCallStart = true;
	callData.sessionMode = mode;
	callData.networkType = networkType;
    callData.spkVol = saveSpkVol;
	
	if(mode == SESSION_MODE_MONITOR) {
        callData.micVol = MIC_VOL_MUTE;
    } else {
        callData.micVol = saveMicVol;
    }


	strcpy(callData.callId,callId);

	Cm_SetCallStatus(CALL_STATUS_INVITE);

	SIPUA_GetLocalIp();

	MED_LOGI("Cm_CallInit callId %s mode %d networkType:%d micVol:%f",callId,mode,networkType,micVol);

	return true;
}


bool Cm_CallWaitingAccept(void){

	if(Cm_GetCallStatus() != CALL_STATUS_ALERTING){
		MED_LOGE("Cm_CallWaitingAccept(%d) err!!",Cm_GetCallStatus());
		return false;
	}

	cmTimer.callAnswer = CALL_ANSWER_TIME;

	return true;
}

void Cm_CallWaitingReject(void){

	//Cm_CallRelease(-1);
}

bool Cm_CallAlert(void){

	if(Cm_GetCallStatus() != CALL_STATUS_INVITE){
		MED_LOGI("Cm_CallAlert err!!");
		return false;
	}

	Cm_SetCallStatus(CALL_STATUS_ALERTING);

	//关闭定时器
	cmTimer.lanQueryDevice = 0;
	cmTimer.wanOutgoingCall = 0;
	//保存网络配置
	Cm_SaveNwCfg(callData.srcUrl,callData.destUrl,callData.callId,callData.networkType);


	//复位GUI播放窗口ID
	Cm_SetVideoWindow(0);

    //监视模式下传递状态到上层
    if(callData.sessionMode ==SESSION_MODE_MONITOR){
        Cm_SendEventNotification(EVENT_CALL_RINGING, NULL,0);
    }

	return true;
}


bool Cm_CallConnect(void){

	if(Cm_GetCallStatus() != CALL_STATUS_ALERTING){
		MED_LOGE("Cm_CallConnect err!!");
		return false;
	}

	Cm_SetCallStatus(CALL_STATUS_CONNECTED);

	//打开音频流
	Cm_OpenStream(true,false);

	//传递状态到上层
	if(callData.sessionMode ==SESSION_MODE_MONITOR)
		Cm_SendEventNotification(EVENT_CALL_ANSWER, NULL,0);
	else{
		char statusCode[10]={0};
		sprintf(statusCode,"%d",200);
		Cm_SendEventNotification(EVENT_CALL_STATUS, statusCode,strlen(statusCode));
	}

	//收到ACK，将定时器清零
	cmTimer.callAck = 0;

	//开启audio数据包接收检查
	cmTimer.audioStreamAlive = AUDIO_STEAM_ALIVE;
	return true;
}


int Cm_CallRelease(int msg) {

	MED_LOGI("Cm_CallRelease");

	if(Cm_GetCallStatus() < CALL_STATUS_INVITE){
		MED_LOGW("Cm_CallRelease err!!");
		memset(&callData,0,sizeof(callData));
		return EXIT_FAILURE;
	}

    if(Cm_GetCallStatus() == CALL_STATUS_TERMINATING
       || Cm_GetCallStatus() == CALL_STATUS_TERMINATED){

        MED_LOGW("Cm_CallRelease err!!");
        return EXIT_FAILURE;
    }

	Cm_SetCallStatus(CALL_STATUS_TERMINATED);
    
    //关闭audio数据包接收检查
    cmTimer.audioStreamAlive = 0;
    
	/*
	 * 传递状态到上层
	 */
	if(msg > 0){
		Cm_SendEventNotification(msg, NULL,0);
	}else{
		SIPUA_DoReleaseAll();
	}

	Cm_StreamStop();

	/*清除保存的 网络配置*/
	if(Cm_GetCallStatus() < CALL_STATUS_ALERTING){

		MED_LOGI("clean nwCfg");
		memset(&nwCfg,0,sizeof(nwCfg));
	}else{
		/* 定时器:30S后清除所有数据 */
		cmTimer.netDataExpires = NWTYPE_DURATION_TIME;
	}

	//清除通话数据
	memset(&callData,0,sizeof(callData));

	check_malloc();

	return EXIT_SUCCESS;
}

    
void Cm_CallStop(void){
     Cm_CallRelease(-1);
}
    
int Cm_OutgoingCall(const char *callId,int networkType){
	int result = EXIT_FAILURE;

	//check_malloc();
	//return result;

	/* 进行错误判断 */
	if(callId == NULL || USER_NAME_MAX_LEN <= strlen(callId)){
		MED_LOGE("Cm_OutgoingCall  callId ERR!!");
		return result;
	}


	if(networkType != NETWORK_TYPE_QUERY){
		callData.networkType = networkType;
	}else if(Cm_CallInit(SESSION_MODE_MONITOR,callId,networkType) == false){
		MED_LOGE("OutgoingCall ERR!!");
		return result;
	}


	MED_LOGI("OutgoingCall callId:%s(%s) nwType:%d available:%d nwName:%s",
			callId,nwCfg.sUrl.callId,callData.networkType,nwCfg.available,nwData.nwName);

	//如果是mobile网络直接发起外网呼叫
	//或者是只使用外网服务器时直接发起外网呼叫
	if(strcmp(nwData.nwName,NETWORK_NAME_MOBILE) == 0
			|| Cm_GetTestOnlyServer()){
		callData.networkType = NETWORK_TYPE_WAN;
	}

	//没有保存网络或者是call id不同则要重新查询
	if((callData.networkType == NETWORK_TYPE_QUERY)
			&&((nwCfg.available == 0) || (strcmp(nwCfg.sUrl.callId, callId) != 0))){

		memset(&nwCfg,0,sizeof(nwCfg));
        
#if CONFIG_MULTICAST_ENABLE && ANDROID
		//只有wifi网络才做局域网查询
		if(strcmp(nwData.nwName,NETWORK_NAME_WIFI) == 0){
			//lan 查询设备
			Cmulticast_DoQuery(callId);
			//打开查询定时器
			cmTimer.lanQueryDevice = LAN_QUERY_DEVICE_TIME;
		}
#endif
		//1s后wan 查询设备
		if(SIPUA_GetRegisterStatus()){

			cmTimer.wanOutgoingCall = WAN_OUTGOING_CALL_TIME;
		}

		return EXIT_SUCCESS;
	}


	/* 呼叫同一个设备且保存的网络是有效的时候,直接发送消息 */
	if(callData.networkType == NETWORK_TYPE_QUERY
			&& (nwCfg.available == 1)
			&& (strcmp(nwCfg.sUrl.callId, callId) == 0) ){

		MED_LOGI("save2:callId %s, srcUrl %s, destUrl %s", nwCfg.sUrl.callId,nwCfg.sUrl.srcUrl,nwCfg.sUrl.destUrl);

		//使用保存的Url
		strcpy(callData.srcUrl, nwCfg.sUrl.srcUrl);
		strcpy(callData.destUrl, nwCfg.sUrl.destUrl);

	}else if(callData.networkType == NETWORK_TYPE_LAN){

		//关闭定时器
		cmTimer.lanQueryDevice = 0;
		cmTimer.wanOutgoingCall = 0;

		sprintf(callData.srcUrl, "sip:%s@%s", sipCfg.sipUserName, Cm_GetLocalIp());
		strcpy(callData.destUrl,callData.mulUrl);

	}else if(callData.networkType == NETWORK_TYPE_WAN){

		sprintf(callData.srcUrl, "sip:%s@%s", sipCfg.sipUserName, sipCfg.sipProxy);
		sprintf(callData.destUrl, "sip:%s@%s", callId, sipCfg.sipProxy);

	}else{

		SIP_LOGE("Cm_OutgoingCall err!!");
		return false;
	}

	SIPUA_DoInvite(callData.srcUrl,callData.destUrl);

	return EXIT_SUCCESS;
}


static bool Cm_IncomingCallSaveUrl(){

	MED_LOGI("Cm_IncomingCallSaveUrl()");

	//保存Url
	if(callData.networkType == NETWORK_TYPE_LAN){

		sprintf(callData.srcUrl, "sip:%s@%s", sipCfg.sipUserName, Cm_GetLocalIp());
		sprintf(callData.destUrl, "sip:%s@%s", callData.callId, callData.host);

	}else if(callData.networkType == NETWORK_TYPE_WAN){

		sprintf(callData.srcUrl, "sip:%s@%s", sipCfg.sipUserName, sipCfg.sipProxy);
		sprintf(callData.destUrl, "sip:%s@%s", callData.callId, sipCfg.sipProxy);
	}

	return true;
}

int Cm_IncomingCall(char *devId,char *host,char *port){

	int networkType;

	if(devId == NULL || host == NULL){

		MED_LOGE("devId,host == NULL");
		return SIP_603_DECLINE;
	}

	//检查并设置网络类型
	networkType = NETWORK_TYPE_LAN;
	if ((strlen(sipCfg.sipProxy) > 1) && (strlen(host) > 1)) {

		char dProxy[URL_MAX_LEN] = { 0 };

		strncpy(dProxy, sipCfg.sipProxy, strlen(host));

		if (strcmp(dProxy, host) == 0) {
			networkType = NETWORK_TYPE_WAN;
		}
	}

	if(!Cm_CallInit(SESSION_MODE_INCOMING_CALL,devId,networkType)){

		MED_LOGE("Cm_CallInit err!!");
		return SIP_486_BUSY_HERE;
	}

	if((port != NULL) && strlen(port) > 1)
		sprintf(callData.host, "%s:%s", host, port);
	else
		strcpy(callData.host,host);

	Cm_IncomingCallSaveUrl();

	//发送消息到GUI层检查devId的有效性
	Cm_SendEventNotification(EVENT_CALL_INVITE, devId,(int)strlen(devId));

#if ANDROID
	//如果CallStatus没有改变为ALERTING，说明来电的devId不在设备列表中，回复消息603(丢弃,不想应答)
	if(Cm_GetCallStatus() != CALL_STATUS_ALERTING){

		MED_LOGW("Cm_IncomingCall err!!");
		memset(&callData,0,sizeof(callData));
		return SIP_603_DECLINE;
	}
#else
    Cm_CallAlert();
#endif
	//关闭定时器
	cmTimer.lanQueryDevice = 0;
	cmTimer.netDataExpires = 0;
	cmTimer.wanOutgoingCall = 0;

	return SIP_200_OK;
}


void Cm_RegisterUser(void){
	if(sysCfg.running && sysCfg.takcfg){
		MED_LOGI("Cm_RegisterUser() ");

		SIPUA_Register(&sipCfg,SIP_REG_EXPIRES_DEFAULT);

	}else{

		MED_LOGW("Cm_RegisterUser(running %d takcfg %d) err",sysCfg.running,sysCfg.takcfg);
	}
}

void Cm_UnRegisterUser(void){
	MED_LOGI("Cm_UnRegisterUser() ");
	SIPUA_UnRegister();
}

static void Cm_TimerHandler(int signum){

#if CONFIG_MULTICAST_ENABLE && ANDROID
	if(cmTimer.lanQueryDevice){

		char callId[USER_NAME_MAX_LEN]={0};

		cmTimer.lanQueryDevice--;

		MED_LOGI("cmTimer.lanQueryDevice %d",cmTimer.lanQueryDevice);

		if(imsgData.status == SENDIMSG_STATUS_QUERY){
			strcpy(callId,imsgData.callId);
		}else{
			strcpy(callId,callData.callId);
		}

		Cmulticast_DoQuery(callId);
	}
#endif

	if(cmTimer.wanOutgoingCall && !(--cmTimer.wanOutgoingCall)){

		MED_LOGI("cmTimer.wanOutgoingCall %d",cmTimer.wanOutgoingCall);

		Cm_OutgoingCall(callData.callId,NETWORK_TYPE_WAN);
	}

	if(cmTimer.netDataExpires && !(--cmTimer.netDataExpires)){

		MED_LOGI("cmTimer.netDataExpires %d",cmTimer.netDataExpires);

		memset(&nwCfg,0,sizeof(nwCfg));
		memset(&imsgData,0,sizeof(imsgData));
	}

	if(cmTimer.callAnswer && !(--cmTimer.callAnswer)){
		SIPUA_DoCallAnswer();
		cmTimer.callAck = CALL_ACK_TIME;
	}

	if(cmTimer.callAck && !(--cmTimer.callAck)){
		MED_LOGE("err:cmTimer.callAck timeout");
		SIPUA_DoReleaseAll();
		Cm_CallRelease(EVENT_CALL_CLOSED);
	}

	if(cmTimer.audioStreamAlive && !(--cmTimer.audioStreamAlive)){

        if(callData.callStatus != CALL_STATUS_CONNECTED){
            
            MED_LOGW("CallStatus err!! %d",Cm_GetCallStatus());
            return ;
        }
        
        cmTimer.audioStreamAlive = AUDIO_STEAM_ALIVE;

		if((callData.audioStream != NULL) &&
			(sip_audio_stream_alive(callData.audioStream) == FALSE)){

			MED_LOGE("err:cmTimer.audioStreamAlive timeout");
			SIPUA_DoReleaseAll();
			Cm_CallRelease(EVENT_CALL_CLOSED);
		}
	}

}

static void Cm_SetTimer(void){

	struct itimerval tick;

	signal(SIGALRM, Cm_TimerHandler);

	//本次的设定值
	tick.it_value.tv_sec	 = 0;
	tick.it_value.tv_usec	 = TIMER_TICK * 1000;
	//下一次的取值
	tick.it_interval.tv_sec	 = 0;
	tick.it_interval.tv_usec = TIMER_TICK * 1000;

	setitimer(ITIMER_REAL,&tick,NULL);
}


void Cm_destoryTimer(void){

	struct itimerval tick;

	memset(&tick, 0, sizeof(tick));
	setitimer(ITIMER_REAL,&tick,NULL);
}


//SIPUA的回调函数
int Cm_RecvSipuaEvent(int event, void *body){

	MED_LOGI("Cm_RecvSipuaEvent %d",event);

	switch (event){
	case SIPUA_CALL_INVITE:
		if(body != NULL){

			SipCfg *cfg = (SipCfg *)body;
			return Cm_IncomingCall(cfg->sipUserName,cfg->sipProxy,cfg->sipPort);
		}
		break;
	case SIPUA_CALL_RINGING:
		Cm_CallAlert();
		break;
	case SIPUA_CALL_ANSWERED:
        Cm_CallAlert();
        Cm_CallConnect();
        break;
	case SIPUA_CALL_ACK:
		Cm_CallConnect();
		break;
	case SIPUA_CALL_RELEASED:
		Cm_CallRelease(EVENT_CALL_CLOSED);
		break;
	case SIPUA_MESSAGE_ANSWERED:
	case SIPUA_MESSAGE_NEW:
		if(body != NULL){
			SipMsg *msg = (SipMsg *)body;
			Cm_SendEventNotification(EVENT_INSTANT_MSG,msg->body,strlen(msg->body));
		}
		break;
	case SIPUA_REGISTRATION_FAILURE:
		{
			char regResult[2]={0};
			sprintf(regResult,"%d",1);
			Cm_SendEventNotification(EVENT_REGISTRATION, regResult,sizeof(regResult));
		}
		break;
	case SIPUA_REGISTRATION_SUCCESS:
		{
			char regResult[2]={0};
			sprintf(regResult,"%d",0);
			Cm_SendEventNotification(EVENT_REGISTRATION, regResult,sizeof(regResult));
		}
		break;
	case SIPUA_CALL_REQUESTFAILURE:
		if(body != NULL){
			char *statusCode = (char*)body;
			Cm_SendEventNotification(EVENT_CALL_STATUS, statusCode,strlen(statusCode));
		}
		Cm_CallRelease(EVENT_CALL_CLOSED);
		break;
	default:break;
	}

	return -1;
}

static void Cm_SetSipTalk(void){
	SipTalk sipTalk;

	memset(&sipTalk,0,sizeof(SipTalk));

	sipTalk.regExpires = SIP_REG_EXPIRES_DEFAULT;
	sipTalk.optRemain = (SIP_OPT_EXPIRES_DEFAULT*1000);
	sipTalk.sendEvent = Cm_RecvSipuaEvent;
	sipTalk.localPortA = RTP_LOCAL_PORT_A;
	sipTalk.localPortV = RTP_LOCAL_PORT_V;

	SIPUA_Create(&sipTalk);
	SIPUA_GetLocalIp4eXosip(nwData.localip);
	SIPUA_SetLocalIp(nwData.localip);
}

static void *Cm_RunSip(void * arg){
	while (sysCfg.running){
		SIPUA_Listeners(arg);
	}

#if ANDROID
    jni_manager_CleanThreadEnv();
#elif TARGET_OS_IPHONE
    return NULL;
#endif
}

static void *Cm_RunMul(void * arg){

	Cmulticast_Init();

	while (sysCfg.running){
		Cmulticast_Listeners(arg);
	}

#if ANDROID
    jni_manager_CleanThreadEnv();
#elif TARGET_OS_IPHONE
    return NULL;
#endif
}

#pragma mark - MS2模块对码消息发送
static void *Cm_RunMatchCode(void * arg){

	if (sysCfg.running){

		CdevMatchCode_Listeners(arg);
	}

#if ANDROID
	jni_manager_CleanThreadEnv();
#elif TARGET_OS_IPHONE
    return NULL;
#endif
}

void Cm_MatchMsgSend(const char *body){

	//初始化
	CdevMatchCode_Init();

	//创建监听线程
	pthread_t id;
	if (pthread_create(&id, NULL,Cm_RunMatchCode, NULL) != 0) {
        MED_LOGE("Create Cm_RunMatchCode error!\n");
	}

	//发送对码消息
	CdevMatchCode_SendMsg(body);
}

void Cm_Unlock(void){

	char dtmf = '*';
	Cm_SendDtmf(dtmf);
}


void Cm_Init(void){

	MED_LOGI("Cm_Init()");

	memset(&callData,0,sizeof(callData));
	memset(&nwCfg,0,sizeof(nwCfg));
	memset(&imsgData,0,sizeof(imsgData));
	memset(&cmTimer,0,sizeof(cmTimer));

	Cm_SetTimer();
#if TARGET_OS_IPHONE
    ms2_set_log_level(SET_LOG_OUT);
#endif
	ortp_init();	//初始化ortp库
	ms_init();		//初始化mediastream2库

	sysCfg.running = true;

#if CONFIG_MULTICAST_ENABLE && ANDROID
	pthread_t id1;
	if (pthread_create(&id1, NULL,Cm_RunMul, NULL) != 0) {
		MED_LOGE("Create Cm_RunMul error!\n");
	}
#endif

#if CONFIG_SIP_ENABLE

	Cm_SetSipTalk();

	pthread_t id2;
	if (pthread_create(&id2, NULL,Cm_RunSip, NULL) != 0) {
		MED_LOGE("Create Cm_RunSip error!\n");
	}
#endif

}


void Cm_Exit(void){
    
    MED_LOGI("Cm_Exit()");

    sysCfg.running = false;
    
    memset(&sysCfg,0,sizeof(sysCfg));
    
    Cm_destoryTimer();
    
    ortp_exit();
    
    SIPUA_Destroy();

    Cmulticast_Exit();

    ms_exit();

}

#endif//CONFIG_SIP_ENABLE

#ifdef __cplusplus
}
#endif

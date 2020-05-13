/*******************************************************************
*
*    DESCRIPTION:Copyright(c) Xiamen Dnake electronic technology co., LTD
*
*    AUTHOR:DGW
*
*    HISTORY:
*
*    DATE:2017-03-16
*
*******************************************************************/
#ifndef MS2COMMON_H_
#define MS2COMMON_H_


#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

#if ANDROID
#include "JniLog.h"
#endif
/************************************************************************/
/*                                                                      */
/************************************************************************/

/************************************************************************/
/* 	宏定义																*/
/************************************************************************/
#pragma mark - 宏定义
#define CONFIG_P2P_PPT_ENABLE  		0
#define CONFIG_MULTICAST_ENABLE  	1
#define CONFIG_SIP_ENABLE			1
#define CONFIG_TUTK_ENABLE			0


#define RESPONSE_XML_TEMP	("<?xml version=\"1.0\" encoding=\"utf-8\"?><root cmd=\"\"></root>")
#define CONFIG_XML_TEMP		("<?xml version=\"1.0\" encoding=\"utf-8\"?><root><addr building=\"1\" unit=\"1\" addr_idx=\"1\" dev_addr==\"111\" /></root>")
#define CONFIG_FILE			("/sdcard/dnake/config.xml")


/* 检查接收包的头和尾*/
#define XML_PARSE_HEAD_MAX_LEN		20
#define XML_PARSE_HEAD				"<params>"
#define XML_PARSE_TAIL				"</params>"


//APP与设备端的会话管理
#define SESSION_MODE_NULL			0
#define SESSION_MODE_INCOMING_CALL	1
#define SESSION_MODE_MONITOR		2
#define SESSION_MODE_QUERY			3

#define NETWORK_TYPE_NON 		(0)
#define NETWORK_TYPE_LAN 		(1)
#define NETWORK_TYPE_WAN 		(2)
#define NETWORK_TYPE_QUERY 		(3)


//状态消息
#define  MSG_201_CALL_ANSWER				201	//摘机成功
#define  MSG_400_BAD_REQUEST				400	//请求失败
#define  MSG_401_UNAUTHORIZED				401	//没有权限
#define  MSG_404_NOT_FOUND					404	//未找到设备
#define  MSG_408_REQUEST_TIMEOUT			408	//设备呼叫已过期
#define  MSG_486_BUSY_HERE					486	//当前设备正忙...
#define  MSG_606_NOT_ACCEPTABLE				606	//来电已被接听
#define  MSG_700_NETWORK_POOR				700	//网络差，通话结束

#if TARGET_OS_IPHONE
//设置log输出等级
#define  SET_LOG_OUT                LOG_LEVEL_INFO
#endif

/************************************************************************/
/*   事件                                                                                                                                                                                                  */
/************************************************************************/
#pragma mark - 事件
#define EVENT_CALL_ANSWER					(0x21) //对方摘机应答
#define EVENT_CALL_RINGING					(0x22) //对方响铃
#define EVENT_CALL_CLOSED					(0x23) //呼叫关闭
#define EVENT_REGISTRATION					(0x24) //注册成功
#define EVENT_REGISTRATION_FAILURE			(0x25) //注册失败
#define EVENT_CALL_ACK						(0x26) //ACK
#define EVENT_CALL_CANCELLED 				(0x27) //呼叫取消
#define EVENT_CALL_INVITE					(0x28) //收到呼叫邀请
#define EVENT_MESSAGE_NEW 					(0x29) //有新消息
#define EVENT_CALL_RELEASED 				(0x2A) //呼叫释放
#define EVENT_CALL_SERVERFAILURE			(0x2B) //呼叫服务失败
#define EVENT_CALL_PROCEEDING				(0x2C) //呼叫过程
#define EVENT_CALL_PICKED					(0x2D) //上层通知摘机
#define EVENT_CALL_UNLOCK					(0x2E) //开锁
#define EVENT_CALL_STATUS					(0x2F) //状态码
#define EVENT_INSTANT_MSG					(0x30) //即时消息

#if TARGET_OS_IPHONE
/************************************************************************/
/*  MSG:                                                                */
/************************************************************************/
#define K_EVENT_URL				("/params/event_url")
#define K_TYPE					("/params/type")
#define K_RESULT				("/params/result")
#define K_APP_ID				("/params/user_id")
#define K_DEV_ID				("/params/device_id")
#define K_DEV_PWD				("/params/device_psw")
#define K_DEV_PWD2				("/params/passwd")
#define K_DEV_ADMIN				("/params/admin_id")

#define V_TYPE_REQ				("req")
#define V_TYPE_ACK				("ack")
#define V_RESULT_SUCCESS		("0")
#define V_RESULT_LIMIT			("-1")


//对码添加设备
#define DEV_SSID_EVER			("Linkhome")
#define WIFI_SSID_EVER			("\"Linkhome\"")
#define DEV_SSID				("unlimited")

#define K_MATCH_SSID			("/params/ssid")
#define K_MATCH_SSID_PWD		("/params/ssid_pwd")
#define K_MATCH_AUTHMODE		("/params/authmode")
#define K_MATCH_ENCRYPT_TYPE	("/params/encrypt_type")
#define K_MATCH_DEV_SIP_PWD		("/params/sip_psw")
#define K_MATCH_SIP_SERVER		("/params/sip_server")

#define V_URL_MATCH_SET			("/wifi/match/set")

//添加设备类型
#define DEV_TYPE_DOORBELL		("doorbell")
#define DEV_TYPE_SIP			("sip")
#define DEV_TYPE_PHONE			("phone")
#define DEV_TYPE_OTHER			("other")

//APP端获取设备信息
#define K_DEV_MODEL				("/params/device_model")
#define K_DEV_IP				("/params/device_ip")
#define K_DEV_MAC				("/params/device_mac")
#define K_DEV_SSID				("/params/device_ssid")
#define K_DEV_INTENSITY			("/params/intensity")
#define K_DEV_VERSION			("/params/device_version")
#define K_DEV_PROXY				("/params/exsip_proxy")

#define V_DEV_REGISTER_FAIL		("0") //0注册失败  1注册成功
#define V_DEV_REGISTER_SUC		("1")

#define V_URL_GET_DEV_INFO		("/wifi/info/get")


//APP端管理员修改管理密码
#define K_ADMIN_ID				("/params/admin_id")
#define K_ADMIN_PWD				("/params/passwd")
#define K_NEW_PWD				("/params/newpasswd")

#define V_URL_CHANGE_PWD		("/wifi/admin_pwd")

//APP端管理员查看SIP信息
#define K_SIP_SERV              ("/params/sip_server")
#define K_SIP_PSW               ("/params/sip_psw")
#define V_URL_GET_SIP_INFO      ("/wifi/exsip/get")

//APP端管理员修改SIP信息
#define K_SET_SIP_SERV          ("/params/sip_server")
#define K_SET_SIP_PSW           ("/params/sip_psw")
#define K_SET_NEW_ID            ("/params/device_id_new")
#define K_SET_DEV_PSW			("/params/passwd")
#define V_URL_SET_SIP_INFO      ("/wifi/exsip/set")

//APP端管理员修改wifi配置
#define K_SET_WIFI_HOT			("/params/ssid")
#define K_SET_WIFI_PSW			("/params/ssid_pwd")
#define K_SET_WIFI_SEC			("/params/authmode")
#define K_SET_WIFI_ENC			("/params/encrypt_type")

#define V_URL_SET_WIFI			("/wifi/router/set")


//APP端管理员查看开锁时间
#define K_GET_LOCK_TIME				("/params/unlock_ti")
#define K_CALL_LIMIT				("/params/called_limit")
#define K_VIDEO_SET					("/params/bitrate")

#define V_URL_GET_LOCK_TIME			("/wifi/misc/get")

//APP端管理员修改开锁时间
#define K_SET_LOCK_TIME				("/params/unlock_ti")
#define K_SET_LOCK_DEV_PSW			("/params/passwd")

#define V_URL_SET_LOCK_TIME			("/wifi/misc/set")


//APP端管理员添加已联网的设备---通过id与密码添加
#define K_USER_TYPE				("/params/utype")
#define K_USER_ID				("/params/user_id")

#define V_URL_ADD_USER			("/wifi/user/add")

//APP端管理员删除用户
#define V_URL_DEL_USER			("/wifi/user/del")

//APP端获取用户信息
#define K_USER_INFO				("/params/user_")
#define K_USER_NUM				("/params/user_number")
#define V_URL_GET_USER_INFO		("/wifi/user/get")
#define V_USER_TYPE_NORM			("0")
#define V_USER_TYPE_ADMIN			("1")

//开锁
#define K_EVENT						("/params/event")
//#define K_UNLOCK_EVENT				("/params/event")
//#define K_UNLOCK_APP				("/params/app")
//#define K_UNLOCK_HOST				("/params/host")
//#define K_UNLOCK_FLOOR				("/params/floor")
//#define K_UNLOCK_FAMILY				("/params/family")
//
//#define V_URL_UNLOCK				("/talk/unlock")
//#define V_UNLOCK_EVENT				("unlock")
//#define V_UNLOCK_APP				("talk")
//#define V_UNLOCK_FLOOR				("1")
//#define V_UNLOCK_FAMILY				("1")

//防拆报警
#define K_TICK						("/params/tick")

#define V_URL_DEV_ALARM				("/wifi/device_alarm")

//开关视频
#define K_SET_DEV_VIDEO_ONOFF		("/params/onoff")

#define V_URL_SET_DEV_VIDEO			("/wifi/video/set")

//通话中开锁
#define K_UNLOCK_DATA               ("/params/data")
#define V_URL2_UNLOCK               ("/ui/v170/unlock")
#define V_URL_UNLOCK                ("/talk/unlock")

#define	V_URL_CALL_STATUS_START 			("/wifi/callStart")
#define	V_URL_CALL_STATUS_ANSWER 			("/wifi/callAnswer")
#define	V_URL_CALL_STATUS_STOP 				("/wifi/callStop")


#define	K_TALK_TYPE							("/params/talk_type")
#define K_EVENT_TIME                        ("/params/event_time")


//版本升级
#define	K_VERSION_UPDATE_LATESTVERSION      ("/params/latestVersion")
#define	K_VERSION_UPDATE_ISFORCE            ("/params/isForce")
#define	K_VERSION_UPDATE_DOWNLOADURL        ("/params/downloadUrl")
#define	K_VERSION_UPDATE_MD5                ("/params/md5")

#define	V_URL_VERSION_UPDATE                ("/wifi/versionUpdate")
#endif //#if TARGET_OS_IPHONE


/************************************************************************/
/*  MSG: UI2JNI                                                         */
/************************************************************************/
#define URL_UI2JNI_ONHOOK					("/talk/onhook")
#define URL_UI2JNI_OFFHOOK					("/talk/offhook")
#define URL_UI2JNI_SET_CFG					("/talk/setcfg")
#define URL_UI2JNI_UNREGISTER_USER			("/talk/unregister_user")
#define URL_UI2JNI_MONITOR					("/talk/monitor")
#define URL_UI2JNI_INCOMING_CALL			("/talk/incomingcall")
#define URL_UI2JNI_MUTE_MIC					("/talk/mute/mic")
#define URL_UI2JNI_MUTE_SPK					("/talk/mute/spk")
#define URL_UI2JNI_LOADIP					("/talk/loadip")
#define URL_UI2JNI_MATCH_CODE				("/talk/matchCode")
#define URL_UI2JNI_UNLOCK					("/talk/unlock")
#define URL_UI2JNI_SNAPSHOT					("/talk/snapshot")
#define URL_UI2JNI_ONLY_SEVER				("/talk/only_sever")
#define URL_UI2JNI_LAN_SEARCH				("/talk/lan_serach")
#define URL_UI2JNI_KEEPLIVE					("/talk/keeplive")


//parm
#define PARM_UI2JNI_ID						("/params/id")
#define PARM_UI2JNI_DEV_PWD					("/params/devpwd")
#define PARM_UI2JNI_MUTE					("/params/mute")
#define PARM_UI2JNI_LOAD_IP					("/params/loadip")
#define PARM_UI2JNI_BROADCAST_IP			("/params/broadcastip")
#define PARM_UI2JNI_NETWORK_NAME 			("/params/nwname")
#define PARM_UI2JNI_SNAPSHOT_NAME			("/params/sname")
#define PARM_UI2JNI_ONLY_SEVER				("/params/onlysever")
#define PARM_UI2JNI_SN						("/params/sn")
#define PARM_UI2JNI_EVENT_TIME				("/params/eventTime")

/************************************************************************/
/*  MSG: JNI2UI                                                         */
/************************************************************************/
#define URL_JNI2UI_CALL_INVITE				("/ui/talk/start")
#define URL_JNI2UI_CALL_CLOSED				("/ui/talk/stop")
#define URL_JNI2UI_CALL_RINGING				("/ui/talk/ringing")
#define URL_JNI2UI_CALL_CONNECTED			("/ui/talk/connected")
#define URL_JNI2UI_REGISTRATION				("/ui/talk/register")
#define URL_JNI2UI_STATUS_CODE				("/ui/talk/statusCode")
#define URL_JNI2UI_IMSG						("/ui/sip/imsg")

//parm
#define PARM_JNI2UI_RESULT					("/params/result")



#define	V_URL_LAN_SEARCH_DEV 				("/wifi/lanSearch/dev")


#define	V_URL_CALL_STATUS_START 			("/wifi/callStart")
#define	V_URL_CALL_STATUS_ANSWER 			("/wifi/callAnswer")
#define	V_URL_CALL_STATUS_STOP 				("/wifi/callStop")
/************************************************************************/
/*  其它定义																*/
/************************************************************************/
#define REGIST_SUCCESS 			(0)
#define REGIST_FAILED 			(1)

#define REGIST_SUCCESS_STR 		("0")
#define REGIST_FAILED_STR 		("1")

#if ANDROID
#define JAVA_CLASS_AUDIO				"com/dnake/evertalk/talk/audio"
#define J_CLASS_NAME_DMSG_SEND_RECV		"com/dnake/evertalk/communication/RecvMsg4Jni"
#define J_CLASS_NAME_VIDEO_WINDOW		"org/linphone/mediastream/video/AndroidVideoWindowImpl"
#endif

#if TARGET_OS_IPHONE
/************************************************************************/
/*  IOS API                                                             */
/************************************************************************/
#pragma mark - 底层音视频模块 pubilc函数
//模块初始化与退出
void Cm_Init(void);
void Cm_Exit(void);

//通话相关模块
void Cm_CallStop(void);
int Cm_OutgoingCall(const char *callId,int networkType);

bool Cm_OpenVideo(unsigned long obj);
bool Cm_CallWaitingAccept(void);
//通话中开锁
void Cm_Unlock(void);
//发送SIP消息到设备
int Cm_InstantMsgSend(const char *callId,int networkType,const char *body);

//参数设置
void Cm_SetVideoWindow(unsigned long obj);
void Cm_SetNetWData(const char *loadIp,const char *broadcastIp,const char *nwName);

void Cm_SetAppMicMute(const char * mute);
void Cm_SetAppSpkMute(const char * mute);

void Cm_videoSnapshot(const char *fileName);
//设置服务器IP 及 app 帐号及密码
void Cm_SetSipCfg(const char *sipProxy,const char *sipUserName,const char *sipPasswd);

//发送对码消息
void Cm_MatchMsgSend(const char *body);
//通话中开关视频
void sendSetDevVideo(const char *onOff);
//注销用户，使所有SIP用户无法呼入
void Cm_UnRegisterUser(void);

/*
 * APP发送即时消息
 */
// 对码添加设备
void sendImsgMatchAddDev(const char* ssid ,const char* ssidPwd ,const char* authmode,  const char*  encryptType,const char* user_id,const char* dev_id,const char*sip_psw,const char*sip_server);

// 手动添加设备
void sendImsgAddDev(const char* callId);

//查询用户信息
void sendImsgQueryUserInfo(const char *callId);
//添加用户
void sendImsgAddUser(const char *callId,const char * devPwd ,const char * user_id, const char *user_type);
//删除用户
void sendImsgDelUser(const char *callId,const char * devPwd ,const char * user_id);
// 查询设备信息
void sendImsgQueryDevInfo(const char *callId);
// 修改设备密码
void sendImsgChangeDevicePwd(const char *callId,const char * oldPwd ,const char * newPwd);
// 获得开锁时间
void sendImsGetLockTime(const char * callId);
// 设置开锁时间
void sendImsSetLockTime(const char * callId ,const char *devPwd ,const char* callLimit ,const char* bitrate ,const char*unlockTi);
// 配置WIFI
void sendImsSetWifi(const char * callId ,const char *devPwd , const char*wifiHot,const char* wifiPwd);

//查询设备sip帐号
void sendImsgQueryDeviceId(const char *callId);
//修改设备sip帐号
void sendImsgChangeDeviceId(const char *callId,const char * dev_pwd ,const char * dev_new_id,const char * sip_pwd,const char * sip_serv);
//固件版本升级
void sendImsSetVerUpdate(const char * callId ,const char *devPwd , const char*devModel,const char* latestVersion ,const char* isForce ,const char* downLoadUrl,const char* md5);

#endif //#if TARGET_OS_IPHONE
#endif /* COMMON_H_ */

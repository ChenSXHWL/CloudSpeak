//
//  testXml.m
//  EverTalk
//
//  Created by dgw on 16/6/28.
//  Copyright © 2016年 dnake. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "tinyxml/dxml.h"
#import "ms2log.h"
#import "packUnpackImsg.h"

@implementation packImsg

#define XML_SET_VALUE(_ELEM,_CFG)	if((val = p.getText(_ELEM)) != NULL){strcpy(_CFG,val);}

#define XML_GET_VALUE(_ELEM,_CFG)	if((val = p.getText(_ELEM)) != NULL){_CFG = [NSString stringWithUTF8String:val];}


static char imsgBody[640];
//multicast_data_t mul_data = {0};

static const char* log_level_string[]=
{
    "F",
    "E",
    "W",
    "I",
    "D",
    "",
};

void ms2_dbg_log(int log_level,const char* module,const char* fmt,...)
{
    va_list args;
    
    
    if(log_level>LOG_LEVEL)
        return ;
    
    {
        char tmpbuf[256];
        int  len = 0;
        
        va_start(args, fmt);
        len = sprintf(tmpbuf,"%-4s(%s):",module,log_level_string[log_level]);
        
        len += vsnprintf(tmpbuf+len,sizeof(tmpbuf)-len-1,fmt, args);
        
        printf("%s\n",tmpbuf);
        
        fflush(stdout);
        
        /*
         * end & cleanup
         */
        va_end(args);
    }
}


+(void)parseMulMsg:(const char *)body mul_data:(MulticastData *)mul_data{
   
    const char * val = NULL;
    NSString *url= nil;
    NSString *type= nil;
    
    dxml p(body);
    
    XML_GET_VALUE("/event/active",url);
    XML_GET_VALUE("/event/type",type);
    
    if(url == nil || type == nil){
        
        MSG_LOGE("parseImsg K_EVENT_URL or K_TYPE is nil !!");
        return ;
    }
        
    
    
    XML_SET_VALUE("/event/active", mul_data->active);
    XML_SET_VALUE("/event/type",   mul_data->type);
    XML_SET_VALUE("/event/id",	   mul_data->id);
    XML_SET_VALUE("/event/url",    mul_data->url);
    XML_SET_VALUE("/event/broadcast_url", mul_data->br_url);
    XML_SET_VALUE("/event/device_id", mul_data->id);
    XML_SET_VALUE("/event/tick", mul_data->tick);
    
}


+(NSDictionary *)parseImsg:(const char *)body{
    const char * val = NULL;
    NSDictionary *userinfo;
    NSString *url= nil;
    NSString *type= nil;
    
    dxml p(body);
    
    XML_GET_VALUE(K_EVENT_URL,url);
    XML_GET_VALUE(K_TYPE,type);
    
    if(url == nil || type == nil){
        
        MSG_LOGE("parseImsg K_EVENT_URL or K_TYPE is nil !!");
        return nil;
    }
    
    if(![type isEqualToString:@V_TYPE_ACK]){
        
        MSG_LOGE("parseImsg K_TYPE != ack");
        return nil;
    }
    
    
    if([url isEqualToString:@V_URL_MATCH_SET]){
        
        NSString *uid     = nil;
        NSString *pwd     = nil;
        NSString *result  = nil;
        
        XML_GET_VALUE(K_DEV_ID,uid);
//        XML_GET_VALUE(K_DEV_PWD2,pwd);
        XML_GET_VALUE(K_RESULT,result);
        
        
        userinfo = [NSDictionary dictionaryWithObjectsAndKeys:
                    url,@"url",
                    uid,@"uid",
//                    pwd,@"pwd",
                    result,@"result",
                    nil];
        
    }else if([url isEqualToString:@V_URL_GET_DEV_INFO]){
        
        NSString *model     = nil;
        NSString *uid       = nil;
        NSString *ip        = nil;
        NSString *mac       = nil;
        NSString *ssid      = nil;
        NSString *intensity = nil;
        NSString *proxy     = nil;
        NSString *version   = nil;
        NSString *result    = nil;
        
        XML_GET_VALUE(K_DEV_MODEL,model);
        XML_GET_VALUE(K_DEV_ID,uid);
        XML_GET_VALUE(K_DEV_IP,ip);
        XML_GET_VALUE(K_DEV_MAC,mac);
        XML_GET_VALUE(K_DEV_SSID,ssid);
        XML_GET_VALUE(K_DEV_INTENSITY,intensity);
        XML_GET_VALUE(K_DEV_PROXY,proxy);
        XML_GET_VALUE(K_DEV_VERSION,version);
        XML_GET_VALUE(K_RESULT,result);
        
        userinfo = [NSDictionary dictionaryWithObjectsAndKeys:
                    url,@"url",
                    model,@"model",
                    uid,@"uid",
                    ip,@"ip",
                    mac,@"mac",
                    ssid,@"ssid",
                    intensity,@"intensity",
                    proxy,@"proxy",
                    version,@"version",
                    result,@"result",       //0成功,  其它失败
                    nil];
        
    }else if([url isEqualToString:@V_URL_CHANGE_PWD]){
        
        NSString *result = nil;
        
        XML_GET_VALUE(K_RESULT,result);
        
        userinfo = [NSDictionary dictionaryWithObjectsAndKeys:
                    url,@"url",
                    result,@"result",
                    nil];
        
    }else if([url isEqualToString:@V_URL_GET_LOCK_TIME]){
        
        NSString *lockTime  = nil;
        NSString *videoSet  = nil;
        NSString *result    = nil;
        
        XML_GET_VALUE(K_GET_LOCK_TIME,lockTime);
        XML_GET_VALUE(K_VIDEO_SET,videoSet);
        XML_GET_VALUE(K_RESULT,result);
        
        
        userinfo = [NSDictionary dictionaryWithObjectsAndKeys:
                    url,@"url",
                    lockTime,@"lockTime",   //开锁时间
                    videoSet,@"videoSet",   //0流畅(320*240)  1标准(640*480)  2高清
                    result,@"result",       //0成功，其它失败
                    nil];
        
    }else if([url isEqualToString:@V_URL_SET_LOCK_TIME]){
        
        NSString *result = nil;
        
        XML_GET_VALUE(K_RESULT,result);
        
        userinfo = [NSDictionary dictionaryWithObjectsAndKeys:
                    url,@"url",
                    result,@"result",
                    nil];
        
    }else if([url isEqualToString:@V_URL_UNLOCK]){
        
        NSString *result = nil;
        
        XML_GET_VALUE(K_RESULT,result);
        
        userinfo = [NSDictionary dictionaryWithObjectsAndKeys:
                    url,@"url",
                    result,@"result",//0成功，其它失败
                    nil];
        
    }else if([url isEqualToString:@V_URL_SET_WIFI]){
        
        NSString *result = nil;
        
        XML_GET_VALUE(K_RESULT,result);
        
        userinfo = [NSDictionary dictionaryWithObjectsAndKeys:
                    url,@"url",
                    result,@"result",//0成功，其它失败
                    nil];
        
    }else if([url isEqualToString:@V_URL_DEV_ALARM]){
        
        MSG_LOGW("parseImsg V_URL_DEV_ALARM is not use");
        
    }else if([url isEqualToString:@V_URL_SET_DEV_VIDEO]){
        
        NSString *result = nil;
        
        XML_GET_VALUE(K_RESULT,result);
        
        userinfo = [NSDictionary dictionaryWithObjectsAndKeys:
                    url,@"url",
                    result,@"result",//0成功，其它失败
                    nil];
        
    }else if([url isEqualToString:@V_URL_VERSION_UPDATE]){
        
        NSString *result = nil;
        
        XML_GET_VALUE(K_RESULT,result);
        
        userinfo = [NSDictionary dictionaryWithObjectsAndKeys:
                    url,@"url",
                    result,@"result", //0成功，1正在更新中，其它失败
                    nil];
    }else{
        
        MSG_LOGE("parseImsg K_EVENT_URL is err!!");
    }
    
    return userinfo;
    
}


+(const char *) queryUserInfo:(const char * )dev_id user_id:(const char * )user_id{
    
    dxml info;

    info.setText(K_EVENT_URL, V_URL_GET_USER_INFO);
    info.setText(K_TYPE, V_TYPE_REQ);
    info.setText(K_DEV_ID, dev_id);
    info.setText(K_APP_ID, user_id);
    
    MSG_LOGD("send:%s",info.data());
    
    memset(imsgBody, 0, sizeof(imsgBody));
    strcpy(imsgBody, info.data());
    
    return imsgBody;
}

+(const char *) addUser:(const char * )dev_id devPwd:(const char *)devPwd  admin_id:(const char * )admin_id user_id:(const char * )user_id user_type:(const char * )user_type{
    
    dxml info;
    
    info.setText(K_EVENT_URL, V_URL_ADD_USER);
    info.setText(K_TYPE, V_TYPE_REQ);
    info.setText(K_DEV_ID, dev_id);
    info.setText(K_DEV_PWD2, devPwd);
    info.setText(K_DEV_ADMIN, admin_id);
    info.setText(K_USER_TYPE, user_type);
    info.setText(K_USER_ID, user_id);
    
    MSG_LOGD("send:%s",info.data());
    
    memset(imsgBody, 0, sizeof(imsgBody));
    strcpy(imsgBody, info.data());
    
    return imsgBody;
}

+(const char *) delUser:(const char * )dev_id devPwd:(const char *)devPwd  admin_id:(const char * )admin_id user_id:(const char * )user_id{
    
    dxml info;
    
    info.setText(K_EVENT_URL, V_URL_DEL_USER);
    info.setText(K_TYPE, V_TYPE_REQ);
    info.setText(K_DEV_ID, dev_id);
    info.setText(K_DEV_PWD2, devPwd);
    info.setText(K_DEV_ADMIN, admin_id);
    info.setText(K_USER_ID, user_id);
    
    MSG_LOGD("send:%s",info.data());
    
    memset(imsgBody, 0, sizeof(imsgBody));
    strcpy(imsgBody, info.data());
    
    return imsgBody;
}

+(const char *) queryDevInfo:(const char * )dev_id user_id:(const char * )user_id{
    
    dxml info;
    
    info.setText(K_EVENT_URL, V_URL_GET_DEV_INFO);
    info.setText(K_TYPE, V_TYPE_REQ);
    info.setText(K_DEV_ID, dev_id);
    info.setText(K_APP_ID, user_id);
    
    MSG_LOGD("send:%s",info.data());
    
    memset(imsgBody, 0, sizeof(imsgBody));
    strcpy(imsgBody, info.data());
    
    return imsgBody;
}

+(const char *) changeDevicePwd:(const char *)dev_id user_id:(const char *)user_id oldPwd:(const char *)oldPwd  newPwd:(const char *) newPwd{
    
    dxml info;
    
    info.setText(K_EVENT_URL, V_URL_CHANGE_PWD);
    info.setText(K_TYPE, V_TYPE_REQ);
    info.setText(K_DEV_ID, dev_id);
    info.setText(K_ADMIN_ID, user_id);
    info.setText(K_ADMIN_PWD, oldPwd);
    info.setText(K_NEW_PWD, newPwd);
    MSG_LOGD("send:%s",info.data());
    
    
    memset(imsgBody, 0, sizeof(imsgBody));
    strcpy(imsgBody, info.data());
    
    return imsgBody;
}

+(const char *) changeDeviceId:(const char *)dev_id dev_pwd:(const char *)dev_pwd user_id:(const char *)user_id dev_new_id:(const char *)dev_new_id  sip_pwd:(const char *)sip_pwd  sip_serv:(const char *) sip_serv{
    
    dxml info;
    
    info.setText(K_EVENT_URL, V_URL_SET_SIP_INFO);
    info.setText(K_TYPE, V_TYPE_REQ);
    info.setText(K_DEV_ID, dev_id);
    info.setText(K_SET_DEV_PSW, dev_pwd);
    info.setText(K_APP_ID, user_id);
    info.setText(K_SET_NEW_ID, dev_new_id);
    info.setText(K_SET_SIP_PSW, sip_pwd);
    info.setText(K_SET_SIP_SERV, sip_serv);

    MSG_LOGD("send:%s",info.data());
    
    
    memset(imsgBody, 0, sizeof(imsgBody));
    strcpy(imsgBody, info.data());
    
    return imsgBody;
}

+(const char *) queryDeviceId:(const char * )dev_id user_id:(const char * )user_id{
    
    dxml info;
    
    info.setText(K_EVENT_URL, V_URL_GET_SIP_INFO);
    info.setText(K_TYPE, V_TYPE_REQ);
    info.setText(K_DEV_ID, dev_id);
    info.setText(K_APP_ID, user_id);
    
    MSG_LOGD("send:%s",info.data());
    
    memset(imsgBody, 0, sizeof(imsgBody));
    strcpy(imsgBody, info.data());
    
    return imsgBody;
}

+(const char *)matchAddDev: (const char*) ssid ssidPwd:(const char*) ssidPwd authmode:(const char*)authmode encryptType:(const char*) encryptType user_id:(const char*)user_id dev_id:(const char*)dev_id sip_psw:(const char*)sip_psw sip_server:(const char*)sip_server{
    
    dxml info;
    
    info.setText(K_EVENT_URL, V_URL_MATCH_SET);
    info.setText(K_TYPE, V_TYPE_REQ);
    info.setText(K_MATCH_SSID, ssid);
    info.setText(K_MATCH_SSID_PWD,ssidPwd);
    info.setText(K_MATCH_AUTHMODE,authmode);
    info.setText(K_MATCH_ENCRYPT_TYPE,encryptType);
    info.setText(K_APP_ID, user_id);
    
    if(dev_id !=nil )
        info.setText(K_DEV_ID, dev_id);
    if(sip_psw !=nil )
        info.setText(K_MATCH_DEV_SIP_PWD,sip_psw);
    
    info.setText(K_MATCH_SIP_SERVER,sip_server);
    
    MSG_LOGD("send:%s",info.data());
    
    memset(imsgBody, 0, sizeof(imsgBody));
    strcpy(imsgBody, info.data());
    
    return imsgBody;
}


// 获得开锁时间
+(const char *) getLockTime:(const char *) dev_id user_id: (const char * )user_id {
    dxml info;
    
    info.setText(K_EVENT_URL, V_URL_GET_LOCK_TIME);
    info.setText(K_TYPE, V_TYPE_REQ);
    info.setText(K_DEV_ID, dev_id);
    info.setText(K_APP_ID, user_id);
    
    memset(imsgBody, 0, sizeof(imsgBody));
    strcpy(imsgBody, info.data());
    
    return imsgBody;
}

// 设置开锁时间
+(const char *) setLockTime:(const char *) user_id dev_id: (const char *) dev_id devPwd: (const char *) devPwd callLimit:(const char* )callLimit bitrate:(const char* )bitrate unlockTi:(const char*) unlockTi{
    dxml info;
    
    info.setText(K_EVENT_URL, V_URL_SET_LOCK_TIME);
    info.setText(K_TYPE, V_TYPE_REQ);
    info.setText(K_DEV_ID, dev_id);
    info.setText(K_ADMIN_ID, user_id);
    info.setText(K_CALL_LIMIT, callLimit);
    info.setText(K_VIDEO_SET, bitrate);
    info.setText(K_SET_LOCK_TIME,unlockTi);
    info.setText(K_SET_LOCK_DEV_PSW,devPwd);
    
    MSG_LOGD("send:%s",info.data());
    
    memset(imsgBody, 0, sizeof(imsgBody));
    strcpy(imsgBody, info.data());
    
    return imsgBody;
    
}

// 配置WIFI
+(const char *) setWifi:(const char *) dev_id devPwd: (const char *) devPwd user_id:(const char*) user_id authmode:(const char*)authmode encryptType:(const char*) encryptType wifiHot:(const char* ) wifiHot wifiPwd:(const char*) wifiPwd {
    dxml info;
    
    info.setText(K_EVENT_URL, V_URL_SET_WIFI);
    info.setText(K_TYPE, V_TYPE_REQ);
    info.setText(K_DEV_ID, dev_id);
    info.setText(K_APP_ID, user_id);
    info.setText(K_SET_WIFI_SEC,authmode);
    info.setText(K_SET_WIFI_ENC,encryptType);
    info.setText(K_SET_WIFI_HOT,wifiHot);
    info.setText(K_SET_WIFI_PSW,wifiPwd);
    info.setText(K_SET_DEV_PSW,devPwd);
    
    MSG_LOGD("send:%s",info.data());
    
    memset(imsgBody, 0, sizeof(imsgBody));
    strcpy(imsgBody, info.data());
    
    return imsgBody;
}


//开关视频
+(const char *) setDevVideo:(const char *) dev_id user_id:(const char*) user_id onOff:(const char *)onOff {
    dxml info;
    
    info.setText(K_EVENT_URL, V_URL_SET_DEV_VIDEO);
    info.setText(K_TYPE, V_TYPE_REQ);
    info.setText(K_DEV_ID, dev_id);
    info.setText(K_APP_ID, user_id);
    info.setText(K_SET_DEV_VIDEO_ONOFF, onOff);
    
    MSG_LOGD("send:%s",info.data());
    
    memset(imsgBody, 0, sizeof(imsgBody));
    strcpy(imsgBody, info.data());
    
    return imsgBody;
    
}

//通话中开锁
+(const char *) setDevUnlock{
    dxml info;
    
    info.setText(K_EVENT_URL, V_URL2_UNLOCK);
    info.setText(K_TYPE, V_TYPE_REQ);
    info.setText(K_UNLOCK_DATA, "0");
    
    MSG_LOGD("send:%s",info.data());
    
    memset(imsgBody, 0, sizeof(imsgBody));
    strcpy(imsgBody, info.data());
    
    return imsgBody;
    
}

//设置与dev的通话状态
+(const char *) setDevCallStatus: (const char *)callStatus mode:(int)sessionMode  uid:(const char *)uid time:(const char*)time{
    dxml info;

    
    info.setText(K_EVENT_URL, callStatus);
    info.setText(K_TYPE, V_TYPE_REQ);
    info.setText(K_DEV_ID, uid);
    
    ////0来电， 1 监视
    if(strcmp(callStatus,V_URL_CALL_STATUS_START)==0){
        info.setText(K_TALK_TYPE,(sessionMode==SESSION_MODE_MONITOR)?"1":"0");
        info.setText(K_EVENT_TIME,time);
    }
    
    
    MSG_LOGD("send:%s",info.data());
    
    memset(imsgBody, 0, sizeof(imsgBody));
    strcpy(imsgBody, info.data());
    
    return imsgBody;
    
}

//设置dev版本升级
+(const char *) setVersionUpdate : (const char *)devModel latestVersion:(const char *)latestVersion  isForce:(const char *)isForce downLoadUrl:(const char*)downLoadUrl md5:(const char*)md5{
    dxml info;
    
    info.setText(K_EVENT_URL, V_URL_VERSION_UPDATE);
    info.setText(K_TYPE, V_TYPE_REQ);
    info.setText(K_DEV_MODEL, devModel);
    info.setText(K_VERSION_UPDATE_LATESTVERSION, latestVersion);
    info.setText(K_VERSION_UPDATE_ISFORCE, isForce);
    info.setText(K_VERSION_UPDATE_DOWNLOADURL, downLoadUrl);
    info.setText(K_VERSION_UPDATE_MD5, md5);

    //NSLog(@"send:%d,%s",(int)strlen(info.data()),info.data());
    
    memset(imsgBody, 0, sizeof(imsgBody));
    strcpy(imsgBody, info.data());
    
    return imsgBody;
    
}

/************************************************************************/
/*	multicast															*/
/************************************************************************/
+(const char*)setDiscover:(const char*)user{
    dxml info;

    info.setText("/event/active","discover");
    info.setText("/event/type","req");
    info.setText("/event/id",user);
    
    memset(imsgBody, 0, sizeof(imsgBody));
    strcpy(imsgBody, info.data());
    
    return imsgBody;
}

+(const char*)setDiscoverAck:(const char*)url uid:(const char*)uid{
    dxml info;
    
    info.setText("/event/active","discover");
    info.setText("/event/type","ack");
    info.setText("/event/id",uid);
    info.setText("/event/url",url);
    
    memset(imsgBody, 0, sizeof(imsgBody));
    strcpy(imsgBody, info.data());
    
    return imsgBody;
}


+(const char*)setSearchAck:(const char*)localip uid:(const char*)uid{
    dxml info;
    
    info.setText("/event/active","search");
    info.setText("/event/type","ack");
    info.setText("/event/id",uid);
    info.setText("/event/ip",localip);
    info.setText("/event/mac","00:00:00:00:00:00");
    
    memset(imsgBody, 0, sizeof(imsgBody));
    strcpy(imsgBody, info.data());
    
    return imsgBody;
}


+(const char*)setRcvDevAlarm:(const char*)tick uid:(const char*)uid{
    dxml info;
    
    info.setText("/params/event_url","/wifi/device_alarm");
    info.setText("/params/type","req");
    info.setText("/params/device_id",uid);
    info.setText("/params/tick",tick);
    
    memset(imsgBody, 0, sizeof(imsgBody));
    strcpy(imsgBody, info.data());
    
    return imsgBody;
}

@end

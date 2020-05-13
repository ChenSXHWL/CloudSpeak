//
//  sendMsg2Dev.h
//  EverTalk
//
//  Created by dgw on 16/7/2.
//  Copyright © 2016年 dnake. All rights reserved.
//

#ifndef sendMsg2Dev_h
#define sendMsg2Dev_h

#import <Foundation/Foundation.h>
#import "callManager.h"


@interface packImsg : NSObject
+(NSDictionary *)parseImsg:(const char *)body;
+(const char *) queryUserInfo:(const char * )dev_id user_id:(const char * )user_id;
+(const char *) addUser:(const char * )dev_id devPwd:(const char *)devPwd  admin_id:(const char * )admin_id user_id:(const char * )user_id user_type:(const char * )user_type;
+(const char *) delUser:(const char * )dev_id devPwd:(const char *)devPwd  admin_id:(const char * )admin_id user_id:(const char * )user_id;
+(const char *) queryDevInfo:(const char * )dev_id user_id:(const char * )user_id;
+(const char *) changeDevicePwd:(const char *)dev_id user_id:(const char *)user_id oldPwd:(const char *)oldPwd  newPwd:(const char *) newPwd;
+(const char *) changeDeviceId:(const char *)dev_id dev_pwd:(const char *)dev_pwd user_id:(const char *)user_id dev_new_id:(const char *)dev_new_id  sip_pwd:(const char *)sip_pwd  sip_serv:(const char *) sip_serv;
+(const char *) queryDeviceId:(const char * )dev_id user_id:(const char * )user_id;
+(const char *)matchAddDev: (const char*) ssid ssidPwd:(const char*) ssidPwd authmode:(const char*)authmode encryptType:(const char*) encryptType user_id:(const char*)user_id dev_id:(const char*)dev_id sip_psw:(const char*)sip_psw sip_server:(const char*)sip_server;
+(const char *) getLockTime:(const char *) dev_id user_id: (const char * )user_id ;
+(const char *) setLockTime:(const char *) user_id dev_id: (const char *) dev_id devPwd: (const char *) devPwd callLimit:(const char* )callLimit bitrate:(const char* )bitrate unlockTi:(const char*) unlockTi;
+(const char *) setWifi:(const char *) dev_id devPwd: (const char *) devPwd user_id:(const char*) user_id authmode:(const char*)authmode encryptType:(const char*) encryptType wifiHot:(const char* ) wifiHot wifiPwd:(const char*) wifiPwd ;
+(const char *) setDevVideo:(const char *) dev_id user_id:(const char*) user_id onOff:(const char *)onOff;
+(const char *) setDevUnlock;
+(const char *) setDevCallStatus: (const char *)callStatus mode:(int)sessionMode uid:(const char *)uid time:(const char*)time;
//+(void) parseImsgDevCallStatus:(const char *)body callStatus:(call_status_t *)callStatus;
+(const char *) setVersionUpdate : (const char *)devModel latestVersion:(const char *)latestVersion  isForce:(const char *)isForce downLoadUrl:(const char*)downLoadUrl md5:(const char*)md5;



/************************************************************************/
/*	multicast															*/
/************************************************************************/
+(const char*)setDiscover:(const char*)user;
+(const char*)setDiscoverAck:(const char*)url uid:(const char*)uid;
+(const char*)setSearchAck:(const char*)localip uid:(const char*)uid;
+(const char*)setRcvDevAlarm:(const char*)tick uid:(const char*)uid;
+(void)parseMulMsg:(const char *)body mul_data:(MulticastData *)mul_data;
@end

#endif /* sendMsg2Dev_h */

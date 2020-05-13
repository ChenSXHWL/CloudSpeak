//
//  AYCloudSpeakApi.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/28.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AYCloudSpeakApi : NSObject

+ (AYCloudSpeakApi *)cloudSpeakApi;

/**
 * 初始化
 */
- (void)initCloudSpeak;
/**
 * 退出
 */
- (void)exitCloudSpeak;
/**
 * 注销用户，使所有SIP用户无法呼入
 */
- (void)unRegisterUser;
/**
 * Sip配置
 */
- (void)setSipConfigWithSipServer:(NSString *)sipServer sipAccout:(NSString *)sipAccout sipPassword:(NSString *)sipPassword;
/**
 * 设置网络配置（ip，子网掩码）需求：内网
 */
- (void)setNetWorkDataWithLocalDeviceIpAddress:(NSString *)localDeviceIpAddress netmaskAddress:(NSString *)netmaskAddress currentNetType:(NSString *)currentNetType;
/**
 * 呼叫设备(callId:设备sip号)
 */
- (void)outGoingCallWithCallId:(NSString *)callId;
/**
 * 打开视频（view：当前所在视图）
 */
- (void)openView:(UIView *)view;
/**
 * 打开麦克风🎤(0:打开 1:关闭)
 */
- (void)openMic:(int)isOpen;
/**
 * 打开被动呼叫麦克风🎤(0:打开 1:关闭)
 */
- (void)openSpe:(int)isOpen;
/**
 * 关闭呼叫
 */
- (void)callStop;
/**
 * 发送Sip消息到设备（用于开锁🔓，与开锁一起发送 callId：设备号）
 */
- (void)instantMsgSendWithCallId:(NSString *)callId unLockXML:(NSString *)unLockXML;
/**
 * 开锁
 */
- (void)unLock;
/**
 * 截图
 */
- (void)videoSnapshot;

/**
 *  获取本地图片
 */
- (NSArray *)getLocalImages;
/**
 * 响应设备
 */
- (void)respondDev;

@property (assign, nonatomic) BOOL isExit;

@property (assign, nonatomic) BOOL isEnterBackground;

@property (assign, nonatomic) BOOL isOutLogin;

@end

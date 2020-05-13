//
//  AYGetIpAddress.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/7.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AYGetIpAddress : NSObject

+ (AYGetIpAddress *)getIpAddress;
/*
 * 广播地址
 */
@property (copy, nonatomic) NSString *broadcastAddress;
/*
 * 本地ip地址
 */
@property (copy, nonatomic) NSString *localDeviceIpAddress;
/*
 * 子网掩码地址
 */
@property (copy, nonatomic) NSString *netmaskAddress;
/*
 * 端口地址
 */
@property (copy, nonatomic) NSString *interfaceAddress;

@property (copy, nonatomic) NSString *currentNetType;


@end

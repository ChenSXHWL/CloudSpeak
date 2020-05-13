//
//  DeviceInfoRequest.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/20.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface DeviceInfoRequest : RequestConfig

@property (copy, nonatomic) NSString *deviceNum;

@property (copy, nonatomic) NSString *communityCode;

@property (copy, nonatomic) NSString *timestamp;

@property (copy, nonatomic) NSString *appUserId;

@end

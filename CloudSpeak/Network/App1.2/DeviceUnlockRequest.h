//
//  DeviceUnlockRequest.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/24.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface DeviceUnlockRequest : RequestConfig
//@property (copy, nonatomic) NSString *householdId;//住户ID

@property (copy, nonatomic) NSString *deviceNum;//设备编码

@property (copy, nonatomic) NSString *communityCode;//小区号

@property (copy, nonatomic) NSString *appUserId;//住户id

@property (copy, nonatomic) NSString *from;//住户id

@end

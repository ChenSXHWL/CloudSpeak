//
//  GetDeviceGroupRequest.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface GetDeviceGroupRequest : RequestConfig

@property (copy, nonatomic) NSString *householdId;

@property (copy, nonatomic) NSString *appUserId;

@property (copy, nonatomic) NSString *communityCode;

@end

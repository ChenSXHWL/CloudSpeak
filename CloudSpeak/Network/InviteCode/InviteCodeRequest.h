//
//  InviteCodeRequest.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/10.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface InviteCodeRequest : RequestConfig

@property (copy, nonatomic) NSNumber *dateTag;

@property (copy, nonatomic) NSNumber *appUserId;

//@property (copy, nonatomic) NSString *householdId;

@property (copy, nonatomic) NSNumber *times;

@property (copy, nonatomic) NSNumber *deviceGroupId;

@property (copy, nonatomic) NSString *communityCode;

@end

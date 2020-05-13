//
//  InvalidCodeRequest.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface InvalidCodeRequest : RequestConfig

@property (copy, nonatomic) NSString *deviceGroupId;

@property (copy, nonatomic) NSString *inviteCode;

@property (copy, nonatomic) NSString *communityCode;

@end

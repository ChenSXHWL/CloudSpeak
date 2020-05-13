//
//  CheckAuthorizationRequest.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/6/26.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface CheckAuthorizationRequest : RequestConfig

@property (copy, nonatomic) NSString *sipNumber;

@property (copy, nonatomic) NSString *registrationId;

@property (copy, nonatomic) NSString *loginName;

@property (copy, nonatomic) NSString *appUserId;

@property (copy, nonatomic) NSString *uuid;

@end

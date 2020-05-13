//
//  LoginRequest.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/7.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface LoginRequest : RequestConfig

@property (copy, nonatomic) NSString *loginName;

@property (copy, nonatomic) NSString *password;

@property (copy, nonatomic) NSString *registrationId;

@property (strong, nonatomic) NSNumber *platform;

@property (copy, nonatomic) NSString *clusterAccountId;

@end

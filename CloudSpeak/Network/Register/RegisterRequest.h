//
//  RegisterRequest.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/6.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface RegisterRequest : RequestConfig

@property (copy, nonatomic) NSString *loginName;

@property (copy, nonatomic) NSString *password;

@property (copy, nonatomic) NSString <Ignore> *confirmPassword;

@end

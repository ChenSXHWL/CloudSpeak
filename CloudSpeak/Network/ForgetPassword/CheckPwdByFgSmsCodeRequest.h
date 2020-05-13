//
//  CheckPwdByFgSmsCodeRequest.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/6.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface CheckPwdByFgSmsCodeRequest : RequestConfig

@property (copy, nonatomic) NSString *telNum;

@property (copy, nonatomic) NSString *smsCode;

@end

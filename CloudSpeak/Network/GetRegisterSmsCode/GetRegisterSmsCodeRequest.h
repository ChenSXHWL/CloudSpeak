//
//  GetRegisterSmsCodeRequest.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/5.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface GetRegisterSmsCodeRequest : RequestConfig

@property (copy, nonatomic) NSString *telNum;

@end

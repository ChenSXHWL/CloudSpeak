//
//  UserSwitchRequest.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/28.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//
//修改用户呼叫开关
#import "RequestConfig.h"

@interface UserSwitchRequest : RequestConfig

@property (copy, nonatomic) NSString *appUserId;//业主ID

@property (copy, nonatomic) NSString *callSwitch;//开关：0关，1开；

@property (copy, nonatomic) NSString *sipSwitch;//呼叫转移开关：0关，1开；
@end

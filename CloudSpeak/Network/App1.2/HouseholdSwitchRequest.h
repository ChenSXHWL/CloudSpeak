//
//  HouseholdSwitchRequest.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/22.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface HouseholdSwitchRequest : RequestConfig

@property (copy, nonatomic) NSString *householdId;//业主ID

@property (copy, nonatomic) NSString *callSwitch;//开关：0关，1开；

@property (copy, nonatomic) NSString *sipSwitch;//呼叫转移开关：0关，1开；

@end

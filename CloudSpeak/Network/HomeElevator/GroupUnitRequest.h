//
//  GroupUnitRequest.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/22.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface GroupUnitRequest : RequestConfig

@property (copy, nonatomic) NSString *appUserId;

@property (copy, nonatomic) NSString *communityId;//APP用户ID，工程人员测试不传

@property (copy, nonatomic) NSString *deviceNum;

@end

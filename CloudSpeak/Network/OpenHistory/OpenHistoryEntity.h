//
//  OpenHistoryEntity.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "EntityConfig.h"

@interface OpenHistoryEntity : EntityConfig

@property (copy, nonatomic) NSString *modifytime;

@property (copy, nonatomic) NSString *validityEndTime;

@property (copy, nonatomic) NSString *dataStatus;

@property (copy, nonatomic) NSString *inviteCode;

@property (copy, nonatomic) NSString *useTimes;

@property (copy, nonatomic) NSString *inviteCodeType;

@property (copy, nonatomic) NSString *deviceGroupId;

@end

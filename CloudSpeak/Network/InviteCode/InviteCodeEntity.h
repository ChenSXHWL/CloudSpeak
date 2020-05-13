//
//  InviteCodeEntity.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "EntityConfig.h"

@interface InviteCodeEntity : EntityConfig

@property (copy, nonatomic) NSString *inviteCode;

@property (copy, nonatomic) NSString *endDate;

@end

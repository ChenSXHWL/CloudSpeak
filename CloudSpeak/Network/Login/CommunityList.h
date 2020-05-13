//
//  CommunityList.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/10.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "EntityConfig.h"

@interface CommunityList : EntityConfig

@property (copy, nonatomic) NSString *householdId;

@property (copy, nonatomic) NSString *communityCode;

@property (copy, nonatomic) NSString *communityName;

@property (copy, nonatomic) NSString *communityId;

@property (copy, nonatomic) NSNumber *cloudSpeakSwitch;//云对讲开关：0关，1开

@property (copy, nonatomic) NSNumber *ladderControlSwitch;//梯控开关：0关，1开

@end

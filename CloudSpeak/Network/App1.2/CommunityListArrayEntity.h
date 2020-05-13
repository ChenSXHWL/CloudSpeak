//
//  CommunityListArrayEntity.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/28.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "EntityConfig.h"
#import "HouseList.h"

@interface CommunityListArrayEntity : EntityConfig

@property (copy, nonatomic) NSArray *householdList;

@property (copy, nonatomic) NSString *communityName;

@end

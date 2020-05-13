//
//  CommunityInfoEntity.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/15.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "EntityConfig.h"
#import "CommunityInfoUnitEntity.h"
#import "CommunityInfoZoneEntity.h"
#import "CommunityInfoBuildingEntity.h"

@interface CommunityInfoEntity : EntityConfig

@property (strong, nonatomic) NSArray *unitList;

@property (strong, nonatomic) NSArray *zoneList;

@property (strong, nonatomic) NSArray *buildingList;

@end

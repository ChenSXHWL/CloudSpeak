//
//  CommunityInfoEntity.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/15.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "CommunityInfoEntity.h"

@implementation CommunityInfoEntity

- (void)setUnitList:(NSArray *)unitList
{
    _unitList = (NSArray *)[CommunityInfoUnitEntity arrayOfModelsFromDictionaries:unitList error:nil];
    
}

- (void)setZoneList:(NSArray *)zoneList
{
    _zoneList = (NSArray *)[CommunityInfoZoneEntity arrayOfModelsFromDictionaries:zoneList error:nil];
}

- (void)setBuildingList:(NSArray *)buildingList
{
    _buildingList = (NSArray *)[CommunityInfoBuildingEntity arrayOfModelsFromDictionaries:buildingList error:nil];
}

@end

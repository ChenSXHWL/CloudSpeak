//
//  HousehoIdInfoEntity.h
//  neighborplatform
//
//  Created by 陈思祥 on 2018/4/23.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "EntityConfig.h"

@interface HousehoIdInfoEntity : EntityConfig

@property (copy, nonatomic) NSString *householdId;

@property (copy, nonatomic) NSString *buildingCode;

@property (copy, nonatomic) NSString *unitCode;

@property (copy, nonatomic) NSString *roomNum;

@property (copy, nonatomic) NSString *householdName;

@end

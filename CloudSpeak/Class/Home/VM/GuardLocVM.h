//
//  GuardLocVM.h
//  CloudSpeak
//
//  Created by mac on 2018/6/25.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "SceneModelConfig.h"
#import "HouseholdInfoRequest.h"
#import "HousehoIdInfoEntity.h"
@interface GuardLocVM : SceneModelConfig

@property (strong, nonatomic) HouseholdInfoRequest *householdInfoRequest;

@property (strong, nonatomic) NSMutableArray *houseArray;
@end

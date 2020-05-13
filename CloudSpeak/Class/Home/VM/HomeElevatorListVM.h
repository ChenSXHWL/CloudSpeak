//
//  HomeElevatorListVM.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/22.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "SceneModelConfig.h"
#import "GroupUnitRequest.h"
#import "GroupUnitEntity.h"
@interface HomeElevatorListVM : SceneModelConfig

@property (strong, nonatomic) GroupUnitRequest *groupUnitRequest;

@property (strong, nonatomic) NSArray *groupUnitKeys;

@end

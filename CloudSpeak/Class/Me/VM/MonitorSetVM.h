//
//  MonitorSetVM.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/27.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "SceneModelConfig.h"
#import "HouseholdSwitchRequest.h"
#import "UserSwitchRequest.h"
@interface MonitorSetVM : SceneModelConfig

@property (strong, nonatomic)HouseholdSwitchRequest *householdSwitchRequest;

@property (strong, nonatomic)UserSwitchRequest *userSwitchRequest;

@end

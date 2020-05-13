//
//  GetDeviceGroupVM.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <EasyIOS/EasyIOS.h>
#import "GetDeviceGroupRequest.h"
#import "GetDeviceGroupEntity.h"

@interface GetDeviceGroupVM : SceneModelConfig

@property (strong, nonatomic) GetDeviceGroupRequest *getDeviceGroupRequest;

@property (strong, nonatomic) NSMutableArray *getDeviceGroups;

@end

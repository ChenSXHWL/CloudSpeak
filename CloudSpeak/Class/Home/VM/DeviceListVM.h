//
//  DeviceListVM.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/12.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <EasyIOS/EasyIOS.h>
#import "GetMyKeyRequest.h"
#import "GetMyKeyEntity.h"

@interface DeviceListVM : SceneModelConfig

@property (strong, nonatomic) GetMyKeyRequest *getMyKeyRequest;

@property (strong, nonatomic) NSMutableArray *getMyKeys;

@end

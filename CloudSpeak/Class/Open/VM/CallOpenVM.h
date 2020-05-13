//
//  CallOpenVM.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/15.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <EasyIOS/EasyIOS.h>
#import "CallOpenRequest.h"
#import "GetMyKeyRequest.h"
#import "GetMyKeyEntity.h"
#import "DeviceUnlockRequest.h"
#import "TakePhotoRequest.h"

#import "HouseholdInfoRequest.h"
#import "HousehoIdInfoEntity.h"

@interface CallOpenVM : SceneModelConfig

@property (strong, nonatomic) CallOpenRequest *callOpenRequest;

@property (strong, nonatomic) GetMyKeyRequest *getMyKeyRequest;

@property (strong, nonatomic) DeviceUnlockRequest *deviceUnlockRequest;

@property (strong, nonatomic) TakePhotoRequest *takePhotoRequest;

@property (strong, nonatomic) HouseholdInfoRequest *householdInfoRequest;

@property (strong, nonatomic) NSMutableArray *houseArray;

@property (strong, nonatomic) NSMutableArray *getMyKeys;

@property (strong, nonatomic) NSString *takePhotoString;

@end


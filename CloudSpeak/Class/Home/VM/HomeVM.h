//
//  HomeVM.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/24.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "SceneModelConfig.h"
#import "PropertyNnoticeListRequest.h"
#import "PropertyNnoticeListEntity.h"
#import "VersionUpRequest.h"
#import "LoginRequest.h"
#import "DeviceUnlockRequest.h"
#import "AuthorityRequest.h"
#import "AdvertisingListRequest.h"
#import "AdvertisingListEntity.h"
@interface HomeVM : SceneModelConfig

@property (strong, nonatomic)PropertyNnoticeListRequest *propertyNnoticeListRequest;

@property (strong, nonatomic)NSArray *propertyNnoticeListKeys;

@property (strong, nonatomic)VersionUpRequest *versionUpRequest;

@property (strong, nonatomic)LoginRequest *loginRequest;

@property (strong, nonatomic)DeviceUnlockRequest *deviceUnlockRequest;

@property (strong, nonatomic)AuthorityRequest *authorityRequest;

@property (strong, nonatomic)NSString * ladderControlsSwitch;

@property (strong, nonatomic)AdvertisingListRequest *advertisingListRequest;

@property (strong, nonatomic)NSArray *adverArray;


@end

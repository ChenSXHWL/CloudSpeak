//
//  WarrantyVM.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/24.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "SceneModelConfig.h"
#import "DeviceRepairRequest.h"
#import "HouseInfoRequest.h"
#import "DeviceListRequest.h"
#import "DeviceDetailRequest.h"
@interface WarrantyVM : SceneModelConfig

@property (strong, nonatomic) DeviceRepairRequest *deviceRepairRequest;

@property (assign, nonatomic) BOOL isSuccess;

@property (nonatomic, strong) HouseInfoRequest *communityInfoRequest;

@property (strong, nonatomic) NSArray *unitList;//单元

@property (strong, nonatomic) NSArray *buildingList;//楼栋

@property (strong, nonatomic) NSArray *roomList;//房间

@property (nonatomic, strong) DeviceListRequest *deviceListRequest;

@property (strong, nonatomic) NSArray *deviceList;//设备

@property (nonatomic, strong) DeviceDetailRequest *deviceInfoRequest;

@property (assign, nonatomic) BOOL deviceInfo;//设备
@end

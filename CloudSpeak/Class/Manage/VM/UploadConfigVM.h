//
//  UploadConfigVM.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/20.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <EasyIOS/EasyIOS.h>
#import "UploadConfigRequest.h"
#import "DeviceInfoRequest.h"
#import "DeviceInfoEntity.h"

#import "ReBootRequest.h"

#import "SynchronousDevRequest.h"
#import "BackupDevConfigRequest.h"
#import "DelDevRequest.h"

@interface UploadConfigVM : SceneModelConfig

@property (strong, nonatomic) UploadConfigRequest *uploadConfigRequest;

@property (strong, nonatomic) DeviceInfoRequest *deviceInfoRequest;

@property (strong, nonatomic) ReBootRequest *reBootRequest;

@property (strong, nonatomic) DeviceInfoEntity *deviceInfoEntity;

@property (strong, nonatomic) SynchronousDevRequest *synchronousDevRequest;

@property (strong, nonatomic) BackupDevConfigRequest *backupDevConfigRequest;

@property (strong, nonatomic) DelDevRequest *delDevRequest;


@end

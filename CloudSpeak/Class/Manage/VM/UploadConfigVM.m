//
//  UploadConfigVM.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/20.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "UploadConfigVM.h"
#import "AYTimeSetting.h"
#import "AYAnalysisXMLData.h"

@interface UploadConfigVM () <ActionDelegate>

@end

@implementation UploadConfigVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    
    if (![LoginEntity shareManager].communityList.count) return [AYProgressHud progressHudShowShortTimeMessage:@"暂无小区信息"];

    
    self.action.aDelegaete = self;
    
    self.uploadConfigRequest = [UploadConfigRequest Request];
    
    @weakify(self);
    self.uploadConfigRequest.requestInActiveBlock = ^{
        @strongify(self);
        
//        NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970];
//        
//        long long theTime = [[NSNumber numberWithDouble:nowtime] longLongValue];
//        
//        NSString *curTime = [NSString stringWithFormat:@"%llu",theTime];
//        
//        self.uploadConfigRequest.timeStamp = curTime;
        
        [self SEND_ACTION:self.uploadConfigRequest];
        
        [AYProgressHud progressHudLoadingRequest:self.uploadConfigRequest showInView:nil detailString:@""];
    };
    
    self.deviceInfoRequest = [DeviceInfoRequest Request];
    self.deviceInfoRequest.appUserId = [LoginEntity shareManager].appUserId;
    self.deviceInfoRequest.requestInActiveBlock = ^{
        @strongify(self);
        
        [self SEND_ACTION:self.deviceInfoRequest];
        
        [AYProgressHud progressHudLoadingRequest:self.deviceInfoRequest showInView:nil detailString:@""];
    };
    
    //重启设备
    self.reBootRequest = [ReBootRequest Request];
    
    self.reBootRequest.requestInActiveBlock = ^{
        @strongify(self);
        self.reBootRequest.communityCode = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityCode"];
        
        [self SEND_ACTION:self.reBootRequest];
        
        [AYProgressHud progressHudLoadingRequest:self.reBootRequest showInView:nil detailString:@""];
    };
    
    //备份设备
    self.backupDevConfigRequest = [BackupDevConfigRequest Request];
    
    self.backupDevConfigRequest.requestInActiveBlock = ^{
        @strongify(self);

        [self SEND_ACTION:self.backupDevConfigRequest];
        
        [AYProgressHud progressHudLoadingRequest:self.backupDevConfigRequest showInView:nil detailString:@""];
    };
    
    //同步设备
    self.synchronousDevRequest = [SynchronousDevRequest Request];
    
    self.synchronousDevRequest.requestInActiveBlock = ^{
        @strongify(self);
        
        [self SEND_ACTION:self.synchronousDevRequest];
        
        [AYProgressHud progressHudLoadingRequest:self.synchronousDevRequest showInView:nil detailString:@""];
    };
    
    //删除设备
    self.delDevRequest = [DelDevRequest Request];
    
    self.delDevRequest.requestInActiveBlock = ^{
        @strongify(self);
        
        
        [self SEND_ACTION:self.delDevRequest];
        
        [AYProgressHud progressHudLoadingRequest:self.delDevRequest showInView:nil detailString:@""];
    };
}

- (void)handleActionMsg:(Request *)msg
{
    [super handleActionMsg:msg];
    if (msg.state == RequestStateSending) {
        return;
    }
    if (msg == self.deviceInfoRequest) {
        
        DeviceInfoEntity *entity = [[DeviceInfoEntity alloc] initWithDictionary:self.deviceInfoRequest.output[@"deviceMap"] error:nil];
        
        self.uploadConfigRequest.deviceName = entity.deviceName;
        
        self.uploadConfigRequest.zoneId = entity.zoneId;
        
        self.uploadConfigRequest.buildingId = entity.buildingId;
        
        self.uploadConfigRequest.unitId = entity.unitId;
        
        self.uploadConfigRequest.deviceCode = entity.deviceCode;
        
        self.uploadConfigRequest.enterFlag = @"1";
        
        self.uploadConfigRequest.outFlag = @"0";
        
        self.uploadConfigRequest.sipAccount = entity.sipAccount;
        
        self.uploadConfigRequest.buildingCode = entity.buildingCode;
        
        self.uploadConfigRequest.unitCode = entity.unitCode;
        
        self.uploadConfigRequest.gpsAddress = entity.gpsAddress;
        
        self.deviceInfoEntity = entity;
        
        
    }
    if (msg.state==RequestStateSuccess) {
        if (msg == self.reBootRequest) {
            
            [AYProgressHud progressHudShowShortTimeMessage:@"重启设备成功"];
            
        }else if (msg == self.synchronousDevRequest) {
            
            [AYProgressHud progressHudShowShortTimeMessage:@"设备开始同步"];
            
        }else if (msg == self.backupDevConfigRequest) {
            
            [AYProgressHud progressHudShowShortTimeMessage:@"备份设备成功"];
            
        }else if (msg == self.delDevRequest) {
            
            [AYProgressHud progressHudShowShortTimeMessage:@"删除设备成功"];
            
        } else if (msg == self.uploadConfigRequest) {
            NSLog(@"get -- xml===%@", self.uploadConfigRequest.configStr);
        }
    }
    
}

@end

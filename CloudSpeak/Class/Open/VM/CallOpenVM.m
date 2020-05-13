//
//  CallOpenVM.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/15.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "CallOpenVM.h"

@interface CallOpenVM () <ActionDelegate>

@end

@implementation CallOpenVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    
    if (![LoginEntity shareManager].communityList.count) return [AYProgressHud progressHudShowShortTimeMessage:@"暂无小区信息"];
    
    self.action.aDelegaete = self;
    
    [self.action useCache];
    
    self.callOpenRequest = [CallOpenRequest Request];
    
    @weakify(self);
    self.callOpenRequest.requestInActiveBlock = ^{
        @strongify(self);
        self.callOpenRequest = [CallOpenRequest Request];
        
        self.callOpenRequest.householdId = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"householdId"];
        
        self.callOpenRequest.communityCode = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityCode"];
        
        [self SEND_ACTION:self.callOpenRequest];
    };
    NSNumber *str = [LoginEntity shareManager].communityList[0][@"householdId"];
    
    if (!str) return;
    
    self.getMyKeyRequest = [GetMyKeyRequest Request];
    
    self.getMyKeyRequest.appUserId = [LoginEntity shareManager].appUserId;
    self.getMyKeyRequest.communityCode = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityCode"];

    [self SEND_ACTION:self.getMyKeyRequest];
    
    self.getMyKeyRequest.requestInActiveBlock = ^{
        @strongify(self);
        self.getMyKeyRequest = [GetMyKeyRequest Request];
        
        self.getMyKeyRequest.appUserId = [LoginEntity shareManager].appUserId;
        self.getMyKeyRequest.communityCode = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityCode"];

        [self SEND_ACTION:self.getMyKeyRequest];
        
    };
    
    
    self.deviceUnlockRequest = [DeviceUnlockRequest Request];
    
    self.deviceUnlockRequest.requestInActiveBlock = ^{
        @strongify(self);
        
//        self.deviceUnlockRequest.householdId = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"householdId"];

        self.deviceUnlockRequest.appUserId = [LoginEntity shareManager].appUserId;
        
        self.deviceUnlockRequest.communityCode = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityCode"];
        self.deviceUnlockRequest.from = @"app";

        [self SEND_ACTION:self.deviceUnlockRequest];
    };
    
    self.takePhotoRequest = [TakePhotoRequest Request];
    
    self.takePhotoRequest.requestInActiveBlock = ^{
        @strongify(self);
        
        [self SEND_ACTION:self.takePhotoRequest];
    };
    
    self.householdInfoRequest = [HouseholdInfoRequest Request];
    
    self.householdInfoRequest.requestInActiveBlock = ^{
        @strongify(self);
        
        self.householdInfoRequest.appUserId = [LoginEntity shareManager].appUserId;
        
        self.householdInfoRequest.communityCode = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityCode"];
        
        [self SEND_ACTION:self.householdInfoRequest];
    };
    
}

- (void)handleActionMsg:(Request *)msg
{
    [super handleActionMsg:msg];
    
    if (msg.state == RequestStateSuccess) {
        
        if (msg == self.getMyKeyRequest) {
            
            self.getMyKeys = [GetMyKeyEntity arrayOfModelsFromDictionaries:msg.output[@"devices"] error:nil];
            
        }else if (msg == self.takePhotoRequest){
            self.takePhotoString = msg.output[@"snapshot"];
        }else if (msg == self.householdInfoRequest){
            self.houseArray = [HousehoIdInfoEntity arrayOfModelsFromDictionaries:msg.output[@"householdList"] error:nil];
        }
        
    }
}

@end


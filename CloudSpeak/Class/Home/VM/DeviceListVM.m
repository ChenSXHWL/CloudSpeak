//
//  DeviceListVM.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/12.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "DeviceListVM.h"

@interface DeviceListVM () <ActionDelegate>

@end

@implementation DeviceListVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    
    if (![LoginEntity shareManager].communityList.count) return [AYProgressHud progressHudShowShortTimeMessage:@"暂无小区信息"];

    
    self.action.aDelegaete = self;
    
    [self.action useCache];
    
    self.getMyKeyRequest = [GetMyKeyRequest Request];
    
    self.getMyKeyRequest.appUserId = [LoginEntity shareManager].appUserId;
    self.getMyKeyRequest.communityCode = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityCode"];

    [self SEND_IQ_ACTION:self.getMyKeyRequest];
    
    [AYProgressHud progressHudLoadingRequest:self.getMyKeyRequest showInView:nil detailString:@""];
    
}

- (void)handleActionMsg:(Request *)msg
{
    [super handleActionMsg:msg];
    
    if (msg.state == RequestStateSuccess) {
        self.getMyKeys = [GetMyKeyEntity arrayOfModelsFromDictionaries:msg.output[@"devices"] error:nil];
    }
}

@end

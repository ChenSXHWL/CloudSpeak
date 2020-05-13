//
//  CallForwardingVM.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/12.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "CallForwardingVM.h"
#import "NSString+BXExtension.h"

@interface CallForwardingVM () <ActionDelegate>

@end

@implementation CallForwardingVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    
    if (![LoginEntity shareManager].communityList.count) return [AYProgressHud progressHudShowShortTimeMessage:@"暂无小区信息"];

    
    self.action.aDelegaete = self;
    
    self.callForwardingRequest = [CallForwardingRequest Request];
    
    @weakify(self);
    self.callForwardingRequest.requestInActiveBlock = ^{
        @strongify(self);
        
        if (![self.callForwardingRequest.sipMobile isValidateMobile]) return [AYProgressHud progressHudShowShortTimeMessage:@"手机格式不正确"];
        
        [self SEND_ACTION:self.callForwardingRequest];
        
        [AYProgressHud progressHudLoadingRequest:self.callForwardingRequest showInView:nil detailString:@""];
    };
}

- (void)handleActionMsg:(Request *)msg
{
    [super handleActionMsg:msg];
}

@end

//
//  GetSetConfigVM.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/13.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "GetSetConfigVM.h"

@interface GetSetConfigVM () <ActionDelegate>

@end

@implementation GetSetConfigVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    
    if (![LoginEntity shareManager].communityList.count) return [AYProgressHud progressHudShowShortTimeMessage:@"暂无小区信息"];

    
    self.action.aDelegaete = self;
    
    [self.action useCache];
    
    self.getSettingConfigRequest = [GetSettingConfigRequest Request];
    
    @weakify(self);
    self.getSettingConfigRequest.requestInActiveBlock = ^{
        @strongify(self);
        
        [self SEND_IQ_ACTION:self.getSettingConfigRequest];
        
        [AYProgressHud progressHudLoadingRequest:self.getSettingConfigRequest showInView:nil detailString:@""];
    };
}

- (void)handleActionMsg:(Request *)msg
{
    [super handleActionMsg:msg];
}




@end

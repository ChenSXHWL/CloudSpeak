//
//  UpdateInfoVM.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/17.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "UpdateInfoVM.h"

@interface UpdateInfoVM () <ActionDelegate>

@end

@implementation UpdateInfoVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    
    if (![LoginEntity shareManager].communityList.count) return [AYProgressHud progressHudShowShortTimeMessage:@"暂无小区信息"];

    
    self.action.aDelegaete = self;
    
    self.updateInfoRequest = [UpdateInfoRequest Request];
    
    @weakify(self);
    self.updateInfoRequest.requestInActiveBlock = ^{
        @strongify(self);
        [self SEND_ACTION:self.updateInfoRequest];
    };
}

- (void)handleActionMsg:(Request *)msg
{
    [super handleActionMsg:msg];
    
}

@end

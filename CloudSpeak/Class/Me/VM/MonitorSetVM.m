//
//  MonitorSetVM.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/27.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "MonitorSetVM.h"

@interface MonitorSetVM () <ActionDelegate>

@end

@implementation MonitorSetVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    
    if (![LoginEntity shareManager].communityList.count) return [AYProgressHud progressHudShowShortTimeMessage:@"暂无小区信息"];
    
    
    self.action.aDelegaete = self;
    
    self.userSwitchRequest = [UserSwitchRequest Request];
    self.userSwitchRequest.appUserId = [LoginEntity shareManager].appUserId;
    @weakify(self);
    self.userSwitchRequest.requestInActiveBlock = ^{
        @strongify(self);
        [self SEND_ACTION:self.userSwitchRequest];
    };

    
    self.householdSwitchRequest = [HouseholdSwitchRequest Request];
    
    self.householdSwitchRequest.requestInActiveBlock = ^{
        @strongify(self);
        [self SEND_ACTION:self.householdSwitchRequest];
    };
}

- (void)handleActionMsg:(Request *)msg
{
    [super handleActionMsg:msg];
    
}
@end

//
//  InviteCodeVM.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "InviteCodeVM.h"

@interface InviteCodeVM () <ActionDelegate>

@end

@implementation InviteCodeVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    
    if (![LoginEntity shareManager].communityList.count) return [AYProgressHud progressHudShowShortTimeMessage:@"暂无小区信息"];

    
    self.action.aDelegaete = self;
    
    self.inviteCodeRequest = [InviteCodeRequest Request];
    
    @weakify(self);
    self.inviteCodeRequest.requestInActiveBlock = ^{
        @strongify(self);
        
//        self.inviteCodeRequest.householdId = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"householdId"];

        self.inviteCodeRequest.communityCode = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityCode"];
        
        [self SEND_ACTION:self.inviteCodeRequest];
        
        [AYProgressHud progressHudLoadingRequest:self.inviteCodeRequest showInView:nil detailString:@""];

    };
    
    
    self.invalidCodeHighRequest = [InvalidCodeHighRequest Request];
    self.invalidCodeHighRequest.appUserId = [LoginEntity shareManager].appUserId;
//    self.invalidCodeHighRequest.times = @(0);
//    self.invalidCodeHighRequest.householdId = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"householdId"];

    self.invalidCodeHighRequest.requestInActiveBlock = ^{
        @strongify(self);
        
        self.invalidCodeHighRequest.communityCode = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityCode"];
        
        [self SEND_ACTION:self.invalidCodeHighRequest];
        
        [AYProgressHud progressHudLoadingRequest:self.invalidCodeHighRequest showInView:nil detailString:@""];
        
    };

}

- (void)handleActionMsg:(Request *)msg
{
    [super handleActionMsg:msg];
    
    if (msg.state == RequestStateSuccess) {
        
        [AYProgressHud progressHudShowShortTimeMessage:[NSString stringWithFormat:@"%@下发成功",(NSString *)msg.output[@"successDevices"]]];
        
    }
}

@end

//
//  InvalidCodeVM.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "InvalidCodeVM.h"

@interface InvalidCodeVM () <ActionDelegate>

@end

@implementation InvalidCodeVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    
    if (![LoginEntity shareManager].communityList.count) return [AYProgressHud progressHudShowShortTimeMessage:@"暂无小区信息"];

    
    self.action.aDelegaete = self;
    
    self.invalidCodeRequest = [InvalidCodeRequest Request];
    
    @weakify(self);
    self.invalidCodeRequest.requestInActiveBlock = ^{
        @strongify(self);
        
        self.invalidCodeRequest.communityCode = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityCode"];
        
        [self SEND_ACTION:self.invalidCodeRequest];
        
        [AYProgressHud progressHudLoadingRequest:self.invalidCodeRequest showInView:nil detailString:@""];
    };
}

- (void)handleActionMsg:(Request *)msg
{
    [super handleActionMsg:msg];

}

@end

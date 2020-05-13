//
//  LoginOutVM.m
//  CloudSpeak
//
//  Created by DnakeWCZ on 17/5/18.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "LoginOutVM.h"

@implementation LoginOutVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    
    self.loginOutRequest = [LoginOutRequest Request];
    
    @weakify(self);
    self.loginOutRequest.requestInActiveBlock = ^ {
        @strongify(self);
        [self SEND_ACTION:self.loginOutRequest];
        
        [AYProgressHud progressHudLoadingRequest:self.loginOutRequest showInView:nil detailString:@""];
    };
}

@end

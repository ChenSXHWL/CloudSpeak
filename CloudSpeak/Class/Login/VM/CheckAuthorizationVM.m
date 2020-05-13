//
//  CheckAuthorizationVM.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/6/26.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "CheckAuthorizationVM.h"
#import "JPUSHService.h"
@interface CheckAuthorizationVM () <ActionDelegate>

@end@implementation CheckAuthorizationVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    self.action.aDelegaete = self;

    self.checkAuthorizationRequest = [CheckAuthorizationRequest Request];
    
    @weakify(self);
    self.checkAuthorizationRequest.requestInActiveBlock = ^{
        @strongify(self);
        
        if ([JPUSHService registrationID]) {
            
            self.checkAuthorizationRequest.registrationId = [JPUSHService registrationID];
            
        }
        
        self.checkAuthorizationRequest.appUserId = [LoginEntity shareManager].appUserId;
        
        self.checkAuthorizationRequest.sipNumber = [LoginEntity shareManager].sipAccount;
        
        self.checkAuthorizationRequest.loginName = [LoginEntity shareManager].phone;
        
        self.checkAuthorizationRequest.uuid = [LoginEntity shareManager].uuid;

        [self SEND_ACTION:self.checkAuthorizationRequest];
        
    };
    
}
- (void)handleActionMsg:(Request *)msg
{
    [super handleActionMsg:msg];
    
    if (msg.state == RequestStateSuccess) {
        
    }else{
        
    }
}
@end

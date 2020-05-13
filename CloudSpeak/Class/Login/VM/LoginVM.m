//
//  LoginVM.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/7.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "LoginVM.h"
#import "JPUSHService.h"

@interface LoginVM () <ActionDelegate>

@end

@implementation LoginVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    
    self.action.aDelegaete = self;
    
    self.loginRequest = [LoginRequest Request];
    
    /* 设置密码 注册 */
    
    @weakify(self);
    RACSignal *loginSignal = [RACSignal combineLatest:@[RACObserve(self.loginRequest, loginName), RACObserve(self.loginRequest, password)] reduce:^id(NSString *loginName, NSString *password){
        
        return @(loginName.length && password.length);
    }];
    
    self.loginCommand = [[RACCommand alloc] initWithEnabled:loginSignal signalBlock:^RACSignal *(id input) {
        @strongify(self);
        
        if ([JPUSHService registrationID]) {
            
            self.loginRequest.registrationId = [JPUSHService registrationID];
            
        }
        
        self.loginRequest.requestNeedActive = YES;
        
        return [RACSignal empty];
    }];
    
    self.loginRequest.requestInActiveBlock = ^(void) {
        @strongify(self);
        
        [self SEND_ACTION:self.loginRequest];
        
        [AYProgressHud progressHudLoadingRequest:self.loginRequest showInView:nil detailString:@""];
        
    };
}

- (void)handleActionMsg:(Request *)msg
{
    [super handleActionMsg:msg];
    if (msg.state == RequestStateSuccess) {
        
        LoginEntity *entity = [[LoginEntity alloc] initWithDictionary:msg.output error:nil];
        
        entity.page = @(0);
        
        entity.phone = self.loginRequest.loginName;
        
        entity.password = self.loginRequest.password;
        
        entity.scheme = self.scheme;
        
        entity.url = self.url;
        
        [LoginManage saveEntity:entity];
        
//        [[LoginEntity shareManager] modelOfDictionary];
        
           }
}

@end

//
//  ReSetPwdVM.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/7.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "ReSetPwdVM.h"

@interface ReSetPwdVM () <ActionDelegate>

@end

@implementation ReSetPwdVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    
    self.action.aDelegaete = self;
    
    self.resetPwdRequest = [ResetPwdRequest Request];
    
    /* 设置密码 注册 */
    
    @weakify(self);
    RACSignal *getCodeSignal = [RACSignal combineLatest:@[RACObserve(self.resetPwdRequest, password), RACObserve(self.resetPwdRequest, confirmPassword)] reduce:^id(NSString *password, NSString *confirmPassword){
        
        return @(password.length && confirmPassword.length);
    }];
    
    self.resetPwdCommand = [[RACCommand alloc] initWithEnabled:getCodeSignal signalBlock:^RACSignal *(id input) {
        @strongify(self);
        if (self.resetPwdRequest.password.length>5) {
            if (![self.resetPwdRequest.password isEqualToString:self.resetPwdRequest.confirmPassword]){
                [AYProgressHud progressHudShowShortTimeMessage:@"密码不一致,请重新输入"];
            }else{
                self.resetPwdRequest.requestNeedActive = YES;
            }
        }else{
            [AYProgressHud progressHudShowShortTimeMessage:@"密码至少为6位到20位"];
        }
        
        return [RACSignal empty];
    }];
    
    self.resetPwdRequest.requestInActiveBlock = ^(void) {
        @strongify(self);
        
        
        [self SEND_ACTION:self.resetPwdRequest];
        
        [AYProgressHud progressHudLoadingRequest:self.resetPwdRequest showInView:nil detailString:@""];
    };
}

- (void)handleActionMsg:(Request *)msg
{
    [super handleActionMsg:msg];
}

@end

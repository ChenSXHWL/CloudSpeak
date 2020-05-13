//
//  RegisterVM.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/6.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "RegisterVM.h"

@implementation RegisterVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    
    self.registerRequest = [RegisterRequest Request];
    
    /* 设置密码 注册 */
    
    @weakify(self);
    RACSignal *getCodeSignal = [RACSignal combineLatest:@[RACObserve(self.registerRequest, password), RACObserve(self.registerRequest, confirmPassword)] reduce:^id(NSString *password, NSString *confirmPassword){
        
        return @(password.length && confirmPassword.length);
    }];
    
    self.registerCommand = [[RACCommand alloc] initWithEnabled:getCodeSignal signalBlock:^RACSignal *(id input) {
        @strongify(self);
        
        self.registerRequest.requestNeedActive = YES;
        
        return [RACSignal empty];
    }];
    
    self.registerRequest.requestInActiveBlock = ^(void) {
        @strongify(self);
        
        if (![self.registerRequest.password isEqualToString:self.registerRequest.confirmPassword]) return [AYProgressHud progressHudShowShortTimeMessage:@"密码不一致,请重新输入"];
        
        [self SEND_ACTION:self.registerRequest];
        
        [AYProgressHud progressHudLoadingRequest:self.registerRequest showInView:nil detailString:@""];
    };
}

@end

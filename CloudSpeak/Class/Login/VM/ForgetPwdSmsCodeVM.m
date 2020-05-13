//
//  ForgetPwdSmsCodeVM.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/6.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "ForgetPwdSmsCodeVM.h"

@implementation ForgetPwdSmsCodeVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    
    self.forgetPwdSmsCodeRequest = [ForgetPwdSmsCodeRequest Request];
    
    /*忘记密码 获取验证码 */
    
    @weakify(self);
    RACSignal *forgetPwdSmsCodeSignal = [RACSignal combineLatest:@[RACObserve(self.forgetPwdSmsCodeRequest, telNum)] reduce:^id(NSString *sms){
        
        return @(sms.length);
    }];
    
    self.forgetPwdSmsCodeCommond = [[RACCommand alloc] initWithEnabled:forgetPwdSmsCodeSignal signalBlock:^RACSignal *(id input) {
        @strongify(self);
        
        self.forgetPwdSmsCodeRequest.requestNeedActive = YES;
        
        return [RACSignal empty];
    }];
    
    self.forgetPwdSmsCodeRequest.requestInActiveBlock = ^(void) {
        @strongify(self);
        
        [self SEND_ACTION:self.forgetPwdSmsCodeRequest];
        
        [AYProgressHud progressHudLoadingRequest:self.forgetPwdSmsCodeRequest showInView:nil detailString:@""];
    };
    
    /*忘记密码 下一步 验证验证码 */
    
    self.checkPwdByFgSmsCodeRequest = [CheckPwdByFgSmsCodeRequest Request];
    
    RACSignal *checkPwdByFgSmsCodeSignal = [RACSignal combineLatest:@[RACObserve(self.checkPwdByFgSmsCodeRequest, telNum), RACObserve(self.checkPwdByFgSmsCodeRequest, smsCode)] reduce:^id(NSString *telNum, NSString *smsCode){
        
        return @(telNum.length && smsCode.length);
    }];
    
    self.checkPwdByFgSmsCodeCommond = [[RACCommand alloc] initWithEnabled:checkPwdByFgSmsCodeSignal signalBlock:^RACSignal *(id input) {
        @strongify(self);
        
        self.checkPwdByFgSmsCodeRequest.requestNeedActive = YES;
        
        return [RACSignal empty];
    }];
    
    self.checkPwdByFgSmsCodeRequest.requestInActiveBlock = ^(void) {
        @strongify(self);
        
        [self SEND_ACTION:self.checkPwdByFgSmsCodeRequest];
        
        [AYProgressHud progressHudLoadingRequest:self.checkPwdByFgSmsCodeRequest showInView:nil detailString:@""];
    };

}

@end

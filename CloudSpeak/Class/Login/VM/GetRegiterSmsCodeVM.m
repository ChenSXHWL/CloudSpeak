//
//  GetRegiterSmsCodeVM.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/5.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "GetRegiterSmsCodeVM.h"

@implementation GetRegiterSmsCodeVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    
    self.getRegisterSmsCodeRequest = [GetRegisterSmsCodeRequest Request];
    
    /* 获取验证码 */
    
    @weakify(self);
    RACSignal *getCodeSignal = [RACSignal combineLatest:@[RACObserve(self.getRegisterSmsCodeRequest, telNum)] reduce:^id(NSString *sms){
        
        return @(sms.length);
    }];
    
    self.getCodeCommond = [[RACCommand alloc] initWithEnabled:getCodeSignal signalBlock:^RACSignal *(id input) {
        @strongify(self);
        
        self.getRegisterSmsCodeRequest.requestNeedActive = YES;
        
        return [RACSignal empty];
    }];
    
    self.getRegisterSmsCodeRequest.requestInActiveBlock = ^(void) {
        @strongify(self);
        
        [self SEND_ACTION:self.getRegisterSmsCodeRequest];
        
        [AYProgressHud progressHudLoadingRequest:self.getRegisterSmsCodeRequest showInView:nil detailString:@""];
    };
    
    /* 下一步 验证验证码 */
    
    self.checkSmsCodeRequest = [CheckSmsCodeRequest Request];
    
    RACSignal *nextSignal = [RACSignal combineLatest:@[RACObserve(self.checkSmsCodeRequest, telNum), RACObserve(self.checkSmsCodeRequest, smsCode)] reduce:^id(NSString *telNum, NSString *smsCode){
        
        return @(telNum.length && smsCode.length);
    }];
    
    self.nextCommond = [[RACCommand alloc] initWithEnabled:nextSignal signalBlock:^RACSignal *(id input) {
        @strongify(self);
        
        self.checkSmsCodeRequest.requestNeedActive = YES;
        
        return [RACSignal empty];
    }];
    
    self.checkSmsCodeRequest.requestInActiveBlock = ^(void) {
        @strongify(self);
        
        [self SEND_ACTION:self.checkSmsCodeRequest];
        
        [AYProgressHud progressHudLoadingRequest:self.checkSmsCodeRequest showInView:nil detailString:@""];
    };
    
}

@end

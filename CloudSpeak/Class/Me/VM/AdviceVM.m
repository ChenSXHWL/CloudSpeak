//
//  AdviceVM.m
//  Linkhome
//
//  Created by 陈思祥 on 2017/9/28.
//  Copyright © 2017年 陈思祥. All rights reserved.
//

#import "AdviceVM.h"

@interface AdviceVM ()<ActionDelegate>
@end
@implementation AdviceVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    
    self.action.aDelegaete = self;
    
    self.adviceRequest = [AdviceRequest Request];
    
    @weakify(self);
    
    self.adviceRequest.requestInActiveBlock = ^(void) {
        @strongify(self);
//        self.adviceRequest.token = [LoginEntity shareManager].token;
//        self.adviceRequest.accountId = [LoginEntity shareManager].appUserId;

        [self SEND_ACTION:self.adviceRequest];
        
        [AYProgressHud progressHudLoadingRequest:self.adviceRequest showInView:nil detailString:@""];
    };
}

- (void)handleActionMsg:(Request *)msg
{
    
    [super handleActionMsg:msg];

    
    
    if (msg.state == RequestStateSuccess) {
        
//        [AYProgressHud progressHudShowShortTimeMessage:NSLocalizedString(@"意见提交成功", 意见提交成功)];

        
    }else if(msg.state == RequestStateError){
        
        NSLog(@"%@",msg);
//        [AYProgressHud progressHudShowShortTimeMessage:NSLocalizedString(@"意见提交失败", 意见提交失败)];

        
    }
}
@end

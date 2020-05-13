//
//  ComplaintsPhoneVM.m
//  CloudSpeak
//
//  Created by mac on 2018/10/10.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "ComplaintsPhoneVM.h"


@interface ComplaintsPhoneVM () <ActionDelegate>

@end

@implementation ComplaintsPhoneVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    self.action.aDelegaete = self;
    self.communityPhoneRequest = [CommunityPhoneRequest Request];
    @weakify(self);
    
    self.communityPhoneRequest.requestInActiveBlock = ^{
        @strongify(self);
        self.communityPhoneRequest.communityCode = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityCode"];
        [self SEND_ACTION:self.communityPhoneRequest];
        [AYProgressHud progressHudLoadingRequest:self.communityPhoneRequest showInView:nil detailString:@""];
    };
}

- (void)handleActionMsg:(Request *)msg
{
    [super handleActionMsg:msg];
    if (msg.state==RequestStateSuccess) {
    }
    
}
@end

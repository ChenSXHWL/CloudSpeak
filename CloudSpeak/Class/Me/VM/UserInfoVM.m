//
//  UserInfoVM.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/12.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "UserInfoVM.h"

@interface UserInfoVM () <ActionDelegate>

@end

@implementation UserInfoVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    
    if (![LoginEntity shareManager].communityList.count) return [AYProgressHud progressHudShowShortTimeMessage:@"暂无小区信息"];

    
    self.action.aDelegaete = self;
    
    [self.action useCache];
    
    self.userInfoRequest = [UserInfoRequest Request];
    self.userInfoRequest.appUserId = [LoginEntity shareManager].appUserId;

    @weakify(self);
    self.userInfoRequest.requestInActiveBlock = ^{
        @strongify(self);
        
//        self.userInfoRequest.httpHeaderFields = [NSMutableDictionary dictionaryWithObject:[LoginEntity shareManager].authorization forKey:@"authorization"];
        
        
        [self SEND_ACTION:self.userInfoRequest];
        
//        [AYProgressHud progressHudLoadingRequest:self.userInfoRequest showInView:nil detailString:@""];
        
    };
}

- (void)handleActionMsg:(Request *)msg
{
    [super handleActionMsg:msg];
    
    if (msg.state == RequestStateSuccess) {
        
        self.userInfoEntity = [[UserInfoEntity alloc] initWithDictionary:msg.output error:nil];
        
        [LoginEntity shareManager].sipMobile = self.userInfoEntity.sipMobile;
        
    }
}

@end

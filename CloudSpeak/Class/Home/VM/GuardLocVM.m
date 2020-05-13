//
//  GuardLocVM.m
//  CloudSpeak
//
//  Created by mac on 2018/6/25.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "GuardLocVM.h"


@interface GuardLocVM () <ActionDelegate>

@end

@implementation GuardLocVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    
    if (![LoginEntity shareManager].communityList.count) return [AYProgressHud progressHudShowShortTimeMessage:@"暂无小区信息"];
    
    
    self.action.aDelegaete = self;
    
    [self.action useCache];
    
    self.householdInfoRequest = [HouseholdInfoRequest Request];
    
    self.householdInfoRequest = [HouseholdInfoRequest Request];
    @weakify(self);
    self.householdInfoRequest.requestInActiveBlock = ^{
        @strongify(self);
        
        self.householdInfoRequest.appUserId = [LoginEntity shareManager].appUserId;
        
        self.householdInfoRequest.communityCode = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityCode"];
        
        [self SEND_ACTION:self.householdInfoRequest];
    };
    
}

- (void)handleActionMsg:(Request *)msg
{
    [super handleActionMsg:msg];
    
    if (msg.state == RequestStateSuccess) {
        self.houseArray = [HousehoIdInfoEntity arrayOfModelsFromDictionaries:msg.output[@"householdList"] error:nil];
    }
}
@end

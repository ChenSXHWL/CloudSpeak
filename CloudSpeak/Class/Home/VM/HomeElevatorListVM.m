//
//  HomeElevatorListVM.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/22.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "HomeElevatorListVM.h"

@interface HomeElevatorListVM () <ActionDelegate>

@end

@implementation HomeElevatorListVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    
    if (![LoginEntity shareManager].communityList.count) return [AYProgressHud progressHudShowShortTimeMessage:@"暂无小区信息"];
    
    self.action.aDelegaete = self;
    
    [self.action useCache];
    
    self.groupUnitRequest = [GroupUnitRequest Request];
    
    self.groupUnitRequest.appUserId = [LoginEntity shareManager].appUserId;
    
    self.groupUnitRequest.communityId = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityId"];
    
    [self SEND_ACTION:self.groupUnitRequest];
    
    [AYProgressHud progressHudLoadingRequest:self.groupUnitRequest showInView:nil detailString:@""];
    
}
- (void)handleActionMsg:(Request *)msg
{
    [super handleActionMsg:msg];
    
    if (msg.state == RequestStateSuccess) {
        self.groupUnitKeys = [GroupUnitEntity arrayOfModelsFromDictionaries:msg.output[@"houseList"] error:nil];
    }
}
@end

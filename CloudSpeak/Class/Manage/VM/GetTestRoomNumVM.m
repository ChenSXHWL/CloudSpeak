//
//  GetTestRoomNumVM.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/26.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "GetTestRoomNumVM.h"

@implementation GetTestRoomNumVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    
    if (![LoginEntity shareManager].communityList.count) return [AYProgressHud progressHudShowShortTimeMessage:@"暂无小区信息"];

    
    self.getTestRoomNumRequest = [GetTestRoomNumRequest Request];
    
    self.getTestRoomNumRequest.communityCode = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityCode"];
    
    [self SEND_IQ_ACTION:self.getTestRoomNumRequest];
    
    [AYProgressHud progressHudLoadingRequest:self.getTestRoomNumRequest showInView:nil detailString:@""];
}

- (void)handleActionMsg:(Request *)msg
{
    [super handleActionMsg:msg];
    
}

@end

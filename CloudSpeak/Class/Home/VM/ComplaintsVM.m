//
//  ComplaintsVM.m
//  CloudSpeak
//
//  Created by mac on 2018/9/7.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "ComplaintsVM.h"

@interface ComplaintsVM () <ActionDelegate>

@end
@implementation ComplaintsVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    self.action.aDelegaete = self;
    self.reportComplaintsRequest = [ReportComplaintsRequest Request];
    @weakify(self);
    self.reportComplaintsRequest.requestInActiveBlock = ^{
        @strongify(self);
        
        self.reportComplaintsRequest.communityId = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityId"];
        self.reportComplaintsRequest.appUserId = [LoginEntity shareManager].appUserId;
        
        [self SEND_ACTION:self.reportComplaintsRequest];
    };
    
    self.historyComplaintsRequest = [HistoryComplaintsRequest Request];
    self.historyComplaintsRequest.requestInActiveBlock = ^{
        @strongify(self);
        
        self.historyComplaintsRequest.communityId = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityId"];
        self.historyComplaintsRequest.appUserId = [LoginEntity shareManager].appUserId;
        
        [self SEND_ACTION:self.historyComplaintsRequest];
    };
}
- (void)handleActionMsg:(Request *)msg
{
    [super handleActionMsg:msg];
    if (msg.state==RequestStateSuccess) {
        if (msg == self.historyComplaintsRequest) {
            self.complaintList = [HistoryComplaintsEntity arrayOfModelsFromDictionaries:msg.output[@"propertyComplainList"] error:nil];
        }else{
            self.report = @"YES";
        }
        
    }
}
@end

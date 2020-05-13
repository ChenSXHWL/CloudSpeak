//
//  CommuntityServiceVM.m
//  CloudSpeak
//
//  Created by mac on 2018/9/13.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "CommuntityServiceVM.h"
@interface CommuntityServiceVM () <ActionDelegate>

@end
@implementation CommuntityServiceVM
- (void)loadSceneModel
{
    [super loadSceneModel];
    self.action.aDelegaete = self;
    self.obtainComplaintsTypeRequest = [ObtainComplaintsTypeRequest Request];
    @weakify(self);

    self.obtainComplaintsTypeRequest.requestInActiveBlock = ^{
        @strongify(self);
        self.obtainComplaintsTypeRequest.communityCode = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityCode"];
        self.obtainComplaintsTypeRequest.appUserId = [LoginEntity shareManager].appUserId;
        [self SEND_ACTION:self.obtainComplaintsTypeRequest];
        [AYProgressHud progressHudLoadingRequest:self.obtainComplaintsTypeRequest showInView:nil detailString:@""];
    };
    
    self.repairTypeListRequest = [RepairTypeListRequest Request];
    
    self.repairTypeListRequest.requestInActiveBlock = ^{
        @strongify(self);
        self.repairTypeListRequest.communityCode = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityCode"];
        self.repairTypeListRequest.appUserId = [LoginEntity shareManager].appUserId;
        [self SEND_ACTION:self.repairTypeListRequest];
        [AYProgressHud progressHudLoadingRequest:self.repairTypeListRequest showInView:nil detailString:@""];
    };
}
- (void)handleActionMsg:(Request *)msg
{
    [super handleActionMsg:msg];
    if (msg.state==RequestStateSuccess) {
        if (msg==self.obtainComplaintsTypeRequest) {
            self.complainTypeList = msg.output[@"complainTypeList"];
            self.complainStatusList = msg.output[@"complainStatusList"];
        }else{
            self.repairTypeList = msg.output[@"repairTypeList"];
            self.repairStatusList = msg.output[@"repairStatusList"];
        }
        
    }
}
@end

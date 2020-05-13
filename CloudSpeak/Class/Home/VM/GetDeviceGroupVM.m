//
//  GetDeviceGroupVM.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "GetDeviceGroupVM.h"

@interface GetDeviceGroupVM () <ActionDelegate>

@end

@implementation GetDeviceGroupVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    
    if (![LoginEntity shareManager].communityList.count) return [AYProgressHud progressHudShowShortTimeMessage:@"暂无小区信息"];
    
    self.action.aDelegaete = self;
    
    [self.action useCache];
    
    self.getDeviceGroupRequest = [GetDeviceGroupRequest Request];
    
    self.getDeviceGroupRequest.householdId = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"householdId"];
//    self.getDeviceGroupRequest.includePublic = @"2";
    self.getDeviceGroupRequest.appUserId = [LoginEntity shareManager].appUserId;
    self.getDeviceGroupRequest.communityCode = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityCode"];
    [self SEND_IQ_ACTION:self.getDeviceGroupRequest];
    
    [AYProgressHud progressHudLoadingRequest:self.getDeviceGroupRequest showInView:nil detailString:@""];
    
}

- (void)handleActionMsg:(Request *)msg
{
    [super handleActionMsg:msg];
    
    if (msg.state == RequestStateSuccess) {
        NSMutableArray *muta =  [GetDeviceGroupEntity arrayOfModelsFromDictionaries:msg.output[@"deviceGroups"] error:nil];
        NSMutableArray *array = [NSMutableArray new];
        GetDeviceGroupEntity *model = [GetDeviceGroupEntity new];
        model.deviceGroupName = @"公共权限组";
        model.deviceGroupType = @"2";
        model.deviceGroupId = @"0";
        [array addObject:model];
        [array addObjectsFromArray:muta];
        self.getDeviceGroups  = array;
        
    }else if(msg.state == RequestStateError){
        NSMutableArray *array = [NSMutableArray new];

        GetDeviceGroupEntity *model = [GetDeviceGroupEntity new];
        model.deviceGroupName = @"公共权限组";
        model.deviceGroupType = @"2";
        model.deviceGroupId = @"0";
        [array addObject:model];
        
        self.getDeviceGroups  = array;

    }
}

@end

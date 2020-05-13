//
//  WarrantyVM.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/24.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "WarrantyVM.h"

@interface WarrantyVM () <ActionDelegate>

@end

@implementation WarrantyVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    
    if (![LoginEntity shareManager].communityList.count) return [AYProgressHud progressHudShowShortTimeMessage:@"暂无小区信息"];
    
    
    self.action.aDelegaete = self;
    
    self.deviceRepairRequest = [DeviceRepairRequest Request];
    @weakify(self);
    self.deviceRepairRequest.requestInActiveBlock = ^{
        @strongify(self);
        self.isSuccess = NO;
        
        self.deviceRepairRequest.communityId = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityId"];
        self.deviceRepairRequest.appUserId = [LoginEntity shareManager].appUserId;
        
        [self SEND_ACTION:self.deviceRepairRequest];
        [AYProgressHud progressHudLoadingRequest:self.deviceRepairRequest showInView:nil detailString:@""];
    };
    
    
    self.communityInfoRequest = [HouseInfoRequest Request];
    
    self.communityInfoRequest.householdId = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"householdId"];
//    [self SEND_ACTION:self.communityInfoRequest];
//    [AYProgressHud progressHudLoadingRequest:self.communityInfoRequest showInView:nil detailString:@""];
    self.communityInfoRequest.requestInActiveBlock = ^{
        @strongify(self);
        
        
        
        
        [self SEND_ACTION:self.communityInfoRequest];
        [AYProgressHud progressHudLoadingRequest:self.communityInfoRequest showInView:nil detailString:@""];
    };
    
    
    self.deviceListRequest = [DeviceListRequest Request];
    
    self.deviceListRequest.communityCode = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityCode"];
    self.deviceListRequest.requestInActiveBlock = ^{
        @strongify(self);
        [self SEND_ACTION:self.deviceListRequest];
        [AYProgressHud progressHudLoadingRequest:self.deviceListRequest showInView:nil detailString:@""];
    };

    self.deviceInfoRequest = [DeviceDetailRequest Request];
//    self.deviceInfoRequest.appUserId = [LoginEntity shareManager].appUserId;
    self.deviceInfoRequest.communityCode = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityCode"];
    self.deviceInfoRequest.requestInActiveBlock = ^{
        @strongify(self);
        self.deviceInfo = NO;
        [self SEND_ACTION:self.deviceInfoRequest];
        [AYProgressHud progressHudLoadingRequest:self.deviceInfoRequest showInView:nil detailString:@""];
    };
}

- (void)handleActionMsg:(Request *)msg
{
    [super handleActionMsg:msg];
    if (msg.state == RequestStateSuccess) {
        if (msg==self.deviceRepairRequest) {
            self.isSuccess = YES;
        }else if(msg==self.communityInfoRequest){
            
            
            if (self.communityInfoRequest.buildingId==nil) {
                self.buildingList = msg.output[@"buildingList"];
            }else if(self.communityInfoRequest.unitId==nil){
                self.unitList = msg.output[@"unitList"];
            }else{
                self.roomList = msg.output[@"roomList"];
            }
            

        }else if (msg==self.deviceInfoRequest){
            self.deviceInfo = YES;
        }else{
           
            self.deviceList = msg.output[@"deviceList"];
            
        }
        
    }
}
@end

//
//  HomeVM.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/24.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "HomeVM.h"

@interface HomeVM () <ActionDelegate>

@end

@implementation HomeVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    
    if (![LoginEntity shareManager].communityList.count) return [AYProgressHud progressHudShowShortTimeMessage:@"暂无小区信息"];
    
    self.action.aDelegaete = self;
    
    [self.action useCache];
    
    self.propertyNnoticeListRequest = [PropertyNnoticeListRequest Request];
    self.propertyNnoticeListRequest.appUserId = [LoginEntity shareManager].appUserId;
    self.propertyNnoticeListRequest.noticeType = @"0";
    self.propertyNnoticeListRequest.pageIndex = @"0";
    self.propertyNnoticeListRequest.pageSize = @"10";
    @weakify(self);
    self.propertyNnoticeListRequest.requestInActiveBlock = ^(void) {
        @strongify(self);
        
        [self SEND_IQ_ACTION:self.propertyNnoticeListRequest];
//        [AYProgressHud progressHudLoadingRequest:self.propertyNnoticeListRequest showInView:nil detailString:@""];

    };
    
    self.versionUpRequest = [VersionUpRequest Request];
    self.versionUpRequest.appUserId = [LoginEntity shareManager].appUserId;
    [self SEND_ACTION:self.versionUpRequest];
//    [AYProgressHud progressHudLoadingRequest:self.versionUpRequest showInView:nil detailString:@""];
    
    self.loginRequest = [LoginRequest Request];
    self.loginRequest.password = [LoginEntity shareManager].password;
    self.loginRequest.loginName = [LoginEntity shareManager].phone;
   
    self.loginRequest.requestInActiveBlock = ^(void) {
        @strongify(self);
        if ([JPUSHService registrationID]) {
            
            self.loginRequest.registrationId = [JPUSHService registrationID];
            
        }
        [self SEND_ACTION:self.loginRequest];
        
//        [AYProgressHud progressHudLoadingRequest:self.loginRequest showInView:nil detailString:@""];
        
    };

    self.deviceUnlockRequest = [DeviceUnlockRequest Request];
    
    self.deviceUnlockRequest.requestInActiveBlock = ^{
        @strongify(self);
        
        
        [self SEND_ACTION:self.deviceUnlockRequest];
    };
    
    self.authorityRequest = [AuthorityRequest Request];
    
    self.authorityRequest.requestInActiveBlock = ^{
        @strongify(self);
        self.authorityRequest.appUserId = [LoginEntity shareManager].appUserId;
        self.authorityRequest.communityId = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityId"];

        [self SEND_ACTION:self.authorityRequest];
    };
    
    self.advertisingListRequest = [AdvertisingListRequest Request];
    
    self.advertisingListRequest.requestInActiveBlock = ^{
        @strongify(self);
        
        self.advertisingListRequest.communityCode = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityCode"];
        [self SEND_ACTION:self.advertisingListRequest];
    };
}
- (void)handleActionMsg:(Request *)msg
{
    [super handleActionMsg:msg];
    
    if (msg.state == RequestStateSuccess) {
        if (msg == self.propertyNnoticeListRequest) {
            self.propertyNnoticeListKeys = [PropertyNnoticeListEntity arrayOfModelsFromDictionaries:msg.output[@"noticeList"] error:nil];
        }else if (msg==self.loginRequest){
            LoginEntity *entity = [[LoginEntity alloc] initWithDictionary:msg.output error:nil];
            
            entity.page = @(0);
            
            entity.phone = self.loginRequest.loginName;
            
            entity.password = self.loginRequest.password;
            
            entity.scheme = [LoginEntity shareManager].scheme;
            
            entity.url = [LoginEntity shareManager].url;
            
            [LoginManage saveEntity:entity];
            
//            [[LoginEntity shareManager] modelOfDictionary];

        }else if (msg==self.authorityRequest){
            self.ladderControlsSwitch = msg.output[@"ladderControlsSwitch"];
        }else if (msg == self.advertisingListRequest){
            self.adverArray =  [AdvertisingListEntity arrayOfModelsFromDictionaries:msg.output[@"data"][@"adList"] error:nil];

        }
        else{
        }
    }
}
@end

//
//  GetConfigVM.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/12.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "GetConfigVM.h"
#import "AYAnalysisXMLData.h"

@interface GetConfigVM () <ActionDelegate>

@end

@implementation GetConfigVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    
    if (![LoginEntity shareManager].communityList.count) return [AYProgressHud progressHudShowShortTimeMessage:@"暂无小区信息"];
    
    self.action.aDelegaete = self;
    
    self.getConfigRequest = [GetConfigRequest Request];
    
    @weakify(self);
    self.getConfigRequest.requestInActiveBlock = ^{
        @strongify(self);
                
        [self SEND_IQ_ACTION:self.getConfigRequest];
        
        [AYProgressHud progressHudLoadingRequest:self.getConfigRequest showInView:nil detailString:@""];
    };
    
    self.communityInfoRequest = [CommunityInfoRequest Request];
    
    self.communityInfoRequest.requestInActiveBlock = ^{
        @strongify(self);
        
        [self SEND_IQ_ACTION:self.communityInfoRequest];
    };
    
}

- (void)handleActionMsg:(Request *)msg
{
    [super handleActionMsg:msg];
    
    if (msg.state == RequestStateSuccess) {
        
        if (msg == self.getConfigRequest) {
            
            NSDictionary *dict = [AYAnalysisXMLData analysisXMLWithSetConfig11:msg.output[@"sys"]];
            
            self.getConfigEntity = [[GetConfigEntity alloc] initWithDictionary:dict error:nil];
            
        } else {
            
            self.communityInfoEntity = [[CommunityInfoEntity alloc] initWithDictionary:msg.output error:nil];
            
        }

    }
    
}

@end

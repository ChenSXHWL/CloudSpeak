//
//  OpenHistoryVM.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "OpenHistoryVM.h"

@interface OpenHistoryVM () <ActionDelegate>

@end

@implementation OpenHistoryVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    
    if (![LoginEntity shareManager].communityList.count) return [AYProgressHud progressHudShowShortTimeMessage:@"暂无小区信息"];

    
    self.action.aDelegaete = self;
    
    [self.action useCache];
    
    self.openHistoryRequest = [OpenHistoryRequest Request];
    
    @weakify(self);
    self.openHistoryRequest.requestInActiveBlock = ^(void) {
        @strongify(self);
        [self SEND_IQ_ACTION:self.openHistoryRequest];
        
        [AYProgressHud progressHudLoadingRequest:self.openHistoryRequest showInView:nil detailString:@""];

    };
    
}

- (void)handleActionMsg:(Request *)msg
{
    [super handleActionMsg:msg];
    
    if (msg.state == RequestStateSuccess) {
        
        if (self.openHistoryRequest.pageIndex.integerValue == 0) {
            
            self.openHistorys = [OpenHistoryEntity arrayOfModelsFromDictionaries:msg.output[@"list"] error:nil];
            
        } else {
            
            [self.openHistorys addObjectsFromArray:[OpenHistoryEntity arrayOfModelsFromDictionaries:msg.output[@"list"] error:nil]];
            self.openHistorys = self.openHistorys;
        }
        
    }
}

@end

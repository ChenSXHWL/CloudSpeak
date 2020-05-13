//
//  ConfigDevGroupVM.m
//  CloudSpeak
//
//  Created by mac on 2018/9/20.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "ConfigDevGroupVM.h"
@interface ConfigDevGroupVM () <ActionDelegate>

@end

@implementation ConfigDevGroupVM

- (void)loadSceneModel
{
    [super loadSceneModel];
    
    self.action.aDelegaete = self;
    
    self.obtainDevGroupRequest = [ObtainDevGroupRequest Request];
    @weakify(self);
    self.obtainDevGroupRequest.requestInActiveBlock = ^{
        @strongify(self);
        
                
        [self SEND_ACTION:self.obtainDevGroupRequest];
        [AYProgressHud progressHudLoadingRequest:self.obtainDevGroupRequest showInView:nil detailString:@""];

    };
    
    self.editorDevGroupRequest = [EditorDevGroupRequest Request];
    self.editorDevGroupRequest.requestInActiveBlock = ^{
        @strongify(self);
        
        [self SEND_ACTION:self.editorDevGroupRequest];
        [AYProgressHud progressHudLoadingRequest:self.editorDevGroupRequest showInView:nil detailString:@""];
        
    };
    
}
- (void)handleActionMsg:(Request *)msg
{
    [super handleActionMsg:msg];
    if (msg.state == RequestStateSuccess) {
        if (msg==self.obtainDevGroupRequest) {
            self.dataArray = [ObtainDevGroupEntity arrayOfModelsFromDictionaries:msg.output[@"deviceGroupList"] error:nil];

        }else{
            self.isEditor = @"yes";
        }
    }
    
}
@end

//
//  OpenHistoryRequest.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "OpenHistoryRequest.h"

@implementation OpenHistoryRequest

- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/api/common/openHistory";
    
    self.appUserId = [LoginEntity shareManager].appUserId;
    
    self.pageIndex = @"0";
    
    self.pageSize = @"10";
}

@end

//
//  OpenRecordRequest.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/10.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "OpenRecordRequest.h"

@implementation OpenRecordRequest

- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/api/device/openRecord";
    
    self.pageIndex = @"0";
    
    self.pageSize = @"10";
}

@end

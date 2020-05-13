//
//  CallForwardingRequest.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "CallForwardingRequest.h"

@implementation CallForwardingRequest

- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/api/common/callForwarding";
    
    self.appUserId = [LoginEntity shareManager].appUserId;
}

@end

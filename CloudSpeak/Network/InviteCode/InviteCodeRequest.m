//
//  InviteCodeRequest.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/10.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "InviteCodeRequest.h"

@implementation InviteCodeRequest

- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/api/common/inviteCode";
    
    self.appUserId = @([LoginEntity shareManager].appUserId.intValue);
    
    self.dateTag = @(0);
    
    self.times = @(0);
    
}

@end

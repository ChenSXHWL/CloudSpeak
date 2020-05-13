//
//  CallOpenRequest.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "CallOpenRequest.h"

@implementation CallOpenRequest

- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/api/device/callOpen";
    
    self.interactiveType = @"4";
    
    self.openStatus = @"0";
}

@end

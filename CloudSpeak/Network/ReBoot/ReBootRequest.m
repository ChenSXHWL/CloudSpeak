//
//  ReBootRequest.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/15.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "ReBootRequest.h"

@implementation ReBootRequest

- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/api/device/reboot";
    
}

@end

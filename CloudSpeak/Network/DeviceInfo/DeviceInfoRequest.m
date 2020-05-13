//
//  DeviceInfoRequest.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/20.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "DeviceInfoRequest.h"

@implementation DeviceInfoRequest

- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/api/device/info";
}

@end

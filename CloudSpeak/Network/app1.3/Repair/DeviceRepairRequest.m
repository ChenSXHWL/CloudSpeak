//
//  DeviceRepairRequest.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/24.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "DeviceRepairRequest.h"

@implementation DeviceRepairRequest
- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/api/property/reportRepairMsg";
    
}
@end

//
//  PropertyRepairRequest.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/24.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "PropertyRepairRequest.h"

@implementation PropertyRepairRequest
- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/api/property/repair";
    
}
@end

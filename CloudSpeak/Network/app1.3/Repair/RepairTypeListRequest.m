//
//  RepairTypeListRequest.m
//  CloudSpeak
//
//  Created by mac on 2018/10/9.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "RepairTypeListRequest.h"

@implementation RepairTypeListRequest
- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/api/property/repairType";
    
}
@end

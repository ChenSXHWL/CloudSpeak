//
//  AdvertisingListRequest.m
//  CloudSpeak
//
//  Created by mac on 2018/10/8.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "AdvertisingListRequest.h"

@implementation AdvertisingListRequest
- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/api/ad/adPush";
    self.pageSize = @"5";
    self.pageIndex = @"0";

}
@end

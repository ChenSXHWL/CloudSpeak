//
//  CommunityInfoRequest.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "HouseInfoRequest.h"

@implementation HouseInfoRequest

- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/api/common/houseInfo";
    
}

@end

//
//  InvalidCodeRequest.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "InvalidCodeHighRequest.h"

@implementation InvalidCodeHighRequest

- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/api/common/inviteCode/highGrade";
    
}

@end
//
//  CheckAuthorizationRequest.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/6/26.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "CheckAuthorizationRequest.h"

@implementation CheckAuthorizationRequest

- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/base/validate";
}

@end

//
//  AdviceRequest.m
//  Linkhome
//
//  Created by 陈思祥 on 2017/9/28.
//  Copyright © 2017年 陈思祥. All rights reserved.
//

#import "AdviceRequest.h"

@implementation AdviceRequest
- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/api/user/feedback";
    
}
@end

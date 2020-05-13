//
//  TakePhotoRequest.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2018/2/10.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "TakePhotoRequest.h"

@implementation TakePhotoRequest
- (void)loadRequest
{
    [super loadRequest];
    
    self.PATH = @"/auth/api/device/takePhoto";
    
}
@end

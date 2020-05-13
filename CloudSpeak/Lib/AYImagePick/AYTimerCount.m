//
//  AYTimerCount.m
//  CloudSpeak
//
//  Created by DnakeWCZ on 17/5/12.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "AYTimerCount.h"
#include <ifaddrs.h>

#include <arpa/inet.h>

#include <net/if.h>

@interface AYTimerCount ()
{
    NSTimer *sipTimer;
    
    int sipCount;
}

@end

@implementation AYTimerCount

+ (AYTimerCount *)timerCount
{
    static AYTimerCount *timerCount = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        timerCount = [[self alloc] init];
    });
    return timerCount;
}

- (AYTimerCount *)init
{
    self = [super init];
    
    if (self) {
        
//        sipCount = 0;
//        
//        sipTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reRegistionSip) userInfo:nil repeats:YES];
        
    }
    
    return self;
}

- (void)reRegistionSip
{
    sipCount ++;
    
    if (sipCount == 120) {
        
        //注册SIP服务
        [[AYCloudSpeakApi cloudSpeakApi] setSipConfigWithSipServer:SIP_SERVER sipAccout:[LoginEntity shareManager].sipAccount sipPassword:[LoginEntity shareManager].sipPassword];
        
        sipCount = 0;
        
    }
}

- (void)clearTimerCount
{
    [sipTimer invalidate];
    
    sipTimer = nil;
}

- (void)startTime
{
    [sipTimer setFireDate:[NSDate distantPast]];
}

- (void)stopTime
{
    [sipTimer setFireDate:[NSDate distantFuture]];
}

- (void)setTimeZero
{
    sipCount = 0;
}


@end

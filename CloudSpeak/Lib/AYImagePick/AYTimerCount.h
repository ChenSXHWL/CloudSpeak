//
//  AYTimerCount.h
//  CloudSpeak
//
//  Created by DnakeWCZ on 17/5/12.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AYTimerCount : NSObject

+ (AYTimerCount *)timerCount;

- (void)clearTimerCount;

- (void)startTime;

- (void)stopTime;

- (void)setTimeZero;

@property (copy, nonatomic) NSString *imageUrl;

@end

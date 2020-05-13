//
//  DeviceTestTView.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/12.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "AYCustomTView.h"

typedef void(^DeviceTestVCBlock)(NSString *);

@interface DeviceTestTView : AYCustomTView

@property (copy, nonatomic) NSString *sipContent;

@property (strong, nonatomic) DeviceTestVCBlock deviceTestVCBlock;

@property (copy, nonatomic) NSString *talkTime;

@end

//
//  OpenTimerView.h
//  CloudSpeak
//
//  Created by DnakeWCZ on 17/5/10.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MonitorTimePopBlock)(void);

@interface OpenTimerView : UIView

@property (strong, nonatomic) MonitorTimePopBlock block;

- (void)clearTime;

- (void)setupVedioListen;

@end

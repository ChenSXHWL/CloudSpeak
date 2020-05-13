//
//  HomeGuardLocMonitorView.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/4/1.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeFunctionButton.h"

typedef void(^HomeGuardLocMonitorViewPopBlock)(void);

typedef void(^HomeGuardLocMonitorViewLockBlock)(void);

typedef void(^HomeGuardLocMonitorViewOpenViewBlock)(void);

@interface HomeGuardLocMonitorView : UIView

@property (strong, nonatomic) HomeGuardLocMonitorViewPopBlock popBlock;

@property (strong, nonatomic) HomeGuardLocMonitorViewLockBlock lockBlock;

@property (strong, nonatomic) HomeGuardLocMonitorViewOpenViewBlock openViewBlock;

@property (strong, nonatomic) HomeFunctionButton *homeUnLoadButton;

@property (strong, nonatomic) UILabel *timeLabel;

- (void)clearTime;

- (void)setupVedioListen;

@end

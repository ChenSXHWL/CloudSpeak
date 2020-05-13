//
//  OpenView.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/22.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CallOpenVM.h"

@interface OpenView : UIView

@property (strong, nonatomic) CallOpenVM *callOpenVM;

+ (instancetype)setupOpenView;
@end

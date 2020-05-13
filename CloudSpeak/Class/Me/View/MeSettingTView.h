//
//  MeSettingTView.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/14.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "AYCustomTView.h"

typedef void(^MeSettingCompletionBlock)(void);

@interface MeSettingTView : AYCustomTView

@property (strong, nonatomic) MeSettingCompletionBlock meSettingBlock;

@property (strong, nonatomic) UISlider *micSlider;

@property (assign, nonatomic) BOOL isMic;
@end

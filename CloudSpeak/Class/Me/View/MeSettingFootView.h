//
//  MeSettingFootView.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/14.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MeSettingFootViewLoginOutBlock)(void);

@interface MeSettingFootView : UIView

@property (strong, nonatomic) MeSettingFootViewLoginOutBlock loginOutBlock;

@end

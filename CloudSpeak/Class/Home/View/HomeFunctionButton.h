//
//  HomeFunctionButton.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/14.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeFunctionButton : UIButton

@property (assign, nonatomic)BOOL isEnble;

+ (instancetype)setupHomeFunctionButtonWithImageString:(NSString *)string title:(NSString *)title;

@end

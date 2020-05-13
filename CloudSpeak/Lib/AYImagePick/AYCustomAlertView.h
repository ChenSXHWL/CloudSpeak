//
//  AYCustomAlertView.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/20.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AYCustomAlertViewBlock)(NSDictionary *);

@interface AYCustomAlertView : UIView

+ (instancetype)setupAYCustomAlertView:(NSString *)title;

@property (strong, nonatomic) AYCustomAlertViewBlock customAlertViewBlock;

@end

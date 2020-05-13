//
//  HomeMoreTView.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/10.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HomeMoreTViewBlock)(NSDictionary *);

@interface HomeMoreTView : AYCustomTView

+ (instancetype)setupHomeMoreTView:(NSArray *)array;

@property (strong, nonatomic) HomeMoreTViewBlock homeMoreTViewBlock;

@end

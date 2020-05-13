//
//  CustomBlueButton.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/24.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "CustomBlueButton.h"

@interface CustomBlueButton ()

@property (copy, nonatomic) NSString *title;

@end

@implementation CustomBlueButton

+ (instancetype)setupCustomBlueButton:(NSString *)title
{
    CustomBlueButton *customBlueButton = [CustomBlueButton buttonWithType:UIButtonTypeSystem];
    
    customBlueButton.title = title;
    
    return customBlueButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setBackgroundColor:TextBlueColor];
        
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    [self setTitle:title forState:UIControlStateNormal];
    
    self.titleLabel.font = [UIFont systemFontOfSize:21];
}

@end

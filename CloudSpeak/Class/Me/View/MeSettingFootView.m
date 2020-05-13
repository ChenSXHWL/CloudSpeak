//
//  MeSettingFootView.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/14.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "MeSettingFootView.h"

@interface MeSettingFootView ()

@property (strong, nonatomic) UIButton *loginOutButton;

@end

@implementation MeSettingFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIButton *loginOutButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [loginOutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [loginOutButton setTitleColor:TextBlueColor forState:UIControlStateNormal];
        [self addSubview:loginOutButton];
        self.loginOutButton = loginOutButton;
        [loginOutButton addTarget:self action:@selector(loginOutButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.loginOutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
}

- (void)loginOutButtonMethod
{
    self.loginOutBlock();
}

@end

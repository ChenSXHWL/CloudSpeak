//
//  ManageSettingTVFootView.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/30.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "ManageSettingTVFootView.h"

@interface ManageSettingTVFootView ()

@property (strong, nonatomic) UIButton *loginOutButton;

@end

@implementation ManageSettingTVFootView

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


@end

//
//  HomeMessageTVSHeadView.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/15.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "HomeMessageTVSHeadView.h"
#import "AYTimeSetting.h"

@interface HomeMessageTVSHeadView ()

@property (strong, nonatomic) UIImageView *iconImageView;

@property (strong, nonatomic) UILabel *timeLabel;

@property (strong, nonatomic) UIView *topView;

@property (strong, nonatomic) UIView *bottomView;

@end

@implementation HomeMessageTVSHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIImageView *iconImageView = [UIImageView new];
        iconImageView.image = [UIImage imageNamed:@"message_point"];
        [self addSubview:iconImageView];
        self.iconImageView = iconImageView;
        
        UILabel *timeLabel = [UILabel new];
        timeLabel.text = @"今天";
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UIView *topView = [UIView new];
        topView.backgroundColor = TextShallowGaryColor;
        [self addSubview:topView];
        self.topView = topView;
        
        UIView *bottomView = [UIView new];
        bottomView.backgroundColor = TextShallowGaryColor;
        [self addSubview:bottomView];
        self.bottomView = bottomView;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(11);
        make.width.height.mas_equalTo(30);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImageView.mas_centerY);
        make.left.equalTo(self.iconImageView.mas_right).offset(16);
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.iconImageView.mas_centerX);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(-6);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(1);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.iconImageView.mas_centerX);
        make.bottom.equalTo(self.iconImageView.mas_top).offset(6);
        make.top.equalTo(self.mas_top);
        make.width.mas_equalTo(1);
    }];
    
}

- (void)setOpenRecordEntity:(OpenRecordEntity *)openRecordEntity
{
    _openRecordEntity = openRecordEntity;
    
    if ([openRecordEntity.openDay isEqualToString:[AYTimeSetting dateStringFromDateYMD:[NSDate date]]]) {
        
        self.timeLabel.text = @"今天";
        
        self.iconImageView.image = [UIImage imageNamed:@"message_point_in"];
        
    } else {
        
        self.timeLabel.text = openRecordEntity.openDay;
        
        self.iconImageView.image = [UIImage imageNamed:@"message_point"];
        
    }
    
}

- (void)setIsShowLine:(BOOL)isShowLine
{
    _isShowLine = isShowLine;
    
    if (isShowLine) {
        
        self.bottomView.hidden = NO;
        
    } else {
        
        self.bottomView.hidden = YES;
        
    }
}

@end

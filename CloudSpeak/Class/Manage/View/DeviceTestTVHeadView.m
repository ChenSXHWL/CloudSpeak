//
//  DeviceTestTVHeadView.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/12.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "DeviceTestTVHeadView.h"

@interface DeviceTestTVHeadView ()

@property (strong, nonatomic) UILabel *roomNumLabel;

@property (strong, nonatomic) UILabel *codeLabel;

@property (strong, nonatomic) UILabel *timeLabel;

@end

@implementation DeviceTestTVHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *roomNumLabel = [UILabel new];
        roomNumLabel.text = @"临时房号";
        roomNumLabel.textColor = TextMainBlackColor;
        [self addSubview:roomNumLabel];
        self.roomNumLabel = roomNumLabel;
        
        UILabel *codeLabel = [UILabel new];
        codeLabel.text = @"0000";
        codeLabel.font = [UIFont systemFontOfSize:60];
        codeLabel.textColor = TextBlueColor;
        [self addSubview:codeLabel];
        self.codeLabel = codeLabel;
        
        UILabel *timeLabel = [UILabel new];
        timeLabel.text = @"15min倒计时";
        timeLabel.font = [UIFont systemFontOfSize:13];
        timeLabel.textColor = TextDeepGaryColor;
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
    }];
    
    [self.roomNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.codeLabel.mas_top).offset(-20);
        make.centerX.equalTo(self.codeLabel.mas_centerX);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.codeLabel.mas_centerX);
    }];
    
    
}

- (void)setRoomNum:(NSString *)roomNum
{
    _roomNum = roomNum;
    
    self.codeLabel.text = roomNum;
}

@end

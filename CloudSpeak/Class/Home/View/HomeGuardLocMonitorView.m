//
//  HomeGuardLocMonitorView.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/4/1.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "HomeGuardLocMonitorView.h"

@interface HomeGuardLocMonitorView ()
{
    int minute;
    int second;
    NSTimer *addTime;
}

@property (strong, nonatomic) HomeFunctionButton *homePhotoButton;

@property (strong, nonatomic) HomeFunctionButton *homeEndButton;


@end

@implementation HomeGuardLocMonitorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupUI];
        
                
    }
    return self;
}

- (void)setupUI
{
    HomeFunctionButton *homePhotoButton = [HomeFunctionButton setupHomeFunctionButtonWithImageString:@"monitor_" title:@"拍照"];
    homePhotoButton.backgroundColor = [UIColor clearColor];
    [homePhotoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [homePhotoButton addTarget:self action:@selector(phoneImage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:homePhotoButton];
    self.homePhotoButton = homePhotoButton;
    
    HomeFunctionButton *homeUnLoadButton = [HomeFunctionButton setupHomeFunctionButtonWithImageString:@"door_on" title:@"开锁"];
    homeUnLoadButton.backgroundColor = [UIColor clearColor];
    [homeUnLoadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [homeUnLoadButton addTarget:self action:@selector(openLockButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:homeUnLoadButton];
    self.homeUnLoadButton = homeUnLoadButton;
    
    HomeFunctionButton *homeEndButton = [HomeFunctionButton setupHomeFunctionButtonWithImageString:@"monitor_hangup" title:@"挂断"];
    homeEndButton.backgroundColor = [UIColor clearColor];
    [homeEndButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [homeEndButton addTarget:self action:@selector(endCall) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:homeEndButton];
    self.homeEndButton = homeEndButton;
    
    UILabel *timeLabel = [UILabel new];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont systemFontOfSize:19];
    timeLabel.text = @"00:00";
    timeLabel.textColor = TextDeepGaryColor;
    [self addSubview:timeLabel];
    self.timeLabel = timeLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.homePhotoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.width.equalTo(self.mas_width).multipliedBy(1/3.0);
        make.centerY.equalTo(self.mas_centerY).offset(20);
        make.height.equalTo(self.homePhotoButton.mas_width).multipliedBy(1.2);
    }];
    
    [self.homeUnLoadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(self.mas_width).multipliedBy(1/3.0);
        make.centerY.equalTo(self.mas_centerY).offset(20);
        make.height.equalTo(self.homeEndButton.mas_width).multipliedBy(1.2);
    }];
    
    [self.homeEndButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(0);
        make.width.equalTo(self.mas_width).multipliedBy(1/3.0);
        make.centerY.equalTo(self.mas_centerY).offset(20);
        make.height.equalTo(self.homeEndButton.mas_width).multipliedBy(1.2);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.homePhotoButton.mas_top);
    }];
}

- (void)phoneImage
{
    
    [[AYCloudSpeakApi cloudSpeakApi] videoSnapshot];
    
}
-(void)openLockButtonMethod{
    
    self.lockBlock();
    
}
- (void)endCall
{
    
    self.popBlock();
    
}

- (void)addTimeMetho
{
    
    second ++;
    
    if (minute < 10) {
        if (second < 10) {
            
            self.timeLabel.text = [NSString stringWithFormat:@"0%d:0%d",minute, second];
            
        } else {
            
            self.timeLabel.text = [NSString stringWithFormat:@"0%d:%d",minute, second];
            
            if (second == 59) {
                
                minute ++;
                
                second = -1;
                
            }
            
        }
        
    } else {
        
        if (second < 10) {
            
            self.timeLabel.text = [NSString stringWithFormat:@"%d:0%d",minute, second];
            
        } else {
            
            self.timeLabel.text = [NSString stringWithFormat:@"%d:%d",minute, second];
            
            if (second == 59) {
                
                minute ++;
                
                second = -1;
                
            }
            
            
            
        }
        
        
        
    }
    
    if ([self.timeLabel.text isEqualToString:@"01:30"]) {
        
        self.popBlock();
        
    }
    
}

- (void)setupVedioListen
{
        
    minute = 0;
    second = 0;
    
    addTime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(addTimeMetho) userInfo:nil repeats:YES];
    
}

- (void)clearTime
{
    [addTime invalidate];
    
    addTime = nil;
}

@end

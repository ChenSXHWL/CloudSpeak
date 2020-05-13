//
//  OpenTimerView.m
//  CloudSpeak
//
//  Created by DnakeWCZ on 17/5/10.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "OpenTimerView.h"
#import "BHBNetworkSpeed.h"

@interface OpenTimerView ()
{
    int minute;
    int second;
    NSTimer *addTime;
}

@property (strong, nonatomic) UILabel *timeLabel;

@end

@implementation OpenTimerView

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
    self.hidden = YES;
    
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
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
    }];
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
        
        self.block();
        
    }
    
}

- (void)setupVedioListen
{
    self.hidden = NO;
    
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

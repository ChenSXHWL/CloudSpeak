//
//  AYCustomSegmentView.m
//  ishanghome
//
//  Created by DNAKE_AY on 16/12/15.
//  Copyright © 2016年 DNAKE_AY. All rights reserved.
//

#import "AYCustomSegmentView.h"

#define customSegmentView_width self.frame.size.width
#define customSegmentView_height self.frame.size.height

@interface AYCustomSegmentView ()
@property (strong, nonatomic) NSArray *names;

@property (strong, nonatomic) UIView *singleView;

@end

@implementation AYCustomSegmentView

+ (instancetype)setupCustomSegmentViewWithFrame:(CGRect)frame names:(NSArray *)names
{
    AYCustomSegmentView *segmentView = [[self alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44) names:names];
    
    return segmentView;
}

- (instancetype)initWithFrame:(CGRect)frame names:(NSArray *)names
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupUINames:names];
        
    }
    return self;
}

- (void)setupUINames:(NSArray *)names
{
    self.backgroundColor = [UIColor whiteColor];
    
    [self setupSegmentViewNames:names];
    
}

- (void)setupSegmentViewNames:(NSArray *)names
{
    self.names = names;
    
    for (int i = 0; i < names.count; i ++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(customSegmentView_width / names.count * i, 0, customSegmentView_width / names.count, customSegmentView_height);
        [button setTitle:names[i] forState:UIControlStateNormal];
        button.tag = i + 10000;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:button];
        [button addTarget:self action:@selector(changeButtonTitleColor:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            
        } else {
            
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
        }
        
    }
    
    UIView *singleView = [[UIView alloc] initWithFrame:CGRectMake(customSegmentView_width / (4 * self.names.count), customSegmentView_height - 1, customSegmentView_width / (2 * self.names.count), 1)];
    singleView.backgroundColor = [UIColor orangeColor];
    [self addSubview:singleView];
    self.singleView = singleView;
    
}

- (void)changeButtonTitleColor:(UIButton *)sender
{
    
    for (int i = 0; i < self.names.count; i ++) {
        
        UIButton *button = (UIButton *)[self viewWithTag:i + 10000];
        
        if (button.tag == sender.tag) {
            
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            
        } else {
            
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
        }
        
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.singleView.frame = CGRectMake((sender.tag - 10000) * customSegmentView_width / self.names.count + customSegmentView_width / (4 * self.names.count), customSegmentView_height - 1, customSegmentView_width / (2 * self.names.count), 1);
        
    }];
    
    if ([_segmentViewDelegate respondsToSelector:@selector(customSegmentView:selectionStyle:)]) {
        
        [_segmentViewDelegate customSegmentView:self selectionStyle:(int)(sender.tag - 10000)];
        
    }
    
    
}

- (void)changeButtonTitleColorFromTag:(int)tag
{
    
    for (int i = 0; i < self.names.count; i ++) {
        
        UIButton *button = (UIButton *)[self viewWithTag:i + 10000];
        
        if (button.tag == tag) {
            
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            
        } else {
            
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
        }
        
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.singleView.frame = CGRectMake((tag - 10000) * customSegmentView_width / self.names.count + customSegmentView_width / (4 * self.names.count), customSegmentView_height - 1, customSegmentView_width / (2 * self.names.count), 1);
        
    }];
    
    if ([_segmentViewDelegate respondsToSelector:@selector(customSegmentView:selectionStyle:)]) {
        
        [_segmentViewDelegate customSegmentView:self selectionStyle:(int)(tag - 10000)];
        
    }
    
    
}


@end

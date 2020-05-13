//
//  AdvertHeadView.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/10.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "AdvertHeadView.h"

@interface AdvertHeadView()


@property (strong, nonatomic) UIButton *allButton;

@property (strong, nonatomic) UIButton *urgButton;

@property (strong, nonatomic) UIButton *noticeButton;

@property (strong, nonatomic) UIButton *activityButton;

@property (strong, nonatomic) UIButton *hintButton;

@property (strong, nonatomic) UIButton *newsButton;

@end

@implementation AdvertHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:25.0/255.0 green:25.0/255.0 blue:25.0/255.0 alpha:0.5];
        [self whenTapped:^{
            [self upHeadView];
            self.hidden = YES;
            
        }];
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI
{
    
    UIView *headView = [UIView new];
    headView.frame = CGRectMake(0, 64-140, SCREEN_WIDTH, 140);
    headView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:headView];
    self.headView = headView;
    
    UIButton *allButton = [UIButton buttonWithType:UIButtonTypeCustom];
    allButton.layer.cornerRadius = 4;
    allButton.layer.masksToBounds = YES;
//    allButton.layer.borderColor = [UIColor blackColor].CGColor;
    allButton.layer.borderWidth = 1;
    allButton.tag = 101;
    allButton.layer.borderColor = RGB(255, 202, 48).CGColor;
    [allButton setTitleColor:RGB(255, 202, 48) forState:UIControlStateNormal];
    [allButton setTitle:@"全部" forState:UIControlStateNormal];
//    [allButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [allButton addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:allButton];
    self.allButton = allButton;
    
    UIButton *urgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    urgButton.layer.cornerRadius = 4;
    urgButton.layer.masksToBounds = YES;
    urgButton.layer.borderColor = [UIColor blackColor].CGColor;
    urgButton.layer.borderWidth = 1;
    urgButton.tag = 102;
    [urgButton setTitle:@"紧急" forState:UIControlStateNormal];
    [urgButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [urgButton addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:urgButton];
    self.urgButton = urgButton;
    
    UIButton *noticeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    noticeButton.layer.cornerRadius = 4;
    noticeButton.layer.masksToBounds = YES;
    noticeButton.layer.borderColor = [UIColor blackColor].CGColor;
    noticeButton.layer.borderWidth = 1;
    noticeButton.tag = 103;
    [noticeButton setTitle:@"通知" forState:UIControlStateNormal];
    [noticeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [noticeButton addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:noticeButton];
    self.noticeButton = noticeButton;
    
    UIButton *activityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    activityButton.layer.cornerRadius = 4;
    activityButton.layer.masksToBounds = YES;
    activityButton.layer.borderColor = [UIColor blackColor].CGColor;
    activityButton.layer.borderWidth = 1;
    activityButton.tag = 104;
    [activityButton setTitle:@"活动" forState:UIControlStateNormal];
    [activityButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [activityButton addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:activityButton];
    self.activityButton = activityButton;
    
    UIButton *hintButton = [UIButton buttonWithType:UIButtonTypeCustom];
    hintButton.layer.cornerRadius = 4;
    hintButton.layer.masksToBounds = YES;
    hintButton.layer.borderColor = [UIColor blackColor].CGColor;
    hintButton.layer.borderWidth = 1;
    hintButton.tag = 105;
    [hintButton setTitle:@"提示" forState:UIControlStateNormal];
    [hintButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [hintButton addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:hintButton];
    self.hintButton = hintButton;
    
    UIButton *newsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    newsButton.layer.cornerRadius = 4;
    newsButton.layer.masksToBounds = YES;
    newsButton.layer.borderColor = [UIColor blackColor].CGColor;
    newsButton.layer.borderWidth = 1;
    newsButton.tag = 106;
    [newsButton setTitle:@"新闻" forState:UIControlStateNormal];
    [newsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [newsButton addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:newsButton];
    self.newsButton = newsButton;

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    
    [self.allButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headView.mas_left).offset(16);
        make.top.equalTo(self.headView.mas_top).offset(18);
        make.width.mas_equalTo((SCREEN_WIDTH-64)/3);
        make.height.mas_equalTo(44);
    }];
    
    [self.urgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.allButton.mas_right).offset(16);
        make.centerY.equalTo(self.allButton.mas_centerY);
        make.width.mas_equalTo((SCREEN_WIDTH-64)/3);
        make.height.mas_equalTo(44);
    }];
    
    [self.noticeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.urgButton.mas_right).offset(16);
        make.centerY.equalTo(self.allButton.mas_centerY);
        make.width.mas_equalTo((SCREEN_WIDTH-64)/3);
        make.height.mas_equalTo(44);
    }];
    
    [self.activityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headView.mas_left).offset(16);
        make.top.equalTo(self.allButton.mas_bottom).offset(16);
        make.width.mas_equalTo((SCREEN_WIDTH-64)/3);
        make.height.mas_equalTo(44);
    }];
    
    [self.hintButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.activityButton.mas_right).offset(16);
        make.centerY.equalTo(self.activityButton.mas_centerY);
        make.width.mas_equalTo((SCREEN_WIDTH-64)/3);
        make.height.mas_equalTo(44);
    }];
    
    [self.newsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hintButton.mas_right).offset(16);
        make.centerY.equalTo(self.activityButton.mas_centerY);
        make.width.mas_equalTo((SCREEN_WIDTH-64)/3);
        make.height.mas_equalTo(44);
    }];
    
}
-(void)upHeadView{
    
    _headView.frame = CGRectMake(0, 64-140,SCREEN_WIDTH, 140);

}
-(void)downHeadView{
    [UIView animateWithDuration: 0.2 delay: 0.35 options: UIViewAnimationOptionCurveEaseInOut animations: ^{
        _headView.frame = CGRectMake(0, kTopHeight,SCREEN_WIDTH, 140);
        
    } completion: ^(BOOL finished) {
        _headView.frame = CGRectMake(0, kTopHeight,SCREEN_WIDTH, 140);
        
    }];

}
-(void)buttonTouch:(UIButton *)sender{
    _headView.frame = CGRectMake(0, 64-140,SCREEN_WIDTH, 140);
    self.hidden = YES;
    for (int i = 0; i<6; i++) {
        UIButton *button = [self.headView viewWithTag:101+i];
        if (button.tag == sender.tag) {
            sender.layer.borderColor = RGB(255, 202, 48).CGColor;
            [sender setTitleColor:RGB(255, 202, 48) forState:UIControlStateNormal];
            if ([_advertHeadViewDelegate respondsToSelector:@selector(advertHeadView:selectRowAtLoc:)]) {
                [_advertHeadViewDelegate advertHeadView:self selectRowAtLoc:i];
            }
        }else{
            button.layer.borderColor = [UIColor blackColor].CGColor;
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    
    
}
@end

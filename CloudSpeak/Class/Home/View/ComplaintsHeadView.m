//
//  ComplaintsHeadView.m
//  CloudSpeak
//
//  Created by mac on 2018/9/7.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "ComplaintsHeadView.h"

@interface ComplaintsHeadView()


@property (strong, nonatomic) UIButton *allButton;
//处理状态
@property (strong, nonatomic)UILabel *processingStateLabel;

@property (strong, nonatomic) UIButton *unreadButton;//未查阅

@property (strong, nonatomic) UIButton *untreatedButton;//待处理

@property (strong, nonatomic) UIButton *inProButton;//处理中

@property (strong, nonatomic) UIButton *proButton;//已处理

@property (strong, nonatomic) UIButton *delayProButton;//延期处理

//投诉类型
@property (strong, nonatomic) UILabel *complaintsTypeLabel;

@property (strong, nonatomic) UIButton *urgButton;//投诉建议

@property (strong, nonatomic) UIButton *noticeButton;//公共设施

@property (strong, nonatomic) UIButton *activityButton;//邻里纠纷

@property (strong, nonatomic) UIButton *hintButton;//噪音扰民

@property (strong, nonatomic) UIButton *newsButton;//停车秩序

@property (strong, nonatomic) UIButton *noticeButtonA;//服务态度

@property (strong, nonatomic) UIButton *activityButtonB;//业务流程

@property (strong, nonatomic) UIButton *hintButtonC;//工程维修

@property (strong, nonatomic) UIButton *newsButtonD;//售后服务
@end

@implementation ComplaintsHeadView

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
    headView.frame = CGRectMake(0, (iPhoneX?88:64)-404, SCREEN_WIDTH, 404);
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
    
    UILabel *processingStateLabel = [UILabel new];
    processingStateLabel.text = @"处理状态";
    [self.headView addSubview:processingStateLabel];
    self.processingStateLabel =processingStateLabel;
    
    UIButton *unreadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self buttonLayer:unreadButton];
    unreadButton.tag = 102;
    [unreadButton setTitle:@"未查阅" forState:UIControlStateNormal];
    [self.headView addSubview:unreadButton];
    self.unreadButton = unreadButton;
    
    UIButton *untreatedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self buttonLayer:untreatedButton];
    untreatedButton.tag = 103;
    [untreatedButton setTitle:@"待处理" forState:UIControlStateNormal];
    [self.headView addSubview:untreatedButton];
    self.untreatedButton = untreatedButton;
    
    UIButton *inProButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self buttonLayer:inProButton];
    inProButton.tag = 104;
    [inProButton setTitle:@"处理中" forState:UIControlStateNormal];
    [self.headView addSubview:inProButton];
    self.inProButton = inProButton;
    
    UIButton *proButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self buttonLayer:proButton];
    proButton.tag = 105;
    [proButton setTitle:@"已处理" forState:UIControlStateNormal];
    [self.headView addSubview:proButton];
    self.proButton = proButton;
    
    UIButton *delayProButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self buttonLayer:delayProButton];
    delayProButton.tag = 106;
    [delayProButton setTitle:@"延期处理" forState:UIControlStateNormal];
    [self.headView addSubview:delayProButton];
    self.delayProButton = delayProButton;
    
    UILabel *complaintsTypeLabel = [UILabel new];
    complaintsTypeLabel.text = @"投诉类型";
    [self.headView addSubview:complaintsTypeLabel];
    self.complaintsTypeLabel = complaintsTypeLabel;
    
    UIButton *urgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self buttonLayer:urgButton];
    urgButton.tag = 107;
    [urgButton setTitle:@"投诉建议" forState:UIControlStateNormal];
    [self.headView addSubview:urgButton];
    self.urgButton = urgButton;
    
    UIButton *noticeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self buttonLayer:noticeButton];
    noticeButton.tag = 108;
    [noticeButton setTitle:@"公共设施" forState:UIControlStateNormal];
    [self.headView addSubview:noticeButton];
    self.noticeButton = noticeButton;
    
    UIButton *activityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self buttonLayer:activityButton];
    activityButton.tag = 109;
    [activityButton setTitle:@"邻里纠纷" forState:UIControlStateNormal];
    [self.headView addSubview:activityButton];
    self.activityButton = activityButton;
    
    UIButton *hintButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self buttonLayer:hintButton];
    hintButton.tag = 110;
    [hintButton setTitle:@"噪音扰民" forState:UIControlStateNormal];
    [self.headView addSubview:hintButton];
    self.hintButton = hintButton;
    
    UIButton *newsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self buttonLayer:newsButton];
    newsButton.tag = 111;
    [newsButton setTitle:@"停车秩序" forState:UIControlStateNormal];
    [self.headView addSubview:newsButton];
    self.newsButton = newsButton;
    
    UIButton *noticeButtonA = [UIButton buttonWithType:UIButtonTypeCustom];
    [self buttonLayer:noticeButtonA];
    noticeButtonA.tag = 112;
    [noticeButtonA setTitle:@"公共设施" forState:UIControlStateNormal];
    [self.headView addSubview:noticeButtonA];
    self.noticeButtonA = noticeButtonA;
    
    UIButton *activityButtonB = [UIButton buttonWithType:UIButtonTypeCustom];
    [self buttonLayer:activityButtonB];
    activityButtonB.tag = 113;
    [activityButtonB setTitle:@"邻里纠纷" forState:UIControlStateNormal];
    [self.headView addSubview:activityButtonB];
    self.activityButtonB = activityButtonB;
    
    UIButton *hintButtonC = [UIButton buttonWithType:UIButtonTypeCustom];
    [self buttonLayer:hintButtonC];
    hintButtonC.tag = 114;
    [hintButtonC setTitle:@"噪音扰民" forState:UIControlStateNormal];
    [self.headView addSubview:hintButtonC];
    self.hintButtonC = hintButtonC;
    
    UIButton *newsButtonD = [UIButton buttonWithType:UIButtonTypeCustom];
    [self buttonLayer:newsButtonD];
    newsButtonD.tag = 115;
    [newsButtonD setTitle:@"售后服务" forState:UIControlStateNormal];
    [self.headView addSubview:newsButtonD];
    self.newsButtonD = newsButtonD;
}
-(void)buttonLayer:(UIButton *)button{
    
    button.layer.cornerRadius = 4;
    button.layer.masksToBounds = YES;
    button.layer.borderColor = [UIColor blackColor].CGColor;
    button.layer.borderWidth = 1;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    
    [self.allButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headView.mas_left).offset(16);
        make.right.equalTo(self.headView.mas_right).offset(-16);
        make.top.equalTo(self.headView.mas_top).offset(10);
        make.height.mas_equalTo(44);
    }];
    
    [self.processingStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headView.mas_left).offset(16);
        make.top.equalTo(self.allButton.mas_bottom).offset(12);
    }];
    
    [self.unreadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headView.mas_left).offset(16);
        make.top.equalTo(self.processingStateLabel.mas_bottom).offset(12);
        make.width.mas_equalTo((SCREEN_WIDTH-68)/4);
        make.height.mas_equalTo(44);
    }];
    [self.untreatedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.unreadButton.mas_right).offset(12);
        make.centerY.equalTo(self.unreadButton.mas_centerY);
        make.width.mas_equalTo((SCREEN_WIDTH-68)/4);
        make.height.mas_equalTo(44);
    }];
    
    [self.inProButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.untreatedButton.mas_right).offset(12);
        make.centerY.equalTo(self.unreadButton.mas_centerY);
        make.width.mas_equalTo((SCREEN_WIDTH-68)/4);
        make.height.mas_equalTo(44);
    }];
    
    [self.proButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inProButton.mas_right).offset(12);
        make.centerY.equalTo(self.unreadButton.mas_centerY);
        make.width.mas_equalTo((SCREEN_WIDTH-68)/4);
        make.height.mas_equalTo(44);
    }];
    
    [self.delayProButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headView.mas_left).offset(16);
        make.top.equalTo(self.unreadButton.mas_bottom).offset(12);
        make.width.mas_equalTo((SCREEN_WIDTH-68)/4);
        make.height.mas_equalTo(44);
    }];
    
    [self.complaintsTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headView.mas_left).offset(16);
        make.top.equalTo(self.delayProButton.mas_bottom).offset(12);
    }];
    
    
    [self.urgButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headView.mas_left).offset(16);
        make.top.equalTo(self.complaintsTypeLabel.mas_bottom).offset(12);
        make.width.mas_equalTo((SCREEN_WIDTH-68)/4);
        make.height.mas_equalTo(44);
    }];
    
    [self.noticeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.urgButton.mas_right).offset(12);
        make.centerY.equalTo(self.urgButton.mas_centerY);
        make.width.mas_equalTo((SCREEN_WIDTH-68)/4);
        make.height.mas_equalTo(44);
    }];
    
    [self.activityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.noticeButton.mas_right).offset(12);
        make.centerY.equalTo(self.urgButton.mas_centerY);
        make.width.mas_equalTo((SCREEN_WIDTH-68)/4);
        make.height.mas_equalTo(44);
    }];
    
    [self.hintButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.activityButton.mas_right).offset(12);
        make.centerY.equalTo(self.urgButton.mas_centerY);
        make.width.mas_equalTo((SCREEN_WIDTH-68)/4);
        make.height.mas_equalTo(44);
    }];
    
    [self.newsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headView.mas_left).offset(16);
        make.top.equalTo(self.urgButton.mas_bottom).offset(12);
        make.width.mas_equalTo((SCREEN_WIDTH-68)/4);
        make.height.mas_equalTo(44);
    }];
    
    [self.noticeButtonA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.newsButton.mas_right).offset(12);
        make.centerY.equalTo(self.newsButton.mas_centerY);
        make.width.mas_equalTo((SCREEN_WIDTH-68)/4);
        make.height.mas_equalTo(44);
    }];
    
    [self.activityButtonB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.noticeButtonA.mas_right).offset(12);
        make.centerY.equalTo(self.newsButton.mas_centerY);
        make.width.mas_equalTo((SCREEN_WIDTH-68)/4);
        make.height.mas_equalTo(44);
    }];
    
    [self.hintButtonC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.activityButtonB.mas_right).offset(12);
        make.centerY.equalTo(self.newsButton.mas_centerY);
        make.width.mas_equalTo((SCREEN_WIDTH-68)/4);
        make.height.mas_equalTo(44);
    }];
    
    [self.newsButtonD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headView.mas_left).offset(16);
        make.top.equalTo(self.newsButton.mas_bottom).offset(12);
        make.width.mas_equalTo((SCREEN_WIDTH-68)/4);
        make.height.mas_equalTo(44);
    }];
    
}
-(void)upHeadView{
    
    _headView.frame = CGRectMake(0, (iPhoneX?88:64)-404,SCREEN_WIDTH, 404);
    
}
-(void)downHeadView{
    [UIView animateWithDuration: 0.2 delay: 0.35 options: UIViewAnimationOptionCurveEaseInOut animations: ^{
        _headView.frame = CGRectMake(0, kTopHeight,SCREEN_WIDTH, 404);
        
    } completion: ^(BOOL finished) {
        _headView.frame = CGRectMake(0, kTopHeight,SCREEN_WIDTH, 404);
        
    }];
}
-(void)buttonTouch:(UIButton *)sender{
    _headView.frame = CGRectMake(0, (iPhoneX?88:64)-404,SCREEN_WIDTH, 404);
    self.hidden = YES;
    for (int i = 0; i<15; i++) {
        UIButton *button = [self.headView viewWithTag:101+i];
        if (button.tag == sender.tag) {
            sender.layer.borderColor = RGB(255, 202, 48).CGColor;
            [sender setTitleColor:RGB(255, 202, 48) forState:UIControlStateNormal];
            if ([_complaintsHeadViewDelegate respondsToSelector:@selector(complaintsHeadView:selectRowAtLoc:)]) {
                [_complaintsHeadViewDelegate complaintsHeadView:self selectRowAtLoc:i];
            }
        }else{
            button.layer.borderColor = [UIColor blackColor].CGColor;
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    
    
}
@end


//
//  SetDoorView.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/20.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "SetDoorView.h"

#define ComeIn @[@"入",@"出"]

@interface SetDoorView () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIView *alertView;

@property (strong, nonatomic) UIView *verView;

@property (strong, nonatomic) UIView *horView;

@property (strong, nonatomic) UIButton *cancelButton;

@property (strong, nonatomic) UIButton *confirmButton;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIView *centerView;

@property (strong, nonatomic) UILabel *mainLabel;

@property (strong, nonatomic) UIView *mainValueView;

@property (strong, nonatomic) UILabel *mainValueLabel;

@property (strong, nonatomic) UILabel *secondLabel;

@property (strong, nonatomic) UIView *secondValueView;

@property (strong, nonatomic) UILabel *secondValueLabel;

@property (strong, nonatomic) AYCustomTView *customTView;

@property (assign, nonatomic) BOOL isFirst;

@end

@implementation SetDoorView

+ (instancetype)setupSetDoorView:(NSString *)title
{
    SetDoorView *customAlertView = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    customAlertView.titleLabel.text = title;
    
    return customAlertView;
}

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
    
    self.backgroundColor = RGBA(0, 0, 0, 0.3);
    
    UIView *alertView = [UIView new];
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.layer.cornerRadius = 20;
    [self addSubview:alertView];
    self.alertView = alertView;
    [self exChangeOut:alertView dur:0.6];
    
    UIView *verView = [UIView new];
    verView.backgroundColor = RGB(200, 200, 200);
    [alertView addSubview:verView];
    self.verView = verView;
    
    UIView *horView = [UIView new];
    horView.backgroundColor = RGB(200, 200, 200);
    [alertView addSubview:horView];
    self.horView = horView;
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:TextMainBlackColor forState:UIControlStateNormal];
    [self.alertView addSubview:cancelButton];
    self.cancelButton = cancelButton;
    [cancelButton addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
    confirmButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:RGB(0, 98, 255) forState:UIControlStateNormal];
    [self.alertView addSubview:confirmButton];
    self.confirmButton = confirmButton;
    [confirmButton addTarget:self action:@selector(clickConfirmButton) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"区域";
    titleLabel.textColor = [UIColor blackColor];
    [self.alertView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIView *centerView = [UIView new];
    [self.alertView addSubview:centerView];
    self.centerView = centerView;
    
    UILabel *mainLabel = [UILabel new];
    mainLabel.font = [UIFont systemFontOfSize:15];
    mainLabel.text = @"主卡-01 : ";
    mainLabel.textAlignment = NSTextAlignmentLeft;
    [self.centerView addSubview:mainLabel];
    self.mainLabel = mainLabel;
    
    UIView *mainValueView = [UIView new];
    [self.centerView addSubview:mainValueView];
    self.mainValueView = mainValueView;
    
    UILabel *mainValueLabel = [UILabel new];
    mainValueLabel.layer.borderColor = TextMainBlackColor.CGColor;
    mainValueLabel.layer.borderWidth = 0.5;
    mainValueLabel.font = [UIFont systemFontOfSize:15];
    mainValueLabel.text = @" 入";
    mainValueLabel.textAlignment = NSTextAlignmentLeft;
    [mainValueView addSubview:mainValueLabel];
    self.mainValueLabel = mainValueLabel;
    
    UILabel *secondLabel = [UILabel new];
    secondLabel.font = [UIFont systemFontOfSize:15];
    secondLabel.text = @"副卡-02 : ";
    secondLabel.textAlignment = NSTextAlignmentLeft;
    [self.centerView addSubview:secondLabel];
    self.secondLabel = secondLabel;
    
    UIView *secondValueView = [UIView new];
    [self.centerView addSubview:secondValueView];
    self.secondValueView = secondValueView;
    
    UILabel *secondValueLabel = [UILabel new];
    secondValueLabel.layer.borderColor = TextMainBlackColor.CGColor;
    secondValueLabel.layer.borderWidth = 0.5;
    secondValueLabel.font = [UIFont systemFontOfSize:15];
    secondValueLabel.text = @" 出";
    secondValueLabel.textAlignment = NSTextAlignmentLeft;
    [self.secondValueView addSubview:secondValueLabel];
    self.secondValueLabel = secondValueLabel;
    
    AYCustomTView *customTView = [AYCustomTView new];
    customTView.delegate = self;
    customTView.dataSource = self;
    customTView.rowHeight = 60;
    customTView.hidden = YES;
    customTView.scrollEnabled = NO;
    [self addSubview:customTView];
    self.customTView = customTView;
    
    [mainValueView whenTapped:^{
        customTView.hidden = NO;
        self.isFirst = YES;
    }];
    
    [secondValueView whenTapped:^{
        customTView.hidden = NO;
        self.isFirst = NO;
    }];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(50);
        make.right.equalTo(self.mas_right).offset(-50);
        make.height.equalTo(self.alertView.mas_width).multipliedBy(0.8);
        make.centerY.equalTo(self.mas_centerY);
        
    }];
    
    [self.verView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.alertView);
        make.bottom.equalTo(self.alertView.mas_bottom).offset(-50);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.horView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verView.mas_bottom);
        make.bottom.equalTo(self.alertView.mas_bottom);
        make.width.mas_equalTo(0.5);
        make.centerX.equalTo(self.alertView.mas_centerX);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.alertView);
        make.top.equalTo(self.verView.mas_bottom);
        make.right.equalTo(self.horView.mas_left);
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.alertView);
        make.top.equalTo(self.verView.mas_bottom);
        make.left.equalTo(self.horView.mas_right);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.alertView.mas_top).offset(16);
        make.centerX.equalTo(self.alertView.mas_centerX);
    }];
    
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.bottom.equalTo(self.verView.mas_top);
        make.left.right.equalTo(self.alertView);
    }];
    
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.top.equalTo(self.centerView.mas_top).offset(16);
        make.left.equalTo(self.centerView.mas_left).offset(32);
    }];
    
    [self.mainValueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.top.equalTo(self.centerView.mas_top).offset(16);
        make.left.equalTo(self.mainLabel.mas_right).offset(0);
        make.right.equalTo(self.centerView.mas_right).offset(-32);
    }];
    
    [self.mainValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mainValueView);
    }];
    
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.bottom.equalTo(self.centerView.mas_bottom).offset(-16);
        make.left.equalTo(self.centerView.mas_left).offset(32);
    }];
    
    [self.secondValueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.bottom.equalTo(self.centerView.mas_bottom).offset(-16);
        make.left.equalTo(self.secondLabel.mas_right).offset(0);
        make.right.equalTo(self.centerView.mas_right).offset(-32);
    }];
    
    [self.secondValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.secondValueView);
    }];
    
    [self.customTView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.alertView.mas_centerY);
        make.height.mas_equalTo(120);
        make.left.equalTo(self.alertView.mas_left).offset(32);
        make.right.equalTo(self.alertView.mas_right).offset(-32);
    }];
}

-(void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur{
    
    CAKeyframeAnimation * animation;
    
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = dur;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    [changeOutView.layer addAnimation:animation forKey:nil];
}

- (void)clickCancelButton
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)clickConfirmButton
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    self.setDoorViewBlock(self.mainValueLabel.text, self.secondValueLabel.text);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ComeIn.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        cell.backgroundColor = RGB(250, 250, 250);
    }
    
    cell.textLabel.text = ComeIn[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.customTView.hidden = YES;
    
    if (self.isFirst) {
        
        self.mainValueLabel.text = [NSString stringWithFormat:@" %@",ComeIn[indexPath.row]];
        
        self.secondValueLabel.text = [NSString stringWithFormat:@" %@",ComeIn[!indexPath.row]];
        
    } else {
        
        self.mainValueLabel.text = [NSString stringWithFormat:@" %@",ComeIn[!indexPath.row]];
        
        self.secondValueLabel.text = [NSString stringWithFormat:@" %@",ComeIn[indexPath.row]];
        
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1f;
}

@end

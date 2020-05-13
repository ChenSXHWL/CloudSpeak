//
//  AYCustomAlertView.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/20.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "AYCustomAlertView.h"

@interface AYCustomAlertView () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIView *alertView;

@property (strong, nonatomic) UIView *verView;

@property (strong, nonatomic) UIView *horView;

@property (strong, nonatomic) UIButton *cancelButton;

@property (strong, nonatomic) UIButton *confirmButton;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIView *centerView;

@property (strong, nonatomic) UILabel *selectLabel;

@property (strong, nonatomic) AYCustomTView *customTView;

@property (strong, nonatomic) NSDictionary *communityList;

@end

@implementation AYCustomAlertView

+ (instancetype)setupAYCustomAlertView:(NSString *)title
{
    AYCustomAlertView *customAlertView = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
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
    
    UILabel *selectLabel = [UILabel new];
    selectLabel.layer.borderColor = TextMainBlackColor.CGColor;
    selectLabel.layer.borderWidth = 0.5;
    selectLabel.font = [UIFont systemFontOfSize:15];
    if ([LoginEntity shareManager].communityList.count) {
        selectLabel.text = [LoginEntity shareManager].communityList[0][@"communityName"];
    }
    selectLabel.textAlignment = NSTextAlignmentLeft;
    [self.centerView addSubview:selectLabel];
    self.selectLabel = selectLabel;
    
    AYCustomTView *customTView = [AYCustomTView new];
    customTView.delegate = self;
    customTView.dataSource = self;
    customTView.scrollEnabled = NO;
    customTView.hidden = YES;
    [self addSubview:customTView];
    self.customTView = customTView;
    
    [centerView whenTapped:^{
        customTView.hidden = NO;
    }];
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(50);
        make.right.equalTo(self.mas_right).offset(-50);
        make.height.equalTo(self.alertView.mas_width).multipliedBy(0.6);
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
    
    [self.selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.centerY.equalTo(self.centerView.mas_centerY);
        make.left.equalTo(self.centerView.mas_left).offset(32);
        make.right.equalTo(self.centerView.mas_right).offset(-32);
    }];
    
    [self.customTView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.selectLabel.mas_bottom);
        make.left.right.equalTo(self.selectLabel);
        make.height.mas_equalTo([LoginEntity shareManager].communityList.count * 60);
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
    
    self.customAlertViewBlock(self.communityList);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [LoginEntity shareManager].communityList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    
    NSDictionary *list = [LoginEntity shareManager].communityList[indexPath.row];
    
    cell.textLabel.text = list[@"communityName"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.selectLabel.text = [LoginEntity shareManager].communityList[indexPath.row][@"communityName"];
    
    self.customTView.hidden = YES;
    
    self.communityList = [LoginEntity shareManager].communityList[indexPath.row];
    
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

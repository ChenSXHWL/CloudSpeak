//
//  WarrantyHeadView.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/14.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "WarrantyHeadView.h"
@interface WarrantyHeadView ()<UITextFieldDelegate>


@property (strong, nonatomic)UIView *viewA;
@property (strong, nonatomic)UILabel *leftTextA;
@property (strong, nonatomic)UIImageView *rightImageA;
@property (strong, nonatomic)UIView *lineA;
@property (strong, nonatomic)UIButton *buttonA;

@property (strong, nonatomic)UIView *viewB;
@property (strong, nonatomic)UIView *lineB;

@property (strong, nonatomic)UIView *viewC;
@property (strong, nonatomic)UILabel *leftTextC;



@property (strong, nonatomic)UILabel *leftTextE;
@property (strong, nonatomic)UIView *lineE;
@end

@implementation WarrantyHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
    }
    [self buildUI];

    return self;
}
-(void)buildUI{
    
    self.userInteractionEnabled = YES;

    UIView *viewA = [UIView new];
    viewA.backgroundColor = [UIColor whiteColor];
    [self addSubview:viewA];
    self.viewA = viewA;
    
    UILabel *leftTextA = [UILabel new];
    leftTextA.text = @"报修类型";
    [viewA addSubview:leftTextA];
    self.leftTextA = leftTextA;
    
    UILabel *labelA = [UILabel new];
    labelA.text = @"室内维修";
    labelA.textColor = TextDeepGaryColor;
    labelA.font = [UIFont systemFontOfSize:15];
    [viewA addSubview:labelA];
    self.labelA = labelA;
    
    UIImageView *rightImageA = [UIImageView new];
    rightImageA.image = [UIImage imageNamed:@"home_enter"];
    [viewA addSubview:rightImageA];
    self.rightImageA = rightImageA;
    
    UIView *lineA = [UIView new];
    lineA.backgroundColor = LineEdgeGaryColor;
    [viewA addSubview:lineA];
    self.lineA = lineA;
    
    UIButton *buttonA = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:buttonA];
    self.buttonA = buttonA;
    [buttonA addTarget:self action:@selector(devTypeTouch) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewB = [UIView new];
    viewB.backgroundColor = [UIColor whiteColor];
    [self addSubview:viewB];
    self.viewB = viewB;
    
    UILabel *leftTextB = [UILabel new];
    leftTextB.text = @"小区";
    leftTextB.font = [UIFont systemFontOfSize:13];
    [viewB addSubview:leftTextB];
    self.leftTextB = leftTextB;
    
    SxButton *manageButtonA = [SxButton setupManageButtonWithImageString:@"home_enter" title:@"栋"];
    [manageButtonA addTarget:self action:@selector(selectCommunityA) forControlEvents:UIControlEventTouchUpInside];
    [viewB addSubview:manageButtonA];
    self.manageButtonA = manageButtonA;
    
    SxButton *manageButtonB = [SxButton setupManageButtonWithImageString:@"home_enter" title:@"单元"];
    [manageButtonB addTarget:self action:@selector(selectCommunityB) forControlEvents:UIControlEventTouchUpInside];
    [viewB addSubview:manageButtonB];
    self.manageButtonB = manageButtonB;
    
    SxButton *manageButtonC = [SxButton setupManageButtonWithImageString:@"home_enter" title:@"房间"];
    [manageButtonC addTarget:self action:@selector(selectCommunityC) forControlEvents:UIControlEventTouchUpInside];
    [viewB addSubview:manageButtonC];
    self.manageButtonC = manageButtonC;
    
    UIView *lineB = [UIView new];
    lineB.backgroundColor = LineEdgeGaryColor;
    [viewB addSubview:lineB];
    self.lineB = lineB;

    UIView *viewC = [UIView new];
    viewC.backgroundColor = [UIColor whiteColor];
    [self addSubview:viewC];
    self.viewC = viewC;
    
    UILabel *leftTextC = [UILabel new];
    leftTextC.text = @"故障地点";
    [viewC addSubview:leftTextC];
    self.leftTextC = leftTextC;
    
    UITextField *textFieldC = [UITextField new];
    textFieldC.placeholder = @"请输入故障地点";
    textFieldC.font = [UIFont systemFontOfSize:13];
    textFieldC.borderStyle = UITextBorderStyleRoundedRect;
    [viewC addSubview:textFieldC];
    self.textFieldC = textFieldC;
    
    UIView *viewD = [UIView new];
    viewD.backgroundColor = [UIColor whiteColor];
    viewD.userInteractionEnabled = YES;
    viewD.hidden = YES;
    [self addSubview:viewD];
    self.viewD = viewD;
    
    
    UIImageView *rightImageD = [UIImageView new];
    rightImageD.image = [UIImage imageNamed:@"icon_ThinkChange"];
    [viewD addSubview:rightImageD];
    self.rightImageD = rightImageD;
    
    UITextField *textFieldD = [UITextField new];
    textFieldD.placeholder = @"请扫描设备二维码";
    textFieldD.borderStyle = UITextBorderStyleRoundedRect;
    textFieldD.delegate = self;
    [viewD addSubview:textFieldD];
    self.textFieldD = textFieldD;
    
    UIView *viewE = [UIView new];
    viewE.userInteractionEnabled = YES;
    viewE.hidden = YES;
    viewE.backgroundColor = [UIColor whiteColor];
    [self addSubview:viewE];
    self.viewE = viewE;
    
    UILabel *leftTextE = [UILabel new];
    leftTextE.text = @"上门时间";
    [viewE addSubview:leftTextE];
    self.leftTextE = leftTextE;
    
    

    UILabel *rightTextE = [UILabel new];
    rightTextE.text = @"开始时间";
    rightTextE.layer.borderColor = [UIColor blackColor].CGColor;
    rightTextE.textAlignment = NSTextAlignmentCenter;
    rightTextE.font = [UIFont systemFontOfSize:14];
    rightTextE.layer.borderWidth = 1;
    [viewE addSubview:rightTextE];
    self.rightTextE = rightTextE;
    
    UILabel *rightTextE2 = [UILabel new];
    rightTextE2.text = @"结束时间";
    rightTextE2.layer.borderColor = [UIColor blackColor].CGColor;
    rightTextE2.layer.borderWidth = 1;
    rightTextE2.font = [UIFont systemFontOfSize:14];
    rightTextE2.textAlignment = NSTextAlignmentCenter;
    [viewE addSubview:rightTextE2];
    self.rightTextE2 = rightTextE2;
    
    UIView *lineE = [UIView new];
    lineE.backgroundColor = [UIColor blackColor];
    [viewE addSubview:lineE];
    self.lineE = lineE;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    

    
    [self.viewA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_top).offset(4);
        make.height.mas_equalTo(50);
    }];

    [self.leftTextA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.viewA.mas_centerY);
        make.left.equalTo(self.viewA.mas_left).offset(16);
    }];
    
    [self.labelA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.viewA.mas_centerX);
        make.centerY.equalTo(self.viewA.mas_centerY);
    }];
    
    [self.rightImageA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.viewA.mas_right).offset(-16);
        make.centerY.equalTo(self.leftTextA.mas_centerY);
        make.width.height.mas_equalTo(22);
    }];
    
    [self.lineA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.viewA);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.buttonA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.viewA);
    }];
    
    [self.viewB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.viewA.mas_bottom);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(SCREEN_WIDTH/4);
    }];
    
    [self.leftTextB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.viewB.mas_centerY);
        make.left.equalTo(self.viewB.mas_left).offset(2);
        make.width.mas_equalTo(SCREEN_WIDTH/4);
    }];
  
    [self.manageButtonA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTextB.mas_right).offset(0);
        make.height.mas_equalTo(48);
        make.width.mas_equalTo(SCREEN_WIDTH/4);
        make.centerY.equalTo(self.viewB.mas_centerY);
    }];
    
    [self.manageButtonB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.manageButtonA.mas_right);
        make.height.mas_equalTo(48);
        make.width.mas_equalTo(SCREEN_WIDTH/4);
        make.centerY.equalTo(self.viewB.mas_centerY);
    }];
    
    [self.manageButtonC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.manageButtonB.mas_right);
        make.height.mas_equalTo(48);
        make.width.mas_equalTo(SCREEN_WIDTH/4);
        make.centerY.equalTo(self.viewB.mas_centerY);
    }];
    
    [self.lineB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.viewB);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.viewC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.viewB.mas_bottom);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    [self.leftTextC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.viewC.mas_centerY);
        make.left.equalTo(self.viewC.mas_left).offset(12);
        make.width.mas_equalTo(SCREEN_WIDTH/4);
    }];
    
    [self.textFieldC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.viewC.mas_centerY);
        make.left.equalTo(self.leftTextC.mas_right).offset(0);
        make.right.equalTo(self.viewC.mas_right).offset(-4);
        make.height.mas_equalTo(44);
    }];
    
    [self.viewD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.viewC.mas_bottom);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    [self.rightImageD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.viewD.mas_right).offset(-12);
        make.centerY.equalTo(self.viewD.mas_centerY);
        make.height.width.mas_equalTo(34);
    }];
    
    [self.textFieldD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewD.mas_left).offset(12);
        make.centerY.equalTo(self.viewD.mas_centerY);
        make.right.equalTo(self.rightImageD.mas_left).offset(-12);
        make.height.mas_equalTo(44);
    }];
    
    [self.viewE mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.viewC.mas_bottom);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    [self.leftTextE mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.viewE.mas_centerY);
        make.left.equalTo(self.viewE.mas_left).offset(12);
        make.width.mas_equalTo(72);
    }];
    
    [self.rightTextE mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTextE.mas_right).offset(3);
        make.centerY.equalTo(self.viewE.mas_centerY);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(SCREEN_WIDTH/3+2);
    }];
    
    [self.lineE mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.viewE.mas_centerY);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(SCREEN_WIDTH/3-100);
        make.left.equalTo(self.rightTextE.mas_right).offset(2);
    }];
    
    [self.rightTextE2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineE.mas_right).offset(2);
        make.centerY.equalTo(self.viewE.mas_centerY);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(SCREEN_WIDTH/3+2);
    }];
}


- (void)devTypeTouch{
    if ([_warrantyHeadViewDelegate respondsToSelector:@selector(warrantyHeadView:selectRowAtLoc:selctSection:)]) {
        [_warrantyHeadViewDelegate warrantyHeadView:self selectRowAtLoc:0 selctSection:0];
    }
}
- (void)selectCommunityA
{
    
    if ([_warrantyHeadViewDelegate respondsToSelector:@selector(warrantyHeadView:selectRowAtLoc:selctSection:)]) {
        [_warrantyHeadViewDelegate warrantyHeadView:self selectRowAtLoc:0 selctSection:1];
    }
}
- (void)selectCommunityB
{
    self.stings = self.manageButtonA.titleLabel.text;
    
    if ([_warrantyHeadViewDelegate respondsToSelector:@selector(warrantyHeadView:selectRowAtLoc:selctSection:)]) {
        [_warrantyHeadViewDelegate warrantyHeadView:self selectRowAtLoc:1 selctSection:1];
    }
}
- (void)selectCommunityC
{
    self.stings = self.manageButtonB.titleLabel.text;

    if ([_warrantyHeadViewDelegate respondsToSelector:@selector(warrantyHeadView:selectRowAtLoc:selctSection:)]) {
        [_warrantyHeadViewDelegate warrantyHeadView:self selectRowAtLoc:2 selctSection:1];
    }
}

@end

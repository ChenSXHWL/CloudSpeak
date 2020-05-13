//
//  ManageTVHeadView.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/30.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "ManageTVHeadView.h"
#import "ManageButton.h"

@interface ManageTVHeadView ()

@property (strong, nonatomic) ManageButton *allButton;

@property (strong, nonatomic) ManageButton *areaButton;

@property (strong, nonatomic) ManageButton *floorButton;

@property (strong, nonatomic) ManageButton *unitButton;

@property (strong, nonatomic) UIView *allLineView;

@property (strong, nonatomic) UIView *areaLineView;

@property (strong, nonatomic) UIView *floorLineView;

@end

@implementation ManageTVHeadView

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
    self.backgroundColor = [UIColor whiteColor];
    
    ManageButton *allButton = [ManageButton setupManageButtonWithImageString:@"icon_me_in" title:@"全部"];
    [allButton addTarget:self action:@selector(clickAllButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:allButton];
    self.allButton = allButton;
    
    ManageButton *areaButton = [ManageButton setupManageButtonWithImageString:@"icon_me_in" title:@"区域"];
    [areaButton addTarget:self action:@selector(clickAreaButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:areaButton];
    self.areaButton = areaButton;
    
    ManageButton *floorButton = [ManageButton setupManageButtonWithImageString:@"icon_me_in" title:@"楼栋"];
    [floorButton addTarget:self action:@selector(clickFloorButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:floorButton];
    self.floorButton = floorButton;
    
    ManageButton *unitButton = [ManageButton setupManageButtonWithImageString:@"icon_me_in" title:@"单元"];
    [unitButton addTarget:self action:@selector(clickUnitButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:unitButton];
    self.unitButton = unitButton;
    
    UIView *allLineView = [UIView new];
    allLineView.backgroundColor = RGB(200, 200, 200);
    [self addSubview:allLineView];
    self.allLineView = allLineView;
    
    UIView *areaLineView = [UIView new];
    areaLineView.backgroundColor = RGB(200, 200, 200);
    [self addSubview:areaLineView];
    self.areaLineView = areaLineView;
    
    UIView *floorLineView = [UIView new];
    floorLineView.backgroundColor = RGB(200, 200, 200);
    [self addSubview:floorLineView];
    self.floorLineView = floorLineView;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.allButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH / 4);
    }];
    
    [self.areaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH / 4);
        make.left.equalTo(self.allButton.mas_right).offset(1);
    }];
    
    [self.floorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH / 4);
        make.left.equalTo(self.areaButton.mas_right).offset(1);
    }];
    
    [self.unitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self);
        make.left.equalTo(self.floorButton.mas_right).offset(1);
    }];
    
    [self.allLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(16);
        make.bottom.equalTo(self.mas_bottom).offset(-16);
        make.width.mas_equalTo(.5);
        make.left.equalTo(self.allButton.mas_right);
    }];
    
    [self.areaLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(16);
        make.bottom.equalTo(self.mas_bottom).offset(-16);
        make.width.mas_equalTo(.5);
        make.left.equalTo(self.areaButton.mas_right);
    }];
    
    [self.floorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(16);
        make.bottom.equalTo(self.mas_bottom).offset(-16);
        make.width.mas_equalTo(.5);
        make.left.equalTo(self.floorButton.mas_right);
    }];
}

- (void)clickAllButtonMethod
{
    
}

- (void)clickAreaButtonMethod
{
    
}

- (void)clickFloorButtonMethod
{
    
}

- (void)clickUnitButtonMethod
{
    
}

@end

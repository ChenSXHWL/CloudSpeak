//
//  VersionUpView.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/12/11.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "VersionUpView.h"



@interface VersionUpView()


@property (strong, nonatomic) UIButton *allButton;

@property (strong, nonatomic) UIButton *urgButton;

@property (strong, nonatomic) UIButton *noticeButton;

@property (strong, nonatomic) UIButton *activityButton;

@property (strong, nonatomic) UIButton *hintButton;

@property (strong, nonatomic) UIButton *newsButton;

@end

@implementation VersionUpView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:25.0/255.0 green:25.0/255.0 blue:25.0/255.0 alpha:0.5];
        [self whenTapped:^{
            
//            self.hidden = YES;
            
        }];
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI
{
      
    UIView *back = [UIView new];
    back.backgroundColor = [UIColor whiteColor];
    back.layer.cornerRadius = 10;
    back.layer.masksToBounds = YES;
    [self addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH-80);
        make.height.mas_equalTo((SCREEN_WIDTH-80)*0.9);
    }];
    
    UILabel *title = [UILabel new];
    title.text = @"提示";
    title.textColor = TextBlueColor;
    [back addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(back.mas_left).offset(16);
        make.top.equalTo(back.mas_top).offset(16);
    }];
    
    UILabel *contenText = [UILabel new];
    contenText.text = @"系统已更新至2.0版本，您需要升级至最新版本方可正常使用该软件";
    contenText.numberOfLines = 0;
    contenText.textAlignment = NSTextAlignmentCenter;
    [back addSubview:contenText];
    [contenText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(back);
        make.width.mas_equalTo(SCREEN_WIDTH-140);
    }];
    self.contenText = contenText;
    
    UIView *lineA = [UIView new];
    lineA.backgroundColor = LineEdgeGaryColor;
    [back addSubview:lineA];
    [lineA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(back.mas_centerX);
        make.width.mas_equalTo(SCREEN_WIDTH-120);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(back.mas_bottom).offset(-52);
    }];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setTitle:@"升级" forState:UIControlStateNormal];
    [confirmButton setBackgroundColor:[UIColor whiteColor]];
    [confirmButton setTitleColor:TextBlueColor forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(confirmTouch) forControlEvents:UIControlEventTouchUpInside];
    [back addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(back.mas_right);
        make.bottom.equalTo(back.mas_bottom);
        make.left.equalTo(back.mas_left);
        make.height.mas_equalTo(52);
    }];
    
//    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [cancelButton setTitle:@"稍后处理" forState:UIControlStateNormal];
//    [cancelButton setBackgroundColor:[UIColor whiteColor]];
//    [cancelButton addTarget:self action:@selector(cancelTouch) forControlEvents:UIControlEventTouchUpInside];
//    [back addSubview:cancelButton];
//    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(back.mas_left);
//        make.bottom.equalTo(back.mas_bottom);
//        make.width.mas_equalTo((SCREEN_WIDTH-80)/2);
//        make.height.mas_equalTo(52);
//    }];
    
}-(void)cancelTouch{
    
    self.hidden = YES;
}
-(void)confirmTouch{
    self.hidden = YES;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:AppStoreUrl]];


}
@end

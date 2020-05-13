//
//  BaseLoginVC.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/24.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "BaseLoginVC.h"

@interface BaseLoginVC ()

@end

@implementation BaseLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *whiteBackgroundView = [UIView new];
    whiteBackgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteBackgroundView];
    self.whiteBackgroundView = whiteBackgroundView;
    
    UIView *middleView = [UIView new];
    middleView.backgroundColor = RGB(200, 200, 200);
    [whiteBackgroundView addSubview:middleView];
    self.middleView = middleView;
    
    UIView *phoneView = [UIView new];
    [whiteBackgroundView addSubview:phoneView];
    self.phoneView = phoneView;
    
    UIView *passwordView = [UIView new];
    [whiteBackgroundView addSubview:passwordView];
    self.passwordView = passwordView;
    
    [self.whiteBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(80);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(120);
    }];
    
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.right.equalTo(self.whiteBackgroundView);
        make.left.equalTo(self.whiteBackgroundView.mas_left).offset(16);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.whiteBackgroundView);
        make.left.bottom.equalTo(self.middleView);
    }];
    
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.whiteBackgroundView);
        make.left.top.equalTo(self.middleView);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

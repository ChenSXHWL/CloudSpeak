//
//  ManageSettingVC.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/30.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "ManageSettingVC.h"
#import "ManageSettingTView.h"

@interface ManageSettingVC ()

@end

@implementation ManageSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    ManageSettingTView *manageSettingTView = [ManageSettingTView new];
    
    [self.view addSubview:manageSettingTView];
    
    [manageSettingTView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(16);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

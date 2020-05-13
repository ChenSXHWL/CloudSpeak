//
//  MeSettingVC.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/14.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "MeSettingVC.h"
#import "MeSettingTView.h"
#import "AYAlertViewController.h"

@interface MeSettingVC ()

@end

@implementation MeSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    
    MeSettingTView *meSettingTView = [MeSettingTView new];
    
    [self.view addSubview:meSettingTView];
    
    [meSettingTView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(16);
    }];
    
//    @weakify(self);
    meSettingTView.meSettingBlock = ^(void) {
//        @strongify(self);
        
    };

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

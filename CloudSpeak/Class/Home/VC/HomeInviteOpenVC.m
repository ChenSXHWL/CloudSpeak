//
//  HomeInviteOpenVC.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/16.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "HomeInviteOpenVC.h"
#import "HomeInviteOpenTView.h"

@interface HomeInviteOpenVC ()

@end

@implementation HomeInviteOpenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"开门记录";
    
    HomeInviteOpenTView *homeInviteOpenTView = [HomeInviteOpenTView new];
    
    [self.view addSubview:homeInviteOpenTView];
    
    [homeInviteOpenTView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(0);
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

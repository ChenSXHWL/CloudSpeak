//
//  HomeMessageVC.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/14.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "HomeMessageVC.h"
#import "HomeMessageTView.h"

@interface HomeMessageVC ()

@end

@implementation HomeMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"开门记录";
    
    HomeMessageTView *homeMessageTView = [HomeMessageTView new];
    
    [self.view addSubview:homeMessageTView];
    
    [homeMessageTView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

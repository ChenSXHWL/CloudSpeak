//
//  MeInfoVC.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/13.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "MeInfoVC.h"
#import "MeInfoTView.h"

@interface MeInfoVC ()

@property (strong, nonatomic) MeInfoTView *meInfoTView;

@end

@implementation MeInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    
    MeInfoTView *meInfoTView = [MeInfoTView new];
    
    meInfoTView.userInfoEntity = self.userInfoEntity;
    
    [self.view addSubview:meInfoTView];
    
    self.meInfoTView = meInfoTView;
    
    [meInfoTView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(16);
    }];
    
    @weakify(self);
    self.meInfoTView.meInfoTViewBlock = ^{
        @strongify(self);
        self.meInfoVCBlock();
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

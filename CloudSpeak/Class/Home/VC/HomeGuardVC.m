//
//  HomeGuardVC.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/14.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "HomeGuardVC.h"
#import "HomeGuardCView.h"
#import "HomeGuardLocVC.h"
#import "GetMyKeyEntity.h"

@interface HomeGuardVC ()
@property (strong, nonatomic)RefreshDevicesRequest *refreshDevicesRequest;
@end

@implementation HomeGuardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"一键监视";
    
    HomeGuardCView *homeGuardCView = [HomeGuardCView setupHomeGuardCView];
    
    [self.view addSubview:homeGuardCView];
    
    [homeGuardCView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    @weakify(self);
    homeGuardCView.guardBlock = ^(GetMyKeyEntity *getMyKeyEntity) {
        @strongify(self);
        
        HomeGuardLocVC *homeGuardLocVC = [HomeGuardLocVC new];
        
        homeGuardLocVC.getMyKeyEntity = getMyKeyEntity;
                
        [self.navigationController pushViewController:homeGuardLocVC animated:YES];
        
        homeGuardLocVC.homeGuardLocVCBlock = ^(NSString *time) {
            
        };
    };
    self.refreshDevicesRequest = [RefreshDevicesRequest Request];
    self.refreshDevicesRequest.communityCode = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue] [@"communityCode"];
    [[SceneModel SceneModel] SEND_ACTION:self.refreshDevicesRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

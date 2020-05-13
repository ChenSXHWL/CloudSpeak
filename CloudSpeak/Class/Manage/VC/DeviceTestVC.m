//
//  DeviceTestVC.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/12.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "DeviceTestVC.h"
#import "DeviceTestTView.h"
#import "HomeGuardLocVC.h"
#import "GetMyKeyEntity.h"
#import "HomeElevatorVC.h"
#import "GroupUnitRequest.h"
#import "GroupUnitEntity.h"
@interface DeviceTestVC ()
@property (strong, nonatomic) DeviceTestTView *deviceTestTView;

@property (strong, nonatomic) GroupUnitRequest *groupUnitRequest;

@end

@implementation DeviceTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设备测试";
    
    DeviceTestTView *deviceTestTView = [DeviceTestTView new];
    
    deviceTestTView.sipContent = self.sipContent;
    
    [self.view addSubview:deviceTestTView];
    
    self.deviceTestTView = deviceTestTView;
    
    [deviceTestTView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    @weakify(self);
    deviceTestTView.deviceTestVCBlock = ^(NSString *sipAccount) {
        @strongify(self);
        
        GetMyKeyEntity *entity = [GetMyKeyEntity new];
        
        if ([sipAccount isEqualToString:@"Elevator"]) {
            self.groupUnitRequest.deviceNum = entity.deviceNum;
            [[SceneModelConfig SceneModel] SEND_ACTION:self.groupUnitRequest];
            [AYProgressHud progressHudLoadingRequest:self.groupUnitRequest showInView:self.view detailString:@""];
        }else{
            
            entity.deviceName = self.deviceName;
            
            entity.sipAccount = sipAccount;
            
            HomeGuardLocVC *homeGuardLocVC = [HomeGuardLocVC new];
            homeGuardLocVC.isTest = YES;
            homeGuardLocVC.getMyKeyEntity = entity;
            
            [self.navigationController pushViewController:homeGuardLocVC animated:YES];
            
            homeGuardLocVC.homeGuardLocVCBlock = ^(NSString *time) {
                @strongify(self);
                self.deviceTestTView.talkTime = time;
            };
        }
    };
    
    self.groupUnitRequest = [GroupUnitRequest Request];
    self.groupUnitRequest.communityId = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityId"];
    [[RACObserve(self.groupUnitRequest, state) filter:^BOOL(id value) {
        return value == RequestStateSuccess;
    }] subscribeNext:^(id x) {
        HomeElevatorVC *vc = [HomeElevatorVC new];
        NSArray *arr = [GroupUnitEntity arrayOfModelsFromDictionaries:self.groupUnitRequest.output[@"houseList"] error:nil];
        vc.groupUnitEntity = arr[0];
        [self.navigationController pushViewController:vc animated:YES];

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

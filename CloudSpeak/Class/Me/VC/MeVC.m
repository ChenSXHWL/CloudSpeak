//
//  MeVC.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/8.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//


#import "MeVC.h"
#import "MeTView.h"
#import "MeSettingVC.h"
#import "MeInfoVC.h"
#import "UserInfoVM.h"
#import "MonitorSetVC.h"
#import "WarrantyVC.h"
#import "MyNeighborhoodVC.h"
#import "MeAboutVC.h"
@interface MeVC ()

//@property (strong, nonatomic) UIButton *setButton;

@property (strong, nonatomic) MeTView *meTView;

@property (strong, nonatomic) UserInfoVM *userInfoVM;

@end

@implementation MeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setupConstraint];
    
    [self setupBlock];
    
    [self setupVM];
    
    [self setupRAC];
}

- (void)setupUI
{
    self.title = @"我";
    
    UIButton *setButton = [UIButton buttonWithType:UIButtonTypeSystem];
    setButton.frame = CGRectMake(0, 0, 25, 25);
    [setButton addTarget:self action:@selector(settingButton) forControlEvents:UIControlEventTouchUpInside];
    [setButton setBackgroundImage:[UIImage imageNamed:@"icon_set"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:setButton];
    
    MeTView *meTView = [MeTView new];
    [self.view addSubview:meTView];
    self.meTView = meTView;
    
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"getInfo" object:nil] subscribeNext:^(id x) {
        @strongify(self);
        
        if (!self.userInfoVM) return ;
        
        self.userInfoVM.userInfoRequest.requestNeedActive = YES;
    }];
}

- (void)setupConstraint
{
    [self.meTView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(16);
    }];
}

- (void)setupBlock
{
    @weakify(self);
    self.meTView.clickBlock = ^(NSString *className) {
        @strongify(self);
        
        UIViewController *subViewController = [[NSClassFromString(className) alloc] init];
        
        if ([subViewController isKindOfClass:[MeInfoVC class]]) {
            
            MeInfoVC *meInfoVC = (MeInfoVC *)subViewController;
            
            meInfoVC.userInfoEntity = self.userInfoVM.userInfoEntity;
            
            @weakify(self);
            meInfoVC.meInfoVCBlock = ^{
                @strongify(self);
                self.userInfoVM.userInfoRequest.requestNeedActive = YES;
            };
            
            
        }
        
        NSMutableArray *arr = [NSMutableArray new];
        for (int i = 0; i<self.userInfoVM.userInfoEntity.communityList.count; i++) {
            CommunityListArrayEntity *model =self.userInfoVM.userInfoEntity.communityList[i] ;
            [arr insertObjects:model.householdList atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, model.householdList.count)]];
//            [arr addObject:model.householdList];
        }

        if ([subViewController isKindOfClass:[MonitorSetVC class]]) {

            MonitorSetVC *meInfoVC = (MonitorSetVC *)subViewController;
            meInfoVC.userInfoEntity = self.userInfoVM.userInfoEntity;
//            @weakify(self);
//            meInfoVC.meInfoVCBlock = ^{
//                @strongify(self);
//                self.userInfoVM.userInfoRequest.requestNeedActive = YES;
//            };
            meInfoVC.communityInfoVCBlock = ^(UserInfoEntity *userInfoEntity){
                self.userInfoVM.userInfoEntity = userInfoEntity;
            };
            
        }
        if ([subViewController isKindOfClass:[WarrantyVC class]]) {
            
            WarrantyVC *meInfoVC = (WarrantyVC *)subViewController;
            meInfoVC.userInfoEntity = self.userInfoVM.userInfoEntity;

            meInfoVC.dataArray = arr;
            
        }
        if ([subViewController isKindOfClass:[MyNeighborhoodVC class]]) {
            
            MyNeighborhoodVC *meInfoVC = (MyNeighborhoodVC *)subViewController;
            meInfoVC.houseList = [self.userInfoVM.userInfoEntity.communityList mutableCopy];
            
        }
        
//        if ([subViewController isKindOfClass:[MeAboutVC class]]) {
//            
//            MeAboutVC *meInfoVC = (MeAboutVC *)subViewController;
//            
//        }
        
        [self.navigationController pushViewController:subViewController animated:YES];
        
    };
}

- (void)settingButton
{
    [self.navigationController pushViewController:[MeSettingVC new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupVM
{
    self.userInfoVM = [UserInfoVM SceneModel];
    
    self.userInfoVM.userInfoRequest.requestNeedActive = YES;
}

- (void)setupRAC
{
    @weakify(self);
    [[RACObserve(self.userInfoVM, userInfoEntity) filter:^BOOL(UserInfoEntity *value) {
        return value != nil;
    }] subscribeNext:^(UserInfoEntity *x) {
        @strongify(self);
        
        self.meTView.userInfoEntity = x;
        
    }];
}

@end

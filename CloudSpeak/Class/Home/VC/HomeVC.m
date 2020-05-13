//
//  HomeVC.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/8.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "HomeVC.h"
#import "MeVC.h"
#import "SDCycleScrollView.h"
#import "HomeFunctionButton.h"
#import "HomeGuardVC.h"
#import "HomeInviteVC.h"
#import "HomeMessageVC.h"
#import "ManageButton.h"
#import "LBXScanViewController.h"
#import "StyleDIY.h"
#import "ManageDetailVC.h"
#import "YBPopupMenu.h"
#import "AYAddPhone.h"
#import "HomeAnnouncementVC.h"
#import "HomeElevatorListVC.h"
#import "HomeVM.h"
#import "PropertyNnoticeListEntity.h"
#import "VersionUpView.h"
#import "VersionUpEntity.h"
#import "CheckAuthorizationVM.h"
#import "CommunityServiceVC.h"
#import "AdvertisingListEntity.h"
@interface HomeVC () <YBPopupMenuDelegate>

@property (strong, nonatomic) SDCycleScrollView *sdCycleScrollView;

@property (strong, nonatomic) UIView *announcementView;

@property (strong, nonatomic) SDCycleScrollView *announcementScrollView;

@property (strong, nonatomic) UILabel *moreLable;

@property (strong, nonatomic) UIImageView *moreImage;

@property (strong, nonatomic) HomeFunctionButton *guardButton;

@property (strong, nonatomic) HomeFunctionButton *inviteButton;

@property (strong, nonatomic) HomeFunctionButton *messageButton;

@property (strong, nonatomic) HomeFunctionButton *elevatorButton;

@property (strong, nonatomic) ManageButton *manageButton;

@property (strong, nonatomic) UIButton *announcementButton;

@property (strong, nonatomic) UIImageView *anouncemenImage;

@property (strong, nonatomic) HomeVM *homeVM;

@property (strong, nonatomic) VersionUpView *versionUpdateView;

@property (assign, nonatomic) BOOL isEngineering;

@property (strong, nonatomic) CheckAuthorizationVM *checkAuthorizationVM;

@property (strong, nonatomic)  UIButton *rightItemButtonB;

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setupConstraint];
    
    [self RACObserve];
    
    [self setupSipServer];

    [self buildVM];
    
    [AYAddPhone setupAYAddPhone:[[LoginEntity shareManager].sipNumber componentsSeparatedByString:@","]];
    [self buildVersion];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"CallOpenVMS" object:nil];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"communityName"];

    if (![name isEqualToString:self.manageButton.titleLabel.text]&&[LoginEntity shareManager].changeVillage.intValue==1) {
        if (!([LoginEntity shareManager].communityList.count>0)||!(name.length>0)) {
            return;
        }
        
//        self.homeVM.loginRequest.requestNeedActive = YES;
        [self.manageButton setTitle:name forState:UIControlStateNormal];
        
        LoginEntity *entitya  = [LoginEntity shareManager];
        NSLog(@"endt==%@",entitya);
        
        NSString *communityName = [[NSUserDefaults standardUserDefaults]objectForKey:@"communityName"];
        
        NSMutableArray *arr = [[LoginEntity shareManager].communityList mutableCopy];
        for (NSDictionary *communityList in [LoginEntity shareManager].communityList) {
            if ([communityList[@"communityName"] isEqualToString:communityName]) {
                [arr removeObject:communityList];
                [arr insertObject:communityList atIndex:0];
            }
        }
        LoginEntity *model = [LoginEntity shareManager];
        model.communityList = [arr copy];
        model.changeVillage= @(0);
        [LoginManage saveEntity:model];

       
        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"CallOpenVM" object:nil];
        
    }
    
    self.homeVM.propertyNnoticeListRequest.communityId = [LoginEntity shareManager].communityList[[[LoginEntity shareManager].page intValue]][@"communityId"];
    self.homeVM.propertyNnoticeListRequest.requestNeedActive = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.checkAuthorizationVM.checkAuthorizationRequest.requestNeedActive = YES;

}
- (void)setupUI
{
    self.title = @"首页";
    self.navigationController.navigationBar.tintColor = TextBlueColor;
    
    UIView *backView = [UIView new];
    backView.frame = CGRectMake(0, 20, SCREEN_WIDTH * 2 / 3, 44);
    self.navigationItem.titleView = backView;
    
    LoginEntity *entity = [LoginEntity shareManager];
    
    if (entity.communityList.count) {
        
        ManageButton *manageButton = [ManageButton setupManageButtonWithImageString:@"home_enter" title:entity.communityList[entity.page.intValue][@"communityName"]];
        [manageButton addTarget:self action:@selector(selectCommunity) forControlEvents:UIControlEventTouchUpInside];
        manageButton.frame = backView.bounds;
        [backView addSubview:manageButton];
        self.manageButton = manageButton;
        
    }
    
    UIButton *leftItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftItemButton.frame = CGRectMake(0, 0, 25, 25);
    [leftItemButton addTarget:self action:@selector(scanMethod) forControlEvents:UIControlEventTouchUpInside];
    [leftItemButton setImage:[UIImage imageNamed:@"scan"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftItemButton];
        
    self.isEngineering = NO;//默认不是工程账号
    
    if ([LoginEntity shareManager].phone.length == 12) {
        self.isEngineering = YES;
    }
    
    SDCycleScrollView *sdCycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:nil placeholderImage:[UIImage imageNamed:@"banner"]];
    sdCycleScrollView.showPageControl = NO;
//    sdCycleScrollView.autoScroll = NO;
    sdCycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:sdCycleScrollView];
    self.sdCycleScrollView = sdCycleScrollView;
    
    UIView *announcementView = [UIView new];
    announcementView.backgroundColor = ViewBGGaryColor;
    [self.view addSubview:announcementView];
    self.announcementView = announcementView;
    
    SDCycleScrollView *announcementScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageNamesGroup:@[@"banner",@"banner",@"banner",@"banner",@"banner",@"banner",@"banner",@"banner",@"banner",@"banner"]];
    announcementScrollView.backgroundColor = ViewBGGaryColor;
    announcementScrollView.showPageControl = NO;
    announcementScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;//竖方向滚动
    announcementScrollView.onlyDisplayText = YES;//只显示文字
    announcementScrollView.titleLabelBackgroundColor = ViewBGGaryColor;
    announcementScrollView.titleLabelTextColor = TextBlueColor;
    announcementScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    [self.announcementView addSubview:announcementScrollView];
    self.announcementScrollView = announcementScrollView;

    UIImageView *anouncemenImage = [UIImageView new];
    anouncemenImage.backgroundColor = ViewBGGaryColor;
    anouncemenImage.image = [UIImage imageNamed:@"icon_notice"];
    [self.announcementView addSubview:anouncemenImage];
    self.anouncemenImage = anouncemenImage;
    
    UIImageView *moreImage = [UIImageView new];
    moreImage.backgroundColor = ViewBGGaryColor;
    moreImage.image = [UIImage imageNamed:@"indicate"];
    [self.announcementView addSubview:moreImage];
    self.moreImage = moreImage;

    UILabel *moreLable = [UILabel new];
    moreLable.text = @"更多";
    moreLable.font = [UIFont systemFontOfSize:14];
    moreLable.textColor = TextBlueColor;
    moreLable.textAlignment = NSTextAlignmentRight;
    [self.announcementView addSubview:moreLable];
    self.moreLable  = moreLable;
    
    UIButton *annuncementButton = [UIButton buttonWithType:UIButtonTypeCustom];
    annuncementButton.backgroundColor = [UIColor clearColor];
    [self.announcementView addSubview:annuncementButton];
    self.announcementButton = annuncementButton;
    
    
    HomeFunctionButton *guardButton = [HomeFunctionButton setupHomeFunctionButtonWithImageString:@"home_monitor" title:@"一键监视"];
    [self.view addSubview:guardButton];
    self.guardButton = guardButton;
    
    HomeFunctionButton *inviteButton = [HomeFunctionButton setupHomeFunctionButtonWithImageString:@"home_visitor" title:@"访客邀请"];
    [self.view addSubview:inviteButton];
    self.inviteButton = inviteButton;
    
    HomeFunctionButton *elevatorButton = [HomeFunctionButton setupHomeFunctionButtonWithImageString:@"home_elevator" title:@"电梯控制"];
    [self.view addSubview:elevatorButton];
    self.elevatorButton = elevatorButton;
    
    HomeFunctionButton *messageButton = [HomeFunctionButton setupHomeFunctionButtonWithImageString:@"icon_service" title:@"社区服务"];
    [self.view addSubview:messageButton];
    self.messageButton = messageButton;
    
    NSMutableArray *array1 = [NSMutableArray array];
    
    NSMutableArray *array2 = [NSMutableArray arrayWithArray:[LoginEntity shareManager].communityList];
    
    for (NSDictionary *list in array2) {
        if (list[@"communityName"]) {
            
            [array1 addObject:list[@"communityName"]];
            
        } else {
            
            [array1 addObject:@""];
        }
    }
    UIButton *rightItemButtonA = [UIButton buttonWithType:UIButtonTypeCustom];
    rightItemButtonA.frame = CGRectMake(0, 0, 25, 25);
    [rightItemButtonA addTarget:self action:@selector(refreshMethod) forControlEvents:UIControlEventTouchUpInside];
    [rightItemButtonA setTintColor:TextBlueColor];
    [rightItemButtonA setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    UIButton *rightItemButtonB = [UIButton buttonWithType:UIButtonTypeCustom];
    rightItemButtonB.frame = CGRectMake(0, 0, 25, 25);
    [rightItemButtonB addTarget:self action:@selector(onLine) forControlEvents:UIControlEventTouchUpInside];
    [rightItemButtonB setTitle:@"离线"  forState:UIControlStateNormal];
    
    self.rightItemButtonB = rightItemButtonB;
    
    UIBarButtonItem *settingBtnItemA = [[UIBarButtonItem alloc] initWithCustomView:rightItemButtonA];
    UIBarButtonItem *settingBtnItemB = [[UIBarButtonItem alloc] initWithCustomView:rightItemButtonB];
    self.navigationItem.rightBarButtonItems  = @[settingBtnItemB,settingBtnItemA];

    self.navigationItem.rightBarButtonItem.tintColor = TextBlueColor;

}
-(void)refreshMethod{
    
    self.checkAuthorizationVM.checkAuthorizationRequest.requestNeedActive = YES;

    self.homeVM.propertyNnoticeListRequest.communityId = [LoginEntity shareManager].communityList[[[LoginEntity shareManager].page intValue]][@"communityId"];
    self.homeVM.propertyNnoticeListRequest.requestNeedActive = YES;
    
    [self onLine];
    
    
}
- (void)onLine
{
    NSString *sipService = @"";
    
    if ([[LoginEntity shareManager].url isEqualToString:@"119.23.146.101:8080/cmp"]) {
        sipService = @"sipproxy.dnake.com:45068";
    } else {
        sipService = @"sipproxy.ucpaas.com:25060";
    }
    [[AYCloudSpeakApi cloudSpeakApi] setSipConfigWithSipServer:sipService sipAccout:[LoginEntity shareManager].sipAccount sipPassword:[LoginEntity shareManager].sipPassword];
}

- (void)setupConstraint
{
    
    [self.sdCycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(kTopHeight);
        if (SCREEN_HEIGHT==480) {
            make.height.mas_equalTo(SCREEN_HEIGHT / 4);
        }else{
            make.height.mas_equalTo(SCREEN_WIDTH / 2);
        }
    }];
    
    [self.announcementView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.sdCycleScrollView.mas_bottom).offset(8);
        make.height.mas_equalTo(40);
    }];
    
    [self.anouncemenImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.announcementView).offset(12);
        make.top.equalTo(self.announcementView.mas_top).offset(8);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(24);
    }];
    
    [self.moreImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.announcementView.mas_right).offset(-8);
        make.centerY.equalTo(self.anouncemenImage.mas_centerY);
        make.width.height.mas_equalTo(24);
    }];
    
    [self.moreLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.moreImage.mas_left).offset(-8);
        make.centerY.equalTo(self.anouncemenImage.mas_centerY);
    }];
    
    [self.announcementScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.announcementView.mas_right).offset(-64);
        make.left.equalTo(self.anouncemenImage.mas_right);
        make.top.equalTo(self.announcementView);
        make.height.mas_equalTo(40);
    }];
    
   
    
    [self.announcementButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(self.announcementView);
    }];
    
    [self.guardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.announcementScrollView.mas_bottom).offset(8);
        make.left.equalTo(self.view.mas_left).offset(16);
        if (SCREEN_HEIGHT==480) {
            make.width.mas_equalTo(SCREEN_HEIGHT / 4);
        }else{
            make.width.mas_equalTo(SCREEN_WIDTH / 2 - 20);
        }
        make.height.equalTo(self.guardButton.mas_width).multipliedBy(0.8);
    }];
    
    [self.inviteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.announcementScrollView.mas_bottom).offset(8);
        make.right.equalTo(self.view.mas_right).offset(-16);
        if (SCREEN_HEIGHT==480) {
            make.width.mas_equalTo(SCREEN_HEIGHT / 4);
        }else{
            make.width.mas_equalTo(SCREEN_WIDTH / 2 - 20);
        }
        make.height.equalTo(self.inviteButton.mas_width).multipliedBy(0.8);
    }];
    
    [self.elevatorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.guardButton.mas_bottom).offset(8);
        make.left.equalTo(self.view.mas_left).offset(16);
        if (SCREEN_HEIGHT==480) {
            make.width.mas_equalTo(SCREEN_HEIGHT / 4);
        }else{
            make.width.mas_equalTo(SCREEN_WIDTH / 2 - 20);
        }
        make.height.equalTo(self.elevatorButton.mas_width).multipliedBy(0.8);
    }];
    
    [self.messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.guardButton.mas_bottom).offset(8);
        make.right.equalTo(self.view.mas_right).offset(-16);
        if (SCREEN_HEIGHT==480) {
            make.width.mas_equalTo(SCREEN_HEIGHT / 4);
        }else{
            make.width.mas_equalTo(SCREEN_WIDTH / 2 - 20);
        }
        make.height.equalTo(self.guardButton.mas_height);
    }];
    
}

- (void)RACObserve
{
    @weakify(self);
    
    
    //社区公告点击事件
    [[self.announcementButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if ([LoginEntity shareManager].phone.length == 12) return [AYProgressHud progressHudShowShortTimeMessage:@"当前账号为工程账号"];
        if (!(self.homeVM.propertyNnoticeListKeys.count>0))return [AYProgressHud progressHudShowShortTimeMessage:@"当前小区无公告"];
        HomeAnnouncementVC *vc = [HomeAnnouncementVC new];
        vc.dataArray = self.homeVM.propertyNnoticeListKeys;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    //一键监视点击事件
    [[self.guardButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        if ([LoginEntity shareManager].phone.length == 12) return [AYProgressHud progressHudShowShortTimeMessage:@"当前账号为工程账号"];
        NSDictionary *dic =  [LoginEntity shareManager].communityList[[[LoginEntity shareManager].page intValue]];
        
        if ([dic[@"cloudSpeakSwitch"] intValue]== 0) return [AYProgressHud progressHudShowShortTimeMessage:@"当前小区禁止"];

        [self.navigationController pushViewController:[HomeGuardVC new] animated:YES];
    }];
    //访客邀请点击事件
    [[self.inviteButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        if ([LoginEntity shareManager].phone.length == 12) return [AYProgressHud progressHudShowShortTimeMessage:@"当前账号为工程账号"];
        [self.navigationController pushViewController:[HomeInviteVC new] animated:YES];
    }];
    //梯控点击事件
    [[self.elevatorButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"logine===%@",[LoginEntity shareManager]);
        if ([LoginEntity shareManager].phone.length == 12) return [AYProgressHud progressHudShowShortTimeMessage:@"当前账号为工程账号"];
        
        
        if([[LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"ladderControlSwitch"] intValue]==0) return [AYProgressHud progressHudShowShortTimeMessage:@"当前小区无梯控"];
//        self.homeVM.authorityRequest.requestNeedActive = YES;
        [self.navigationController pushViewController:[HomeElevatorListVC new] animated:YES];


    }];
    //社区服务点击事件
    [[self.messageButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        CommunityServiceVC *vc = [CommunityServiceVC new];
        vc.dataArray = self.homeVM.propertyNnoticeListKeys;

        [self.navigationController pushViewController:vc animated:YES];
    }];
    if ([LoginEntity shareManager].communityList.count>0) {
        NSString *ladderControlSwitch = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"ladderControlSwitch"];
        if (ladderControlSwitch.intValue==0) {
            self.elevatorButton.isEnble = YES;
        }else{
            self.elevatorButton.isEnble = NO;
        }
    }
   
    
}

- (void)setupSipServer
{
//    [AYTimerCount timerCount];
    
//    [[AYCloudSpeakApi cloudSpeakApi] unRegisterUser];
    
    NSString *sipService = @"";
    
    if ([[LoginEntity shareManager].url isEqualToString:@"119.23.146.101:8080/cmp"]) {
        sipService = @"sipproxy.dnake.com:45068";
    } else {
        sipService = @"sipproxy.ucpaas.com:25060";
    }
    
    [[AYCloudSpeakApi cloudSpeakApi] setSipConfigWithSipServer:sipService sipAccout:[LoginEntity shareManager].sipAccount sipPassword:[LoginEntity shareManager].sipPassword];
    
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"event_registration" object:nil] subscribeNext:^(NSNotification *x) {
        @strongify(self);
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            NSDictionary *dict = x.userInfo;
            
            NSNumber *registrationCode = dict[@"registration"];
            
            //在主线程中更新UI代码
            //(0:注册成功 1：失败)
            if (registrationCode.intValue == 1) {
                
                [self.rightItemButtonB setTitle:@"离线" forState:UIControlStateNormal];;
                self.rightItemButtonB.tintColor = [UIColor lightGrayColor];

                
            } else {
                
                [self.rightItemButtonB setTitle:@"在线" forState:UIControlStateNormal];;
                self.rightItemButtonB.tintColor = TextBlueColor;

            }
            
            
        });
        
        
    }];
    
    //注册SIP服务
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"notificationNetworkChange" object:nil] subscribeNext:^(NSNotification *x) {
        
        if (![LoginEntity shareManager].sipAccount.length) return ;
        
        [[AYCloudSpeakApi cloudSpeakApi] setSipConfigWithSipServer:sipService sipAccout:[LoginEntity shareManager].sipAccount sipPassword:[LoginEntity shareManager].sipPassword];
        
    }];


}

-(void)buildVM{
    
    self.homeVM = [HomeVM SceneModel];
    @weakify(self);
    [RACObserve( self.homeVM, propertyNnoticeListKeys)subscribeNext:^(id x) {
        @strongify(self);
        if (x) {
            if (self.homeVM.propertyNnoticeListKeys.count>0) {
                NSMutableArray *arr = [NSMutableArray new];
                for ( int i=0; i<self.homeVM.propertyNnoticeListKeys.count; i++) {
                    PropertyNnoticeListEntity *model = self.homeVM.propertyNnoticeListKeys[i];
                    [arr addObject:model.noticeTitle];
                }
                self.announcementScrollView.titlesGroup = arr;

            }else{
                self.announcementScrollView.titlesGroup = nil;

            }
            
            

        }
    }];
//    self.homeVM.propertyNnoticeListRequest.communityId = [LoginEntity shareManager].communityList[0][@"communityId"];
//    self.homeVM.propertyNnoticeListRequest.requestNeedActive = YES;
    [RACObserve(self.homeVM, adverArray)subscribeNext:^(id x) {
        @strongify(self);
        if (x) {
            
            NSMutableArray *urlArray = [NSMutableArray new];
            for (int i = 0; i<self.homeVM.adverArray.count; i++) {
                AdvertisingListEntity *model = self.homeVM.adverArray[i];
                NSString *url = [NSString stringWithFormat:@"%@%@",model.domain,model.storeFileName];
                [urlArray addObject:url];
            }
            self.sdCycleScrollView.imageURLStringsGroup = urlArray;
        }
    }];
    self.homeVM.advertisingListRequest.requestNeedActive = YES;
    self.checkAuthorizationVM = [CheckAuthorizationVM SceneModel];
    
    
}
//扫描二维码
- (void)scanMethod
{
    if (![LoginEntity shareManager].communityList.count) return [AYProgressHud progressHudShowShortTimeMessage:@"暂无小区信息"];
    @weakify(self);

    LBXScanViewController *vc = [LBXScanViewController new];
    vc.style = [StyleDIY ZhiFuBaoStyle];
    vc.isOpenInterestRect = YES;
    if (self.isEngineering==NO) {
        vc.isWarranty = 2;
        vc.warrntyBlock = ^(NSArray *code) {
            @strongify(self);
            NSLog(@"code==%@",code);
            if (code.count>1) {
                self.homeVM.deviceUnlockRequest.communityCode = code[1];
            }
            if ([code[0] isEqualToString:@"null"]) {
                return [AYProgressHud progressHudShowShortTimeMessage:@"二维码错误"];
            }
            self.homeVM.deviceUnlockRequest.deviceNum = code[0];
            self.homeVM.deviceUnlockRequest.appUserId = [LoginEntity shareManager].appUserId;
            self.homeVM.deviceUnlockRequest.from = @"qrcode";
            
            self.homeVM.deviceUnlockRequest.requestNeedActive = YES;
            [AYProgressHud progressHudLoadingRequest:self.homeVM.deviceUnlockRequest showInView:self.view detailString:@""];
        };
        
    }else{
        vc.isWarranty= 1;
    }

    [self.navigationController pushViewController:vc animated:YES];
}

- (void)selectCommunity
{
    LoginEntity *entitya  = [LoginEntity shareManager];
    NSLog(@"endt==%@",entitya);

    if (![LoginEntity shareManager].communityList.count) return;
       NSString *communityName = [[NSUserDefaults standardUserDefaults]objectForKey:@"communityName"];

    NSMutableArray *arr = [[LoginEntity shareManager].communityList mutableCopy];
    for (NSDictionary *communityList in [LoginEntity shareManager].communityList) {
        if ([communityList[@"communityName"] isEqualToString:communityName]) {
            [arr removeObject:communityList];
            [arr insertObject:communityList atIndex:0];
        }
    }
    LoginEntity *model = [LoginEntity shareManager];
    model.communityList = [arr copy];
    [LoginManage saveEntity:model];
    
    NSMutableArray *communityNames = [NSMutableArray array];
    
    for (NSDictionary *communityList in [LoginEntity shareManager].communityList) {
        
        [communityNames addObject:communityList[@"communityName"]];
        
    }

    [YBPopupMenu showRelyOnView:self.manageButton titles:communityNames icons:nil menuWidth:150 delegate:self];
    
    
}
//切换小区通知更换个人信息
#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu
{
    
    [self.manageButton setTitle:[LoginEntity shareManager].communityList[index][@"communityName"] forState:UIControlStateNormal];
    
    [LoginEntity shareManager].page = @(index);
    
    self.homeVM.propertyNnoticeListRequest.communityId = [LoginEntity shareManager].communityList[index][@"communityId"];
    self.homeVM.propertyNnoticeListRequest.requestNeedActive = YES;
    NSString *ladderControlSwitch = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"ladderControlSwitch"];
    if (ladderControlSwitch.intValue==0) {
        self.elevatorButton.isEnble = YES;
    }else{
        self.elevatorButton.isEnble = NO;
    }
    
    self.homeVM.advertisingListRequest.requestNeedActive = YES;

//    [[NSNotificationCenter defaultCenter] postNotificationName:@"CallOpenVM" object:nil];

//    [[NSNotificationCenter defaultCenter] postNotificationName:@"getInfo" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)buildVersion{
    
    [[RACObserve(self.homeVM.versionUpRequest, state)filter:^BOOL(id value) {
        return value == RequestStateSuccess;
    }] subscribeNext:^(id x) {
        VersionUpEntity *model = [[VersionUpEntity alloc]initWithDictionary:self.homeVM.versionUpRequest.output[@"version"] error:nil];
//        NSString *appCurVersion = @"1.2.0";

        if ([model.appVersion isEqualToString:appCurVersion]) {
            
        }else{
            if (!(model.appType.intValue==1)) {
                
            }else{
                self.versionUpdateView = [[VersionUpView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                self.versionUpdateView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:0.4];
                self.versionUpdateView.contenText.text = [NSString stringWithFormat:@"系统已更新至%@版本，您需要升级至最新版本方可正常使用该软件",model.appVersion];

                [[UIApplication sharedApplication].keyWindow addSubview:self.versionUpdateView];
            }

        }
    }];
    
    
    
    
}

@end

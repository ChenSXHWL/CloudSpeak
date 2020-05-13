//
//  HomeGuardLocVC.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/15.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "HomeGuardLocVC.h"
#import "HomeGuardLocMonitorView.h"
#import "DGActivityIndicatorView/DGActivityIndicatorView.h"
#import "BHBNetworkSpeed.h"
#import "AYAnalysisXMLData.h"

#import "GuardLocVM.h"
@interface HomeGuardLocVC ()

@property (strong, nonatomic) UIButton *micPhoneButton;

@property (strong, nonatomic) UIButton *openSoundButton;

@property (strong, nonatomic) UIButton *leftItemButton;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) HomeGuardLocMonitorView *homeGuardLocMonitorView;

@property (strong, nonatomic) DGActivityIndicatorView *activityIndicatorView;

@property (assign, nonatomic) BOOL micIsOpen;

@property (assign, nonatomic) BOOL openSoundIsOpen;

@property (assign, nonatomic) BOOL isUnlockFail;

@property (strong, nonatomic) NSTimer *timer;

@property (assign, nonatomic) int count;

@property (strong, nonatomic) UILabel *netSpeedLabel;

@property (strong, nonatomic) GuardLocVM  *guardLocVM;


@end

@implementation HomeGuardLocVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setVM];
    
    [self setupConstraint];
    
    [self setupBlock];
    
    [self forbidLeftSlide];
}

- (void)setupUI
{
    
    self.micIsOpen = YES;
    self.openSoundIsOpen = NO;
    self.isVedio = YES;
    
    self.title = self.getMyKeyEntity.deviceName;
    
    self.view.backgroundColor = RGB(24, 24, 24);
    
    UIImageView *videoView = [UIImageView new];
    videoView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:videoView];
    self.videoView = videoView;
    
    UILabel *netSpeedLabel = [UILabel new];
    netSpeedLabel.text = @"";
    netSpeedLabel.hidden = YES;
    netSpeedLabel.textColor = [UIColor whiteColor];
    netSpeedLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:netSpeedLabel];
    self.netSpeedLabel = netSpeedLabel;
    
    UIButton *micPhoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    micPhoneButton.userInteractionEnabled = NO;
    [micPhoneButton setImage:[UIImage imageNamed:@"mic_off"] forState:UIControlStateNormal];
    [self.view addSubview:micPhoneButton];
    [micPhoneButton addTarget:self action:@selector(micPhoneButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    self.micPhoneButton = micPhoneButton;
    
    UIButton *openSoundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    openSoundButton.userInteractionEnabled = NO;
    [openSoundButton setImage:[UIImage imageNamed:@"speaker_on"] forState:UIControlStateNormal];
    [self.view addSubview:openSoundButton];
    [openSoundButton addTarget:self action:@selector(openSoundButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    self.openSoundButton = openSoundButton;
    
    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallClipRotateMultiple tintColor:[UIColor whiteColor]];
    [videoView addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    self.activityIndicatorView = activityIndicatorView;
    
    [activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(videoView);
    }];
    
    HomeGuardLocMonitorView *homeGuardLocMonitorView = [HomeGuardLocMonitorView new];
    [self.view addSubview:homeGuardLocMonitorView];
    self.homeGuardLocMonitorView = homeGuardLocMonitorView;
    
}
-(void)setVM{
    
    self.guardLocVM = [GuardLocVM SceneModel];
    
    if (self.getMyKeyEntity.buildingCode.length>0) {
        self.guardLocVM.householdInfoRequest.buildingCode = self.getMyKeyEntity.buildingCode;
    }
    if (self.getMyKeyEntity.unitCode.length>0) {
        self.guardLocVM.householdInfoRequest.unitCode = self.getMyKeyEntity.unitCode;
    }
    self.guardLocVM.householdInfoRequest.requestNeedActive = YES;

}
- (void)setupConstraint
{
    
    [self.videoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.4);
        make.top.equalTo(self.view.mas_top).offset(91);
    }];
    
    [self.netSpeedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.videoView.mas_right).offset(-16);
        make.top.equalTo(self.videoView.mas_top).offset(8);
    }];
    
    [self.micPhoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.videoView.mas_left).offset(16);
        make.bottom.equalTo(self.videoView.mas_bottom).offset(-16);
        make.width.height.mas_equalTo(25);
    }];
    
    [self.openSoundButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.micPhoneButton.mas_right).offset(16);
        make.bottom.equalTo(self.videoView.mas_bottom).offset(-16);
        make.width.height.mas_equalTo(25);
    }];
    
    
    [self.homeGuardLocMonitorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.videoView.mas_bottom);
    }];
    
}

- (void)popToVC
{
    
    [super popToVC];
    
    [self closeVideo];
    
}

- (void)closeVideo
{
    [[AYCloudSpeakApi cloudSpeakApi] callStop];
    
    [self.homeGuardLocMonitorView clearTime];
    
    self.homeGuardLocVCBlock(self.homeGuardLocMonitorView.timeLabel.text);
    
    if (self.timer) {
        
        [self.timer invalidate];
        
        self.timer = nil;
        
    }
}

- (void)timeReCount
{
    self.count ++;
    
    if (self.count == 30) {
        
        [self popToVC];
        
        [AYProgressHud progressHudShowShortTimeMessage:@"连接超时，请稍后重试"];
        
    }
    
}

- (void)setupBlock
{
    self.count = 0;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeReCount) userInfo:nil repeats:YES];
    
    //流量数据显示
    [[BHBNetworkSpeed shareNetworkSpeed] startMonitoringNetworkSpeed];
    
    //呼叫
    [[AYCloudSpeakApi cloudSpeakApi] outGoingCallWithCallId:self.getMyKeyEntity.sipAccount];
    
    //挂断
    @weakify(self);
    self.homeGuardLocMonitorView.popBlock = ^(void) {
        @strongify(self);
        
        [self popToVC];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (![AYCloudSpeakApi cloudSpeakApi].isEnterBackground) return ;
            
            [[AYCloudSpeakApi cloudSpeakApi] exitCloudSpeak];
            
            
        });
        
        
    };
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kNetworkReceivedSpeedNotification object:nil] subscribeNext:^(id x) {
        @strongify(self);
        
        self.netSpeedLabel.text = [BHBNetworkSpeed shareNetworkSpeed].receivedNetworkSpeed;
        
    }];
    
    
    //监听设备是否受到APP的呼叫
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"event_call_ringing" object:nil] subscribeNext:^(id x) {
        @strongify(self);
        
        if ([[URLNavigation navigation].currentViewController isKindOfClass:[OpenVC class]]) return ;
        
        [[AYCloudSpeakApi cloudSpeakApi] openView:self.videoView];
        
    }];

    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"event_call_answer" object:nil] subscribeNext:^(id x) {
        @strongify(self);
        
        if ([[URLNavigation navigation].currentViewController isKindOfClass:[OpenVC class]]) return ;
        
        [self.timer invalidate];
        
        self.timer = nil;
        
        [[AYCloudSpeakApi cloudSpeakApi] openMic:self.micIsOpen];
        
        [[AYCloudSpeakApi cloudSpeakApi] openSpe:self.openSoundIsOpen];
        
        self.micPhoneButton.userInteractionEnabled = YES;
        
        self.openSoundButton.userInteractionEnabled = YES;
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [self.homeGuardLocMonitorView setupVedioListen];
        
            [self.activityIndicatorView stopAnimating];
            
            self.netSpeedLabel.hidden = NO;
            
            
        });
        
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"event_call_close" object:nil] subscribeNext:^(id x) {
        @strongify(self);
        
        if ([[URLNavigation navigation].currentViewController isKindOfClass:[OpenVC class]]) return ;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self popToVC];
            
            if (![AYCloudSpeakApi cloudSpeakApi].isEnterBackground) return ;
            
            [[AYCloudSpeakApi cloudSpeakApi] exitCloudSpeak];
            
        });

        
        
    }];
    
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"event_call_status" object:nil] subscribeNext:^(NSNotification *x) {
        
        if ([[URLNavigation navigation].currentViewController isKindOfClass:[OpenVC class]]) return ;
        
        dispatch_sync(dispatch_get_main_queue(), ^{
        
            NSDictionary *dict = x.userInfo;
            
            NSString *error = dict[@"status"] == nil ? @"" : dict[@"status"];
            
            if (error.integerValue < 400) return ;
            
            if ([error isEqualToString:@"404"]) {
                
                [AYProgressHud progressHudShowShortTimeMessage:@"未找到设备"];
                
            } else if ([error isEqualToString:@"486"]) {
                
                [AYProgressHud progressHudShowShortTimeMessage:@"当前设备正忙..."];

            } else {
                
                [AYProgressHud progressHudShowShortTimeMessage:@"连接异常"];
                
            }
            
        });
        
    }];
    
    //开锁
    self.homeGuardLocMonitorView.lockBlock = ^(void) {
        @strongify(self);
        if (self.isTest) {
                [[AYCloudSpeakApi cloudSpeakApi] instantMsgSendWithCallId:self.getMyKeyEntity.sipAccount unLockXML:[AYAnalysisXMLData appendXML]];

        }else{
            if (!(self.guardLocVM.houseArray.count>0)) {
                [AYProgressHud progressHudShowShortTimeMessage:@"数据库异常，住户信息获取不到"];
                return;
            }
            NSString *roomList = [self.guardLocVM.houseArray[0] roomNum];
            
            for (int i = 1; i<self.guardLocVM.houseArray.count; i++) {
                
                HousehoIdInfoEntity *model = self.guardLocVM.houseArray[i];
                roomList = [NSString stringWithFormat:@"%@,%@",roomList,model.roomNum];
            }
            
            [[AYCloudSpeakApi cloudSpeakApi] instantMsgSendWithCallId:self.getMyKeyEntity.sipAccount unLockXML:[AYAnalysisXMLData appendXML:roomList unit:nil room:nil family:nil]];
        }
        
        
        
//        [[AYCloudSpeakApi cloudSpeakApi] instantMsgSendWithCallId:self.getMyKeyEntity.sipAccount unLockXML:[AYAnalysisXMLData appendXML:self.getMyKeyEntity.buildingCode unit:self.getMyKeyEntity.unitCode room:[NSString stringWithFormat:@"%d",self.getMyKeyEntity.roomNum.intValue / 100] family:[NSString stringWithFormat:@"%d",self.getMyKeyEntity.roomNum.intValue % 100]]];

//        [[AYCloudSpeakApi cloudSpeakApi] unLock];
        
        self.isUnlockFail = NO;

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (self.isUnlockFail) return ;
            
            
            [AYProgressHud progressHudShowShortTimeMessage:@"门锁打开失败"];
            
        });
        
        
    };
    
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"event_instant_msg" object:nil] subscribeNext:^(NSNotification *x) {
        @strongify(self);
        
        if ([[URLNavigation navigation].currentViewController isKindOfClass:[OpenVC class]]) return ;
        
        self.isUnlockFail = YES;
        
        NSDictionary *dict = x.userInfo;
        
        NSString *unLock = dict[@"event_url"] == nil ? @"" : dict[@"event_url"];
        
        NSString *resultCode = dict[@"resultCode"] == nil ? @"" : dict[@"resultCode"];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            if ([unLock isEqualToString:@"/talk/unlock"]) {
                
                if (resultCode.intValue == 200) {
                    
                    [self.homeGuardLocMonitorView.homeUnLoadButton setImage:[UIImage imageNamed:@"door_off"] forState:UIControlStateNormal];
                    [self.homeGuardLocMonitorView.homeUnLoadButton setTitle:@"已开锁" forState:UIControlStateNormal];
                    [self.homeGuardLocMonitorView.homeUnLoadButton setTitleColor:TextDeepGaryColor forState:UIControlStateNormal];
                    self.homeGuardLocMonitorView.homeUnLoadButton.userInteractionEnabled = NO;
                    
                    [AYProgressHud progressHudShowShortTimeMessage:@"门锁已打开"];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [self.homeGuardLocMonitorView.homeUnLoadButton setImage:[UIImage imageNamed:@"door_on"] forState:UIControlStateNormal];
                        [self.homeGuardLocMonitorView.homeUnLoadButton setTitle:@"开锁" forState:UIControlStateNormal];
                        [self.homeGuardLocMonitorView.homeUnLoadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        self.homeGuardLocMonitorView.homeUnLoadButton.userInteractionEnabled = YES;
                        
                    });
                    
                } else {
                    
                    [self.homeGuardLocMonitorView.homeUnLoadButton setImage:[UIImage imageNamed:@"door_on"] forState:UIControlStateNormal];
                    
                    [AYProgressHud progressHudShowShortTimeMessage:@"门锁打开失败"];
                    
                    
                }
                
            }
            
            
        });
        
    }];


}

- (void)micPhoneButtonMethod
{
    self.micIsOpen = !self.micIsOpen;
    
    [[AYCloudSpeakApi cloudSpeakApi] openMic:self.micIsOpen];
    
    if (self.micIsOpen) {
        
        [self.micPhoneButton setImage:[UIImage imageNamed:@"mic_off"] forState:UIControlStateNormal];
        
    } else {
        
        [self.micPhoneButton setImage:[UIImage imageNamed:@"mic_on"] forState:UIControlStateNormal];
        
    }
    
}

- (void)openSoundButtonMethod
{
    self.openSoundIsOpen = !self.openSoundIsOpen;
    
    [[AYCloudSpeakApi cloudSpeakApi] openSpe:self.openSoundIsOpen];
    
    if (self.openSoundIsOpen) {
        
        [self.openSoundButton setImage:[UIImage imageNamed:@"speaker"] forState:UIControlStateNormal];
        
    } else {
        
        [self.openSoundButton setImage:[UIImage imageNamed:@"speaker_on"] forState:UIControlStateNormal];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

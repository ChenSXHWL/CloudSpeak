//
//  OpenVC.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/8.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "OpenVC.h"
#import "HomeUnLockButton.h"
#import "GDataXMLNode.h"
#import "UIView+DCAnimationKit.h"
#import "DGActivityIndicatorView/DGActivityIndicatorView.h"
#import "CallOpenVM.h"
#import "AYAnalysisXMLData.h"
#import "OpenTimerView.h"
#import "HomeGuardLocVC.h"
#import "BHBNetworkSpeed.h"

@interface OpenVC ()

@property (strong, nonatomic) UIImageView *videoView;

@property (strong, nonatomic) UIButton *micPhoneButton;
@property (strong, nonatomic) UIButton *refreshPhoneButton;

@property (strong, nonatomic) UIImageView *navImageView;

@property (strong, nonatomic) UIButton *leftItemButton;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIView *backgroundView;

@property (strong, nonatomic) HomeUnLockButton *homePhoneButton;

@property (strong, nonatomic) HomeUnLockButton *homeEndButton;

@property (strong, nonatomic) HomeUnLockButton *homeUnLoadButton;

@property (strong, nonatomic) DGActivityIndicatorView *activityIndicatorView;

@property (strong, nonatomic) CallOpenVM *callOpenVM;

@property (assign, nonatomic) BOOL isCall;

@property (copy, nonatomic) NSString *imgUrl;

@property (assign, nonatomic) BOOL isUnlockFail;

@property (assign, nonatomic) BOOL micIsOpen;

@property (copy, nonatomic) NSString *deviceUid;

@property (strong, nonatomic) OpenTimerView *openTimerView;

@property (strong, nonatomic) NSTimer *timer;

@property (assign, nonatomic) int count;

@property (strong, nonatomic) UILabel *netSpeedLabel;

@property (strong, nonatomic) AVAudioPlayer *audioplayer;

@property (strong, nonatomic) NSTimer *refeTimer;

@end

@implementation OpenVC

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.openTimerView clearTime];
        
    if (self.timer) {
        
        [self.timer invalidate];
        
        self.timer = nil;
    }
    
    if (self.audioplayer) {
        
        [self.audioplayer stop];
        
        self.audioplayer = nil;
    }
    
    
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setupConstraint];
    
    [self setupVM];
    
    [self setupNotifiction];
    
    [self playSound];
    
}

- (void)playSound
{
    //1.音频文件的url路径
    NSURL *url=[[NSBundle mainBundle]URLForResource:@"happy.wav" withExtension:Nil];
    
    //2.创建播放器（注意：一个AVAudioPlayer只能播放一个url）
    self.audioplayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:Nil];
    
    self.audioplayer.numberOfLoops = -1;
    
    //3.缓冲
    [self.audioplayer prepareToPlay];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    //4.播放
    [self.audioplayer play];
}

- (void)setupUI
{
    self.micIsOpen = NO;
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
    
    UIButton *refreshPhoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    refreshPhoneButton.enabled = YES;
    [refreshPhoneButton setImage:[UIImage imageNamed:@"refreshPhone_in"] forState:UIControlStateNormal];
    [self.view addSubview:refreshPhoneButton];
    [refreshPhoneButton addTarget:self action:@selector(refreshPhoneButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    self.refreshPhoneButton = refreshPhoneButton;
    
    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallClipRotateMultiple tintColor:[UIColor whiteColor]];
    [videoView addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    self.activityIndicatorView = activityIndicatorView;
    
    [activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(videoView);
    }];
    
    
    UIImageView *navImageView = [UIImageView new];
    navImageView.userInteractionEnabled = YES;
    navImageView.backgroundColor = RGBA(0, 0, 0, 0);
    [self.view addSubview:navImageView];
    self.navImageView = navImageView;
    
//    UIButton *leftItemButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [leftItemButton setImage:[UIImage imageNamed:@"icon_return_in"] forState:UIControlStateNormal];
//    leftItemButton.tintColor = [UIColor whiteColor];
//    [navImageView addSubview:leftItemButton];
//    self.leftItemButton = leftItemButton;
//    [leftItemButton addTarget:self action:@selector(returnLastPageClass) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = [UIFont systemFontOfSize:19];
    titleLabel.text = @"";
    titleLabel.textColor = [UIColor whiteColor];
    [navImageView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIView *backgroundView = [UIView new];
    [self.view addSubview:backgroundView];
    self.backgroundView = backgroundView;
    
    OpenTimerView *openTimerView = [OpenTimerView new];
    [backgroundView addSubview:openTimerView];
    self.openTimerView = openTimerView;
    
    HomeUnLockButton *homeUnLoadButton = [HomeUnLockButton setupHomeUnLockButtonWithImageString:@"door_on" title:@"开锁"];
    homeUnLoadButton.backgroundColor = [UIColor clearColor];
    [homeUnLoadButton addTarget:self action:@selector(openLockButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    [homeUnLoadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backgroundView addSubview:homeUnLoadButton];
    self.homeUnLoadButton = homeUnLoadButton;
    
    HomeUnLockButton *homeEndButton = [HomeUnLockButton setupHomeUnLockButtonWithImageString:@"monitor_hangup" title:@"挂断"];
    homeEndButton.backgroundColor = [UIColor clearColor];
    [homeEndButton addTarget:self action:@selector(stopListenButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    [homeEndButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backgroundView addSubview:homeEndButton];
    self.homeEndButton = homeEndButton;
    
    HomeUnLockButton *homePhoneButton = [HomeUnLockButton setupHomeUnLockButtonWithImageString:@"door_answer" title:@"接听"];
    homePhoneButton.backgroundColor = [UIColor clearColor];
    [homePhoneButton addTarget:self action:@selector(startListenButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    [homePhoneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backgroundView addSubview:homePhoneButton];
    self.homePhoneButton = homePhoneButton;
    
    
}

- (void)setupConstraint
{
    
    [self.videoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(91);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.4);
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
    
    [self.refreshPhoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.videoView.mas_right).offset(-16);
        make.bottom.equalTo(self.videoView.mas_bottom).offset(-16);
        make.width.height.mas_equalTo(25);
    }];
    
    [self.navImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(64);
    }];
    
//    [self.leftItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.navImageView.mas_left).offset(16);
//        make.top.equalTo(self.navImageView.mas_top).offset(30);
//    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.navImageView.mas_centerX);
        make.centerY.equalTo(self.navImageView.mas_centerY).offset(16);
    }];
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.videoView.mas_bottom);
    }];
    
    [self.openTimerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backgroundView);
        make.height.mas_equalTo(30);
        make.centerY.equalTo(self.backgroundView.mas_centerY).offset(-60);
    }];
    
    [self.homeUnLoadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.backgroundView.mas_width).multipliedBy(0.33);
        make.centerY.equalTo(self.backgroundView.mas_centerY).offset(80);
        make.centerX.equalTo(self.backgroundView.mas_centerX);
        make.height.equalTo(self.homePhoneButton.mas_width).multipliedBy(0.9);
    }];
    
    [self.homeEndButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.backgroundView.mas_left).offset(0);
        make.right.equalTo(self.homeUnLoadButton.mas_left);
        make.centerY.equalTo(self.backgroundView.mas_centerY).offset(80);
        make.height.equalTo(self.homePhoneButton.mas_width).multipliedBy(0.9);
        
    }];
    
    [self.homePhoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.backgroundView.mas_right).offset(0);
        make.left.equalTo(self.homeUnLoadButton.mas_right);
        make.centerY.equalTo(self.backgroundView.mas_centerY).offset(80);
        make.height.equalTo(self.homeEndButton.mas_width).multipliedBy(0.9);
    }];
    
}

- (void)setupVM
{
    self.callOpenVM = [CallOpenVM SceneModel];
    
    @weakify(self);
    [[RACObserve(self.callOpenVM, getMyKeys) filter:^BOOL(NSMutableArray *value) {
        return value != nil;
    }] subscribeNext:^(NSMutableArray *getMyKeys) {
        @strongify(self);
        
        NSNumber *cloudSwitchNum = self.callOpenVM.getMyKeyRequest.output[@"cloudSwitch"];
        
        if (cloudSwitchNum.intValue == 0) {
            [self.homePhoneButton setImage:[UIImage imageNamed:@"door_answer_in"] forState:UIControlStateNormal];
            self.homePhoneButton.userInteractionEnabled = NO;
            
        } else {
            self.homePhoneButton.userInteractionEnabled = YES;
            [self.homePhoneButton setImage:[UIImage imageNamed:@"door_answer"] forState:UIControlStateNormal];
        }
        
        if (getMyKeys.count == 0) return ;
        for (GetMyKeyEntity *entity in getMyKeys) {
            if ([entity.sipAccount isEqualToString:self.callId]) {
                self.titleLabel.text = entity.deviceName;
                self.deviceUid = entity.deviceNum;
                self.roomNum = entity.roomNum;
                self.unitCode = entity.unitCode;
                self.buildingCode = entity.buildingCode;
            }
        }
    }];
    [[RACObserve(self.callOpenVM, takePhotoString) filter:^BOOL(NSString *value) {
        return value != nil;
    }] subscribeNext:^(NSMutableArray *getMyKeys) {
        @strongify(self);
        self.imageUrl = self.callOpenVM.takePhotoString;
    }];
}

- (void)returnLastPageClass
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)stopListenButtonMethod
{
    [[AYCloudSpeakApi cloudSpeakApi] callStop];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)startListenButtonMethod
{
    
    if (self.isCall) {
        //截图
        [[AYCloudSpeakApi cloudSpeakApi] videoSnapshot];
        
    } else {
        self.refreshPhoneButton.enabled = NO;
        [self.refreshPhoneButton setImage:[UIImage imageNamed:@"refreshPhone"] forState:UIControlStateNormal];
        
        self.homePhoneButton.userInteractionEnabled = NO;
        
        [[AYCloudSpeakApi cloudSpeakApi] respondDev];
        
        [self.audioplayer stop];
        
        self.audioplayer = nil;
        
    }

}

- (void)openLockButtonMethod
{
    
    
    
    
//    [[AYCloudSpeakApi cloudSpeakApi] instantMsgSendWithCallId:self.callId unLockXML:[AYAnalysisXMLData appendXML]];
    
    [[AYCloudSpeakApi cloudSpeakApi] instantMsgSendWithCallId:self.callId unLockXML:[AYAnalysisXMLData appendXML:self.buildingCode unit:self.unitCode room:[NSString stringWithFormat:@"%d",self.roomNum.intValue / 100] family:[NSString stringWithFormat:@"%d",self.roomNum.intValue % 100]]];

    
//    [[AYCloudSpeakApi cloudSpeakApi] unLock];
    
    self.isUnlockFail = NO;

    [self.homeUnLoadButton tada:NULL];
    
    self.callOpenVM.callOpenRequest.deviceNum = self.deviceUid;
    
    self.callOpenVM.callOpenRequest.imgUrl = self.imageUrl;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (self.isUnlockFail) return ;
        
        self.callOpenVM.callOpenRequest.requestNeedActive = YES;
        
        [AYProgressHud progressHudShowShortTimeMessage:@"门锁打开失败"];
        
    });
    
}

- (void)timeReCount
{
    self.count ++;
    
    if (self.count == 30) {
        
        [[AYCloudSpeakApi cloudSpeakApi] callStop];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        [AYProgressHud progressHudShowShortTimeMessage:@"连接超时，请稍后重试"];
        
    }
    
}

- (void)setupNotifiction
{
    
    @weakify(self);
    
    self.openTimerView.block = ^(void) {
        @strongify(self);
        [self stopListenButtonMethod];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (![AYCloudSpeakApi cloudSpeakApi].isEnterBackground) return ;
            
            [[AYCloudSpeakApi cloudSpeakApi] exitCloudSpeak];
            
        });
    };
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kNetworkReceivedSpeedNotification object:nil] subscribeNext:^(id x) {
        @strongify(self);
        
        if ([[URLNavigation navigation].currentViewController isKindOfClass:[HomeGuardLocVC class]]) return ;
        
        self.netSpeedLabel.text = [BHBNetworkSpeed shareNetworkSpeed].receivedNetworkSpeed;
        
    }];
    
    //监听设备是否受到APP的呼叫
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"event_call_ringing" object:nil] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.timer invalidate];
        
        self.timer = nil;
        
        [[AYCloudSpeakApi cloudSpeakApi] openView:self.videoView];
        
        [[AYCloudSpeakApi cloudSpeakApi] openMic:self.micIsOpen];
        
        
    }];
    
    self.count = 0;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeReCount) userInfo:nil repeats:YES];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"event_call_status" object:nil] subscribeNext:^(NSNotification *x) {
        
        if ([[URLNavigation navigation].currentViewController isKindOfClass:[HomeGuardLocVC class]]) return ;
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            @strongify(self);
            
            NSDictionary *dict = x.userInfo;
            
            NSString *error = dict[@"status"] == nil ? @"" : dict[@"status"];
            
            if (error.integerValue < 400) {
                
                if (error.integerValue == 200) {
                    
                    [self.timer invalidate];
                    
                    self.timer = nil;
                    
                    [[AYCloudSpeakApi cloudSpeakApi] openView:self.videoView];
                    
                    [[AYCloudSpeakApi cloudSpeakApi] openMic:self.micIsOpen];
                    
                    [self.activityIndicatorView stopAnimating];
                    
                    self.micPhoneButton.userInteractionEnabled = YES;
                    
                    self.homePhoneButton.userInteractionEnabled = YES;
                    
                    [self.homePhoneButton setTitle:@"拍照" forState:UIControlStateNormal];
                    
                    [self.homePhoneButton setImage:[UIImage imageNamed:@"monitor_"] forState:UIControlStateNormal];
                    
                    [self.micPhoneButton setImage:[UIImage imageNamed:@"mic_on"] forState:UIControlStateNormal];
                    
                    self.isCall = YES;
                    
                    [self.openTimerView setupVedioListen];
                    
                    self.netSpeedLabel.hidden = NO;
                    
                }
                
                
                return ;
            }
            
            if ([error isEqualToString:@"404"]) {
                
                [AYProgressHud progressHudShowShortTimeMessage:@"未找到设备"];
                
            } else if ([error isEqualToString:@"486"]) {
                
                [AYProgressHud progressHudShowShortTimeMessage:@"当前设备正忙..."];
                
            } else {
                
                [AYProgressHud progressHudShowShortTimeMessage:@"连接异常"];
                
            }
            
        });
        
        
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"event_call_close" object:nil] subscribeNext:^(id x) {
        @strongify(self);
        
        if ([[URLNavigation navigation].currentViewController isKindOfClass:[HomeGuardLocVC class]]) return ;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            [self dismissViewControllerAnimated:YES completion:nil];
            
            if (![AYCloudSpeakApi cloudSpeakApi].isEnterBackground) return ;
            
            [[AYCloudSpeakApi cloudSpeakApi] exitCloudSpeak];
            
            
        });

        
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"event_instant_msg" object:nil] subscribeNext:^(NSNotification *x) {
        @strongify(self);
        
        if ([[URLNavigation navigation].currentViewController isKindOfClass:[HomeGuardLocVC class]]) return ;
        
        self.isUnlockFail = YES;
        
        NSDictionary *dict = x.userInfo;
        
        NSString *unLock = dict[@"event_url"] == nil ? @"" : dict[@"event_url"];
        
        NSString *resultCode = dict[@"resultCode"] == nil ? @"" : dict[@"resultCode"];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            if ([unLock isEqualToString:@"/talk/unlock"]) {
                
                if (resultCode.intValue == 200) {
                    
                    [self.homeUnLoadButton setImage:[UIImage imageNamed:@"door_off"] forState:UIControlStateNormal];
                    [self.homeUnLoadButton setTitle:@"已开锁" forState:UIControlStateNormal];
                    [self.homeUnLoadButton setTitleColor:TextDeepGaryColor forState:UIControlStateNormal];
                    self.homeUnLoadButton.userInteractionEnabled = NO;
                    
                    [AYProgressHud progressHudShowShortTimeMessage:@"门锁已打开"];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [self.homeUnLoadButton setImage:[UIImage imageNamed:@"door_on"] forState:UIControlStateNormal];
                        [self.homeUnLoadButton setTitle:@"开锁" forState:UIControlStateNormal];
                        [self.homeUnLoadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        self.homeUnLoadButton.userInteractionEnabled = YES;
                        
                    });
                    
                } else {
                    
                    [self.homeUnLoadButton setImage:[UIImage imageNamed:@"door_on"] forState:UIControlStateNormal];
                    
                    [AYProgressHud progressHudShowShortTimeMessage:@"门锁打开失败"];
                    
                    self.callOpenVM.callOpenRequest.requestNeedActive = YES;
                    
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
-(void)refreshPhoneButtonMethod{
    self.callOpenVM.takePhotoRequest.householdId = [LoginEntity shareManager].communityList[[[LoginEntity shareManager].page intValue]][@"householdId"];
    self.callOpenVM.takePhotoRequest.deviceSip = self.callId;
    self.callOpenVM.takePhotoRequest.requestNeedActive = YES;
    self.refreshPhoneButton.enabled = NO;
    [self.refreshPhoneButton setImage:[UIImage imageNamed:@"refreshPhone"] forState:UIControlStateNormal];
    self.refeTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(refreshPhone) userInfo:nil repeats:YES];
    
}
-(void)refreshPhone{
    self.refeTimer = nil;
    [self.refeTimer invalidate];
    self.refreshPhoneButton.enabled = YES;
    [self.refreshPhoneButton setImage:[UIImage imageNamed:@"refreshPhone_in"] forState:UIControlStateNormal];
    
}
- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    
    [self.videoView imageShwoActivityIndicatorWithUrlString:[NSString stringWithFormat:@"%@", imageUrl] placeHolder:nil];

//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSURL * url = [NSURL URLWithString:imageUrl];
//        NSData * data = [[NSData alloc]initWithContentsOfURL:url];
//        UIImage *image = [[UIImage alloc]initWithData:data];
//        if (data != nil) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                self.videoView.image = image;
//            });
//        }  
//    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end

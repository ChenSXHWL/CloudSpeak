//
//  OpenView.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/22.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "OpenView.h"
#import "CountryPicker.h"
#import "UIView+DCAnimationKit.h"
#import "AYAnalysisXMLData.h"

@interface OpenView () <CountryPickerDelegate>

@property (strong, nonatomic) CountryPicker *countryPicker;

@property (strong, nonatomic) UIButton *deleteButton;

@property (strong, nonatomic) UIView *openView;

@property (strong, nonatomic) UIImageView *lockImageView;


@property (copy, nonatomic) NSString *deviceNum;
@property (copy, nonatomic) NSString *sipAccout;
@property (copy, nonatomic) NSString *buildingCode;
@property (copy, nonatomic) NSString *unitCode;
@property (copy, nonatomic) NSString *roomNum;

@property (assign, nonatomic) BOOL isUnlockFail;

@property (copy, nonatomic) NSString *isOnline;
@property (assign, nonatomic) BOOL isLogin;
//@property (assign, nonatomic) int row;
@property (strong, nonatomic) RefreshDevicesRequest *refreshDevicesRequest;

@end

@implementation OpenView


+ (instancetype)setupOpenView{
    return [[self alloc]initWithFrame:[UIScreen mainScreen].bounds];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupUI];
        
        [self setupVM];
        
        [self setupRAC];
        @weakify(self);
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"event_call_invite" object:nil] subscribeNext:^(NSNotification *x) {
            @strongify(self);
            dispatch_sync(dispatch_get_main_queue(), ^{

            [self deleteOpenView];
            });
        }];

    }
    return self;
}

- (void)setupUI
{
//    self.phone = [LoginEntity shareManager].phone;

//    self.hidden = YES;
    
    self.backgroundColor = RGBA(0, 0, 0, 0.8);
    
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [deleteButton setBackgroundImage:[UIImage imageNamed:@"door_delete"] forState:UIControlStateNormal];
    deleteButton.tintColor = [UIColor whiteColor];
    [self addSubview:deleteButton];
    self.deleteButton = deleteButton;
    [deleteButton addTarget:self action:@selector(deleteOpenView) forControlEvents:UIControlEventTouchUpInside];
    
    CountryPicker *picker = [CountryPicker new];
    picker.delegate = self;
    picker.backgroundColor = RGBA(255, 255, 255, 1);
    picker.layer.cornerRadius = 20;
    [self exChangeOut:picker dur:0.6];
    [self addSubview:picker];
    self.countryPicker = picker;
    
    UIView *openView = [UIView new];
    openView.layer.cornerRadius = SCREEN_WIDTH * 0.1;
    openView.backgroundColor = TextBlueColor;
    [self addSubview:openView];
    self.openView = openView;
    
    UIImageView *lockImageView = [UIImageView new];
    lockImageView.image = [UIImage imageNamed:@"door_on_open"];
    lockImageView.userInteractionEnabled = YES;
    [openView addSubview:lockImageView];
    self.lockImageView = lockImageView;
    
    @weakify(self);
    [openView whenTapped:^{
        @strongify(self);
        [self openLockMethod];
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(25);
        if (iPhoneX) {
            make.bottom.equalTo(self.mas_bottom).offset(-49);
        }else{
            make.bottom.equalTo(self.mas_bottom).offset(-25);
        }
        make.centerX.equalTo(self.mas_centerX);
    }];

    [self.countryPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH - 120);
        make.height.mas_equalTo(SCREEN_WIDTH - 60);
    }];

    [self.openView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.countryPicker.mas_centerX);
        make.centerY.equalTo(self.countryPicker.mas_bottom);
        make.width.height.mas_equalTo(SCREEN_WIDTH * 0.2);
    }];
    
    [self.lockImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.openView);
        make.width.height.equalTo(self.openView).multipliedBy(0.3);
    }];
}

- (void)setupVM
{
    self.callOpenVM = [CallOpenVM SceneModel];
  
    @weakify(self);
    
    [[RACObserve(self.callOpenVM, houseArray) filter:^BOOL(NSMutableArray *value) {
        return value != nil;
    }] subscribeNext:^(NSMutableArray *x) {
        @strongify(self);
        
        if (x.count) {

        }
    }];
  
    self.refreshDevicesRequest = [RefreshDevicesRequest Request];
    self.refreshDevicesRequest.communityCode = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue] [@"communityCode"];
    [[SceneModel SceneModel] SEND_ACTION:self.refreshDevicesRequest];
}

- (void)setupRAC
{
    @weakify(self);
    [[RACObserve(self.callOpenVM, getMyKeys) filter:^BOOL(NSMutableArray *value) {
        return value != nil;
    }] subscribeNext:^(NSMutableArray *x) {
        @strongify(self);
        
        if (x.count == 0&&self.isLogin==NO) {
            
            self.hidden = YES;
            
            return [AYProgressHud progressHudShowShortTimeMessage:@"查询不到门锁"];
        }
        
        self.hidden = NO;
        
        NSMutableArray *names = [NSMutableArray array];
        
        NSMutableArray *codes = [NSMutableArray array];
        
        NSMutableArray *onLines = [NSMutableArray array];
        
        NSMutableArray *deviceNum = [NSMutableArray array];
        
        for (GetMyKeyEntity *entity in x) {
            
            [names addObject:entity.deviceName.length ? entity.deviceName : @""];
            
            [codes addObject:entity.roomNum ? entity.roomNum : @""];
            
            [onLines addObject:entity.onlineStatus ? entity.onlineStatus : @""];
            
            [deviceNum addObject:entity.sipAccount ? entity.sipAccount : @""];
            
        }
        
       
        
//        if ([self.phone isEqualToString:[LoginEntity shareManager].phone]) {
//            
//        }else{
//            self.row = 0;
//            self.phone = [LoginEntity shareManager].phone;
//        }
        
        self.sipAccout = [self.callOpenVM.getMyKeys[0] sipAccount];
        self.deviceNum = [self.callOpenVM.getMyKeys[0] deviceNum];
        self.roomNum = [self.callOpenVM.getMyKeys[0] roomNum];
        self.unitCode = [self.callOpenVM.getMyKeys[0] unitCode];
        self.buildingCode = [self.callOpenVM.getMyKeys[0] buildingCode];
//        if (self.buildingCode.length>0) {
//            self.callOpenVM.householdInfoRequest.buildingCode = self.buildingCode;
//        }
//        if (self.unitCode.length>0) {
//            self.callOpenVM.householdInfoRequest.unitCode = self.unitCode;
//        }
        self.callOpenVM.householdInfoRequest.requestNeedActive = YES;
        
        self.countryPicker.names = (NSArray *)names;
        
        self.countryPicker.codes = (NSArray *)codes;
        
        self.countryPicker.isOnlines = (NSArray *)onLines;
        
        [self.countryPicker reloadAllComponents];
        
        self.sipAccout = deviceNum[0];
        
        self.callOpenVM.callOpenRequest.deviceNum = [(GetMyKeyEntity *)x[0] deviceNum];
        
        self.callOpenVM.callOpenRequest.imgUrl = @"";
        
        self.isOnline = self.countryPicker.isOnlines[0];
        
    }];
    
//    [[RACObserve(self.callOpenVM.deviceUnlockRequest, state) filter:^BOOL(id value) {
//        return value == RequestStateSuccess;
//    }] subscribeNext:^(id x) {
//            AYProgressHud
//    }];
}

- (void)openLockMethod
{
    
//    if (!self.isOnline.integerValue) return [AYProgressHud progressHudShowShortTimeMessage:@"该设备不在线"];
    
    self.isUnlockFail = NO;
    LoginEntity *model = [LoginEntity shareManager];
    if ([model.communityList[model.page.intValue][@"ladderControlSwitch"] isKindOfClass:[NSNull class]]) {
        
        [[AYCloudSpeakApi cloudSpeakApi] instantMsgSendWithCallId:self.sipAccout unLockXML:[AYAnalysisXMLData appendXML]];

    }else{
        if([[LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"ladderControlSwitch"] intValue]==0){
            [[AYCloudSpeakApi cloudSpeakApi] instantMsgSendWithCallId:self.sipAccout unLockXML:[AYAnalysisXMLData appendXML]];
        }else{
            if (!(self.callOpenVM.houseArray.count>0)) {
                [AYProgressHud progressHudShowShortTimeMessage:@"数据库异常，住户信息获取不到"];
                return;
            }
            NSString *roomList = [self.callOpenVM.houseArray[0] roomNum];

            for (int i = 1; i<self.callOpenVM.houseArray.count; i++) {
                
                HousehoIdInfoEntity *model = self.callOpenVM.houseArray[i];
                roomList = [NSString stringWithFormat:@"%@,%@",roomList,model.roomNum];
            }
            [[AYCloudSpeakApi cloudSpeakApi] instantMsgSendWithCallId:self.sipAccout unLockXML:[AYAnalysisXMLData appendXML:roomList unit:nil room:nil family:nil]];
            
            //        [[AYCloudSpeakApi cloudSpeakApi] instantMsgSendWithCallId:self.deviceNum unLockXML:[AYAnalysisXMLData appendXML:sel.buildingCode unit:self.unitCode room:[NSString stringWithFormat:@"%d",self.roomNum.intValue / 100] family:[NSString stringWithFormat:@"%d",self.roomNum.intValue % 100]]];
        }
    }
    self.callOpenVM.deviceUnlockRequest.deviceNum = self.deviceNum;
    self.callOpenVM.deviceUnlockRequest.requestNeedActive = YES;
    
    [self.lockImageView tada:NULL];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (self.isUnlockFail) return ;
        
        self.isUnlockFail = YES;
        
        self.callOpenVM.callOpenRequest.requestNeedActive = YES;
        
        [AYProgressHud progressHudShowShortTimeMessage:@"门锁打开失败"];
        
    });
    
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"event_instant_msg" object:nil] subscribeNext:^(NSNotification *x) {
        @strongify(self);
        
        self.isUnlockFail = YES;
        
        NSDictionary *dict = x.userInfo;
        
        NSString *unLock = dict[@"event_url"];
        
        NSString *resultCode = dict[@"resultCode"];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            if ([unLock isEqualToString:@"/talk/unlock"]) {
                
                if (resultCode.intValue == 200) {
                    
                    self.lockImageView.image = [UIImage imageNamed:@"door_off_close"];
                    
                    [AYProgressHud progressHudShowShortTimeMessage:@"门锁已打开"];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        self.lockImageView.image = [UIImage imageNamed:@"door_on_open"];
                        
                        [self deleteOpenView];
                        
                    });
                    
                    
                } else {
                    
                    self.lockImageView.image = [UIImage imageNamed:@"door_on_open"];
                    
                    [AYProgressHud progressHudShowShortTimeMessage:@"门锁打开失败"];
                    
                    self.callOpenVM.callOpenRequest.requestNeedActive = YES;
                    
                }
                
            }
            
            
        });
        
    }];
}

- (void)deleteOpenView
{
    [UIView animateWithDuration:0.3 animations:^{
//        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];
    }];
}

- (void)countryPicker:(__unused CountryPicker *)picker didSelectCountryWithName:(NSString *)name code:(NSString *)code
{
    
}

- (void)countryPicker:(CountryPicker *)picker didSelectRow:(NSInteger)row
{
    self.sipAccout = [self.callOpenVM.getMyKeys[row] sipAccount];
    self.deviceNum = [self.callOpenVM.getMyKeys[row] deviceNum];

    self.roomNum = [self.callOpenVM.getMyKeys[row] roomNum];
    self.unitCode = [self.callOpenVM.getMyKeys[row] unitCode];
    self.buildingCode = [self.callOpenVM.getMyKeys[row] buildingCode];
    
    self.callOpenVM.callOpenRequest.deviceNum = [self.callOpenVM.getMyKeys[row] deviceNum];
//    if (self.buildingCode.length>0) {
//        self.callOpenVM.householdInfoRequest.buildingCode = self.buildingCode;
//    }
//    if (self.unitCode.length>0) {
//        self.callOpenVM.householdInfoRequest.unitCode = self.unitCode;
//    }
    self.callOpenVM.householdInfoRequest.requestNeedActive = YES;
    
    self.isOnline = picker.isOnlines[(NSInteger)row];//    self.row = row;
}

- (void)setLayerInfo
{
    //create path
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
//    // MARK: circlePath
//    [path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(SCREEN_WIDTH / 2, 200) radius:100 startAngle:0 endAngle:2*M_PI clockwise:NO]];
    
    // MARK: roundRectanglePath
    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(60,(SCREEN_HEIGHT - SCREEN_WIDTH - 30) / 2,SCREEN_WIDTH - 120, SCREEN_WIDTH - 60) cornerRadius:15] bezierPathByReversingPath]];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.path = path.CGPath;
    
    [self.layer setMask:shapeLayer];
}

-(void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur{
    
    CAKeyframeAnimation * animation;
    
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = dur;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    [changeOutView.layer addAnimation:animation forKey:nil];
}

@end

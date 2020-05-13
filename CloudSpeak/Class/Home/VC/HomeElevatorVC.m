//
//  HomeElevatorVC.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/13.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "HomeElevatorVC.h"
#import "AYAnalysisXMLData.h"
#import "ElevatorControlRequest.h"
#import "DevelopmentElevatorRequest.h"
@interface HomeElevatorVC ()
@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) NSString *sipAccount;

@property (assign, nonatomic) int roomRow;

@property (strong, nonatomic)ElevatorControlRequest *elevatorControlRequest;

@property (strong, nonatomic)DevelopmentElevatorRequest *developmentElevatorRequest;

@property (strong, nonatomic) NSArray *sipArray;

@property (strong, nonatomic) UILabel *floorLable;

@end

@implementation HomeElevatorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.title = [NSString stringWithFormat:@"%@-%@",self.groupUnitEntity.buildingName,self.groupUnitEntity.unitName];
    
    
    [self buildUI];
    [self buildVM];
    self.sipArray = [self.groupUnitEntity.sipAccount componentsSeparatedByString:@","];
    for (int i = 0; i<self.sipArray.count; i++) {
        if ([self.sipArray[i] length]>10) {
            self.sipAccount = self.sipArray[i];
        }
    }
    
    [[AYCloudSpeakApi cloudSpeakApi] instantMsgSendWithCallId:self.sipAccount unLockXML:[AYAnalysisXMLData appendJoin]];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"event_instant_msg" object:nil] subscribeNext:^(NSNotification *x) {
        NSDictionary *dict = x.userInfo;
        
        NSString *unLock = dict[@"event_url"] == nil ? @"" : dict[@"event_url"];
        
        NSString *resultCode = dict[@"resultCode"] == nil ? @"" : dict[@"resultCode"];
        if ([unLock isEqualToString:@"/elev/appoint"]) {
            
            if (resultCode.intValue == 200) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    [AYProgressHud progressHudShowShortTimeMessage:@"电梯调用成功"];
                });
            }
        }else if ([unLock isEqualToString:@"/elev/permit"]){
            if (resultCode.intValue == 200) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    [AYProgressHud progressHudShowShortTimeMessage:[NSString stringWithFormat:@"已对您开放%@-%@-%@楼层",self.groupUnitEntity.buildingName,self.groupUnitEntity.unitName,[NSString stringWithFormat:@"%d",[self.roomArray[self.roomRow] intValue]/100]]];
                });
                
            }
        }
    }];
    
    
    // Do any additional setup after loading the view.
}
-(void)buildUI{
    
    
    self.roomRow = 0;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kTopHeight, SCREEN_WIDTH, 124)];
    self.scrollView.contentSize = CGSizeMake(self.roomArray.count*SCREEN_WIDTH/3+32, 0);  //非常重要
    self.scrollView.contentOffset =  CGPointMake(0, 0);
    //    scrollView.backgroundColor = [UIColor redColor];
    //显示水平方向的滚动条(默认YES)
    self.scrollView.showsHorizontalScrollIndicator = NO;
    //显示垂直方向的滚动条(默认YES)
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    for (int i = 0; i < self.roomArray.count; i++) {
        UIView *deviceView = [UIView new];
        deviceView.backgroundColor = [UIColor whiteColor];
        deviceView.layer.cornerRadius = 36;
        deviceView.layer.masksToBounds = YES;
        deviceView.tag = 100+i;
        [self.scrollView addSubview:deviceView];
        [deviceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scrollView.mas_left).offset(SCREEN_WIDTH/3 * (i) + 32);
            make.top.equalTo(self.scrollView.mas_top).offset(30);
            make.height.width.mas_equalTo(72);
        }];
        @weakify(self);
        [deviceView whenTapped:^{
            @strongify(self);
            self.roomRow = (int)deviceView.tag -100;
            for (int i = 0; i<self.roomArray.count; i++) {
                UIView *device = [self.scrollView viewWithTag:100+i];
                UILabel *deviceImage = [self.scrollView viewWithTag:1000+i];
                if (device.tag == deviceView.tag) {
                    device.backgroundColor = TextBlueColor;
                    deviceImage.textColor = [UIColor whiteColor];
                }else{
                    device.backgroundColor = [UIColor whiteColor];
                    deviceImage.textColor = [UIColor blackColor];
                    
                }
            }
            self.floorLable.text = [NSString stringWithFormat:@"%d",[self.roomArray[self.roomRow] intValue]/100];
            
        }];
        
        UILabel *deviceImage = [UILabel new];
        deviceImage.textColor = [UIColor blackColor];
        deviceImage.text = self.roomArray[i];
        deviceImage.tag = 1000+i;
        deviceImage.textAlignment = NSTextAlignmentCenter;
        [deviceView addSubview:deviceImage];
        
        [deviceImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(deviceView);
        }];
        
        if (i == 0) {
            
            deviceView.backgroundColor = TextBlueColor;
            deviceImage.textColor = [UIColor whiteColor];
        }
    }
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"icon_bg"];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.scrollView.mas_bottom).offset(4);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(240);
    }];
    
    
    UILabel *floorLable = [UILabel new];
    floorLable.textColor = [UIColor whiteColor];
    floorLable.textAlignment = NSTextAlignmentCenter;
    floorLable.font = [UIFont systemFontOfSize:36];
    floorLable.text = [NSString stringWithFormat:@"%d",[self.roomArray[self.roomRow] intValue]/100];
    [self.view addSubview:floorLable];
    [floorLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(imageView.mas_top).offset(12);
        make.width.mas_equalTo(104);
        make.height.mas_equalTo(54);
    }];
    self.floorLable = floorLable;
    
    UIButton *upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [upButton setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
    [upButton setImage:[UIImage imageNamed:@"up_press"] forState:UIControlStateSelected];
    [upButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [upButton addTarget:self action:@selector(upTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:upButton];
    
    [upButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(floorLable.mas_bottom).offset(20);
        make.width.mas_equalTo(104);
        make.height.mas_equalTo(70);
    }];
    
    UIButton *downButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [downButton setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    [downButton setImage:[UIImage imageNamed:@"down_press"] forState:UIControlStateSelected];
    [downButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [downButton addTarget:self action:@selector(downTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downButton];
    
    [downButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(upButton.mas_bottom).offset(0);
        make.width.mas_equalTo(104);
        make.height.mas_equalTo(70);
    }];
    
    UIButton *floorButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [floorButton setTitle:@"开放楼层" forState:UIControlStateNormal];
    floorButton.backgroundColor = TextBlueColor;
    floorButton.layer.cornerRadius = 4;
    floorButton.layer.masksToBounds = YES;
    [floorButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [floorButton addTarget:self action:@selector(floorTouch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:floorButton];
    
    [floorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(downButton.mas_bottom).offset(24);
        make.width.mas_equalTo(104);
        make.height.mas_equalTo(52);
    }];
    
}
-(void)buildVM{
    self.elevatorControlRequest = [ElevatorControlRequest Request];
    self.elevatorControlRequest.communityCode = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityCode"];
    self.elevatorControlRequest.householdId = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"householdId"];
    self.elevatorControlRequest.deviceList = self.groupUnitEntity.deviceNumList;
    
    [[RACObserve(self.elevatorControlRequest, state)filter:^BOOL(id value) {
        return value == RequestStateSuccess;
    }] subscribeNext:^(id x) {
        
    }];
    
    self.developmentElevatorRequest = [DevelopmentElevatorRequest Request];
    self.developmentElevatorRequest.communityCode = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityCode"];
    self.developmentElevatorRequest.householdId = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"householdId"];
    self.developmentElevatorRequest.deviceList = self.groupUnitEntity.deviceNumList;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = FFFF_Color(@"#213868");
    
}
-(void)upTouch{
    
    self.elevatorControlRequest.direct = @"1";
    self.elevatorControlRequest.floor = self.roomArray[self.roomRow];
    [[SceneModel SceneModel]SEND_ACTION:self.elevatorControlRequest];
    for (int a= 0; a<self.sipArray.count; a++) {
        [[AYCloudSpeakApi cloudSpeakApi] instantMsgSendWithCallId:self.sipArray[a] unLockXML:[AYAnalysisXMLData appendLadderXML:@"0" direct:@"1" floor:[NSString stringWithFormat:@"%d",[self.roomArray[self.roomRow] intValue]/100] family:[NSString stringWithFormat:@"%d",[self.roomArray[self.roomRow] intValue]%100] event:@"appoint" event_url:@"/elev/appoint"]];
    }
    
    
}
-(void)downTouch{
    
    self.elevatorControlRequest.direct = @"2";
    self.elevatorControlRequest.floor = self.roomArray[self.roomRow];
    [[SceneModel SceneModel]SEND_ACTION:self.elevatorControlRequest];
    for (int a= 0; a<self.sipArray.count; a++) {
        [[AYCloudSpeakApi cloudSpeakApi] instantMsgSendWithCallId:self.sipArray[a] unLockXML:[AYAnalysisXMLData appendLadderXML:@"0" direct:@"2" floor:[NSString stringWithFormat:@"%d",[self.roomArray[self.roomRow] intValue]/100] family:[NSString stringWithFormat:@"%d",[self.roomArray[self.roomRow] intValue]%100] event:@"appoint" event_url:@"/elev/appoint"]];
    }
}
-(void)floorTouch{
    self.developmentElevatorRequest.floor = self.roomArray[self.roomRow];
    [[SceneModel SceneModel]SEND_ACTION:self.developmentElevatorRequest];
    for (int a= 0; a<self.sipArray.count; a++) {
        [[AYCloudSpeakApi cloudSpeakApi] instantMsgSendWithCallId:self.sipArray[a] unLockXML:[AYAnalysisXMLData appendLadderXML:@"0" direct:nil floor:[NSString stringWithFormat:@"%d",[self.roomArray[self.roomRow] intValue]/100] family:[NSString stringWithFormat:@"%d",[self.roomArray[self.roomRow] intValue]%100] event:@"permit" event_url:@"/elev/permit"]];
    }
    
    
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


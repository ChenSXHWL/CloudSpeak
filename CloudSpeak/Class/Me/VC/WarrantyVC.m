//
//  WarrantyVC.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/2.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "WarrantyVC.h"
#import "WarrantyHeadView.h"
#import "SZTextView.h"
#import "AYPhotoCollectionView.h"
#import "LBXScanViewController.h"
#import "StyleDIY.h"
#import "AYAlertViewController.h"
#import "WarrantyVM.h"
#import "DeviceInfoEntity.h"
#import "HistoryWarrantyVC.h"
#import "IQKeyboardManager.h"
#define Titles @[@"楼栋",@"单元",@"设备"]

@interface WarrantyVC ()<AYPhotoCollectionViewDelegate,WarrantyHeadViewDelegate,UITextViewDelegate>

@property (strong, nonatomic)WarrantyHeadView *warrantyHeadView;

@property (strong, nonatomic) SZTextView *szTextView;

@property (strong, nonatomic) AYPhotoCollectionView *ayPhotoCollectionView;

@property (strong, nonatomic) WarrantyVM *warrantyVM;

@property (strong, nonatomic) NSArray *buildingNameArray;

@property (strong, nonatomic) NSArray *unitNameArray;

@property (strong, nonatomic) NSArray *roomList;
@property (strong, nonatomic) NSArray *roomIdList;

@property (strong, nonatomic) UIView *dateView;

@property (strong, nonatomic) NSString *dateStr;
@property (strong, nonatomic) NSString *endDateStr;

@property (strong, nonatomic) NSString *dateInt;
@property (strong, nonatomic) NSString *endDateInt;

@property (strong, nonatomic) UILabel *limitLabel;

@property (assign, nonatomic)BOOL isStart;
@property (assign, nonatomic)int typeInt;
@property (strong, nonatomic) NSString *deviceId;

@end

@implementation WarrantyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设备报修";
    [self buildUI];
    [self buildVM];
    
    
    // Do any additional setup after loading the view.
}
-(void)buildUI{
    
    UIButton *setButton = [UIButton buttonWithType:UIButtonTypeSystem];
    setButton.frame = CGRectMake(0, 0, 54, 32);
    setButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [setButton setTitle:@"我的上报" forState:UIControlStateNormal];
    [setButton addTarget:self action:@selector(settingButton) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:setButton];
    

    
    self.warrantyHeadView = [WarrantyHeadView new];
    self.warrantyHeadView.warrantyHeadViewDelegate = self;
    self.warrantyHeadView.backgroundColor = [UIColor whiteColor];
    
//    if (self.userInfoEntity.communityList.count<=[LoginEntity shareManager].page.intValue) {
//        [AYProgressHud progressHudShowShortTimeMessage:@"服务器出错，无小区信息"];
//    }else{
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

        self.warrantyHeadView.leftTextB.text =[LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityName"];
//    }
    
    
    [self.view addSubview:self.warrantyHeadView];
    [self.warrantyHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(kTopHeight);
        make.height.mas_equalTo(210);
    }];
    
    self.warrantyHeadView.userInteractionEnabled = YES;
    UITapGestureRecognizer *imageDTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanClick)];
    UITapGestureRecognizer *startTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startClick)];
    UITapGestureRecognizer *endTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endClick)];
    [self.warrantyHeadView.rightImageD addGestureRecognizer:imageDTapGestureRecognizer];
    [self.warrantyHeadView.rightTextE addGestureRecognizer:startTap];
    [self.warrantyHeadView.rightTextE2 addGestureRecognizer:endTap];
    self.warrantyHeadView.rightTextE2.userInteractionEnabled = YES; // 可以理解为设置label可被点击
    self.warrantyHeadView.rightTextE.userInteractionEnabled = YES; // 可以理解为设置label可被点击
    self.warrantyHeadView.rightImageD.userInteractionEnabled = YES; // 可以理解为设置label可被点击

    SZTextView *szTextView = [SZTextView new];
    szTextView.font = [UIFont systemFontOfSize:17];
    szTextView.layer.borderColor = LineEdgeGaryColor.CGColor;
    szTextView.layer.borderWidth = 1;
    szTextView.delegate = self;
    szTextView.placeholder = @"请填写报修单...";
    [self.view addSubview:szTextView];
    self.szTextView = szTextView;
    [self.szTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.warrantyHeadView.mas_bottom);
        make.height.equalTo(self.szTextView.mas_width).multipliedBy(0.5);
    }];

    UILabel *limitLabel = [UILabel new];
    limitLabel.text = @"0/200";
    limitLabel.textColor = [UIColor grayColor];
    [self.view addSubview:limitLabel];
    self.limitLabel = limitLabel;

    [self.limitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.bottom.equalTo(self.szTextView.mas_bottom).offset(-12);
    }];
    
    
    AYPhotoCollectionView *ayPhotoCollectionView = [AYPhotoCollectionView photoWithCollectionView];
    ayPhotoCollectionView.photoDelegate = self;
    [self.view addSubview:ayPhotoCollectionView];
    self.ayPhotoCollectionView = ayPhotoCollectionView;
    [self.ayPhotoCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.szTextView.mas_bottom);
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.width / 3);
    }];

    CustomBlueButton *submitButton = [CustomBlueButton setupCustomBlueButton:@"提交"];
    submitButton.layer.cornerRadius = 6;
    [submitButton addTarget:self action:@selector(submitTouchUp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ayPhotoCollectionView.mas_bottom).offset(40);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(260);
        make.height.mas_equalTo(52);
    }];
    UIView *dateView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 350)];
    dateView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:dateView];
    self.dateView = dateView;
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    confirmButton.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 44);
    [confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(confirmTouch) forControlEvents:UIControlEventTouchDown];
    [dateView addSubview:confirmButton];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 44);
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelTouch) forControlEvents:UIControlEventTouchDown];
    [dateView addSubview:cancelButton];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 300)];
    datePicker.backgroundColor = [UIColor whiteColor];
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    // 设置标题
    datePicker.minuteInterval = 30;
    datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    NSDate *newDate = [[NSDate date] dateByAddingTimeInterval:60 * 60 * 24 * 3];

    [datePicker setDate:[NSDate date] animated:YES];
    [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    [datePicker setMaximumDate:newDate];
    [datePicker setMinimumDate:[NSDate date]];
    [dateView addSubview:datePicker];
    
}

-(void)buildVM{
    
    self.warrantyVM = [WarrantyVM SceneModel];
    //默认室内维修
    self.typeInt = 0;
    for (int i = 0; i<self.repairTypeList.count; i++) {
        if ([self.repairTypeList[i][@"displayValue"] isEqualToString:@"室内维修"]) {
            self.warrantyVM.deviceRepairRequest.repairType = self.repairTypeList[i][@"storeValue"];
        }
    }

    
    
    self.warrantyHeadView.viewD.hidden = YES;
    self.warrantyHeadView.viewE.hidden = NO;
    self.warrantyHeadView.viewE.frame = CGRectMake(0, 154, SCREEN_WIDTH, 50);
    
    @weakify(self);
    [RACObserve(self.warrantyVM, isSuccess)subscribeNext:^(id x) {
        if (self.warrantyVM.isSuccess==YES) {
            
            [AYProgressHud progressHudShowShortTimeMessage:@"报修上传成功"];
            [super popToVC];
        }
    }];
    
    [RACObserve(self.warrantyVM, unitList)subscribeNext:^(id x) {
        if (self.warrantyVM.unitList.count>0) {
            NSMutableArray *arr = [NSMutableArray new];
            for (int i = 0; i<self.warrantyVM.unitList.count; i++) {
//                [arr insertObjects:model.householdList atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, model.householdList.count)]];
                NSString *str = self.warrantyVM.unitList[i][@"unitName"];
                [arr addObject:str];
                
            }
            self.unitNameArray  =[arr  copy];
            [AYAlertViewController actionSheetViewController:self Title:@"选择单元" message:nil actionStrings:self.unitNameArray actionSheet:^(int index) {
                NSLog(@"indexs==%d",index);
                [self.warrantyHeadView.manageButtonB setTitle:self.unitNameArray[index] forState:UIControlStateNormal];
                
                self.warrantyVM.communityInfoRequest.unitId = self.warrantyVM.unitList[index][@"unitId"];
                self.warrantyVM.deviceRepairRequest.unitId = self.warrantyVM.unitList[index][@"unitId"];
                [self.warrantyHeadView.manageButtonC setTitle:@"房间" forState:UIControlStateNormal];

            }];

        }
    }];
    
    
    [RACObserve(self.warrantyVM, buildingList)subscribeNext:^(id x) {
        if (self.warrantyVM.buildingList.count>0) {
            NSMutableArray *arr = [NSMutableArray new];
            for (int i = 0; i<self.warrantyVM.buildingList.count; i++) {
                [arr addObject:self.warrantyVM.buildingList[i][@"buildingName"]];
            }
            
            self.buildingNameArray  =[arr  copy];
            [AYAlertViewController actionSheetViewController:self Title:@"选择楼栋" message:nil actionStrings:self.buildingNameArray actionSheet:^(int index) {
                NSLog(@"index==%d",index);
                [self.warrantyHeadView.manageButtonA setTitle:self.buildingNameArray[index] forState:UIControlStateNormal];
                [self.warrantyHeadView.manageButtonB setTitle:@"单元" forState:UIControlStateNormal];
                [self.warrantyHeadView.manageButtonC setTitle:@"房间" forState:UIControlStateNormal];

                self.warrantyVM.communityInfoRequest.buildingId = self.warrantyVM.buildingList[index][@"buildingId"];
                self.warrantyVM.deviceRepairRequest.buildingId = self.warrantyVM.buildingList[index][@"buildingId"];;

                
            }];
        }
    }];
    
    [RACObserve(self.warrantyVM, roomList)subscribeNext:^(id x) {
        @strongify(self);
        
        if (self.warrantyVM.roomList.count>0) {
            NSMutableArray *arr = [NSMutableArray new];
            NSMutableArray *roomIdArray = [NSMutableArray new];
            for (int i = 0; i<self.warrantyVM.roomList.count; i++) {
                [arr addObject:self.warrantyVM.roomList[i][@"roomCode"]];
                [roomIdArray addObject:self.warrantyVM.roomList[i][@"roomId"]];
            }
            self.roomList  =[arr  copy];
            self.roomIdList  =[roomIdArray  copy];
            [AYAlertViewController actionSheetViewController:self Title:@"选择房间" message:nil actionStrings:self.roomList actionSheet:^(int index) {
                NSLog(@"indexs==%d",index);
                [self.warrantyHeadView.manageButtonC setTitle:self.roomList[index] forState:UIControlStateNormal];
                self.warrantyVM.deviceRepairRequest.roomId = self.roomIdList[index];
//                self.warrantyHeadView.textFieldC.text = [NSString stringWithFormat:@"%@小区%@楼%@%@房",[LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityName"],self.warrantyHeadView.manageButtonA.titleLabel.text,self.warrantyHeadView.manageButtonB.titleLabel.text,self.warrantyHeadView.manageButtonC.titleLabel.text];
            }];
            
        }
    }];
    
    
    
//
//    [RACObserve(self.warrantyVM, deviceList)subscribeNext:^(id x) {
//        if (self.warrantyVM.deviceList.count>0) {
//            NSMutableArray *arr = [NSMutableArray new];
//            for (int i = 0; i<self.warrantyVM.deviceList.count; i++) {
//                [arr addObject:self.warrantyVM.deviceList[i][@"deviceName"]];
//            }
//            self.deviceArray  =[arr  copy];
//            [AYAlertViewController actionSheetViewController:self Title:@"选择设备" message:nil actionStrings:self.deviceArray actionSheet:^(int index) {
//                NSLog(@"indexs==%d",index);
//                [self.warrantyHeadView.manageButtonC setTitle:self.deviceArray[index] forState:UIControlStateNormal];
//
////                self.warrantyVM.deviceRepairRequest.deviceId = self.warrantyVM.deviceList[index][@"deviceId"];
//
//            }];
//
//        }
//    }];
    
    [RACObserve(self.warrantyVM, deviceInfo)subscribeNext:^(id x) {
        if (self.warrantyVM.deviceInfo==YES) {
            @strongify(self);
            DeviceInfoEntity *model = [[DeviceInfoEntity alloc]initWithDictionary:self.warrantyVM.deviceInfoRequest.output[@"deviceMap"] error:nil];

//            self.warrantyHeadView.leftTextB.text = model.communityName;
//            [self.warrantyHeadView.manageButtonA setTitle:model.buildingName forState:UIControlStateNormal];
//            [self.warrantyHeadView.manageButtonB setTitle:model.unitName forState:UIControlStateNormal];
//            [self.warrantyHeadView.manageButtonC setTitle:model.deviceName forState:UIControlStateNormal];
            NSString *start = [self.warrantyVM.deviceInfoRequest.deviceNum substringToIndex:5];
            NSString *end = [self.warrantyVM.deviceInfoRequest.deviceNum substringFromIndex:self.warrantyVM.deviceInfoRequest.deviceNum.length-3];

            self.warrantyHeadView.textFieldD.text = [NSString stringWithFormat:@"%@:%@***%@",model.deviceName,start,end];
            
            self.deviceId = model.deviceId;

        }
    }];
    
}
-(void)popToVC{
    

    [AYAlertViewController alertViewController:self message:@"是否取消上报维修？" confirmStr:@"确定" cancelStr:@"取消" alert:^(UIAlertController *action) {
        [super popToVC];

    }];
    
    
    
}
-(void)settingButton{
    HistoryWarrantyVC *vc = [HistoryWarrantyVC new];
    vc.repairStatusList = self.repairStatusList;
    vc.repairTypeList = self.repairTypeList;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)scanClick
{
    LBXScanViewController *vc = [LBXScanViewController new];
    vc.style = [StyleDIY ZhiFuBaoStyle];
    vc.isOpenInterestRect = YES;
    vc.isWarranty = 0;
    @weakify(self);
    vc.warrntyBlock = ^(NSArray *code) {
        @strongify(self);
        NSLog(@"code==%@",code);
        if (code.count>1) {
            self.warrantyVM.deviceInfoRequest.communityCode = code[1];
        }
        if ([code[0] isEqualToString:@"null"]) {
            return [AYProgressHud progressHudShowShortTimeMessage:@"二维码错误"];
        }
        
        if (![code[1] isEqualToString:[LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityCode"]]) {
            return [AYProgressHud progressHudShowShortTimeMessage:@"当前小区无此设备权限！"];
        }
        
        self.warrantyVM.deviceInfoRequest.deviceNum = code[0];
        self.warrantyVM.deviceInfoRequest.requestNeedActive = YES;
        
    };
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)startClick
{
    self.isStart = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height - 350, self.view.frame.size.width, 350);
    }];
}
- (void)endClick
{
    self.isStart = NO;

    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height - 350, self.view.frame.size.width, 350);
    }];
}
-(void)confirmTouch{
    if (self.isStart) {
        self.warrantyHeadView.rightTextE.text = self.dateStr;
    }else{
        self.warrantyHeadView.rightTextE2.text = self.dateStr;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 350);
    }];
}
-(void)cancelTouch{
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 350);
    }];
}
- (void)dateChange:(UIDatePicker *)datePicker {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置时间格式
    formatter.dateFormat = @"yyyy:MM:dd HH:mm";
    NSString *dateStr = [formatter  stringFromDate:datePicker.date];
    formatter.dateFormat = @"yyyyMMddHHmm";
    NSString *dateint = [formatter  stringFromDate:datePicker.date];

    if (self.isStart) {
        self.dateInt = dateint;
    }else{
        self.endDateInt = dateint;
    }
    
    if ((self.dateInt.integerValue>self.endDateInt.integerValue)&&self.endDateInt>0) {
        dateStr = @"";
        return [AYProgressHud progressHudShowShortTimeMessage:@"不能选择比结束时间晚"];
    }
    self.dateStr = dateStr;
}
-(void)warrantyHeadView:(WarrantyHeadView *)warrantyHeadView selectRowAtLoc:(int)loc selctSection:(int)section{
    if (section==0) {
        NSMutableArray *typeArray = [NSMutableArray new];
        for (int i = 0; i<self.repairTypeList.count; i++) {
            [typeArray addObject:self.repairTypeList[i][@"displayValue"]];
        }
        [AYAlertViewController actionSheetViewController:self Title:@"报修类型" message:nil actionStrings:typeArray actionSheet:^(int index) {
            self.typeInt = index;
            self.warrantyHeadView.labelA.text = typeArray[index];
            if ([typeArray[index] isEqualToString:@"室内维修"]) {
                self.warrantyHeadView.viewD.hidden = YES;
                self.warrantyHeadView.viewE.hidden = NO;
                self.warrantyHeadView.viewE.frame = CGRectMake(0, 154, SCREEN_WIDTH, 50);
            }else if ([typeArray[index] isEqualToString:@"设备报障"]){
                self.warrantyHeadView.viewE.hidden = YES;
                self.warrantyHeadView.viewD.hidden = NO;
            }else{
                self.warrantyHeadView.viewD.hidden = YES;
                self.warrantyHeadView.viewE.hidden = YES;
            }
            self.warrantyVM.deviceRepairRequest.repairType = self.repairTypeList[index][@"storeValue"];
        }];
    }else{
        if (!warrantyHeadView.stings.length&&loc>0) return [AYProgressHud progressHudShowShortTimeMessage:[NSString stringWithFormat:@"请先选择%@", Titles[loc-1]]];
        if (loc == 0) {
            self.warrantyVM.communityInfoRequest.householdId =[LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"householdId"];
            self.warrantyVM.communityInfoRequest.buildingId = nil;
            self.warrantyVM.communityInfoRequest.requestNeedActive = YES;
        } else if (loc == 1) {
            self.warrantyVM.communityInfoRequest.requestNeedActive = YES;
        } else {
            self.warrantyVM.communityInfoRequest.requestNeedActive = YES;
        }
    }
}

- (void)photoCollectionView:(AYPhotoCollectionView *)phoneCollectionView didSelectPlusAtLastItem:(UINavigationController *)navigationController
{
    [self presentViewController:navigationController animated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)photoCollectionViewWithDismissVC:(AYPhotoCollectionView *)phoneCollectionView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)photoCollectionView:(AYPhotoCollectionView *)phoneCollectionView arrayWithPhotos:(NSMutableArray *)photos width:(CGFloat)width height:(CGFloat)heigh{

    
    if (photos.count == 0) {
        
        
        return;
        
    }
    
    for (int i = 0; i < photos.count; i ++) {
        
        NSString *photo = photos[i];
        
        if (i == 0) {
            
            self.warrantyVM.deviceRepairRequest.reportImgUrl = photo;
            
        } else if (i == 1) {

            self.warrantyVM.deviceRepairRequest.reportImgUrl = [NSString stringWithFormat:@"%@,%@",self.warrantyVM.deviceRepairRequest.reportImgUrl,photo];

        } else {
            
            self.warrantyVM.deviceRepairRequest.reportImgUrl = [NSString stringWithFormat:@"%@,%@",self.warrantyVM.deviceRepairRequest.reportImgUrl,photo];
        }
        
    }
    
    
}
-(void)submitTouchUp{
//    if (!(self.warrantyVM.deviceRepairRequest.deviceId)) return[AYProgressHud progressHudShowShortTimeMessage:@"请选择设备"];
    
    if(!(self.szTextView.text.length>0)) return[AYProgressHud progressHudShowShortTimeMessage:@"请选择填入报修原因"];
    int a = self.warrantyVM.deviceRepairRequest.repairType.intValue;
    
    if (!self.warrantyVM.deviceRepairRequest.roomId) {
        return [AYProgressHud progressHudShowShortTimeMessage:@"请选择房间信息"];
    }
    
    switch (a) {
        case 2:
            if (self.warrantyHeadView.rightTextE.text.length<8||self.warrantyHeadView.rightTextE2.text.length<8) {
                return [AYProgressHud progressHudShowShortTimeMessage:@"请选择上门时间"];
            }
            self.warrantyVM.deviceRepairRequest.startVisitDate = self.warrantyHeadView.rightTextE.text;
            self.warrantyVM.deviceRepairRequest.endVisitDate = self.warrantyHeadView.rightTextE2.text;
            break;
        case 1:
            if (!(self.warrantyHeadView.textFieldD.text>0)) return[AYProgressHud progressHudShowShortTimeMessage:@"输入设备名称或扫描设备二维码"];
            self.warrantyVM.deviceRepairRequest.deviceId = self.deviceId;
            break;
       
        default:
            break;
    }
    
    
    self.warrantyVM.deviceRepairRequest.location = self.warrantyHeadView.textFieldC.text;
    
    self.warrantyVM.deviceRepairRequest.reportProblem =self.szTextView.text;
    self.warrantyVM.deviceRepairRequest.requestNeedActive = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    [IQKeyboardManager sharedManager].enable = NO;
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    // 设置占位文字是否隐藏
    
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    //获取高亮部分内容
    //NSString * selectedtext = [textView textInRange:selectedRange];
    //如果有高亮且当前字数开始位置小于最大限制时允许输入
    if (selectedRange && pos) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
        if (offsetRange.location < 200) {
            return YES;
        }else{
            return NO;
        }
    }
    
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger caninputlen = 200 - comcatstr.length;
    if (caninputlen >= 0){
        
        self.limitLabel.text = [NSString stringWithFormat:@"%ld/200",200-(long)caninputlen];
        
        return YES;
    }else{
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0, MAX(len, 0)};
        if (rg.length > 0){
            // 因为我的是不需要输入表情，所以没有计算表情的宽度
            //            NSString *s =@"";
            //            //判断是否只普通的字符或asc码(对于中文和表情返回NO)
            //            BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
            //            if (asc) {
            //                s = [text substringWithRange:rg];//因为是ascii码直接取就可以了不会错
            //            }else{
            //                __block NSInteger idx = 0;
            //                __block NSString  *trimString =@"";//截取出的字串
            //                //使用字符串遍历，这个方法能准确知道每个emoji是占一个unicode还是两个
            //                [text enumerateSubstringsInRange:NSMakeRange(0, [text length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock: ^(NSString* substring,NSRange substringRange,NSRange enclosingRange,BOOL* stop) {
            //                    if (idx >= rg.length) {
            //                        *stop =YES;//取出所需要就break，提高效率
            //                        return ;
            //                    }
            //                    trimString = [trimString stringByAppendingString:substring];
            //                    idx++;
            //                }];
            //                s = trimString;
            //            }
            //rang是指从当前光标处进行替换处理(注意如果执行此句后面返回的是YES会触发didchange事件)
            self.limitLabel.text = @"200/200";

        }
        return NO;
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [_szTextView resignFirstResponder];
    
    [IQKeyboardManager sharedManager].enable = YES;
    
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

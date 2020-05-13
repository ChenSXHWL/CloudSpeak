//
//  ComplaintsVC.m
//  CloudSpeak
//
//  Created by mac on 2018/9/6.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "ComplaintsVC.h"
#import "SxButton.h"
#import "SZTextView.h"
#import "AYPhotoCollectionView.h"
#import "WarrantyVM.h"
#import "AYAlertViewController.h"
#import "ComplaintsVM.h"
#import "MyComplaintsVC.h"
@interface ComplaintsVC ()<AYPhotoCollectionViewDelegate,UITextViewDelegate>
@property (strong, nonatomic)UIView *viewA;
@property (strong, nonatomic)UIView *viewB;
@property (strong, nonatomic)UIView *lineA;
@property (strong, nonatomic)UIButton *buttonA;
@property (strong, nonatomic)UILabel *leftTextA;
@property (strong, nonatomic)UILabel *leftTextB;
@property (strong, nonatomic)UILabel *labelB;
@property (strong, nonatomic)UIImageView *rightImageB;

@property (strong, nonatomic)SxButton *manageButtonA;
@property (strong, nonatomic)SxButton *manageButtonB;
@property (strong, nonatomic)SxButton *manageButtonC;

@property (strong, nonatomic) SZTextView *szTextView;
@property (strong, nonatomic) WarrantyVM *warrantyVM;

@property (strong, nonatomic) NSArray *buildingNameArray;

@property (strong, nonatomic) NSArray *unitNameArray;

@property (strong, nonatomic) NSArray *roomList;

@property (strong, nonatomic) NSMutableArray *complainTypeArray;

@property (strong, nonatomic) NSMutableArray *complainIntArray;

@property (strong, nonatomic) AYPhotoCollectionView *ayPhotoCollectionView;

@property (assign, nonatomic) int typeInt;

@property (strong, nonatomic)ComplaintsVM *complaintsVM;

@property (strong, nonatomic) UILabel *limitLabel;

@end

@implementation ComplaintsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"物业投诉";
    
    [self buildUI];
    [self buildLayout];
    [self buildVM];
    // Do any additional setup after loading the view.
}

-(void)buildUI{
    
    
    UIButton *setButton = [UIButton buttonWithType:UIButtonTypeSystem];
    setButton.frame = CGRectMake(0, 0, 54, 32);
    setButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [setButton setTitle:@"我的投诉" forState:UIControlStateNormal];
    [setButton addTarget:self action:@selector(settingButton) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:setButton];
    
    UIView *viewA = [UIView new];
    viewA.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewA];
    self.viewA = viewA;
    
    UILabel *leftTextA = [UILabel new];
    leftTextA.text = @"小区";
    leftTextA.font = [UIFont systemFontOfSize:13];
    [viewA addSubview:leftTextA];
    self.leftTextA = leftTextA;
    
    SxButton *manageButtonA = [SxButton setupManageButtonWithImageString:@"home_enter" title:@"栋"];
    [manageButtonA addTarget:self action:@selector(selectCommunityA) forControlEvents:UIControlEventTouchUpInside];
    [viewA addSubview:manageButtonA];
    self.manageButtonA = manageButtonA;
    
    SxButton *manageButtonB = [SxButton setupManageButtonWithImageString:@"home_enter" title:@"单元"];
    [manageButtonB addTarget:self action:@selector(selectCommunityB) forControlEvents:UIControlEventTouchUpInside];
    [viewA addSubview:manageButtonB];
    self.manageButtonB = manageButtonB;
    
    SxButton *manageButtonC = [SxButton setupManageButtonWithImageString:@"home_enter" title:@"房间"];
    [manageButtonC addTarget:self action:@selector(selectCommunityC) forControlEvents:UIControlEventTouchUpInside];
    [viewA addSubview:manageButtonC];
    self.manageButtonC = manageButtonC;
    
    UIView *lineA = [UIView new];
    lineA.backgroundColor = LineEdgeGaryColor;
    [viewA addSubview:lineA];
    self.lineA = lineA;
    
    UIView *viewB = [UIView new];
    viewB.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:viewB];
    self.viewB = viewB;
    
    UILabel *leftTextB = [UILabel new];
    leftTextB.text = @"投诉类型";
    [viewB addSubview:leftTextB];
    self.leftTextB = leftTextB;
    
    UILabel *labelB = [UILabel new];
    labelB.text = @"投诉建议";
    labelB.textColor = TextDeepGaryColor;
    labelB.font = [UIFont systemFontOfSize:15];
    [viewB addSubview:labelB];
    self.labelB = labelB;
    
    UIImageView *rightImageB = [UIImageView new];
    rightImageB.image = [UIImage imageNamed:@"home_enter"];
    [viewB addSubview:rightImageB];
    self.rightImageB = rightImageB;
    
    UIButton *buttonA = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.viewB addSubview:buttonA];
    self.buttonA = buttonA;
    [buttonA addTarget:self action:@selector(devTypeTouch) forControlEvents:UIControlEventTouchUpInside];
    
    SZTextView *szTextView = [SZTextView new];
    szTextView.font = [UIFont systemFontOfSize:17];
    szTextView.layer.borderColor = LineEdgeGaryColor.CGColor;
    szTextView.layer.borderWidth = 1;
    szTextView.delegate = self;
    szTextView.placeholder = @"请输入您的投诉内容...";
    [self.view addSubview:szTextView];
    self.szTextView = szTextView;
    
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
}
-(void)buildVM{
    
    
    NSMutableArray *complainTypeArray = [NSMutableArray new];
    NSMutableArray *complainIntArray = [NSMutableArray new];
    for (int i = 0; i<self.complainTypeList.count; i++) {
        [complainTypeArray addObject:self.complainTypeList[i][@"displayValue"]];
        [complainIntArray addObject:self.complainTypeList[i][@"storeValue"]];
    }
    self.complainTypeArray = complainTypeArray;
    self.complainIntArray = complainIntArray;
    
    self.complaintsVM = [ComplaintsVM SceneModel];
    
    self.warrantyVM = [WarrantyVM SceneModel];

    @weakify(self);
    [RACObserve(self.warrantyVM, buildingList)subscribeNext:^(id x) {
        @strongify(self);
        if (self.warrantyVM.buildingList.count>0) {
            NSMutableArray *arr = [NSMutableArray new];
            for (int i = 0; i<self.warrantyVM.buildingList.count; i++) {
                [arr addObject:self.warrantyVM.buildingList[i][@"buildingName"]];
            }
            
            self.buildingNameArray  =[arr  copy];
            [AYAlertViewController actionSheetViewController:self Title:@"选择楼栋" message:nil actionStrings:self.buildingNameArray actionSheet:^(int index) {
                NSLog(@"index==%d",index);
                [self.manageButtonA setTitle:self.buildingNameArray[index] forState:UIControlStateNormal];
                [self.manageButtonB setTitle:@"单元" forState:UIControlStateNormal];
                [self.manageButtonC setTitle:@"房间" forState:UIControlStateNormal];
                
                self.warrantyVM.communityInfoRequest.buildingId = self.warrantyVM.buildingList[index][@"buildingId"];
                self.warrantyVM.communityInfoRequest.unitId = nil;
                self.complaintsVM.reportComplaintsRequest.buildingId =self.warrantyVM.buildingList[index][@"buildingId"];
            }];
        }
    }];
    
    [RACObserve(self.warrantyVM, unitList)subscribeNext:^(id x) {
        @strongify(self);

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
                [self.manageButtonB setTitle:self.unitNameArray[index] forState:UIControlStateNormal];
                [self.manageButtonC setTitle:@"房间" forState:UIControlStateNormal];

                self.warrantyVM.communityInfoRequest.unitId = self.warrantyVM.unitList[index][@"unitId"];
                self.complaintsVM.reportComplaintsRequest.unitId = self.warrantyVM.unitList[index][@"unitId"];
            }];
            
        }
    }];
    
    [RACObserve(self.warrantyVM, roomList)subscribeNext:^(id x) {
        @strongify(self);

        if (self.warrantyVM.roomList.count>0) {
            NSMutableArray *arr = [NSMutableArray new];
            for (int i = 0; i<self.warrantyVM.roomList.count; i++) {
                [arr addObject:self.warrantyVM.roomList[i][@"roomCode"]];
            }
            self.roomList  =[arr  copy];
            [AYAlertViewController actionSheetViewController:self Title:@"选择房间" message:nil actionStrings:self.roomList actionSheet:^(int index) {
                NSLog(@"indexs==%d",index);
                [self.manageButtonC setTitle:self.roomList[index] forState:UIControlStateNormal];
                
                self.complaintsVM.reportComplaintsRequest.roomId = self.warrantyVM.roomList[index][@"roomId"];
                
            }];
            
        }
    }];
    
    [RACObserve(self.complaintsVM, report)subscribeNext:^(id x) {
        if (x) {
            [AYProgressHud progressHudShowShortTimeMessage:@"投诉成功"];
            
            [super popToVC];
        }
    }];
}
-(void)devTypeTouch{
   
//    NSArray *array = @[@"投诉建议",@"公共设施",@"邻里纠纷",@"噪音扰民",@"停车秩序",@"服务态度",@"业务流程",@"工程维修",@"售后服务"];
    [AYAlertViewController actionSheetViewController:self Title:@"投诉类型" message:nil actionStrings:self.complainTypeArray actionSheet:^(int index) {
        self.typeInt = index;
        self.labelB.text = self.complainTypeArray[index];
        self.complaintsVM.reportComplaintsRequest.complainType = self.complainIntArray[index];
    }];
}
#pragma mark ButtonTouch
-(void)selectCommunityA{
    self.warrantyVM.communityInfoRequest.householdId =[LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"householdId"];
    self.warrantyVM.communityInfoRequest.buildingId = nil;
    self.warrantyVM.communityInfoRequest.requestNeedActive = YES;
}
-(void)selectCommunityB{
    
    self.warrantyVM.communityInfoRequest.requestNeedActive = YES;

}
-(void)selectCommunityC{
    
    self.warrantyVM.communityInfoRequest.requestNeedActive = YES;

}
-(void)submitTouchUp{
    
    if(!(self.szTextView.text.length>0)) return[AYProgressHud progressHudShowShortTimeMessage:@"请选择填入投诉内容"];
    if(!(self.complaintsVM.reportComplaintsRequest.roomId)) return[AYProgressHud progressHudShowShortTimeMessage:@"请选择房间信息"];
    
    self.complaintsVM.reportComplaintsRequest.content = self.szTextView.text;
    
    self.complaintsVM.reportComplaintsRequest.requestNeedActive = YES;
}
-(void)settingButton{
    MyComplaintsVC *vc = [MyComplaintsVC new];
    vc.complainTypeList = self.complainTypeList;
    vc.complainStatusList = self.complainStatusList;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)buildLayout{
    [self.viewA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        if (iPhoneX) {
            make.top.equalTo(self.view.mas_top).offset(68+44);
        }else{
            make.top.equalTo(self.view.mas_top).offset(68);
        }
        make.height.mas_equalTo(50);
    }];
    
    [self.leftTextA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.viewA.mas_centerY);
        make.left.equalTo(self.viewA.mas_left).offset(16);
    }];
    
    [self.manageButtonA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTextA.mas_right).offset(0);
        make.height.mas_equalTo(48);
        make.width.mas_equalTo(SCREEN_WIDTH/4);
        make.centerY.equalTo(self.viewA.mas_centerY);
    }];
    
    [self.manageButtonB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.manageButtonA.mas_right);
        make.height.mas_equalTo(48);
        make.width.mas_equalTo(SCREEN_WIDTH/4);
        make.centerY.equalTo(self.viewA.mas_centerY);
    }];
    
    [self.manageButtonC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.manageButtonB.mas_right);
        make.height.mas_equalTo(48);
        make.width.mas_equalTo(SCREEN_WIDTH/4);
        make.centerY.equalTo(self.viewA.mas_centerY);
    }];
    
    [self.lineA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.viewA);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.viewB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.viewA.mas_bottom);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(SCREEN_WIDTH/4);
    }];
    
    [self.leftTextB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.viewB.mas_centerY);
        make.left.equalTo(self.viewB.mas_left).offset(12);
        make.width.mas_equalTo(SCREEN_WIDTH/4);
    }];
    
    [self.labelB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.viewB);
    }];
    
    [self.rightImageB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.viewB.mas_right).offset(-12);
        make.centerY.equalTo(self.viewB.mas_centerY);
        make.height.width.mas_equalTo(28);
    }];
    
    [self.buttonA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.viewB);
    }];
    
    [self.szTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.viewB.mas_bottom);
        make.height.equalTo(self.szTextView.mas_width).multipliedBy(0.5);
    }];
    
    [self.ayPhotoCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.szTextView.mas_bottom);
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.width / 3);
    }];
    
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
            
            self.complaintsVM.reportComplaintsRequest.imgUrlList = photo;
            
        } else if (i == 1) {
            
            self.complaintsVM.reportComplaintsRequest.imgUrlList = [NSString stringWithFormat:@"%@,%@",self.complaintsVM.reportComplaintsRequest.imgUrlList,photo];
            
        } else {
            
            self.complaintsVM.reportComplaintsRequest.imgUrlList = [NSString stringWithFormat:@"%@,%@",self.complaintsVM.reportComplaintsRequest.imgUrlList,photo];
        }
        
    }
    
    
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

//
//  MyComplaintsVC.m
//  CloudSpeak
//
//  Created by mac on 2018/9/7.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "MyComplaintsVC.h"
#import "ManageButton.h"
#import "ComplaintsTBView.h"
#import "ComplaintsHeadView.h"
#import "ComplaintsVM.h"
@interface MyComplaintsVC ()<ComplaintsTBViewDelegate,ComplaintsHeadViewDelegate>
@property (strong, nonatomic) ManageButton *manageButton;

@property (strong, nonatomic)ComplaintsHeadView *complaintsHeadView;

@property (strong, nonatomic)ComplaintsTBView *complaintsTBView;

@property (strong, nonatomic)ComplaintsVM *complaintsVM;
@property (strong, nonatomic)NSMutableArray *complainTypeArray;
@property (strong, nonatomic)NSMutableArray *complainIntArray;
@property (strong, nonatomic)NSMutableArray *complainStateArray;
@property (strong, nonatomic)NSMutableArray *complainStateIntArray;
@end

@implementation MyComplaintsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的投诉";
    [self buildUI];
    [self buildVM];
    // Do any additional setup after loading the view.
}
-(void)buildUI{
    LoginEntity *entity = [LoginEntity shareManager];
    
    if (entity.communityList.count) {
        
        ManageButton *manageButton = [ManageButton setupManageButtonWithImageString:@"home_enter" title:@"全部"];
        [manageButton addTarget:self action:@selector(selectCommunity) forControlEvents:UIControlEventTouchUpInside];
        manageButton.titleLabel.font = [UIFont  systemFontOfSize:14];
        
        manageButton.frame = CGRectMake(0, 0, SCREEN_WIDTH / 3, 60);
        self.manageButton = manageButton;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.manageButton];
    }
    
    ComplaintsTBView *complaintsTBView = [ComplaintsTBView new];
//    advertTableView.dataArray =self.dataArray;
    complaintsTBView.complainStatusList = self.complainStatusList;
    complaintsTBView.complainTypeList = self.complainTypeList;
    complaintsTBView.advertTableViewDelegate =self;
    [self.view addSubview:complaintsTBView];
    self.complaintsTBView = complaintsTBView;
    [self.complaintsTBView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    ComplaintsHeadView *complaintsHeadView = [ComplaintsHeadView new];
    complaintsHeadView.complaintsHeadViewDelegate = self;
    complaintsHeadView.hidden = YES;
    [self.view addSubview:complaintsHeadView];
    self.complaintsHeadView = complaintsHeadView;
    [self.complaintsHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.top.right.equalTo(self.view);
    }];
}
-(void)selectCommunity{
    [self.complaintsHeadView downHeadView];
    self.complaintsHeadView.hidden = NO;

}
-(void)complaintsTBView:(ComplaintsTBView *)complaintsTBView selectRowAtLoc:(int)loc{
    
}
-(void)complaintsHeadView:(ComplaintsHeadView *)complaintsHeadView selectRowAtLoc:(int)loc{
    
    switch (loc) {
        case 0:
            [self.manageButton setTitle:@"全部" forState:UIControlStateNormal];
            break;
        case 1:
            [self.manageButton setTitle:@"未查阅" forState:UIControlStateNormal];
            break;
        case 2:
            [self.manageButton setTitle:@"待处理" forState:UIControlStateNormal];
            break;
        case 3:
            [self.manageButton setTitle:@"处理中" forState:UIControlStateNormal];
            break;
        case 4:
            [self.manageButton setTitle:@"已处理" forState:UIControlStateNormal];
            break;
        case 5:
            [self.manageButton setTitle:@"延期处理" forState:UIControlStateNormal];
            break;
        case 6:
            [self.manageButton setTitle:@"投诉建议" forState:UIControlStateNormal];
            break;
        case 7:
            [self.manageButton setTitle:@"公共设施" forState:UIControlStateNormal];
            break;
        case 8:
            [self.manageButton setTitle:@"邻里纠纷" forState:UIControlStateNormal];
            break;
        case 9:
            [self.manageButton setTitle:@"噪音扰民" forState:UIControlStateNormal];
            break;
        case 10:
            [self.manageButton setTitle:@"停车秩序" forState:UIControlStateNormal];
            break;
        case 11:
            [self.manageButton setTitle:@"服务态度" forState:UIControlStateNormal];
            break;
        case 12:
            [self.manageButton setTitle:@"业务流程" forState:UIControlStateNormal];
            break;
        case 13:
            [self.manageButton setTitle:@"工程维修" forState:UIControlStateNormal];
            break;
        case 14:
            [self.manageButton setTitle:@"售后服务" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    for (int i=0; i<self.complainTypeArray.count; i++) {
        if ([self.manageButton.titleLabel.text isEqualToString:self.complainTypeArray[i]]) {
            self.complaintsVM.historyComplaintsRequest.complainType = self.complainIntArray[i];
            self.complaintsVM.historyComplaintsRequest.complainStatus= nil;
        }
    }
    for (int i=0; i<self.complainStateArray.count; i++) {
        if ([self.manageButton.titleLabel.text isEqualToString:self.complainStateArray[i]]) {
            self.complaintsVM.historyComplaintsRequest.complainStatus = self.complainStateIntArray[i];
            self.complaintsVM.historyComplaintsRequest.complainType = nil;
        }
    }

    self.complaintsVM.historyComplaintsRequest.requestNeedActive = YES;

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
    NSMutableArray *complainStateArray = [NSMutableArray new];
    NSMutableArray *complainStateIntArray = [NSMutableArray new];
    for (int i = 0; i<self.complainStatusList.count; i++) {
        [complainStateArray addObject:self.complainStatusList[i][@"displayValue"]];
        [complainStateIntArray addObject:self.complainStatusList[i][@"storeValue"]];
    }
    self.complainStateArray = complainStateArray;
    self.complainStateIntArray = complainStateIntArray;
    self.complaintsVM = [ComplaintsVM SceneModel];
    @weakify(self);
    [RACObserve(self.complaintsVM, complaintList)subscribeNext:^(id x) {
        @strongify(self);
        if (x) {
            self.complaintsTBView.dataArray = self.complaintsVM.complaintList;
        }
    }];
    
    self.complaintsVM.historyComplaintsRequest.requestNeedActive = YES;
    
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

//
//  HomeAnnouncementVC.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/2.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "HomeAnnouncementVC.h"
#import "AdvertTableView.h"
#import "AdvertHeadView.h"
#import "ManageButton.h"
#import "AnnouncementDetailVC.h"
#import "PropertyNnoticeListRequest.h"
#import "PropertyNnoticeListEntity.h"
@interface HomeAnnouncementVC ()<AdvertTableViewDelegate,AdvertHeadViewDelegate>

@property (strong, nonatomic)UITableView *tableView;

@property (strong, nonatomic)AdvertHeadView *advertHeadView;

@property (strong, nonatomic)AdvertTableView *advertTableView;

@property (strong, nonatomic) ManageButton *manageButton;

@property (strong, nonatomic) PropertyNnoticeListRequest *propertyNnoticeListRequest;

@property (assign, nonatomic) BOOL isUp;

@end

@implementation HomeAnnouncementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"小区公告";

    [self buildUI];
    [self buildVM];
    
    [self mjRefreshOpenDoorMessageRecord];

    // Do any additional setup after loading the view. details
}
-(void)buildUI{
    
    
       
    LoginEntity *entity = [LoginEntity shareManager];
    
    if (entity.communityList.count) {
        
        ManageButton *manageButton = [ManageButton setupManageButtonWithImageString:@"home_enter" title:@"全部"];
        [manageButton addTarget:self action:@selector(selectCommunity) forControlEvents:UIControlEventTouchUpInside];
        manageButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f];

        manageButton.frame = CGRectMake(0, 0, SCREEN_WIDTH / 3, 44);
        self.manageButton = manageButton;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.manageButton];
    }
    
    AdvertTableView *advertTableView = [AdvertTableView new];
    advertTableView.dataArray =self.dataArray;
    advertTableView.advertTableViewDelegate =self;
    [self.view addSubview:advertTableView];
    self.advertTableView = advertTableView;
    [self.advertTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    AdvertHeadView *advertHeadView = [AdvertHeadView new];
    advertHeadView.advertHeadViewDelegate = self;
    advertHeadView.hidden = YES;
    [self.view addSubview:advertHeadView];
    self.advertHeadView = advertHeadView;
    [self.advertHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.top.right.equalTo(self.view);
    }];

}
-(void)buildVM{
    self.propertyNnoticeListRequest = [PropertyNnoticeListRequest Request];
    self.propertyNnoticeListRequest.appUserId = [LoginEntity shareManager].appUserId;
    self.propertyNnoticeListRequest.pageIndex = @"0";
    self.propertyNnoticeListRequest.pageSize = @"10";
    self.propertyNnoticeListRequest.communityId = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityId"];
    [[RACObserve(self.propertyNnoticeListRequest,state)filter:^BOOL(id value) {
        return value == RequestStateSuccess;
    }]subscribeNext:^(id x) {
        NSArray *array = [PropertyNnoticeListEntity arrayOfModelsFromDictionaries:self.propertyNnoticeListRequest.output[@"noticeList"] error:nil];
        if (!array.count) {
            [self.advertTableView.mj_footer endRefreshingWithNoMoreData];
            [self.advertTableView.mj_header endRefreshing];
        } else {
            if (self.isUp == YES) {
                NSMutableArray *mutaArray = [self.advertTableView.dataArray mutableCopy];
                [mutaArray addObjectsFromArray:array];
                self.advertTableView.dataArray = [mutaArray copy];
            }else{
                self.advertTableView.dataArray = array;
            }
            
            [self.advertTableView.mj_header endRefreshing];
            [self.advertTableView.mj_footer endRefreshing];
        }
        
        [self.advertTableView reloadData];
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isUp = NO;
    [[SceneModelConfig SceneModel] SEND_ACTION:self.propertyNnoticeListRequest];

}
- (void)mjRefreshOpenDoorMessageRecord
{
    @weakify(self);
    self.advertTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.isUp = NO;
        [[SceneModelConfig SceneModel] SEND_ACTION:self.propertyNnoticeListRequest];

    }];
    
    self.advertTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.isUp = YES;
        self.propertyNnoticeListRequest.pageIndex = [NSString stringWithFormat:@"%d",self.propertyNnoticeListRequest.pageIndex.intValue+1];
//        self.propertyNnoticeListRequest.pageSize = [NSString stringWithFormat:@"%d",self.propertyNnoticeListRequest.pageSize.intValue+10];
        
        [[SceneModelConfig SceneModel] SEND_ACTION:self.propertyNnoticeListRequest];

    }];
}
-(void)selectCommunity{
    self.advertHeadView.hidden = NO;
    [self.advertHeadView downHeadView];
}
-(void)advertTableView:(AdvertTableView *)advertTableView selectRowAtLoc:(int)loc{
    
    NSMutableArray *mutaArray = [self.advertTableView.dataArray mutableCopy];
    PropertyNnoticeListEntity *model  = mutaArray[loc];
    AnnouncementDetailVC *vc = [AnnouncementDetailVC new];
    vc.propertyNnoticeListEntity = model;
    vc.announcementDetailVCBlock = ^(NSString *number) {
        model.readNum = number;
        [mutaArray removeObject:model];
        [mutaArray insertObject:model atIndex:loc];
        self.advertTableView.dataArray = [mutaArray copy];
        
    };
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

-(void)advertHeadView:(AdvertHeadView *)advertHeadView selectRowAtLoc:(int)loc{
    NSLog(@"全部%d",loc);
    
    self.isUp = NO;
    self.advertTableView.dataArray = nil;
    [self.advertTableView reloadData];
    self.propertyNnoticeListRequest.noticeType = [NSString stringWithFormat:@"%d",loc];
    self.propertyNnoticeListRequest.pageSize = @"10";
    self.propertyNnoticeListRequest.pageIndex=  @"0";
    [[SceneModelConfig SceneModel] SEND_ACTION:self.propertyNnoticeListRequest];
    [AYProgressHud progressHudLoadingRequest:self.propertyNnoticeListRequest showInView:self.view detailString:@""];
    NSArray *array = @[@"全部",@"紧急",@"通知",@"活动",@"提示",@"新闻"];
    [self.manageButton setTitle:array[loc] forState:UIControlStateNormal];

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

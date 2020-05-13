//
//  MeMyKeyVC.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/14.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "MeMyKeyVC.h"
#import "XRDragTableView.h"
#import "MeMyKeyCell.h"
#import "GetMyKeyRequest.h"
#import "GetMyKeyEntity.h"
@interface MeMyKeyVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) XRDragTableView *tableView;
@property (nonatomic, strong) GetMyKeyRequest *getMyKeyRequest;
@property (nonatomic, strong) NSArray *getMyKeys;
@end

@implementation MeMyKeyVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"钥匙管理";
    [self buildUI];
    [self buildVM];
    // Do any additional setup after loading the view.
}


-(void)buildUI{
    
    self.tableView = [[XRDragTableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollSpeed = 10;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor colorWithRed:239.0 / 255 green:239.0 / 255 blue:244.0 / 255 alpha:1];
    [self.view addSubview:_tableView];
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 32)];
    UILabel *headTitle = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, SCREEN_WIDTH, 32)];
    headTitle.text = @"拖动钥匙进行排序";
    headTitle.textColor = TextDeepGaryColor;
    [headView addSubview:headTitle];
    self.tableView.tableHeaderView = headView;
}

-(void)buildVM{
    self.getMyKeyRequest = [GetMyKeyRequest Request];
    self.getMyKeyRequest.appUserId = [LoginEntity shareManager].appUserId;
    self.getMyKeyRequest.communityCode = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityCode"];

    [[RACObserve(self.getMyKeyRequest, state)filter:^BOOL(id value) {
        return value == RequestStateSuccess;
    }]subscribeNext:^(id x) {
        
        NSMutableArray *arry  = [GetMyKeyEntity arrayOfModelsFromDictionaries:self.getMyKeyRequest.output[@"devices"] error:nil];
        NSString *keyName = [[NSUserDefaults standardUserDefaults] objectForKey:@"keyName"];
        for (int i = 0; i<arry.count; i++) {
            GetMyKeyEntity *model = arry[i];

            if ([model.deviceName isEqualToString:keyName]) {
                [arry removeObject:model];
                [arry insertObject:model atIndex:0];
            }
        }
        
        self.tableView.dataArray = arry;
        
        self.getMyKeys = [arry copy];
        [self.tableView reloadData];
    }];
    [[SceneModelConfig SceneModel] SEND_ACTION:self.getMyKeyRequest];
    [AYProgressHud progressHudLoadingRequest:self.getMyKeyRequest showInView:self.view detailString:@""];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 72;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.getMyKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MeMyKeyCell *cell = [MeMyKeyCell setupMeMyKeyCell:tableView];
    GetMyKeyEntity *model = self.tableView.dataArray[indexPath.row];
    cell.keyName.text = model.deviceName;
    cell.dueLabel.text = model.dueDate;
    if (indexPath.row==0) {
        [[NSUserDefaults standardUserDefaults] setObject:model.deviceName forKey:@"keyName"];

        cell.currentLabel.hidden = NO;
    }
    
    return cell;
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


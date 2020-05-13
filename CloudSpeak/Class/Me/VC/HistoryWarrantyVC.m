//
//  HistoryWarrantyVC.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/24.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "HistoryWarrantyVC.h"
#import "RepairHistoryRequest.h"
#import "RepairHistoryEntity.h"
#import "DetailsWarrantyVC.h"
@interface HistoryWarrantyVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *dataArray;

@property (strong, nonatomic) RepairHistoryRequest *repairHistoryRequest;


@end

@implementation HistoryWarrantyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"历史上报";
    
    [self buildUI];
    [self buildVM];
    // Do any additional setup after loading the view.
}
-(void)buildUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate  = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
//    self.tableView.scrollEnabled = NO;

}
-(void)buildVM{
    self.repairHistoryRequest = [RepairHistoryRequest Request];
    self.repairHistoryRequest.communityId = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"communityId"];
    self.repairHistoryRequest.appUserId = [LoginEntity shareManager].appUserId;
    @weakify(self);
    [[RACObserve(self.repairHistoryRequest, state)filter:^BOOL(id value) {
        return value==RequestStateSuccess;
    }] subscribeNext:^(id x) {
        @strongify(self);
        self.dataArray = [RepairHistoryEntity arrayOfModelsFromDictionaries:self.repairHistoryRequest.output[@"propertyRepairList"] error:nil];
        [self.tableView reloadData];
    }];
    [[SceneModelConfig SceneModel] SEND_ACTION:self.repairHistoryRequest];
    [AYProgressHud progressHudLoadingRequest:self.repairHistoryRequest showInView:self.view detailString:@""];
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    return 60;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
#pragma mark tableViewDelegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID;
    
    ID = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    RepairHistoryEntity *model = self.dataArray[indexPath.row];
    
    UILabel *text1 = [UILabel new];
    text1.text = model.reportProblem;
    [cell.contentView addSubview:text1];
    [text1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).offset(16);
        make.width.mas_equalTo(SCREEN_WIDTH/3*2);
        make.centerY.equalTo(cell.contentView.mas_centerY).offset(-12);
    }];
    
    UILabel *text2 = [UILabel new];
    text2.text = model.createtime;
    text2.textColor = TextDeepGaryColor;
    text2.font = [UIFont systemFontOfSize:14];
    [cell.contentView addSubview:text2];
    [text2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).offset(16);
        make.centerY.equalTo(cell.contentView.mas_centerY).offset(12);
    }];
    
    UILabel *text3 = [UILabel new];
    if (model.repairStatus.intValue==1) {
        text3.text = @"未处理";
    }else{
        text3.text = @"已处理";
    }
    text3.textColor = TextDeepGaryColor;
    text3.font = [UIFont systemFontOfSize:16];
    [cell.contentView addSubview:text3];
    [text3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cell.contentView.mas_right).offset(-16);
        make.centerY.equalTo(cell.contentView.mas_centerY);
    }];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RepairHistoryEntity *model = self.dataArray[indexPath.row];
    DetailsWarrantyVC *vc = [DetailsWarrantyVC new];
    vc.repairHistoryEntity = model;
    vc.repairStatusList = self.repairStatusList;
    vc.repairTypeList = self.repairTypeList;
    [self.navigationController pushViewController:vc animated:YES];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 32)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *title = [UILabel new];
    title.textColor = TextBlueColor;
    title.text = @"描述";
    title.font = [UIFont systemFontOfSize:18];
    [view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view).offset(16);
    }];
    UILabel *titleB = [UILabel new];
    titleB.textColor = TextBlueColor;
    titleB.text = @"处理状态";
    titleB.font = [UIFont systemFontOfSize:18];
    [view addSubview:titleB];
    [titleB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.equalTo(view).offset(-16);
    }];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 31, SCREEN_WIDTH, 1)];
    line.backgroundColor = LineEdgeGaryColor;
    [view addSubview:line];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 32;
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

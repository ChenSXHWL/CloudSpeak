//
//  MyNeighborhoodVC.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/16.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "MyNeighborhoodVC.h"
#import "XRDragTableView.h"
#import "MyNeighborhoodCell.h"
#import "DetailsNeighborhoodVC.h"
#import "DeviceListRequest.h"
@interface MyNeighborhoodVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) XRDragTableView *tableView;
@property (nonatomic, strong) DeviceListRequest *deviceListRequest;

@end

@implementation MyNeighborhoodVC

//- (NSMutableArray *)dataArray {
//    if (!_dataArray) {
//        _dataArray = [NSMutableArray arrayWithObjects:@{@"neighbor":@"华美",@"residents":@[@"34栋01单元0401",@"34栋01单元0401",@"34栋01单元0401"],@"residentsMark":@"租客"}, @{@"neighbor":@"杨梅小区",@"residents":@[@"34栋01单元0401",@"34栋01单元0401",@"34栋01单元0401"],@"residentsMark":@"房主"}, @{@"neighbor":@"智障小区",@"residents":@[@"34栋01单元0401",@"34栋01单元0401",@"34栋01单元0401"],@"residentsMark":@"房主"}, @{@"neighbor":@"神经小区",@"residents":@[@"34栋01单元0401",@"34栋01单元0401",@"34栋01单元0401"],@"residentsMark":@"租客"}, @{@"neighbor":@"耳科小区",@"residents":@[@"34栋01单元0401",@"34栋01单元0401",@"34栋01单元0401"],@"residentsMark":@"租客"}, @{@"neighbor":@"眼科小区",@"residents":@[@"34栋01单元0401",@"34栋01单元0401",@"34栋01单元0401"],@"residentsMark":@"房主"}, @{@"neighbor":@"杨杨小区",@"residents":@[@"34栋01单元0401",@"34栋01单元0401",@"34栋01单元0401"],@"residentsMark":@"租客"}, nil];
//    }
//    return _dataArray;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的小区";
    [self buildUI];
    // Do any additional setup after loading the view.
}


-(void)buildUI{
    
    NSString *communityName = [[NSUserDefaults standardUserDefaults] objectForKey:@"communityName"];

    for (int i = 0; i<self.houseList.count; i++) {
        CommunityListArrayEntity *model = self.houseList[i];
        if ([model.communityName isEqualToString:communityName]) {
            [self.houseList removeObject:model];
            [self.houseList insertObject:model atIndex:0];
        }
    }

    self.tableView = [[XRDragTableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollSpeed = 10;
    self.tableView.dataArray = self.houseList;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = [UIColor colorWithRed:239.0 / 255 green:239.0 / 255 blue:244.0 / 255 alpha:1];
    [self.view addSubview:_tableView];
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 32)];
    UILabel *headTitle = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, SCREEN_WIDTH, 32)];
    headTitle.text = @"长按拖动小区进行排序";
    headTitle.textColor = TextDeepGaryColor;
    [headView addSubview:headTitle];
    self.tableView.tableHeaderView = headView;
}
-(void)buildVM{
    
    self.deviceListRequest = [DeviceListRequest Request];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 82;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.houseList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    MyNeighborhoodCell *cell = [MyNeighborhoodCell setupMyNeighborhoodCell:tableView];
    CommunityListArrayEntity *model = self.houseList[indexPath.row];
    
    cell.neighborhoodName.text = model.communityName;
    cell.dataArray = model.householdList;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row==0) {
        cell.currentLabel.hidden = NO;
//        cell.accessoryType=UITableViewCellAccessoryNone;
        [[NSUserDefaults standardUserDefaults] setObject:model.communityName forKey:@"communityName"];
        LoginEntity *model = [LoginEntity shareManager];
        model.changeVillage= @(1);
        model.page= @(0);
        [LoginManage saveEntity:model];
    }else{
//        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    CommunityListArrayEntity *model = self.houseList[indexPath.row];

    DetailsNeighborhoodVC *vc = [DetailsNeighborhoodVC new];
    vc.dataArray = model.householdList;
    vc.title = model.communityName;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be r5467 32ecreated.
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

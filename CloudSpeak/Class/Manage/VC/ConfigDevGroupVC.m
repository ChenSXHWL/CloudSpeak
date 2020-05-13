//
//  ConfigDevGroupVC.m
//  CloudSpeak
//
//  Created by mac on 2018/9/19.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "ConfigDevGroupVC.h"
#import "ConfigDevGroupTBVCell.h"
#import "ObtainDevGroupEntity.h"
#import "ConfigDevGroupVM.h"
@interface ConfigDevGroupVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)NSArray *dataArray;
@property (strong, nonatomic)ConfigDevGroupVM *configDevGroupVM;

@end

@implementation ConfigDevGroupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设备配置";
    
    [self buildUI];
    
    [self buildVM];
    
    // Do any additional setup after loading the view.
}
-(void)buildUI{
    UIButton *setButton = [UIButton buttonWithType:UIButtonTypeSystem];
    setButton.frame = CGRectMake(0, 0, 54, 32);
    setButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [setButton setTitle:@"确定" forState:UIControlStateNormal];
    [setButton addTarget:self action:@selector(settingButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:setButton];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate  = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
}
-(void)buildVM{
    self.configDevGroupVM = [ConfigDevGroupVM SceneModel];
    [RACObserve(self.configDevGroupVM, dataArray) subscribeNext:^(id x) {
        if (x) {
            self.dataArray = self.configDevGroupVM.dataArray;
            [self.tableView reloadData];
        }
    }];
    self.configDevGroupVM.obtainDevGroupRequest.communityCode = self.communityCode;

    self.configDevGroupVM.obtainDevGroupRequest.requestNeedActive = YES;
    [RACObserve(self.configDevGroupVM, isEditor) subscribeNext:^(id x) {
        if (x) {
            [AYProgressHud progressHudShowShortTimeMessage:@"配置成功"];
            [super popToVC];
        }
    }];
    
}
-(void)settingButton{
    NSString * deviceGroupIds  = @"";
    NSMutableArray *modelArray = [NSMutableArray new];
    for (int i = 0; i<self.dataArray.count; i++) {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
//        ConfigDevGroupTBVCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        ObtainDevGroupEntity *model = self.dataArray[i];
        if(model.choose==YES){
            [modelArray addObject:model];
        }
    }
    for (int i = 0; i<modelArray.count;i++) {
        ObtainDevGroupEntity *model = modelArray[i];
        if (i==0) {
            deviceGroupIds = model.id;
        }else{
            deviceGroupIds = [NSString stringWithFormat:@"%@,%@",deviceGroupIds,model.id];
        }
    }
   
    self.configDevGroupVM.editorDevGroupRequest.deviceGroupIds = deviceGroupIds;
    self.configDevGroupVM.editorDevGroupRequest.deviceId = self.devId;
    self.configDevGroupVM.editorDevGroupRequest.requestNeedActive = YES;
}
- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    return 50;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ConfigDevGroupTBVCell *cell = [ConfigDevGroupTBVCell setupConfigDevGroupTBVCell:tableView];
    ObtainDevGroupEntity *model = self.dataArray[indexPath.row];
    cell.deviceNum = self.deviceNum;
    cell.obtainDevGroupEntity = model;
    
    NSMutableArray *mutaArray = [self.dataArray mutableCopy];
    if (cell.checkImage.hidden==YES) {
        model.choose=NO;
    }else{
        model.choose=YES;
    }
    [mutaArray replaceObjectAtIndex:indexPath.row withObject:model];
    self.dataArray = [mutaArray copy];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ConfigDevGroupTBVCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.checkImage.hidden = !cell.checkImage.hidden;
    
    ObtainDevGroupEntity *model = self.dataArray[indexPath.row];
    NSMutableArray *mutaArray = [self.dataArray mutableCopy];
    if (cell.checkImage.hidden==YES) {
        model.choose=NO;
    }else{
        model.choose=YES;
    }
    [mutaArray replaceObjectAtIndex:indexPath.row withObject:model];
    self.dataArray = [mutaArray copy];
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

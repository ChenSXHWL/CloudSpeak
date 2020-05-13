//
//  MonitorSetVC.m
//  Linkhome
//
//  Created by 陈思祥 on 2017/9/20.
//  Copyright © 2017年 陈思祥. All rights reserved.
//

#import "MonitorSetVC.h"
#import "CommunityDisturbVC.h"
#import "MonitorSetVM.h"
@interface MonitorSetVC ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic)UITableView *tableView;

@property (assign, nonatomic)BOOL monDisable;//

@property (assign, nonatomic)BOOL monitorDisable;//

@property (strong, nonatomic) NSArray *houseList;

@property (strong ,nonatomic) MonitorSetVM *monitorSetVM;

@end

@implementation MonitorSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"免打扰", 移动检测设置);
    
    [self buildUI];
    
    [self buildVM];
    // Do any additional setup after loading the view.
}

-(void)buildUI{

    if(self.userInfoEntity.sipSwitch.intValue==0){
        self.monDisable = YES;
    }else if (self.userInfoEntity.callSwitch.intValue==2){
        self.monDisable = YES;
    }
    else{
        self.monDisable = NO;
        
    }
    if (self.userInfoEntity.callSwitch.intValue==0){
        self.monitorDisable = YES;
    }else{
        self.monitorDisable = NO;
    }

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate  = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    self.tableView.scrollEnabled = NO;

}
-(void)popToVC{
    

    self.communityInfoVCBlock(self.userInfoEntity);

    [super popToVC];
}
-(void)buildVM{
    
    self.monitorSetVM = [MonitorSetVM SceneModel];
    
    self.monitorSetVM.userSwitchRequest.appUserId = [LoginEntity shareManager].appUserId;
    
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    if (self.monDisable) {
        return 50;
    }else{
        if (indexPath.section==0) {
            return 50;
        }else{
            return 80;
        }
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        return 2;
    
}
#pragma mark tableViewDelegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if (self.monDisable) {
        return 1;
    }else{
        if (section==0) {
            return 1;
        }else{
            return self.houseList.count;
        }
    }


}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID;
    if (indexPath.row==1) {
        ID = @"UITableViewCellTwo";
    }else{
        ID = @"UITableViewCell";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.accessoryType = UITableViewCellAccessoryNone;
    if (indexPath.section==0) {
        cell.textLabel.text = @"一键免打扰";
        UISwitch *remindSwitch = [UISwitch new];
        remindSwitch.on = self.monDisable;//设置初始为ON的一边
        remindSwitch.onTintColor = TextBlueColor;
        [remindSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];   // 开关事件切换通知
        [cell.contentView addSubview: remindSwitch];
        [remindSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView.mas_centerY);
            make.right.equalTo(cell.contentView.mas_right).offset(-18);
        }];
    }else
    if (indexPath.section==1) {
        if (self.monDisable) {
            cell.textLabel.text = @"呼叫转接屏蔽";
            UISwitch *remindSwitch = [UISwitch new];
            remindSwitch.on = self.monitorDisable;//设置初始为ON的一边
            remindSwitch.onTintColor = TextBlueColor;
            [remindSwitch addTarget:self action:@selector(switchActionTwo:) forControlEvents:UIControlEventValueChanged];   // 开关事件切换通知
            [cell.contentView addSubview: remindSwitch];
            [remindSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.contentView.mas_centerY);
                make.right.equalTo(cell.contentView.mas_right).offset(-18);
            }];
        }else{
            
            HouseList *houseList = self.houseList[indexPath.row];
            
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            UILabel *title = [UILabel new];
            title.text = [NSString stringWithFormat:@"%@%@%@%@",houseList.communityName,houseList.buildingName,houseList.unitName,houseList.roomNum];
            title.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:title];
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView.mas_left).offset(16);
                make.top.equalTo(cell.contentView.mas_top).offset(16);
            }];
            UILabel *titleA = [UILabel new];
            
            if (houseList.sipSwitch.intValue==1) {
                titleA.text = @"免打扰已关闭";
            }else if (houseList.sipSwitch.intValue==2){
                titleA.text = @"免打扰只在夜间开启";
            }
            else{
                titleA.text = @"免打扰已开启";
            }
            
            titleA.font = [UIFont systemFontOfSize:14];
            titleA.textColor = TextDeepGaryColor;
            [cell.contentView addSubview:titleA];
            [titleA mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(title.mas_left);
                make.top.equalTo(title.mas_bottom).offset(8);
            }];
        }
       
    }
   
    return cell;
}
// 选中某行cell时会调用
-(void)switchAction:(UISwitch *)sender{
    self.monDisable = sender.on;
    [self.tableView reloadData];
    
    if (self.monDisable==NO) {
        self.monitorDisable = NO;
        self.monitorSetVM.userSwitchRequest.sipSwitch = @"1";
        self.monitorSetVM.userSwitchRequest.callSwitch = @"1";

    }else{
        self.monitorDisable=YES;
        self.monitorSetVM.userSwitchRequest.sipSwitch = @"0";
        self.monitorSetVM.userSwitchRequest.callSwitch = @"0";

    }
    self.userInfoEntity.sipSwitch = self.monitorSetVM.userSwitchRequest.sipSwitch;

    self.userInfoEntity.callSwitch = self.monitorSetVM.userSwitchRequest.callSwitch;

    self.monitorSetVM.userSwitchRequest.requestNeedActive = YES;

}
-(void)switchActionTwo:(UISwitch *)sender{
    self.monitorDisable = sender.on;
    
    if (self.monitorDisable==YES) {
        self.monitorSetVM.userSwitchRequest.callSwitch = @"0";
        
    }else{
        self.monitorSetVM.userSwitchRequest.callSwitch = @"1";
    }
    self.userInfoEntity.callSwitch = self.monitorSetVM.userSwitchRequest.callSwitch;
    self.monitorSetVM.userSwitchRequest.requestNeedActive = YES;

}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    UILabel *label  = [UILabel new];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = TextDeepGaryColor;
    if (self.monDisable) {
        if (section==0) {
            view.frame = CGRectMake(0,0, SCREEN_WIDTH, 40);
            label.frame = CGRectMake(16, 4, SCREEN_WIDTH-32, 32);
            label.text = @"开启后，您将不再接受来自门禁主机活户户通给您发出的通话请求";
        }else{
            view.frame = CGRectMake(0,0, SCREEN_WIDTH, 40);
            label.frame = CGRectMake(16, 4, SCREEN_WIDTH-32, 32);
            label.text = @"开启后，呼叫开门不再通知您";
        }
    }else{
        if (section==0) {
            view.frame = CGRectMake(0,0, SCREEN_WIDTH, 72);
            label.frame = CGRectMake(16, 4, SCREEN_WIDTH-32, 72);
            label.text = @"开启后，您将不再接受来自门禁主机活户户通给您发出的通话请求\n    \n选择要设置免打扰的小区";
        }else{
            view.frame = CGRectMake(0,0, SCREEN_WIDTH, 0);
            label.frame = CGRectMake(16, 4, SCREEN_WIDTH-32, 0);
            label.text = @" ";
        }
    }
    [view addSubview:label];

    
    return view;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.monDisable) {
        if (section==0) {
            return 40;
        }else{
            return 40;
        }
    }else{
        if (section==0) {
            return 72;
        }else{
            return 0;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.monDisable)  return;
    
    if (indexPath.section==0) return;
    NSMutableArray *mutaArray = [self.houseList mutableCopy];
    CommunityDisturbVC *vc = [CommunityDisturbVC new];
    vc.houseList = self.houseList[indexPath.row];
    @weakify(self);
    vc.communityInfoVCBlock = ^(HouseList * houseList){
        @strongify(self);
        [mutaArray removeObjectAtIndex:indexPath.row];
        [mutaArray insertObject:houseList atIndex:indexPath.row];
        self.houseList = [mutaArray copy];
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)setUserInfoEntity:(UserInfoEntity *)userInfoEntity{
    _userInfoEntity = userInfoEntity;
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0; i<userInfoEntity.communityList.count; i++) {
        CommunityListArrayEntity *model = userInfoEntity.communityList[i];
        [arr insertObjects:model.householdList atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, model.householdList.count)]];
}
    
    
    self.houseList = arr;
    [self.tableView reloadData];
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

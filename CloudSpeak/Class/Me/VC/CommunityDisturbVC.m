//
//  CommunityDisturbVC.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/17.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "CommunityDisturbVC.h"
#import "MonitorSetVM.h"

#define TITLEARRAY @[@"开启",@"只在夜间开启",@"关闭"]


@interface CommunityDisturbVC ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic)UITableView *tableView;

@property (assign, nonatomic)int type;//0开启 2 夜间 1 关闭

@property (strong ,nonatomic) MonitorSetVM *monitorSetVM;

@property (assign, nonatomic)BOOL monitorDisable;//

@property (assign ,nonatomic) BOOL isDisturb;

@end

@implementation CommunityDisturbVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"免打扰";
    
    [self buildUI];
    
    [self buildVM];

    // Do any additional setup after loading the view.
}

-(void)buildUI{
    self.monitorDisable = NO;
    self.isDisturb = NO;
    switch (self.houseList.sipSwitch.intValue) {
        case 0:
            self.isDisturb = YES;
            self.monitorDisable = YES;
            self.type = 0;
            break;
        case 1:
            self.type = 2;
            break;
        case 2:
            self.type = 1;
            break;
            
        default:
            break;
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
    
    self.communityInfoVCBlock(self.houseList);
    
    [super popToVC];
    
    
}
-(void)buildVM{
    self.monitorSetVM = [MonitorSetVM SceneModel];
    self.monitorSetVM.householdSwitchRequest.householdId = self.houseList.householdId;
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    return 50;
   
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.isDisturb) {
        return 2;
    }else{
        return 1;
    }
}
#pragma mark tableViewDelegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isDisturb) {
        if (section==0) {
            return 3;
            
        }else{
            return 1;
            
        }
    }else{
        return 3;
    }
   
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID;
    
    ID = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    cell.textLabel.text = TITLEARRAY[indexPath.row];
    if (self.isDisturb) {
        if (indexPath.section==0) {
            if (self.type==indexPath.row) {
                UIImageView *stateImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-48, 9, 32, 32)];
                stateImage.image = [UIImage imageNamed:@"check"];
                [cell.contentView addSubview:stateImage];
            }
        }else{
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
        }
    }else{
        if (self.type==indexPath.row) {
            UIImageView *stateImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-48, 9, 32, 32)];
            stateImage.image = [UIImage imageNamed:@"check"];
            [cell.contentView addSubview:stateImage];
        }
    }
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==0) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        view.frame = CGRectMake(0,0, SCREEN_WIDTH, 40);
        UILabel *label  = [UILabel new];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = TextDeepGaryColor;
        label.frame = CGRectMake(16, 2, SCREEN_WIDTH-32, 36);
        label.text = @"开启后，呼叫开门不再通知您,夜间开启:在22:00至次日8:00不通知您。";
        [view addSubview:label];
        return view;
    }else{
        return nil;
    }
   
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        view.frame = CGRectMake(0,0, SCREEN_WIDTH, 36);
        UILabel *label  = [UILabel new];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = TextDeepGaryColor;
        label.frame = CGRectMake(16, 2, SCREEN_WIDTH-32, 32);
        label.text = [NSString stringWithFormat:@"%@%@%@%@",_houseList.communityName,_houseList.buildingName,_houseList.unitName,_houseList.roomNum];
        [view addSubview:label];
        return view;
    }else{
        return nil;
    }
    
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 40;
    }else{
        return 0.1f;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 36;
    }else{
        return 0.1f;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.type = (short)indexPath.row;
    
    
    NSString *str = @"";
    
    if (indexPath.row==0) {
        str =@"0";
        self.monitorDisable=YES;
        self.isDisturb = YES;
        self.monitorSetVM.householdSwitchRequest.callSwitch = @"0";

    }
    else if (indexPath.row==1){
        str =@"2";
        self.monitorDisable=NO;
        self.isDisturb = NO;
        self.monitorSetVM.householdSwitchRequest.callSwitch = @"1";

    }else{
        str =@"1";
        self.monitorDisable=NO;
        self.isDisturb = NO;
        self.monitorSetVM.householdSwitchRequest.callSwitch = @"1";

    }
    [self.tableView reloadData];

    self.houseList.sipSwitch =str;
    self.monitorSetVM.householdSwitchRequest.sipSwitch = str;
    self.monitorSetVM.householdSwitchRequest.requestNeedActive = YES;

}
-(void)switchActionTwo:(UISwitch *)sender{
    self.monitorDisable = sender.on;
    
    if (self.monitorDisable==YES) {
        self.monitorSetVM.householdSwitchRequest.callSwitch = @"0";
        
    }else{
        self.monitorSetVM.householdSwitchRequest.callSwitch = @"1";
    }
    self.monitorSetVM.householdSwitchRequest.requestNeedActive = YES;
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

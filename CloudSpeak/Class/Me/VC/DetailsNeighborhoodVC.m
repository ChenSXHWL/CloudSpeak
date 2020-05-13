//
//  DetailsNeighborhoodVC.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/21.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "DetailsNeighborhoodVC.h"

@interface DetailsNeighborhoodVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation DetailsNeighborhoodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildUI];

    // Do any additional setup after loading the view.
}


-(void)buildUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate  = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    self.tableView.scrollEnabled = NO;

}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    return 80;
    
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
    
    cell.accessoryType=UITableViewCellAccessoryNone;
    HouseList *model = self.dataArray[indexPath.row];
    UILabel *text1 = [UILabel new];
    text1.text = [NSString stringWithFormat:@"%@%@%@",model.buildingName,model.unitName,model.roomNum];//householdType
    [cell.contentView addSubview:text1];
    [text1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).offset(16);
        make.centerY.equalTo(cell.contentView.mas_centerY).offset(-14);
    }];
    
    UILabel *stateLabel = [UILabel new];
    stateLabel.textColor = TextDeepGaryColor;
    [cell.contentView addSubview:stateLabel];
    [stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left).offset(16);
        make.centerY.equalTo(cell.contentView.mas_centerY).offset(14);
    }];
    
    if (model.householdStatus.intValue==0) {
        stateLabel.text = @"[注销]";
    }else{
        stateLabel.text = @"[启用]";
    }
    
    UILabel *timeLimit = [UILabel new];
    timeLimit.textColor = TextDeepGaryColor;
    timeLimit.text = [NSString stringWithFormat:@"有效期:%@",model.dueDate];
    [cell.contentView addSubview:timeLimit];
    [timeLimit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(stateLabel.mas_right).offset(8);
        make.centerY.equalTo(stateLabel.mas_centerY);
    }];
    
    UILabel *text2 = [UILabel new];
    text2.textColor = TextBlueColor;
    text2.text = [NSString stringWithFormat:@"[%@]",model.householdType];
    [cell.contentView addSubview:text2];
    [text2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cell.contentView.mas_right).offset(-16);
        make.centerY.equalTo(cell.contentView.mas_centerY);
    }];

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

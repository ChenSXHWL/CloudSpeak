//
//  ComplaintsPhoneVC.m
//  CloudSpeak
//
//  Created by mac on 2018/10/10.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "ComplaintsPhoneVC.h"
#import "ComplaintsPhoneTBViewCell.h"
#import "ComplaintsPhoneVM.h"
@interface ComplaintsPhoneVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *dataArray;

@property (strong, nonatomic) ComplaintsPhoneVM *complaintsPhoneVM;

@property (strong, nonatomic) UIButton *complaintsButton;

@property (strong, nonatomic) UIButton *SOSButton;

@end

@implementation ComplaintsPhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"社区电话";
    [self buildUI];
    [self buildVM];
    // Do any additional setup after loading the view.
}
-(void)buildUI{
    
    UIButton *complaintsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [complaintsButton setTitle:@"物业电话" forState:UIControlStateNormal];
    complaintsButton.frame = CGRectMake(0, iPhoneX?90:66, SCREEN_WIDTH/2-0.5, 44);
    [complaintsButton addTarget:self action:@selector(complaintsTouch:) forControlEvents:UIControlEventTouchDown];
    complaintsButton.backgroundColor = [UIColor whiteColor];
    [complaintsButton setTitleColor:TextBlueColor forState:UIControlStateNormal];
    [self.view addSubview:complaintsButton];
    
    self.complaintsButton = complaintsButton;
    
    UIButton *SOSButton = [UIButton buttonWithType:UIButtonTypeCustom];
    SOSButton.frame = CGRectMake(SCREEN_WIDTH/2+0.5, iPhoneX?90:66, SCREEN_WIDTH/2-0.5, 44);
    SOSButton.backgroundColor = [UIColor whiteColor];
    [SOSButton setTitle:@"紧急电话" forState:UIControlStateNormal];
    [SOSButton addTarget:self action:@selector(SOSTouch:) forControlEvents:UIControlEventTouchDown];
    [SOSButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:SOSButton];
    
    self.SOSButton = SOSButton;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, (iPhoneX?88:64) + 48, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate  = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
}
-(void)buildVM{
    
    self.complaintsPhoneVM = [ComplaintsPhoneVM SceneModel];
   
    self.complaintsPhoneVM.communityPhoneRequest.phoneType = @"1";
    @weakify(self);
    [[RACObserve(self.complaintsPhoneVM.communityPhoneRequest, state)filter:^BOOL(id value) {
        return value == RequestStateSuccess;
    }] subscribeNext:^(id x) {
        @strongify(self);
        self.dataArray = self.complaintsPhoneVM.communityPhoneRequest.output[@"communityPhoneList"];
        [self.tableView reloadData];
    }];
    
    self.complaintsPhoneVM.communityPhoneRequest.requestNeedActive = YES;
}
-(void)complaintsTouch:(UIButton *)sender{
    [self.SOSButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.complaintsButton setTitleColor:TextBlueColor forState:UIControlStateNormal];
    
    self.complaintsPhoneVM.communityPhoneRequest.phoneType = @"1";
 
    self.complaintsPhoneVM.communityPhoneRequest.requestNeedActive = YES;

}
-(void)SOSTouch:(UIButton *)sender{
    [self.complaintsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.SOSButton setTitleColor:TextBlueColor forState:UIControlStateNormal];

    self.complaintsPhoneVM.communityPhoneRequest.phoneType = @"2";
    self.complaintsPhoneVM.communityPhoneRequest.requestNeedActive = YES;

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
    
    ComplaintsPhoneTBViewCell *cell = [ComplaintsPhoneTBViewCell setupComplaintsPhoneTBViewCell:tableView];
    
    cell.phoneName.text = self.dataArray[indexPath.row][@"phoneName"];
    [cell.phone setTitle:self.dataArray[indexPath.row][@"phone"] forState:UIControlStateNormal] ;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   
    
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

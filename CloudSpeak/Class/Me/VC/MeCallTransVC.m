//
//  MeCallTransVC.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/14.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "MeCallTransVC.h"
#import "MeCallTransTView.h"

@interface MeCallTransVC ()

@property (strong, nonatomic) MeCallTransTView *meCallTransTView;

@end

@implementation MeCallTransVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setupConstraint];
    
    [self setupBlock];
    
}

- (void)setupUI
{
    self.title = @"呼叫转移";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(savePhone)];
    
    self.meCallTransTView = [MeCallTransTView new];
    [self.view addSubview:self.meCallTransTView];
}

- (void)setupConstraint
{
    [self.meCallTransTView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(0);
    }];
}

- (void)setupBlock
{
    @weakify(self);
    self.meCallTransTView.callTransBlock = ^(void) {
        @strongify(self);
        [self popToVC];
    };
}

- (void)savePhone
{
    [self.meCallTransTView saveTransPhone];
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

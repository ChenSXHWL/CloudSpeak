//
//  ManageVC.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/29.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "ManageVC.h"
#import "EZQRCodeScanner.h"
#import "ManageSettingVC.h"
#import "ManageTView.h"
#import "ManageDetailVC.h"
#import "ManageTVHeadView.h"

@interface ManageVC () <EZQRCodeScannerDelegate>

@property (strong, nonatomic) ManageTView *manageTView;

@property (strong, nonatomic) ManageTVHeadView *manageTVHeadView;

@end

@implementation ManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setupConstraint];
    
    [self setupBlock];
    
}

- (void)setupUI
{
    self.title = @"金山小区";
    
    UIButton *leftItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftItemButton.frame = CGRectMake(0, 0, 25, 25);
    [leftItemButton addTarget:self action:@selector(scanMethod) forControlEvents:UIControlEventTouchUpInside];
    [leftItemButton setImage:[UIImage imageNamed:@"icon_me_in"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftItemButton];
    
    UIButton *rightItembutton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightItembutton.frame = CGRectMake(0, 0, 25, 25);
    [rightItembutton addTarget:self action:@selector(settingMethod) forControlEvents:UIControlEventTouchUpInside];
    [rightItembutton setImage:[UIImage imageNamed:@"icon_set"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItembutton];
    
    ManageTVHeadView *manageTVHeadView = [ManageTVHeadView new];
    
    [self.view addSubview:manageTVHeadView];
    
    self.manageTVHeadView = manageTVHeadView;
    
    ManageTView *manageTView = [ManageTView new];
    
    [self.view addSubview:manageTView];
    
    self.manageTView = manageTView;
}

- (void)setupConstraint
{
    [self.manageTVHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(64);
        make.height.mas_equalTo(60);
    }];
    
    [self.manageTView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.manageTVHeadView.mas_bottom).offset(16);
    }];
    
}

- (void)setupBlock
{
    @weakify(self);
    self.manageTView.block = ^(void) {
        @strongify(self);
        [self.navigationController pushViewController:[ManageDetailVC new] animated:YES];
    };
}

- (void)scanMethod
{
    EZQRCodeScanner *scanner = [[EZQRCodeScanner alloc] init];
    scanner.delegate = self;
    scanner.scanStyle = EZScanStyleNetGrid;
    scanner.showButton = NO;
    [self.navigationController pushViewController:scanner animated:YES];
}

- (void)settingMethod
{
    [self.navigationController pushViewController:[ManageSettingVC new] animated:YES];
}

- (void)scannerView:(EZQRCodeScanner *)scanner errorMessage:(NSString *)errorMessage {
    
}

- (void)scannerView:(EZQRCodeScanner *)scanner outputString:(NSString *)output {
    [self.navigationController popViewControllerAnimated:YES];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"扫描结果" message:output preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
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

//
//  SetConfigVC.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/13.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "SetConfigVC.h"
#import "SetConfigTView.h"

@interface SetConfigVC () <CSSetConfigTViewDelegate>

@property (strong, nonatomic) SetConfigTView *setConfigTView;

@end

@implementation SetConfigVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setupConstraint];
    
}

- (void)setupUI
{
    
    self.title = @"设备配置";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(saveConfig)];
    
    SetConfigTView *setConfigTView = [SetConfigTView new];
    
    setConfigTView.setConfigDelegate = self;
    
    setConfigTView.sysXML = self.sysXML;
    
    setConfigTView.getDiviceInfo = self.getDeviceInfo;
    
    setConfigTView.getConfigEntity = self.getConfigEntity;
    
    [self.view addSubview:setConfigTView];
    
    self.setConfigTView = setConfigTView;
    
}

- (void)setupConstraint
{
    [self.setConfigTView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)saveConfig
{
    
    [self.setConfigTView saveXMLInfo];
    
}

- (void)sendXMLString:(NSString *)xmlString isSelectMode:(BOOL)mode
{
    [self popToVC];
    
    self.setConfigVCBlock(xmlString, mode);
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

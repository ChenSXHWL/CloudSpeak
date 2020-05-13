//
//  ManageDetailVC.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/29.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "ManageDetailVC.h"
#import "ManageDetailTView.h"
#import "DeviceTestVC.h"
#import "SetConfigVC.h"
#import "GetConfigEntity.h"
#import "ConfigDevGroupVC.h"
@interface ManageDetailVC ()

@property (strong, nonatomic) ManageDetailTView *manageDetailTView;

@end

@implementation ManageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *list = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.integerValue];
    
    
    UILabel *gidLabel = [UILabel new];
    gidLabel.text = @"GID:";
    gidLabel.textColor = TextDeepGaryColor;
    [self.view addSubview:gidLabel];
    [gidLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(16);
        make.top.equalTo(self.view.mas_top).offset(12);
    }];
    
    UILabel *uidLabel = [UILabel new];
    uidLabel.text = @"UID:";
    uidLabel.textColor = TextDeepGaryColor;
    [self.view addSubview:uidLabel];
    [uidLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(16);
        make.top.equalTo(uidLabel.mas_bottom).offset(8);
    }];
    
   

    ManageDetailTView *manageDetailTView = [ManageDetailTView new];
    
    manageDetailTView.deviceNum = self.deviceNum;
    
    manageDetailTView.timestamp = self.timestamp;

    [self.view addSubview:manageDetailTView];
    
    self.manageDetailTView = manageDetailTView;
    
    [manageDetailTView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(50);
    }];

    
    @weakify(self);
    manageDetailTView.popBlock = ^{
        @strongify(self);
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    };
    
    manageDetailTView.pushDevIdBlock = ^(NSString *deviceId){
        @strongify(self);
        
        ConfigDevGroupVC *vc = [ConfigDevGroupVC new];
        vc.devId = deviceId;
        NSArray *devices = [self.deviceNum componentsSeparatedByString:@","];

        vc.deviceNum = devices[0];
        vc.communityCode = devices[1];
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    manageDetailTView.test = ^(NSString *communityCode, NSString *communityName) {
        @strongify(self);
        
        if (![communityCode isEqualToString:@"A1234567891011121314151617181920"]) {
            self.title = communityName;
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"测试" style:UIBarButtonItemStyleDone target:self action:@selector(clickRightItem)];
        } else {
            self.title = list[@"communityName"];
        }
        
    };
    
    
    self.manageDetailTView.configBlock = ^(GetConfigEntity *getConfigEntity, NSString *sysXML, NSDictionary *dict){
        @strongify(self);
        
        SetConfigVC *setConfigVC = [SetConfigVC new];
        
        setConfigVC.getConfigEntity = getConfigEntity;
        
        setConfigVC.getDeviceInfo = dict;
        
        setConfigVC.sysXML = sysXML;
        
        [self.navigationController pushViewController:setConfigVC animated:YES];
        
        setConfigVC.setConfigVCBlock = ^(NSString *beChangeXML, BOOL isSelectMode) {
            //改变后的XML串
            [self.manageDetailTView getSysXML:beChangeXML isSelectMode:isSelectMode];
            
        };
        
    };
    
}

- (void)clickRightItem
{
    DeviceTestVC *deviceTestVC = [DeviceTestVC new];
    
    deviceTestVC.deviceName = self.manageDetailTView.deviceName;
    
    deviceTestVC.sipContent = self.manageDetailTView.sipAccount;
    
    [self.navigationController pushViewController:deviceTestVC animated:YES
     ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

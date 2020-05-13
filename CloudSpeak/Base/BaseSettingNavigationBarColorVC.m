//
//  BaseSettingNavigationBarColorVC.m
//  ishanghome
//
//  Created by DNAKE_AY on 17/1/5.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "BaseSettingNavigationBarColorVC.h"

@interface BaseSettingNavigationBarColorVC ()

@end

@implementation BaseSettingNavigationBarColorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.navigationController.navigationBar.barTintColor = RGB(255,255,255);
    NSMutableDictionary *titleTextAttributes = [[NSMutableDictionary alloc] init];
    titleTextAttributes[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    titleTextAttributes[NSForegroundColorAttributeName] = RGB(1,1,1);
    self.navigationController.navigationBar.titleTextAttributes = titleTextAttributes;

    self.navigationController.navigationBar.tintColor = TextMainBlackColor;

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

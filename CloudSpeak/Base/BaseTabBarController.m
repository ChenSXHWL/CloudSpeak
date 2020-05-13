//
//  LHBaseTabBarController.m
//  LaHuo
//
//  Created by ljh on 14-10-23.
//  Copyright (c) 2014年 LaHuo. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
@interface BaseTabBarController ()
@end

@implementation BaseTabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tabBar setBarTintColor:[UIColor whiteColor]];
    
    [self.tabBar setTintColor:RGB(235,109,8)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

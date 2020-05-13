//
//  LHBaseNavigationController.m
//  LaHuo
//
//  Created by ljh on 14-10-23.
//  Copyright (c) 2014年 LaHuo. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController


- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self)
    {
        
        if ([[UIDevice currentDevice].systemVersion floatValue] > 7.0)
        {
            self.interactivePopGestureRecognizer.delegate = (id <UIGestureRecognizerDelegate>) self;
            self.delegate = (id <UINavigationControllerDelegate>) self;
        }
//        [self appThemeDidChanged];
    }
    return self;
}
/**
 *  设置导航栏NavigationBar的字体颜色大小以及barTintColor
 */
-(void)appThemeDidChanged
{
    self.navigationBar.barTintColor = NavigationBarWhiteColor;
    NSMutableDictionary *titleTextAttributes = [[NSMutableDictionary alloc] init];
    titleTextAttributes[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    titleTextAttributes[NSForegroundColorAttributeName] = RGB(0,0,0);
    self.navigationBar.titleTextAttributes = titleTextAttributes;
}

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if (self.viewControllers.count > 0)
//    {
//        
//        viewController.hidesBottomBarWhenPushed = YES;
//        
//    }
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
//    {
//        self.interactivePopGestureRecognizer.enabled = NO;
//    }
//    [self.visibleViewController.view endEditing:YES];
//    [super pushViewController:viewController animated:animated];
//}
//
//
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleDefault;
//}
//
//-(UIViewController *)popViewControllerAnimated:(BOOL)animated {
//    
//    return [super popViewControllerAnimated:YES];
//}
//
#pragma mark UINavigationControllerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.childViewControllers count] == 1) {
        return NO;
    }
    return YES;
}

@end

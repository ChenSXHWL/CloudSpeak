//
//  Aspect-appearance.m
//  mcapp
//
//  Created by zhuchao on 14/12/16.
//  Copyright (c) 2014年 zhuchao. All rights reserved.
//

#import "AppDelegate.h"
#import <XAspect/XAspect.h>
#import "IQKeyboardManager.h"
#import "IQUIView+IQKeyboardToolbar.h"

#define AtAspect  MainConfig

#define AtAspectOfClass AppDelegate
@classPatchField(AppDelegate)
AspectPatch(-, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions)
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 50.f;
    
    [LoginManage goMain];
    
    return XAMessageForward(application:application didFinishLaunchingWithOptions:launchOptions);
    
    
    
}

@end
#undef AtAspectOfClass
#undef AtAspect

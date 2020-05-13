//
//  Aspect-appearance.m
//  mcapp
//
//  Created by zhuchao on 14/12/16.
//  Copyright (c) 2014年 zhuchao. All rights reserved.
//

#import "AppDelegate.h"
#import <XAspect/XAspect.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

#define AtAspect  Amap

#define AtAspectOfClass AppDelegate
@classPatchField(AppDelegate)
AspectPatch(-, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions)
{
    
    //高德地图Key
    [AMapServices sharedServices].apiKey = @"2118205a119c74384e49ee454e7c657a";
//    [AMapServices sharedServices].apiKey = @"35bd2ac263ca7aafd35056e4900424da";//企业

    
    return XAMessageForward(application:application didFinishLaunchingWithOptions:launchOptions);
    
    
    
}

@end
#undef AtAspectOfClass
#undef AtAspect

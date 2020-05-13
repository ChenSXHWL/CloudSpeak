//
//  Aspect-appearance.m
//  mcapp
//
//  Created by zhuchao on 14/12/16.
//  Copyright (c) 2014年 zhuchao. All rights reserved.
//

#import "AppDelegate.h"
#import <XAspect/XAspect.h>

#define AtAspect  Network

#define AtAspectOfClass AppDelegate
@classPatchField(AppDelegate)
AspectPatch(-, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions)
{
    
    [[[$ rac_didNetworkChanges]skip:1]
     subscribeNext:^(NSNumber *status) {
         AFNetworkReachabilityStatus networkStatus = [status intValue];
         
         
         switch (networkStatus) {
             case AFNetworkReachabilityStatusUnknown:
             case AFNetworkReachabilityStatusNotReachable:
                 
                 if(self.window){
                     [[DialogUtil sharedInstance] showDlg:self.window textOnly:@"网络连接不给力"];
                 }
                
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationNetworkChange" object:@(0)];
                 
                 break;
                 
             case AFNetworkReachabilityStatusReachableViaWWAN:
                 if(self.window){
                     [[DialogUtil sharedInstance] showDlg:self.window textOnly:@"当前使用移动数据网络"];
                     
                 }
                 
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationNetworkChange" object:@(1)];
                 
                 break;
                 
             case AFNetworkReachabilityStatusReachableViaWiFi:
                 
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationNetworkChange" object:@(2)];
                 
                 break;
         }
         
         [[NSUserDefaults standardUserDefaults] setObject:status forKey:@"networkStatus"];


        
         
     }];
    
    return XAMessageForward(application:application didFinishLaunchingWithOptions:launchOptions);
}
@end
#undef AtAspectOfClass
#undef AtAspect

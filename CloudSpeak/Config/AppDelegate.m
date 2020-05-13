//
//  AppDelegate.m
//  ishanghome
//
//  Created by DNAKE_AY on 16/12/1.
//  Copyright © 2016年 DNAKE_AY. All rights reserved.
//

#import "AppDelegate.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [MTA startWithAppkey:@"I4LD1UPMF45B"]; //xxxx为注册App时得到的APPKEY //企业IB8ADW5HX52X //正式I4LD1UPMF45B
    [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:@"networkStatus"];


    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    // 当应用程序即将从活动状态转到非活动状态时。这可能发生在某些类型的临时中断（如传入的电话或SMS消息）或当用户退出应用程序，并开始过渡到背景状态。
    // 使用此方法暂停当前任务，禁用定时器，并使图形渲染回调。游戏应该用这个方法暂停游戏。
    [MTA trackActiveEnd];

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    // 使用此方法释放共享资源，保存用户数据，使计时器失效，并存储足够的应用程序状态信息，以便将应用程序还原到当前状态，以便在以后终止应用程序。
    // 如果您的应用程序支持后台执行，这种方法被称为替代applicationWillTerminate:当用户退出。
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    // 调用作为从背景到活动状态过渡的一部分，在这里您可以撤消进入后台所做的许多更改。
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    // 在应用程序处于非活动状态时，重新启动任何暂停（或尚未启动）的任务。如果应用程序以前在后台，可以随意刷新用户界面。
    [MTA trackActiveBegin];

}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:
    // 当应用程序即将终止时调用。如果适当保存数据。又见applicationDidEnterBackground有

    
}


//注册APNs成功并上报DeviceToken
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
}

//实现注册APNs失败接口（可选）
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
}

//添加处理APNs通知回调方法
#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    
}

@end

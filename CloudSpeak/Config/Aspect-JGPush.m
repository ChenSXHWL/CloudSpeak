//
//  Aspect-appearance.m
//  mcapp
//
//  Created by zhuchao on 14/12/16.
//  Copyright (c) 2014年 zhuchao. All rights reserved.
//

#import "AppDelegate.h"
#import <XAspect/XAspect.h>

// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>
#import "AYAlertViewController.h"
#import "GuideVC.h"
#import "BaseNavigationController.h"
#import "HomeGuardLocVC.h"
#import "OpenVC.h"


#define AtAspect  JGPush

#define AtAspectOfClass AppDelegate
@classPatchField(AppDelegate)

AspectPatch(-, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions)
{
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"happy.wav" withExtension:nil];
    
    //组装音效
    
    SystemSoundID soundIDs = 0;
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundIDs);
    
    /************ 1 **********/
    
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    /************ 2 **********/
    
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    
    
    
    //正式服务器是这个
//    [JPUSHService setupWithOption:launchOptions app才Key:@"1cdd80d7f1960a03de8679b6"////企业版是这个07fe9b0ceab20400fc2cbc4b//06d7227a248e7047155813c6新账号推送
//                          channel:@"App Store"
//                 apsForProduction:JGPushIsProduction
//            advertisingIdentifier:advertisingId];
    
    [JPUSHService setupWithOption:launchOptions appKey:@"1cdd80d7f1960a03de8679b6"
                          channel:@"App Store"
                 apsForProduction:JGPushIsProduction
            advertisingIdentifier:advertisingId];

    
    return XAMessageForward(application:application didFinishLaunchingWithOptions:launchOptions);
    
}

//注册APNs成功并上报DeviceToken
AspectPatch(-, void, application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken)
{
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
//实现注册APNs失败接口（可选）
AspectPatch(-, void, application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error)
{
    
}

AspectPatch(-, void, application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler)
{
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    NSString *aps = userInfo[@"aps"][@"alert"];
    if ([aps isEqualToString:@"您的账号已在别处登录，请确认是否是本人登录:)."]) {
        
        if ([[URLNavigation navigation].currentViewController isKindOfClass:[HomeGuardLocVC class]] || [[URLNavigation navigation].currentViewController isKindOfClass:[OpenVC class]]) {
            
            [[AYCloudSpeakApi cloudSpeakApi] callStop];
            
        }
        
        NSString *scheme = [LoginEntity shareManager].scheme;
        
        NSString *url = [LoginEntity shareManager].url;
        
        [LoginManage loginOut];
        
        [AYAlertViewController alertViewController:[URLNavigation navigation].currentViewController message:@"您的账号已在别处登录，请确认是否是本人登录" confirmStr:@"确定" alert:^(UIAlertController *action) {
            
            GuideVC *guideVC = [GuideVC new];
            
            guideVC.isLogin = YES;
            
            guideVC.scheme = scheme;
            
            guideVC.formalStr = url;
            
            [URLNavigation setRootViewController:[[BaseNavigationController alloc] initWithRootViewController:guideVC]];
            
        }];
        
    }
    
}

AspectPatch(-, void, application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo)
{
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

AspectPatch(-, void, jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler)
{
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
    
    //    NSString *aps = userInfo[@"aps"][@"alert"];
    //
    //    if ([aps isEqualToString:@"您的账号已在别处登录，请确认是否是本人登录:)."]) {
    //
    //        [AYAlertViewController alertViewController:[URLNavigation navigation].currentViewController message:@"您的账号已在别处登录，请确认是否是本人登录" confirmStr:@"确定" alert:^(UIAlertController *action) {
    //
    //            GuideVC *guideVC = [GuideVC new];
    //
    //            guideVC.isLogin = YES;
    //
    //            [URLNavigation setRootViewController:[[BaseNavigationController alloc] initWithRootViewController:guideVC]];
    //
    //        }];
    //
    //    }
}

AspectPatch(-, void, jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler)
{
    
    if (![LoginEntity shareManager].password.length) return;
    
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionNone); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    
    NSString *aps = userInfo[@"aps"][@"alert"];
    
    if ([aps isEqualToString:@"您的账号已在别处登录，请确认是否是本人登录:)."]) {
        
        if ([[URLNavigation navigation].currentViewController isKindOfClass:[HomeGuardLocVC class]] || [[URLNavigation navigation].currentViewController isKindOfClass:[OpenVC class]]) {
            
            [[AYCloudSpeakApi cloudSpeakApi] callStop];
            
        }
        
        NSString *scheme = [LoginEntity shareManager].scheme;
        
        NSString *url = [LoginEntity shareManager].url;
        
        [LoginManage loginOut];
        
        [AYAlertViewController alertViewController:[URLNavigation navigation].currentViewController message:@"您的账号已在别处登录，请确认是否是本人登录" confirmStr:@"确定" alert:^(UIAlertController *action) {
            
            GuideVC *guideVC = [GuideVC new];
            
            guideVC.isLogin = YES;
            
            guideVC.scheme = scheme;
            
            guideVC.formalStr = url;
            
            [URLNavigation setRootViewController:[[BaseNavigationController alloc] initWithRootViewController:guideVC]];
            
        }];
        
    }
}

@end
#undef AtAspectOfClass
#undef AtAspect

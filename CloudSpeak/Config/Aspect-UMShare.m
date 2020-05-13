//
//  Aspect-appearance.m
//  mcapp
//
//  Created by zhuchao on 14/12/16.
//  Copyright (c) 2014年 zhuchao. All rights reserved.
//

#import "AppDelegate.h"
#import <XAspect/XAspect.h>
//友盟分享
#import <UMSocialCore/UMSocialCore.h>

#define AtAspect  UMShare

#define AtAspectOfClass AppDelegate
@classPatchField(AppDelegate)
AspectPatch(-, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions)
{
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@""];//USHARE_DEMO_APPKEY
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和app.Secret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106016667"/*设置QQ平台的appID*/  appSecret:@"RsjB8biXgLrLT5Br" redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx36c691847cf43305" appSecret:@"1334f3f3515215cfb954ead2e220c20b" redirectURL:@"http://mobile.umeng.com/social"];
    
    return XAMessageForward(application:application didFinishLaunchingWithOptions:launchOptions);
    
}

AspectPatch(-, BOOL, application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation)
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return XAMessageForward(application:application openURL:url sourceApplication:sourceApplication annotation:annotation);
}

@end
#undef AtAspectOfClass
#undef AtAspect

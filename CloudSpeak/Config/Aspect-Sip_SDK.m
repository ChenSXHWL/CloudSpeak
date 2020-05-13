//
//  Aspect-appearance.m
//  mcapp
//
//  Created by zhuchao on 14/12/16.
//  Copyright (c) 2014年 zhuchao. All rights reserved.
//

#import "AppDelegate.h"
#import <XAspect/XAspect.h>
//#import "QNIP.h"
#import "HomeGuardLocVC.h"
#import "OpenVC.h"
#import "GuideVC.h"
#import "AYAlertViewController.h"
#import "BaseNavigationController.h"
#import "AYAnalysisXMLData.h"
#import "OpenView.h"
#define AtAspect  Sip_SDK

#define AtAspectOfClass AppDelegate

@classPatchField(AppDelegate)
AspectPatch(-, BOOL, application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions)
{
    
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"event_call_invite" object:nil] subscribeNext:^(NSNotification *x) {
        @strongify(self);
        NSLog(@"收到呼叫");

        if (![LoginEntity shareManager].password.length || [[URLNavigation navigation].currentViewController isKindOfClass:[OpenVC class]]) return ;
        OpenVC *open = [OpenVC new];
        
        open.callId = x.userInfo[@"callId"];
        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenKey" object:nil];
//        UIView *view = [[UIApplication sharedApplication].keyWindow viewWithTag:1200];
//        view.hidden = YES;
//        
        dispatch_sync(dispatch_get_main_queue(), ^{
//            OpenView *openView = [OpenView sharedInstance];
//            
//            openView.hidden = YES;
//            [openView deleteOpenView];
            [MBProgressHUD hideHUDForView:[URLNavigation navigation].currentViewController.view animated:YES];
            
            [[URLNavigation navigation].currentViewController presentViewController:open animated:YES completion:nil];
            
        });
        
        
        self.openVC = open;
        
        self.isInvite = YES;
        
        [self presentVideoisImage:self.isImage invite:self.isInvite];
        
        
        
    }];
    
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"event_instant_msg" object:nil] subscribeNext:^(NSNotification *x) {
        @strongify(self);
        
        NSDictionary *dict = x.userInfo;
        
        NSString *snapshot = (NSString *)dict[@"event"] == nil ? @"" : (NSString *)dict[@"event"];
        
        if ([snapshot isEqualToString:@"/talk/snapshot/report"]) {
            
            self.imageUrl = dict[@"url"];
            
            self.isImage = YES;
            
            [self presentVideoisImage:self.isImage invite:self.isInvite];
            
        }
        
        
    }];
    
    
    self.checkAuthorizationVM = [CheckAuthorizationVM SceneModel];
    
    if([LoginEntity shareManager].password.length) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            self.checkAuthorizationVM.checkAuthorizationRequest.requestNeedActive = YES;
            
        });
        
    } else {
        
            [[AYCloudSpeakApi cloudSpeakApi] initCloudSpeak];
        
    }
    
    
    
    [[RACObserve(self.checkAuthorizationVM.checkAuthorizationRequest, state) filter:^BOOL(id value) {
        return YES;
    }] subscribeNext:^(id x) {
        @strongify(self);
        if (x == RequestStateSending || x == nil) return ;
        
        NSNumber *error = self.checkAuthorizationVM.checkAuthorizationRequest.output[@"errorCode"];
        
        if (error.integerValue == 32) {
            
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
            
        } else {
            
            [[AYCloudSpeakApi cloudSpeakApi] initCloudSpeak];
            
            NSString *sipService = @"";
            
            if ([self.checkAuthorizationVM.checkAuthorizationRequest.url.host isEqualToString:@"119.23.146.101"]) {
                sipService = @"sipproxy.dnake.com:45068";
            } else {
                sipService = @"sipproxy.ucpaas.com:25060";
            }
            
            [[AYCloudSpeakApi cloudSpeakApi] setSipConfigWithSipServer:sipService sipAccout:[LoginEntity shareManager].sipAccount sipPassword:[LoginEntity shareManager].sipPassword];
            
            NSString *deviceSip = self.checkAuthorizationVM.checkAuthorizationRequest.output[@"deviceSip"];
            
            if(![deviceSip isKindOfClass:[NSNull class]]) {
                
                if (deviceSip.length) {
                    
                    if ([[URLNavigation navigation].currentViewController isKindOfClass:[OpenVC class]]) return ;
                    
//                    [MBProgressHUD showHUDAddedTo:[URLNavigation navigation].currentViewController.view animated:YES];
                    
                }
                
            }
            
            [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"event_registration" object:nil] subscribeNext:^(NSNotification *x) {
                
                NSDictionary *dict = x.userInfo;
                
                NSNumber *registrationCode = dict[@"registration"];
                
                //在主线程中更新UI代码
                //(0:注册成功 1：失败)
                if (registrationCode.intValue == 1) return ;
                                
                NSString *deviceSip = self.checkAuthorizationVM.checkAuthorizationRequest.output[@"deviceSip"];
                
                if(![deviceSip isKindOfClass:[NSNull class]]) {
                    
                    if (deviceSip.length) {
                        
                        [[AYCloudSpeakApi cloudSpeakApi] instantMsgSendWithCallId:deviceSip unLockXML:[AYAnalysisXMLData reCallAppendXML]];
                        
                    }
                }
            }];
        }
    }];
    
    return XAMessageForward(application:application didFinishLaunchingWithOptions:launchOptions);
}

AspectPatch(-, void, applicationDidEnterBackground:(UIApplication *)application)
{
    
    [AYCloudSpeakApi cloudSpeakApi].isEnterBackground = YES;
    
    if ([[URLNavigation navigation].currentViewController isKindOfClass:[HomeGuardLocVC class]] || [[URLNavigation navigation].currentViewController isKindOfClass:[OpenVC class]]) return;
    
    [[AYCloudSpeakApi cloudSpeakApi] exitCloudSpeak];
    
}

AspectPatch(-, void, applicationWillEnterForeground:(UIApplication *)application)
{
    [AYCloudSpeakApi cloudSpeakApi].isEnterBackground = NO;
    
    if (![AYCloudSpeakApi cloudSpeakApi].isExit) {
        
        if ([LoginEntity shareManager].password.length) {
            
            self.checkAuthorizationVM.checkAuthorizationRequest.requestNeedActive = YES;
            
        } else {
            
            [[AYCloudSpeakApi cloudSpeakApi] initCloudSpeak];
            
        }
        
    }
    
}

AspectPatch(-, void, applicationWillTerminate:(UIApplication *)application) {
    
    [[AYCloudSpeakApi cloudSpeakApi] exitCloudSpeak];
    
}

- (void)presentVideoisImage:(BOOL)image invite:(BOOL)invite
{
    
    if (image && invite) {
        
        self.openVC.imageUrl = self.imageUrl;
        
        self.isImage= NO;
        
        self.isInvite = NO;
//
//        self.imageUrl = nil;
//
//        self.openVC = nil;
        
    }
}

@end
#undef AtAspectOfClass
#undef AtAspect

//
//  AppDelegate.h
//  ishanghome
//
//  Created by DNAKE_AY on 16/12/1.
//  Copyright © 2016年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckAuthorizationVM.h"
#import "JPUSHService.h"
#import "OpenVC.h"
#import "LoginVC.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, JPUSHRegisterDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CheckAuthorizationVM *checkAuthorizationVM;

@property (strong, nonatomic) OpenVC *openVC;

@property (assign, nonatomic) BOOL isImage;

@property (assign, nonatomic) BOOL isInvite;

@property (copy, nonatomic) NSString *callId;

@property (copy, nonatomic) NSString *imageUrl;

@end


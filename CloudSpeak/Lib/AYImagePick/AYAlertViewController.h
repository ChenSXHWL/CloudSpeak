//
//  AYAlertViewController.h
//  IntelligentControlSystem
//
//  Created by DNAKE_AY on 16/10/24.
//  Copyright © 2016年 DNAKE_AY. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AYActionCompletionBlock)(int index);

typedef void(^AYAlertCompletionBlock)(UIAlertController *action);

@interface AYAlertViewController : NSObject <UITextFieldDelegate>

+ (void)alertViewController:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)message cancelStr:(NSString *)cancelStr confirmStr:(NSString *)confirmStr styleText:(int)styleText isSecret:(BOOL)isSecret value:(NSString *)value alert:(AYAlertCompletionBlock)alert;
+ (void)actionSheetViewController:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)message actionStrings:(NSArray *)actionStrings actionSheet:(AYActionCompletionBlock)alert;

+ (void)alertViewController:(UIViewController *)viewController message:(NSString *)message confirmStr:(NSString *)confirmStr alert:(AYAlertCompletionBlock)alert;
+ (void)alertViewController:(UIViewController *)viewController message:(NSString *)message confirmStr:(NSString *)confirmStr cancelStr:(NSString *)cancelStr alert:(AYAlertCompletionBlock)alert;
+ (void)alertViewController:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)message actionStrings:(NSArray *)actionStrings actionSheet:(AYActionCompletionBlock)alert;

//设备配置
+ (void)alertViewControllerEquipmentSetting:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)message cancelStr:(NSString *)cancelStr confirmStr:(NSString *)confirmStr styleText:(int)styleText isSecret:(BOOL)isSecret value:(NSString *)value alert:(AYAlertCompletionBlock)alert;

+ (void)alertViewControllerEquipmentSetting1:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)message cancelStr:(NSString *)cancelStr confirmStr:(NSString *)confirmStr styleText:(int)styleText isSecret:(BOOL)isSecret value:(NSString *)value alert:(AYAlertCompletionBlock)alert;

+ (void)alertViewControllerNormal:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)message cancelStr:(NSString *)cancelStr confirmStr:(NSString *)confirmStr style:(int)style value:(NSString *)value length:(NSInteger)length alert:(AYAlertCompletionBlock)alert;

@end

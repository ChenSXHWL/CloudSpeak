//
//  AYAlertViewController.m
//  IntelligentControlSystem
//
//  Created by DNAKE_AY on 16/10/24.
//  Copyright © 2016年 DNAKE_AY. All rights reserved.
//

#import "AYAlertViewController.h"

@implementation AYAlertViewController

+ (void)alertViewController:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)message cancelStr:(NSString *)cancelStr confirmStr:(NSString *)confirmStr styleText:(int)styleText isSecret:(BOOL)isSecret value:(NSString *)value alert:(AYAlertCompletionBlock)alert
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (styleText) {
        
        [alertVC addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            
            textField.placeholder = isSecret == YES ? @"密码" : @"";
            textField.secureTextEntry = isSecret == YES ? YES : NO;
            textField.text = value;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        }];
        
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelStr style:UIAlertActionStyleDestructive handler:nil];
    
    //修改按钮
    [cancelAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:confirmStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        alert(alertVC);
    }];
    
    [alertVC addAction:cancelAction];
    
    [alertVC addAction:okAction];
    
    [viewController presentViewController:alertVC animated:YES completion:nil];
}

+ (void)actionSheetViewController:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)message actionStrings:(NSArray *)actionStrings actionSheet:(AYActionCompletionBlock)alert
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int i = 0; i < actionStrings.count; i ++) {
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:actionStrings[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            alert(i);
        }];
        
        [alertVC addAction:action];
        
    }
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil]];
    
    [viewController presentViewController:alertVC animated:YES completion:nil];
    
}

+ (void)alertViewController:(UIViewController *)viewController message:(NSString *)message confirmStr:(NSString *)confirmStr alert:(AYAlertCompletionBlock)alert
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:confirmStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        alert(alertVC);
    }];
    
    [alertVC addAction:okAction];
    
    [viewController presentViewController:alertVC animated:YES completion:nil];
}

+ (void)alertViewController:(UIViewController *)viewController message:(NSString *)message confirmStr:(NSString *)confirmStr cancelStr:(NSString *)cancelStr alert:(AYAlertCompletionBlock)alert
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:confirmStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        alert(alertVC);
    }];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:cancelStr style:UIAlertActionStyleDestructive handler:nil]];
    
    [alertVC addAction:okAction];
    
    [viewController presentViewController:alertVC animated:YES completion:nil];
}
+ (void)alertViewControllerEquipmentSetting:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)message cancelStr:(NSString *)cancelStr confirmStr:(NSString *)confirmStr styleText:(int)styleText isSecret:(BOOL)isSecret value:(NSString *)value alert:(AYAlertCompletionBlock)alert
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (styleText) {
        
        [alertVC addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            
            textField.placeholder = isSecret == YES ? @"密码" : @"";
            textField.secureTextEntry = isSecret == YES ? YES : NO;
            textField.text = value;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.keyboardType = UIKeyboardTypeDecimalPad;
        }];
        
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelStr style:UIAlertActionStyleDestructive handler:nil];
    
    //修改按钮
    [cancelAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:confirmStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        alert(alertVC);
    }];
    
    [alertVC addAction:cancelAction];
    
    [alertVC addAction:okAction];
    
    [viewController presentViewController:alertVC animated:YES completion:nil];
}

+ (void)alertViewControllerEquipmentSetting1:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)message cancelStr:(NSString *)cancelStr confirmStr:(NSString *)confirmStr styleText:(int)styleText isSecret:(BOOL)isSecret value:(NSString *)value alert:(AYAlertCompletionBlock)alert
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (styleText) {
        
        [alertVC addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            
            textField.placeholder = isSecret == YES ? @"密码" : @"";
            textField.secureTextEntry = isSecret == YES ? YES : NO;
            textField.text = value;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.keyboardType = UIKeyboardTypeNumberPad;
        }];
        
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelStr style:UIAlertActionStyleDestructive handler:nil];
    
    //修改按钮
    [cancelAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:confirmStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        alert(alertVC);
    }];
    
    [alertVC addAction:cancelAction];
    
    [alertVC addAction:okAction];
    
    [viewController presentViewController:alertVC animated:YES completion:nil];
}
+ (void)alertViewController:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)message actionStrings:(NSArray *)actionStrings actionSheet:(AYActionCompletionBlock)alert
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil]];
    
    for (int i = 0; i < actionStrings.count; i ++) {
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:actionStrings[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            alert(i);
        }];
        
        [alertVC addAction:action];
        
    }
    
    
    [viewController presentViewController:alertVC animated:YES completion:nil];
    
}

+ (void)alertViewControllerNormal:(UIViewController *)viewController Title:(NSString *)title message:(NSString *)message cancelStr:(NSString *)cancelStr confirmStr:(NSString *)confirmStr style:(int)style value:(NSString *)value length:(NSInteger)length alert:(AYAlertCompletionBlock)alert
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        textField.text = value;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        switch (style) {
            case 0:
            {
                @weakify(self);
                [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UITextFieldTextDidChangeNotification object:textField] subscribeNext:^(id x) {
                    @strongify(self);
                    [self textFieldDidChange:textField length:length];
                }];
                
                textField.keyboardType = UIKeyboardTypeNumberPad;
            }
                break;
            case 1:
            {
                textField.keyboardType = UIKeyboardTypeDefault;
            }
                break;
            case 2:
            {
                textField.keyboardType = UIKeyboardTypeDecimalPad;
            }
                break;
                
            default:
                break;
        }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelStr style:UIAlertActionStyleDestructive handler:nil];
    
    //修改按钮
    [cancelAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:confirmStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        alert(alertVC);
    }];
    
    [alertVC addAction:cancelAction];
    
    [alertVC addAction:okAction];
    
    [viewController presentViewController:alertVC animated:YES completion:nil];
}

+ (void) textFieldDidChange:(UITextField *)textField length:(NSInteger)length
{
    NSInteger kMaxLength = length;
    NSString *toBeString = textField.text;
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; //ios7之前使用[UITextInputMode currentInputMode].primaryLanguage
    if ([lang isEqualToString:@"zh-Hans"]) { //中文输入
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        if (!position) {// 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
        }
        else{//有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    }else{//中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > kMaxLength) {
            textField.text = [toBeString substringToIndex:kMaxLength];
        }
    }
}

@end

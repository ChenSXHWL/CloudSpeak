//
//  AYProgressHud.m
//  renfang
//
//  Created by FLY_AY on 16/6/23.
//  Copyright © 2016年 FLY_AY. All rights reserved.
//

#import "AYProgressHud.h"

@implementation AYProgressHud
DEF_SINGLETON(AYProgressHud)

+ (void)progressHudLoadingRequest:(Request *)request showInView:(UIView *)view detailString:(NSString *)string
{
    
    [[self sharedInstance]progressHudLoadingRequest:request showInView:view detailString:string];
    
}


- (void)progressHudLoadingRequest:(Request *)request showInView:(UIView *)view detailString:(NSString *)string{
    
    MBProgressHUD *hud;
    
    if (view) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    } else {
        hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    }
    
    NSString *detailString = [NSString stringWithFormat:@"%@",string];
    
    hud.labelText = NSLocalizedString(detailString, @"HUD loading title");
    
    [[RACObserve(request, state) filter:^BOOL(id value) {
        return YES;
    }] subscribeNext:^(id x) {
        
        if (x == RequestStateSending) return ;
        
        [hud hide:YES];
        
        if (request.codeKey.intValue != 1) {
            if (request.codeKey.intValue == 3) {
//                [AYProgressHud progressHudShowShortTimeMessage:@"登录失效，请重新登录"];
            }else{
                if (request.message.length>0) {
                    if ([request.message isEqualToString:@"住户没有可控制的设备列表！"]) {
                        
                    }else{
                        [AYProgressHud progressHudShowShortTimeMessage:request.message];
                    }
                }
            }
        }
        
        
    }];
    
    [hud hide:YES afterDelay:10];
    
}

+ (void)progressHudShowShortTimeMessage:(NSString *)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
//    hud.labelText = NSLocalizedString(message, @"HUD message title");
    hud.detailsLabelText = NSLocalizedString(message, @"HUD message title");
    hud.detailsLabelFont = [UIFont systemFontOfSize:17];
    // Move to bottm center.
    [hud setXOffset:0];
    [hud setYOffset:0];
    [hud hide:YES afterDelay:2.f];
}

+ (void)progressHudLoadSuccess {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    // Set the custom view mode to show any view.
    hud.mode = MBProgressHUDModeCustomView;
    hud.tintColor = RGB(255, 255, 255);
    // Set an image view with a checkmark.
    UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    // Looks a bit nicer if we make it square.
    hud.square = YES;
    // Optional label text.
    hud.labelText = NSLocalizedString(@"登录成功", @"HUD done title");
    
    [hud hide:YES afterDelay:2.f];
}

@end

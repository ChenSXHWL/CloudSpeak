//
//  AYProgressHud.h
//  renfang
//
//  Created by FLY_AY on 16/6/23.
//  Copyright © 2016年 FLY_AY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AYProgressHud : NSObject
/**
 *  如果view传nil 默认hud展示在window上 否则展示在当前view上面
 *
 *  @param request 网络请求对象
 *  @param view    hud所展示的位置 if（view == nil）在window else 在view上
 *  @param string  菊花下面的文字
 */
+ (void)progressHudLoadingRequest:(Request *)request showInView:(UIView *)view detailString:(NSString *)string;
/**
 *  message展示时长3s
 *
 *  @param message 展示内容
 */
+ (void)progressHudShowShortTimeMessage:(NSString *)message;


@end

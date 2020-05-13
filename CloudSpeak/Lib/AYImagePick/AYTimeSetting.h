//
//  AYTimeSetting.h
//  ishanghome
//
//  Created by DNAKE_AY on 16/12/12.
//  Copyright © 2016年 DNAKE_AY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AYTimeSetting : NSObject

/**
 时间格式转化成字符串
 */

+ (NSString *)dateStringFromDate:(NSDate *)date;

+ (NSString *)dateStringFromDateYMD:(NSDate *)date;

+ (NSString *)dateStringFromDateYM:(NSDate *)date;

/**
 普通字符串转换成时间格式
 */
+ (NSString *)dateStyleFromDateString:(NSString *)dataString;

+ (NSString *)dateStyleFromDateStringTypeYMD:(NSString *)dataString;
+ (NSString *)dateStyleFromDateStringTypeYMDSale:(NSString *)dataString;

+ (UIViewController *)getCurrentRootViewController;

@end

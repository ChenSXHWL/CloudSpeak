//
//  AYTimeSetting.m
//  ishanghome
//
//  Created by DNAKE_AY on 16/12/12.
//  Copyright © 2016年 DNAKE_AY. All rights reserved.
//

#import "AYTimeSetting.h"

@implementation AYTimeSetting

+ (NSString *)dateStringFromDate:(NSDate *)date
{
    //转换时间格式
    
    NSDateFormatter*df = [[NSDateFormatter alloc]init];//格式化
    
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString* s1 = [df stringFromDate:date];
    
    NSDate* dateValue = [df dateFromString:s1];
    
    //转换时间格式
    
    NSDateFormatter*df2 = [[NSDateFormatter alloc]init];//格式化
    
    [df2 setDateFormat:@"yyyyMMdd"];
    
    [df2 setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    
    return [df2 stringFromDate:dateValue];
}

+ (NSString *)dateStringFromDateYMD:(NSDate *)date
{
    //转换时间格式
    
    NSDateFormatter*df = [[NSDateFormatter alloc]init];//格式化
    
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString* s1 = [df stringFromDate:date];
    
    NSDate* dateValue = [df dateFromString:s1];
    
    //转换时间格式
    
    NSDateFormatter*df2 = [[NSDateFormatter alloc]init];//格式化
    
    [df2 setDateFormat:@"yyyy-MM-dd"];
    
    [df2 setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    
    return [df2 stringFromDate:dateValue];
}

+ (NSString *)dateStringFromDateYM:(NSDate *)date
{
    //转换时间格式
    
    NSDateFormatter*df = [[NSDateFormatter alloc]init];//格式化
    
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString* s1 = [df stringFromDate:date];
    
    NSDate* dateValue = [df dateFromString:s1];
    
    //转换时间格式
    
    NSDateFormatter*df2 = [[NSDateFormatter alloc]init];//格式化
    
    [df2 setDateFormat:@"yyyy-MM"];
    
    [df2 setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    
    return [df2 stringFromDate:dateValue];
}

+ (NSString *)dateStyleFromDateString:(NSString *)dataString
{
    NSDateFormatter*df = [[NSDateFormatter alloc]init];//格式化
    
    [df setDateFormat:@"yyyyMMddHHmmss"];
    
    [df setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"] ];
    
    NSDate *date =[df dateFromString:dataString];
    
    NSDateFormatter* df2 = [[NSDateFormatter alloc]init];
    
    [df2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString* str1 = [df2 stringFromDate:date];
    
    return str1;
}

+ (NSString *)dateStyleFromDateStringTypeYMD:(NSString *)dataString
{
    NSDateFormatter*df = [[NSDateFormatter alloc]init];//格式化
    
    [df setDateFormat:@"yyyyMMddHHmmss"];
    
    [df setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"] ];
    
    NSDate*date =[df dateFromString:dataString];
    
    NSDateFormatter* df2 = [[NSDateFormatter alloc]init];
    
    [df2 setDateFormat:@"yyyy-MM-dd"];
    
    NSString* str1 = [df2 stringFromDate:date];
    
    return str1;
}

+ (NSString *)dateStyleFromDateStringTypeYMDSale:(NSString *)dataString
{
    NSDateFormatter*df = [[NSDateFormatter alloc]init];//格式化
    
    [df setDateFormat:@"yyyyMMdd"];
    
    [df setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"] ];
    
    NSDate *date =[df dateFromString:dataString];
    
    NSDateFormatter* df2 = [[NSDateFormatter alloc]init];
    
    [df2 setDateFormat:@"yyyy-MM-dd"];
    
    NSString* str1 = [df2 stringFromDate:date];
    
    return str1;
}

/**
 *  获取当前的viewController
 */
+ (UIViewController *)getCurrentRootViewController {
    
    
    UIViewController *result;
    
    
    // Try to find the root view controller programmically
    
    
    // Find the top window (that is not an alert view or other window)
    
    
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    
    
    if (topWindow.windowLevel != UIWindowLevelNormal)
        
        
    {
        
        
        NSArray *windows = [[UIApplication sharedApplication] windows];
        
        
        for(topWindow in windows)
            
            
        {
            
            
            if (topWindow.windowLevel == UIWindowLevelNormal)
                
                
                break;
            
            
        }
        
        
    }
    
    
    UIView *rootView = [[topWindow subviews] objectAtIndex:0];
    
    
    id nextResponder = [rootView nextResponder];
    
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        
        
        result = nextResponder;
    
    
    else if ([topWindow respondsToSelector:@selector(rootViewController)] && topWindow.rootViewController != nil)
        
        
        result = topWindow.rootViewController;
    
    
    else
        
        
        NSAssert(NO, @"ShareKit: Could not find a root view controller.  You can assign one manually by calling [[SHK currentHelper] setRootViewController:YOURROOTVIEWCONTROLLER].");
    
    
    return result;
    
    
}


@end

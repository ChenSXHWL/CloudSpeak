//
//  AYAnalysisXMLData.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/13.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AYAnalysisXMLData : NSObject
/**
 解析工程配置XML信息
 
 @param xmlString XML字符串
 @return 字典
 */
+ (NSDictionary *)analysisXMLWithSetConfig:(NSString *)xmlString;

/**
 转码底层XML字符串

 @param xmlString XML
 @return NSDictionary
 */
+ (NSDictionary *)analysisXMLWithListenVideo:(NSString *)xmlString;

/**
 解析工程配置XML信息

 @param xmlString XML字符串
 @return 字典
 */
+ (NSDictionary *)analysisXMLWithSetConfig11:(NSString *)xmlString;

/**
 生成单开锁字符串

 @return 开锁用字符串
 */
+ (NSString *)appendXML;

/**
 通话中开锁
 
 @param buildStr 楼栋 1-9999
 @param unitStr 单元 0-99
 @param floorStr 楼层号 room/100
 @param familyStr 房号 room%100
 @return 拼接完的XML
 */

+ (NSString *)appendXML:(NSString *)buildStr unit:(NSString *)unitStr room:(NSString *)floorStr family:(NSString *)familyStr;

/**
   解析NSDictionary用于获取设备配置音量等数组

 @param dict NSDictionary
 @return NSArray
 */
+ (NSArray *)analysisSelectLoc:(NSDictionary *)dict;

/**
 联动控制电梯

 @param elevStr 电梯编号
 @param directStr 1上 2下
 @param floorStr 楼层号 room/100
 @param familyStr 房号 room%100
 @param eventStr appoint permit
 @param event_urlStr /elev/appoint  /elev/permit
 @return 拼接完的XML
 */
+ (NSString *)appendLadderXML:(NSString *)elevStr direct:(NSString *)directStr floor:(NSString *)floorStr family:(NSString *)familyStr event:(NSString *)eventStr event_url:(NSString *)event_urlStr;

/**
 电梯联动

 @return NSString
 */
+(NSString *)appendJoin;
/**
 * 修改保存XML文件
 */
+ (NSString *)xmlString:(NSString *)xmlString locString:(NSString *)locString content:(NSString *)content;

/**
 解析获取工程配置设备配置数据数组

 @param dictionary 工程配置字典
 @param sysXML 工程XML
 @return NSMutableArray
 */
+ (NSMutableArray *)arrayOfXMLArrayFromXMLDict:(NSDictionary *)dictionary sysXML:(NSString *)sysXML;

+ (NSString *)reCallAppendXML;
@end

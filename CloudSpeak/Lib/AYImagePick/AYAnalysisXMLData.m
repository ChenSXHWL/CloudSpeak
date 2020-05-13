//
//  AYAnalysisXMLData.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/13.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "AYAnalysisXMLData.h"
#import "GDataXMLNode.h"

@implementation AYAnalysisXMLData

+ (NSMutableArray *)arrayOfXMLArrayFromXMLDict:(NSDictionary *)dictionary sysXML:(NSString *)sysXML
{
    
    NSMutableArray *leftBarArray = [NSMutableArray array];
    
    NSMutableArray *leftBarTitleArray = [NSMutableArray array];
    
    NSMutableArray *leftBarContentArray = [NSMutableArray array];
    
    for (NSString *key in dictionary) {
        
        if ([key isEqualToString:@"msg"] || [key isEqualToString:@"isSuccess"] || [key isEqualToString:@"leftbar"]) {
            
            if ([key isEqualToString:@"leftbar"]) {
                
                NSDictionary *dict = [self analysisXMLWithSetConfig:[dictionary objectForKey:key]];
                //排序
                NSArray *keys = [dict allKeys];
                
                NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                    
                    return [obj1 compare:obj2 options:NSNumericSearch];
                }];
                
                for (NSString *categoryId in sortedArray) {
                    
                    NSDictionary *leftBarTitleDict = [dict objectForKey:categoryId];
                    
                    [leftBarTitleArray addObject:leftBarTitleDict];
                    
                }
                
                leftBarArray = [self analysisData:leftBarTitleArray];
                
                leftBarContentArray = [self analysisDataContent:leftBarTitleArray totalDictionary:dictionary];
            }
            
        }
        
    }
    
    
    NSMutableArray *mainArray = [NSMutableArray array];
    
    NSMutableArray *titles = [NSMutableArray array];
    
    NSMutableArray *values = [NSMutableArray array];
    
    for (NSString *xmlString in leftBarContentArray) {
        
        NSMutableArray *subArray = [NSMutableArray array];
        
        NSDictionary *dict = [self analysisXMLWithSetConfig:xmlString];
        
        if (dict) {
            
            NSArray *keys = [dict allKeys];
            
            NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                
                return [obj1 compare:obj2 options:NSNumericSearch];
            }];
            
            for (NSString *categoryId in sortedArray) {
                
                [subArray addObject:[dict objectForKey:categoryId]];
                
            }
            
        }
        
        [titles addObject: [self mainArrayWithLeft:subArray sysXML:sysXML isValue:1]];
        
        [values addObject: [self mainArrayWithLeft:subArray sysXML:sysXML isValue:0]];
        
        [mainArray addObject:subArray];
        
    }
    
    return [NSMutableArray arrayWithArray:@[titles, values, mainArray, leftBarArray]];
    
}

+ (NSMutableArray *)mainArrayWithLeft:(NSMutableArray *)left sysXML:(NSString *)sysXML isValue:(int)isValue
{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *subDict in left) {
        
        NSString *scope = subDict[@"scope"][@"scope"];
        
        if (!scope || [scope isEqualToString:@"app"]) {
            
            NSString *key;
            
            NSString *value;
            
            if (subDict[@"uri"][@"uri"]) {
                
                key = (NSString *)subDict[@"tag"][@"tag"];
                
                if ([key isEqualToString:@"栋号"] || [key isEqualToString:@"单元"] || [key isEqualToString:@"编号"] || [key isEqualToString:@"GID"] || [key isEqualToString:@"楼层"]|| [key isEqualToString:@"房号"]) {
                    
                } else {
                    
                    if (isValue) {
                        
                        [array addObject:key];
                        
                        
                    } else {
                        
                        value = [self xmlString:sysXML locString:(NSString *)subDict[@"uri"][@"uri"]];
                        
                        if (subDict[@"options"]) {
                            
                            for (NSString *keyOptions in subDict) {
                                
                                if ([keyOptions isEqualToString:@"options"]) {
                                    
                                    NSMutableArray *optionsArray = [NSMutableArray array];
                                    
                                    //排序
                                    NSArray *keys = [[subDict objectForKey:keyOptions] allKeys];
                                    
                                    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                                        
                                        return [obj1 compare:obj2 options:NSNumericSearch];
                                    }];
                                    
                                    for (NSString *categoryId in sortedArray) {
                                        
                                        NSString *titleDict = [[subDict objectForKey:keyOptions] objectForKey:categoryId];
                                        
                                        [optionsArray addObject:titleDict];
                                        
                                    }
                                    
                                    NSString *low = optionsArray[0];
                                    
                                    if ([low isEqualToString:@"低"]) {
                                        if ([value isEqualToString:@"60"]) {
                                            value = @"0";
                                        } else if ([value isEqualToString:@"75"]) {
                                            value = @"1";
                                        } else {
                                            value = @"2";
                                        }
                                    }
                                    
                                    
                                    [array addObject:optionsArray[value.intValue]];
                                    
                                    
                                }
                                
                            }
                            
                        } else {
                            
                            [array addObject:value];
                            
                        }
                        
                        
                    }
                    
                    
                }
                
            }
            
            
        } else {
            return nil;
        }
        
    }
    
    return array;
}
//获取标题（leftBar）
+ (NSMutableArray *)analysisData:(NSMutableArray *)leftBarArray
{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *dictionary in leftBarArray) {
        
        NSString *scope = dictionary[@"scope"][@"scope"];
        
        if (!scope || [scope isEqualToString:@"app"]) {
            
            NSString *tag = dictionary[@"tag"][@"tag"];
            
            if (![tag isEqualToString:@"SIP设置"]) {
                
                [array addObject:tag];
                
            }
            
            
        }
        
    }
    
    return array;
    
}

//获取内容排序（leftBar）
+ (NSMutableArray *)analysisDataContent:(NSMutableArray *)leftBarArray totalDictionary:(NSDictionary *)totalDictionary
{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *dictionary in leftBarArray) {
        
        if ([dictionary[@"key"][@"key"] isEqualToString:@"setting_sip"]) {
            
        } else {
            
            
            NSString *scope = dictionary[@"scope"][@"scope"];
            
            if (!scope || [scope isEqualToString:@"app"]) {
                
                [array addObject:[totalDictionary objectForKey:dictionary[@"key"][@"key"]]];
                
            }

            
        }
        
    }
    
    return array;
    
}

+ (NSArray *)analysisSelectLoc:(NSDictionary *)dict
{
    
    NSMutableArray *dhcp = [NSMutableArray array];
    
    for (NSString *key in dict.allKeys) {
        
        if ([key isEqualToString:@"options"]) {
            
            NSDictionary *dictionary = dict[@"options"];
            
            //排序
            NSArray *keys = [dictionary allKeys];
            
            NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                
                return [obj1 compare:obj2 options:NSNumericSearch];
            }];
            
            for (NSString *categoryId in sortedArray) {
                
                [dhcp addObject:[dictionary objectForKey:categoryId]];
                
            }

            
        }
        
    }
    
    return dhcp;
}

+ (NSDictionary *)analysisXMLWithSetConfig:(NSString *)xmlString
{
    //过滤：字条串是否包含有某字符串
    //    if ([xmlString rangeOfString:@"uri"].location == NSNotFound) return nil;
    //
    //    if ([xmlString rangeOfString:@"uris"].location != NSNotFound) return nil;
    
    //开始解析
    GDataXMLDocument *document  = [[GDataXMLDocument alloc] initWithXMLString:xmlString options:0 error:nil];
    
    GDataXMLElement *xmlEle = [document rootElement];
    
    NSArray *array = [xmlEle children];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    for (GDataXMLElement *ele in array) {
        
        NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
        
        if (ele.children.count > 1) {
            
            for (GDataXMLElement *subElement in ele.children) {
                
                NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
                
                if ([subElement.name isEqualToString:@"attrs"] || [subElement.name isEqualToString:@"options"]) {
                    
                    for (GDataXMLElement *element in subElement.children) {
                        
                        [dict2 setObject:element.stringValue forKey:element.name];
                        
                    }
                    
                } else {
                    
                    [dict2 setObject:subElement.stringValue forKey:subElement.name];
                    
                }
                
                
                [dict1 setObject:dict2 forKey:subElement.name];
                
                
            }
            
        } else {
            
            [dict1 setObject:ele.stringValue forKey:ele.name];
            
            
        }
        
        [dict setObject:dict1 forKey:ele.name];
        
    }
    
    return dict;
    
}

+ (NSDictionary *)analysisXMLWithListenVideo:(NSString *)xmlString
{
    
    NSString *string1 = [xmlString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    
    NSString *string2 = [string1 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    
    NSString *string3 = [string2 stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    //
    NSString *string4 = [string3 stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    
    NSString *string5 = [string4 stringByReplacingOccurrencesOfString:@"&#x0A;" withString:@""];
    //开始解析
    GDataXMLDocument *document  = [[GDataXMLDocument alloc] initWithXMLString:string5 options:0 error:nil];
    //取出xml的根节点
    GDataXMLElement *xmlEle = [document rootElement];
    //取出根节点的所有孩子节点
    NSArray *array = [xmlEle children];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    for (int i = 0; i < [array count]; i++) {
        
        GDataXMLElement *ele = [array objectAtIndex:i];
        
        [dict setValue:ele.stringValue forKey:ele.name];
        
    }
    
    return dict;
    
}

+ (NSDictionary *)analysisXMLWithSetConfig11:(NSString *)xmlString
{
    //开始解析
    GDataXMLDocument *document  = [[GDataXMLDocument alloc] initWithXMLString:xmlString options:0 error:nil];
    
    GDataXMLElement *xmlEle = [document rootElement];
    
    NSArray *array = [xmlEle children];
    
    NSMutableArray *strings = [NSMutableArray array];
    
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    
    for (int i = 0; i < [array count]; i++) {
        
        GDataXMLElement *ele = [array objectAtIndex:i];
        
        [strings addObject:ele.name];
        
        NSMutableArray *strings1 = [NSMutableArray array];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        for (GDataXMLElement *subElement in ele.children) {
            
            GDataXMLElement *sub = subElement;
            
            [strings1 addObject:subElement.name];
            
            [dict setObject:sub.stringValue forKey:sub.name];
            
        }
        
        [dict1 setValue:dict forKey:ele.name];
        
        //        [dict1 setObject:dict forKey:ele.name];
        
        
    }
    
    return dict1;
    
}
//拼接XML文件
+ (NSString *)appendLadderXML:(NSString *)elevStr direct:(NSString *)directStr floor:(NSString *)floorStr family:(NSString *)familyStr event:(NSString *)eventStr event_url:(NSString *)event_urlStr
{
    // 创建一个根标签
    
    GDataXMLElement *rootElement = [GDataXMLNode elementWithName:@"params"];
    
    // 创建一个属性
    
    //    GDataXMLElement *attribute = [GDataXMLNode attributeWithName:@"a" stringValue:@"b"];
    
    // 创建一个标签元素
    
    GDataXMLElement *elev = [GDataXMLNode elementWithName:@"elev" stringValue:elevStr];
    GDataXMLElement *direct;
   
    
    GDataXMLElement *floor = [GDataXMLNode elementWithName:@"floor" stringValue:floorStr];
    GDataXMLElement *family = [GDataXMLNode elementWithName:@"family" stringValue:familyStr];
    GDataXMLElement *app = [GDataXMLNode elementWithName:@"app" stringValue:@"elev"];
    GDataXMLElement *event = [GDataXMLNode elementWithName:@"event" stringValue:eventStr];
    
    GDataXMLElement *event_url = [GDataXMLNode elementWithName:@"event_url" stringValue:event_urlStr];
    
    // 把标签与属性添加到根标签中
    
    if (directStr) {
        direct = [GDataXMLNode elementWithName:@"direct" stringValue:directStr];
        [rootElement addChild:direct];
    }
        
    [rootElement addChild:elev];
    
    
    [rootElement addChild:floor];
    
    [rootElement addChild:family];
    
    [rootElement addChild:app];
    
    [rootElement addChild:event];
    
    
    [rootElement addChild:event_url];
    
    
    // 生成xml文件内容
    
    GDataXMLDocument *xmlDoc = [[GDataXMLDocument alloc] initWithRootElement:rootElement];
    
    NSData *data1 = [xmlDoc XMLData];
    
    NSString *xmlString = [[NSString alloc] initWithData:data1 encoding:NSWindowsCP1253StringEncoding];
    
    return xmlString;
}

+(NSString *)appendJoin{
    GDataXMLElement *rootElement = [GDataXMLNode elementWithName:@"params"];
    GDataXMLElement *event_url = [GDataXMLNode elementWithName:@"event_url" stringValue:@"/elev/join"];
    
    [rootElement addChild:event_url];
    GDataXMLDocument *xmlDoc = [[GDataXMLDocument alloc] initWithRootElement:rootElement];
    
    NSData *data1 = [xmlDoc XMLData];
    
    NSString *xmlString = [[NSString alloc] initWithData:data1 encoding:NSWindowsCP1253StringEncoding];
    
    return xmlString;

}
//拼接XML文件联动开锁/拼接XML文件联动开锁
+ (NSString *)appendXML:(NSString *)buildStr unit:(NSString *)unitStr room:(NSString *)floorStr family:(NSString *)familyStr
{
    // 创建一个根标签
    
    GDataXMLElement *rootElement = [GDataXMLNode elementWithName:@"params"];
    
    // 创建一个属性
    
    //    GDataXMLElement *attribute = [GDataXMLNode attributeWithName:@"a" stringValue:@"b"];
    
    // 创建一个标签元素
    
    GDataXMLElement *app = [GDataXMLNode elementWithName:@"app" stringValue:@"talk"];
    GDataXMLElement *event = [GDataXMLNode elementWithName:@"event" stringValue:@"unlock"];
    GDataXMLElement *event_rul = [GDataXMLNode elementWithName:@"event_url" stringValue:@"/talk/unlock"];
    GDataXMLElement *sip_Id = [GDataXMLNode elementWithName:@"sip_id" stringValue:[LoginEntity shareManager].sipAccount];
    
    NSNumber *a = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"householdId"];
    GDataXMLElement *house_Id = [GDataXMLNode elementWithName:@"house_id" stringValue:a.description];
    GDataXMLElement *timestamp = [GDataXMLNode elementWithName:@"timestamp" stringValue:@""];
    
    [rootElement addChild:app];
    
    [rootElement addChild:event];
    
    [rootElement addChild:event_rul];
    
    [rootElement addChild:timestamp];
    
    [rootElement addChild:sip_Id];
    
    [rootElement addChild:house_Id];
    if (buildStr.length>0) {
        GDataXMLElement *build = [GDataXMLNode elementWithName:@"room_list" stringValue:buildStr];
        [rootElement addChild:build];
    }
    //    if (buildStr.length>0) {
    //        GDataXMLElement *build = [GDataXMLNode elementWithName:@"build" stringValue:buildStr];
    //        [rootElement addChild:build];
    //    }
    //    if (unitStr.length>0) {
    //        GDataXMLElement *unit = [GDataXMLNode elementWithName:@"unit" stringValue:unitStr];
    //        [rootElement addChild:unit];
    //    }
    //    if (floorStr.length>0) {
    //        GDataXMLElement *floor = [GDataXMLNode elementWithName:@"floor" stringValue:floorStr];
    //        [rootElement addChild:floor];
    //    }
    //    if (familyStr.length>0) {
    //        GDataXMLElement *family = [GDataXMLNode elementWithName:@"family" stringValue:familyStr];
    //        [rootElement addChild:family];
    //    }
    //
    // 把标签与属性添加到根标签中
    
    //    [rootElement addAttribute:attribute];
    
    
    
    // 生成xml文件内容
    
    GDataXMLDocument *xmlDoc = [[GDataXMLDocument alloc] initWithRootElement:rootElement];
    
    NSData *data1 = [xmlDoc XMLData];
    
    NSString *xmlString = [[NSString alloc] initWithData:data1 encoding:NSWindowsCP1253StringEncoding];
    
    return xmlString;
}

//拼接XML文件
+ (NSString *)appendXML
{
    // 创建一个根标签
    
    GDataXMLElement *rootElement = [GDataXMLNode elementWithName:@"params"];
    
    // 创建一个属性
    
    //    GDataXMLElement *attribute = [GDataXMLNode attributeWithName:@"a" stringValue:@"b"];
    
    // 创建一个标签元素
    
    GDataXMLElement *app = [GDataXMLNode elementWithName:@"app" stringValue:@"talk"];
    GDataXMLElement *event = [GDataXMLNode elementWithName:@"event" stringValue:@"unlock"];
    GDataXMLElement *event_rul = [GDataXMLNode elementWithName:@"event_url" stringValue:@"/talk/unlock"];
    GDataXMLElement *sip_Id = [GDataXMLNode elementWithName:@"sip_id" stringValue:[LoginEntity shareManager].sipAccount];
    NSNumber *a = [LoginEntity shareManager].communityList[[LoginEntity shareManager].page.intValue][@"householdId"];

    GDataXMLElement *house_Id = [GDataXMLNode elementWithName:@"house_id" stringValue:a.description];
    GDataXMLElement *timestamp = [GDataXMLNode elementWithName:@"timestamp" stringValue:@""];

    //    GDataXMLElement *host = [GDataXMLNode elementWithName:@"host" stringValue:@"1019900"];
    //    GDataXMLElement *floor = [GDataXMLNode elementWithName:@"floor" stringValue:@"1"];
    //    GDataXMLElement *family = [GDataXMLNode elementWithName:@"family" stringValue:@"1"];
    
    // 把标签与属性添加到根标签中
    
    //    [rootElement addAttribute:attribute];
    
    [rootElement addChild:app];
    
    [rootElement addChild:event];
    
    [rootElement addChild:event_rul];
    
    [rootElement addChild:timestamp];
    
    [rootElement addChild:sip_Id];
    
    [rootElement addChild:house_Id];
    
    //    [rootElement addChild:host];
    //
    //    [rootElement addChild:floor];
    //
    //    [rootElement addChild:family];
    
    // 生成xml文件内容
    
    GDataXMLDocument *xmlDoc = [[GDataXMLDocument alloc] initWithRootElement:rootElement];
    
    NSData *data1 = [xmlDoc XMLData];
    
    NSString *xmlString = [[NSString alloc] initWithData:data1 encoding:NSWindowsCP1253StringEncoding];
    
    return xmlString;
}

////修改保存XML文件
//+ (NSString *)xmlString:(NSString *)xmlString locString:(NSString *)locString content:(NSString *)content
//{
//    
//    if (!locString) return xmlString;
//    
//    GDataXMLDocument *document  = [[GDataXMLDocument alloc] initWithXMLString:xmlString options:0 error:nil];
//    
//    NSArray *locEles = [locString componentsSeparatedByString:@"/"];
//    
//    NSString *locElesString = [NSString stringWithFormat:@"%@/%@", locEles[1], locEles[2]];
//    
//    NSArray *array = [document nodesForXPath:locElesString error:nil];
//    
//    NSString *xml;
//    
//    for (GDataXMLElement *element in array) {
//        
//        xml = [xmlString stringByReplacingOccurrencesOfString:element.XMLString withString:[NSString stringWithFormat:@"<%@>%@</%@>", element.name, content, element.name]];
//        
//    }
//    
//    return xml;
//}

+ (NSString *)xmlString:(NSString *)xmlString locString:(NSString *)locString
{
    
    GDataXMLDocument *document  = [[GDataXMLDocument alloc] initWithXMLString:xmlString options:0 error:nil];
    
    NSArray *array = [document nodesForXPath:locString error:nil];
    
    if (array.count == 0) {
        
        return @"";
        
    } else {
        
        GDataXMLElement *element = array[0];
        
        if ([element.name isEqualToString:@"passwd"]) {
            
            EZLog(@"%@",element.stringValue);
            
        }
        
        return element.stringValue;
        
    }
}

//修改保存XML文件
+ (NSString *)xmlString:(NSString *)xmlString locString:(NSString *)locString content:(NSString *)content
{
    
    if (!locString) return xmlString;
    
    NSArray *eleString= [locString componentsSeparatedByString:@"/"];
    
    GDataXMLDocument *document  = [[GDataXMLDocument alloc] initWithXMLString:xmlString options:0 error:nil];
    
    GDataXMLElement *xmlEle = [document rootElement];
    //根
    GDataXMLElement *rootElement = [GDataXMLNode elementWithName:@"sys"];
    //属性
    
    //标签
    
    for (GDataXMLElement *element in xmlEle.children) {
        
        GDataXMLElement *attributeElement;
        
        if (![[element.children[0] name] isEqualToString:@"text"]) {
            
            attributeElement = [GDataXMLNode elementWithName:element.name];
            
            for (GDataXMLElement *ele in element.children) {
                
                GDataXMLElement *tableElement;
                
                if ([element.name isEqualToString:eleString[eleString.count - 2]] && [ele.name isEqualToString:eleString[eleString.count - 1]]) {
                    
                    tableElement = [GDataXMLNode elementWithName:ele.name stringValue:content];
                    
                }else if ([element.name isEqualToString:eleString[eleString.count - 3]] && [ele.name isEqualToString:eleString[eleString.count - 2]]) {
                    GDataXMLElement *tableElementS;

                    for (GDataXMLElement *eles in ele.children) {
                        if ([eles.name isEqualToString:eleString[eleString.count - 1]]){
                            tableElementS = [GDataXMLNode elementWithName:eles.name stringValue:content];
                        }else{
                            tableElementS = eles;
                        }
                        [tableElement addChild:tableElementS];
                    }
                }else {
                    if (![[ele.children[0] name] isEqualToString:@"text"]&&[ele.children[0] name]!=nil) {
                        
                        tableElement = ele;

                    }else{
                        
                        tableElement = [GDataXMLNode elementWithName:ele.name stringValue:ele.stringValue];
                    }
                }
                
                [attributeElement addChild:tableElement];
                
            }
            
        } else {
            
            if ([element.name isEqualToString:eleString[eleString.count - 1]]) {
                
                attributeElement = [GDataXMLNode elementWithName:element.name stringValue:content];
                
            } else {
                
                attributeElement = [GDataXMLNode elementWithName:element.name stringValue:element.stringValue];
                
            }
            
        }

        [rootElement addChild:attributeElement];
        
    }
    
    // 生成xml文件内容
    
    GDataXMLDocument *xmlDoc = [[GDataXMLDocument alloc] initWithRootElement:rootElement];
    
    NSData *data1 = [xmlDoc XMLData];
    
    return [[NSString alloc] initWithData:data1 encoding:NSWindowsCP1253StringEncoding];
}
//拼接XML文件
+ (NSString *)reCallAppendXML
{
    // 创建一个根标签
    
    GDataXMLElement *rootElement = [GDataXMLNode elementWithName:@"params"];
    
    // 创建一个属性
    
    //    GDataXMLElement *attribute = [GDataXMLNode attributeWithName:@"a" stringValue:@"b"];
    
    // 创建一个标签元素
    
    GDataXMLElement *app = [GDataXMLNode elementWithName:@"app" stringValue:@"talk"];
    GDataXMLElement *event = [GDataXMLNode elementWithName:@"event" stringValue:@"redial"];
    GDataXMLElement *event_rul = [GDataXMLNode elementWithName:@"event_url" stringValue:@"/talk/redial"];
    GDataXMLElement *sip_Id = [GDataXMLNode elementWithName:@"sip_id" stringValue:[LoginEntity shareManager].sipAccount];
    
    //    GDataXMLElement *host = [GDataXMLNode elementWithName:@"host" stringValue:@"1019900"];
    //    GDataXMLElement *floor = [GDataXMLNode elementWithName:@"floor" stringValue:@"1"];
    //    GDataXMLElement *family = [GDataXMLNode elementWithName:@"family" stringValue:@"1"];
    
    // 把标签与属性添加到根标签中
    
    //    [rootElement addAttribute:attribute];
    
    [rootElement addChild:app];
    
    [rootElement addChild:event];
    
    [rootElement addChild:event_rul];
    
    [rootElement addChild:sip_Id];
    
    //    [rootElement addChild:host];
    //
    //    [rootElement addChild:floor];
    //
    //    [rootElement addChild:family];
    
    // 生成xml文件内容
    
    GDataXMLDocument *xmlDoc = [[GDataXMLDocument alloc] initWithRootElement:rootElement];
    
    NSData *data1 = [xmlDoc XMLData];
    
    NSString *xmlString = [[NSString alloc] initWithData:data1 encoding:NSWindowsCP1253StringEncoding];
    
    return xmlString;
}

@end

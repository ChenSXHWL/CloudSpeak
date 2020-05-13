//
//  AYSnapShot.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/17.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "AYSnapShot.h"

@implementation AYSnapShot

+ (NSString *)getPhotoPath
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *imagePathToFile = [NSString stringWithFormat:@"%@/%@", pathDocuments,@"Image/"];
    
    // 判断文件夹是否存在，如果不存在，则创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:imagePathToFile]) {
        
        [fileManager createDirectoryAtPath:imagePathToFile withIntermediateDirectories:YES attributes:nil error:nil];
        
    } else {
        EZLog(@"FileDir is exists.");
    }
    
    //图片名及路径
    NSString *imageName=[NSString stringWithFormat:@"image%f",[[NSDate date] timeIntervalSince1970]];
    NSString* theImagePath = [imagePathToFile stringByAppendingPathComponent:imageName];
    
    return theImagePath;
}

+ (void)savePhone
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *imagePathToFile = [NSString stringWithFormat:@"%@/%@", pathDocuments,[@"Image/" stringByAppendingString:@""]];
    
    NSArray *files = [fileManager subpathsAtPath:imagePathToFile];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *string in files) {
        [array addObject:[imagePathToFile stringByAppendingPathComponent:string]];
    }
}

@end

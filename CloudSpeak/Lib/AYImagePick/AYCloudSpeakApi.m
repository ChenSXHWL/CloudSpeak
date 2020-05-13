//
//  AYCloudSpeakApi.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/28.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "AYCloudSpeakApi.h"

@implementation AYCloudSpeakApi

+ (AYCloudSpeakApi *)cloudSpeakApi
{
    static AYCloudSpeakApi *updSocket = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        updSocket = [[self alloc] init];
    });
    return updSocket;
}
- (AYCloudSpeakApi *)init
{
    self = [super init];
    
    if (self) {
        
        self.isExit = YES;
        
    }
    
    return self;
}

- (void)initCloudSpeak
{
    Cm_Init();
    
    self.isExit = YES;
}

- (void)exitCloudSpeak
{
    Cm_Exit();
    
    self.isExit = NO;
    
}

- (void)unRegisterUser
{
    Cm_UnRegisterUser();
}

- (void)setSipConfigWithSipServer:(NSString *)sipServer sipAccout:(NSString *)sipAccout sipPassword:(NSString *)sipPassword
{
    Cm_SetSipCfg([sipServer UTF8String], [sipAccout UTF8String], [sipPassword UTF8String]);
}

- (void)setNetWorkDataWithLocalDeviceIpAddress:(NSString *)localDeviceIpAddress netmaskAddress:(NSString *)netmaskAddress currentNetType:(NSString *)currentNetType
{
    Cm_SetNetWData([localDeviceIpAddress UTF8String],[netmaskAddress UTF8String],[currentNetType UTF8String]);
}

- (void)outGoingCallWithCallId:(NSString *)callId
{
    
    Cm_OutgoingCall([callId UTF8String], NETWORK_TYPE_QUERY);
}

- (void)openView:(UIView *)view
{
    Cm_OpenVideo((unsigned long)view);
}

- (void)openMic:(int)isOpen
{
    Cm_SetAppMicMute([[NSString stringWithFormat:@"%d", isOpen] UTF8String]);
}

- (void)openSpe:(int)isOpen
{
    Cm_SetAppSpkMute([[NSString stringWithFormat:@"%d", isOpen] UTF8String]);
}

- (void)callStop
{
    Cm_CallStop();
}

- (void)instantMsgSendWithCallId:(NSString *)callId unLockXML:(NSString *)unLockXML
{
    Cm_InstantMsgSend([callId UTF8String], NETWORK_TYPE_QUERY, [unLockXML UTF8String]);
}

- (void)unLock
{
    
    Cm_Unlock();
}

- (void)respondDev
{
    Cm_CallWaitingAccept();
}

- (void)videoSnapshot
{
    Cm_videoSnapshot([[AYCloudSpeakApi getPhotoPath] UTF8String]);
    
    [AYCloudSpeakApi savePhone];
    
    [AYProgressHud progressHudShowShortTimeMessage:[NSString stringWithFormat:@"拍照成功，地址：%@", [AYCloudSpeakApi getPhotoPath]]];
}

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

- (NSArray *)getLocalImages
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *imagePathToFile = [NSString stringWithFormat:@"%@/%@", pathDocuments,[@"Image/" stringByAppendingString:@""]];
    
    NSArray *files = [fileManager subpathsAtPath:imagePathToFile];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *string in files) {
        [array addObject:[imagePathToFile stringByAppendingPathComponent:string]];
    }
    
    return array;
}

@end

//
//  AYQiniuCloudUploadmage.m
//  ishanghome
//
//  Created by DNAKE_AY on 16/12/15.
//  Copyright © 2016年 DNAKE_AY. All rights reserved.
//

#import "AYQiniuCloudUploadmage.h"
#import "UploadImageRequest.h"
#import <QiniuSDK.h>

@interface AYQiniuCloudUploadmage ()

@property (strong, nonatomic) UploadImageRequest *uploadImageRequest;

@end

@implementation AYQiniuCloudUploadmage

- (instancetype)initWithData:(NSData *)imageData
{
    self = [super init];
    
    if (self) {
        
        self.uploadImageRequest = [UploadImageRequest Request];
        [[Action Action] Send:self.uploadImageRequest];
        
        [[RACObserve(self.uploadImageRequest, state) filter:^BOOL(id value) {
            return value == RequestStateSuccess;
        }] subscribeNext:^(id x) {
            
            NSString *imageToken = self.uploadImageRequest.output[@"upToken"];
            NSString *domain = self.uploadImageRequest.output[@"domain"];
            
            QNUploadManager *upManager = [[QNUploadManager alloc] init];
            
            [upManager putData:imageData key:nil token:imageToken
                      complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                          NSString *imageUrl = [NSString stringWithFormat:@"%@%@",domain,resp[@"key"]];
                          
                          if ([_uploadImageDelegate respondsToSelector:@selector(qiniuCloudUploadmage:urlString:image:domain:)]) {
                              [_uploadImageDelegate qiniuCloudUploadmage:self urlString:imageUrl image:resp[@"key"] domain: domain];
                          }
                          
                      } option:nil];
            
        }];
        
        
    }
    return self;
}

@end

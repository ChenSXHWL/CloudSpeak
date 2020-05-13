//
//  AYQiniuCloudUploadmage.h
//  ishanghome
//
//  Created by DNAKE_AY on 16/12/15.
//  Copyright © 2016年 DNAKE_AY. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AYQiniuCloudUploadmage;

@protocol AYQiniuCloudUploadmageDelegate <NSObject>

- (void)qiniuCloudUploadmage:(AYQiniuCloudUploadmage *)qiniuCloudUploadmage urlString:(NSString *)urlString image:(NSString *)image domain:(NSString *)domain;

@end

@interface AYQiniuCloudUploadmage : NSObject

- (instancetype)initWithData:(NSData *)imageData;

@property (weak, nonatomic) id <AYQiniuCloudUploadmageDelegate> uploadImageDelegate;

@end

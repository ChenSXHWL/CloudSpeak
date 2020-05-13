//
//  EditorDevGroupRequest.h
//  CloudSpeak
//
//  Created by mac on 2018/9/19.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface EditorDevGroupRequest : RequestConfig

@property (strong, nonatomic)NSString * deviceGroupIds;
@property (strong, nonatomic)NSString * deviceId;
@end

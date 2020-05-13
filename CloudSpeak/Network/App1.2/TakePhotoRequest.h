//
//  TakePhotoRequest.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2018/2/10.
//  Copyright © 2018年 DNAKE_AY. All rights reserved.
//

#import "RequestConfig.h"

@interface TakePhotoRequest : RequestConfig

@property (strong, nonatomic)NSString *householdId;


@property (strong, nonatomic)NSString *deviceSip;

@end

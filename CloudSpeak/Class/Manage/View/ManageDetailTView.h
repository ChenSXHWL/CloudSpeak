//
//  ManageDetailTView.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/29.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "AYCustomTView.h"
@class GetConfigEntity;

typedef void(^ManageDetailTViewConfigBlock)(GetConfigEntity *, NSString *, NSDictionary *);

typedef void(^ManageDetailTViewPopBlock)(void);

typedef void(^ManageDetailTViewDevIdPushBlock)(NSString *);

typedef void(^ManageDetailTViewShowTest)(NSString *, NSString *);

@interface ManageDetailTView : AYCustomTView

@property (copy, nonatomic) NSString *deviceNum;

@property (copy, nonatomic) NSString *deviceName;

@property (copy, nonatomic) NSString *deviceId;

@property (copy, nonatomic) NSString *sipAccount;

@property (strong, nonatomic) ManageDetailTViewConfigBlock configBlock;

@property (strong, nonatomic) ManageDetailTViewPopBlock popBlock;

@property (strong, nonatomic) ManageDetailTViewShowTest test;

@property (strong, nonatomic) ManageDetailTViewDevIdPushBlock pushDevIdBlock;


@property (copy, nonatomic) NSString *timestamp;

- (void)getSysXML:(NSString *)sysXML isSelectMode:(BOOL)mode;

@end

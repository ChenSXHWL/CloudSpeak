//
//  AnnouncementDetailVC.h
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/16.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "BaseViewController.h"
#import "PropertyNnoticeListEntity.h"

typedef void(^AnnouncementDetailVCBlock)(NSString *);

@interface AnnouncementDetailVC : BaseViewController

@property (strong, nonatomic)PropertyNnoticeListEntity *propertyNnoticeListEntity;

@property (strong, nonatomic) AnnouncementDetailVCBlock announcementDetailVCBlock;

@end

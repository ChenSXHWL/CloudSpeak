//
//  GDMapView.h
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/4/26.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GDMapViewBlock)(NSString *, NSString *);

@interface GDMapView : UIView

@property (strong, nonatomic) GDMapViewBlock mapViewBlock;

@end

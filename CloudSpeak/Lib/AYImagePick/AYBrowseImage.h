//
//  AYBrowseImage.h
//  ishanghome
//
//  Created by DNAKE_AY on 17/1/17.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AYBrowseImage : NSObject

+ (void)browseNetworkImageWithImages:(NSMutableArray *)images currentIndex:(int)index;

+ (void)browseLocalImageWithImages:(NSMutableArray *)images currentIndex:(int)index;

@end

//
//  AYBrowseImage.m
//  ishanghome
//
//  Created by DNAKE_AY on 17/1/17.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "AYBrowseImage.h"
#import "MSSBrowseDefine.h"

@implementation AYBrowseImage

+ (void)browseNetworkImageWithImages:(NSMutableArray *)images currentIndex:(int)index
{
    // 加载网络图片
    NSMutableArray *browseItemArray = [[NSMutableArray alloc]init];
    int i = 0;
    for(i = 0;i < images.count;i++)
    {
        
        MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
        // browseItem.bigImageLocalPath 建议传本地图片的路径来减少内存使用
        browseItem.bigImageUrl = images[i];// 大图赋值
        
        [browseItemArray addObject:browseItem];
    }
    
    MSSBrowseNetworkViewController *bvc = [[MSSBrowseNetworkViewController alloc]initWithBrowseItemArray:browseItemArray currentIndex:index];
    
    
    [bvc showBrowseViewController];
}

+ (void)browseLocalImageWithImages:(NSMutableArray *)images currentIndex:(int)index
{
    // 加载本地图片
    NSMutableArray *browseItemArray = [[NSMutableArray alloc]init];
    int i = 0;
    for(i = 0;i < images.count - 1;i++)
    {
        UIImage *image = images[i];
        
        MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
        // browseItem.bigImageLocalPath 建议传本地图片的路径来减少内存使用
        browseItem.bigImage = image;// 大图赋值
        [browseItemArray addObject:browseItem];
    }
    MSSBrowseLocalViewController *bvc = [[MSSBrowseLocalViewController alloc]initWithBrowseItemArray:browseItemArray currentIndex:index];
    [bvc showBrowseViewController];
}

@end

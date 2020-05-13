//
//  PhoneCollectionView.h
//  AYPhoto
//
//  Created by FLY_AY on 16/1/28.
//  Copyright © 2016年 FLY_AY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AYPhotoCollectionView;

@protocol AYPhotoCollectionViewDelegate <NSObject>

@optional
/**
 *  AYPhotoCollectionView的代理方法 （点击加号添加照片）
 *
 *  @param navigationController pickerViewController
 */
- (void)photoCollectionView:(AYPhotoCollectionView *)phoneCollectionView didSelectPlusAtLastItem:(UINavigationController *)navigationController;
/**
 *  dismissVC
 */
- (void)photoCollectionViewWithDismissVC:(AYPhotoCollectionView *)phoneCollectionView;
/**
 *  将选定后将照片传出去
 *
 *  @param photos              照片数组
 */
- (void)photoCollectionView:(AYPhotoCollectionView *)phoneCollectionView arrayWithPhotos:(NSMutableArray *)photos width:(CGFloat)width height:(CGFloat)height;

@end

@interface AYPhotoCollectionView : UICollectionView
//代理属性
@property (weak, nonatomic) id <AYPhotoCollectionViewDelegate> photoDelegate;
//创建对象
+ (instancetype)photoWithCollectionView;

@end

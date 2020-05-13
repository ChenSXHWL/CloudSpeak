//  添加多张图片上传至腾讯云
//  ImageCell.h
//  所需要用到的类：（UIActivityIndicator-for-SDWebImage，SDWebImage：加载处理网络图片，MJPhotoBrowser-master：图片浏览，ZYQAssetPickerController：相册控制器，UIAlertController+Blocks：封装的ActionSheet）
//
//  Created by FLY_AY on 16/1/28.
//  Copyright © 2016年 FLY_AY. All rights reserved
//

#import <UIKit/UIKit.h>

@class AYPhotoCollectionViewCell;

@protocol AYPhotoCollectionViewCellDelegate <NSObject>
/**
 *  删除图片的代理方法
 *
 *  @param deletedBtn 删除图片的按钮
 */
- (void)photoCollectionCell:(AYPhotoCollectionViewCell *)photoCollectionViewCell deletedBtn:(UIButton *)deletedBtn;
/**
 *
 *  @param navigationController 将控制器传出去
 */
- (void)photoCollectionCell:(AYPhotoCollectionViewCell *)photoCollectionViewCell presentNavigationController:(UINavigationController *)navigationController;
/**
 *  dismiss
 */
- (void)photoCollectionCellDidDismissVC:(AYPhotoCollectionViewCell *)photoCollectionViewCell;
/**
 *  将图片传递出去
 */
- (void)photoCollectionCell:(AYPhotoCollectionViewCell *)photoCollectionViewCell photos:(NSMutableArray *)photos urls:(NSArray *)urls;

@end

@interface AYPhotoCollectionViewCell : UICollectionViewCell
/**
 *  本地图片路径
 */
@property (strong, nonatomic) id image;
/**
 *  网络图片集
 */
@property (strong, nonatomic) NSString *networkImageUrls;
/**
 *  删除图片的代理
 */
@property (weak, nonatomic) id <AYPhotoCollectionViewCellDelegate> photoCellDelegate;

/**
 *  创建imageCell对象
 *
 *  @return imageCell
 */
+ (instancetype)photoCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;
/**
 *  点击collectionViewCell触发事件
 */
- (void)showCameraOrPhotoToSelectWithImageArray:(NSMutableArray *)imageArray networkImageUrls:(NSMutableArray *)urls;

@end

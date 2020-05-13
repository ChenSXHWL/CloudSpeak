//
//  PhoneCollectionView.m
//  AYPhoto
//
//  Created by FLY_AY on 16/1/28.
//  Copyright © 2016年 FLY_AY. All rights reserved.
//

#import "AYPhotoCollectionView.h"
#import "AYPhotoCollectionViewCell.h"

@interface AYPhotoCollectionView ()<UICollectionViewDataSource, UICollectionViewDelegate, AYPhotoCollectionViewCellDelegate>

//图片张数UIImage
@property (strong, nonatomic) NSMutableArray *imageArray;

@property (strong, nonatomic) NSMutableArray *urls;

@end

@implementation AYPhotoCollectionView

/**
 *  创建AYPhotoCollectionView对象
 */
+ (instancetype)photoWithCollectionView
{
    UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [[self alloc]initWithFrame:CGRectNull collectionViewLayout:layout];;
}

/**
 *  初始化实例方法
 */
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewFlowLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    if (self) {
        
        //UICollectionView的数据源代理方法
        self.dataSource = self;
        
        self.delegate = self;
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.scrollEnabled = YES;
        
        self.imageArray = [NSMutableArray arrayWithArray:@[@"post_photo"]];
        
        self.urls = [NSMutableArray array];
        
    }
    
    return self;
}

/**
 *  imageArray的Set方法
 */
- (void)setImageArray:(NSMutableArray *)imageArray
{
    _imageArray = imageArray;
    
    [self reloadData];
}

#pragma mark  UICollectionViewDataSource（数据元代理）

-(NSInteger)numberOfSectionsInCollectionView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.imageArray.count > 3) {
        
        return 3;
        
    }
    
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AYPhotoCollectionViewCell *cell = [AYPhotoCollectionViewCell photoCollectionView:collectionView indexPath:indexPath];
    
    cell.image = self.imageArray[indexPath.row];
    
    //删除图片的代理
    cell.photoCellDelegate = self;
    
    return cell;
}

#pragma mark UICollectionViewDelegate代理方法

/**
 * 浏览图片
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    AYPhotoCollectionViewCell *cell = (AYPhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [cell showCameraOrPhotoToSelectWithImageArray:self.imageArray networkImageUrls:self.urls];
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width / 3.4, [UIScreen mainScreen].bounds.size.width / 3.4);
}

#pragma mark AYPhotoCollectionViewCellDelegate

/**
 *  移除图片的代理方法
 *
 *  @param deletedBtn 移除图片的按钮❌
 */
- (void)photoCollectionCell:(AYPhotoCollectionViewCell *)photoCollectionViewCell deletedBtn:(UIButton *)deletedBtn
{
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.imageArray];
    [array removeObjectAtIndex:deletedBtn.tag];
    self.imageArray = array;
    
    UIImage *images;
    
    for (int i = 0; i < array.count; i ++) {
        if (i == 0) {
            images = array[0];
        }
    }
    
    NSMutableArray *array1 = [NSMutableArray arrayWithArray:self.urls];
    [array1 removeObjectAtIndex:deletedBtn.tag];
    self.urls = array1;
    
    if ([_photoDelegate respondsToSelector:@selector(photoCollectionView:arrayWithPhotos:width:height:)]) {
        [_photoDelegate photoCollectionView:self arrayWithPhotos:self.urls width:array.count == 1 ? 0 : images.size.width height:array.count == 1 ? 0 : images.size.height];
    }
}

- (void)photoCollectionCell:(AYPhotoCollectionViewCell *)photoCollectionViewCell photos:(NSMutableArray *)photos urls:(NSMutableArray *)urls
{
    UIImage *images;
    
    for (int i = 0; i < photos.count; i ++) {
        if (i == 0) {
            images = photos[0];
        }
    }
    
    self.imageArray = photos;
    
    self.urls = urls;
    
    if ([_photoDelegate respondsToSelector:@selector(photoCollectionView:arrayWithPhotos:width:height:)]) {
        [_photoDelegate photoCollectionView:self arrayWithPhotos:urls width:images.size.width height:images.size.height];
    }
}

- (void)photoCollectionCell:(AYPhotoCollectionViewCell *)photoCollectionViewCell presentNavigationController:(UINavigationController *)navigationController
{
    EZLog(@"%@",navigationController);
    if ([_photoDelegate respondsToSelector:@selector(photoCollectionView:didSelectPlusAtLastItem:)]) {
        [_photoDelegate photoCollectionView:self didSelectPlusAtLastItem:navigationController];
    }
}

- (void)photoCollectionCellDidDismissVC:(AYPhotoCollectionViewCell *)photoCollectionViewCell
{
    if ([_photoDelegate respondsToSelector:@selector(photoCollectionViewWithDismissVC:)]) {
        [_photoDelegate photoCollectionViewWithDismissVC:self];
    }
}

@end

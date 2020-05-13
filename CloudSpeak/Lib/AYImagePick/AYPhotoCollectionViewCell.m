//
//  ImageCell.m
//  AYPhoto
//
//  Created by FLY_AY on 16/1/28.
//  Copyright © 2016年 FLY_AY. All rights reserved
//

#import "AYPhotoCollectionViewCell.h"
#import "ALActionSheetView.h"
#import "AYQiniuCloudUploadmage.h"

#import "MSSBrowseDefine.h"

#define DELETE_FRAME 20

@interface AYPhotoCollectionViewCell ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate, AYQiniuCloudUploadmageDelegate>
//图片
@property (strong, nonatomic) UIImageView *phoneImage;
//装图片的数组UIImage
@property (strong, nonatomic) NSMutableArray *imageArray;
//装图片urls
@property (strong, nonatomic) NSMutableArray *urls;
//删除按钮
@property (strong, nonatomic) UIButton *deleteBtn;

@property (nonatomic, strong) ALActionSheetView *sheet;

@property (strong, nonatomic) NSIndexPath *indexPath;

@end

@implementation AYPhotoCollectionViewCell

+ (instancetype)photoCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"AYPhotoCollectionViewCell";
    
    [collectionView registerClass:[AYPhotoCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    
    AYPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.deleteBtn.tag = indexPath.row;
    
    cell.phoneImage.tag = 500 + indexPath.row;
    
    cell.indexPath = indexPath;
    
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupUI];
        
    }
    
    return self;
    
}

- (void)setupUI
{

    self.phoneImage = [UIImageView new];
    self.phoneImage.contentMode = UIViewContentModeScaleAspectFill;
    self.phoneImage.clipsToBounds = YES;
    [self addSubview:self.phoneImage];
    
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.deleteBtn setBackgroundImage:[UIImage imageNamed:@"release_delete"] forState:UIControlStateNormal];
    [self.deleteBtn addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.deleteBtn];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.phoneImage.frame = CGRectMake(DELETE_FRAME / 2, DELETE_FRAME / 2, self.frame.size.width - DELETE_FRAME, self.frame.size.height - DELETE_FRAME);
    //删除按钮frame
    self.deleteBtn.frame = CGRectMake(self.frame.size.width - DELETE_FRAME, 0, DELETE_FRAME, DELETE_FRAME);
    
    
    
}

- (void)setImage:(id)image
{
    
    if ([image isKindOfClass:[NSString class]]) {
        
        self.phoneImage.image = [UIImage imageNamed:image];
        
        self.deleteBtn.hidden = YES;
        
    } else {
        
        self.phoneImage.image = image;
        
        self.deleteBtn.hidden = NO;
        
    }
    
    
}

- (void)deleteImage:(UIButton *)deletedBtn
{
    if ([_photoCellDelegate respondsToSelector:@selector(photoCollectionCell:deletedBtn:)]) {
        [_photoCellDelegate photoCollectionCell:self deletedBtn:deletedBtn];
    }
}

- (void)showCameraOrPhotoToSelectWithImageArray:(NSMutableArray *)imageArray networkImageUrls:(NSMutableArray *)urls
{
    
    if (_indexPath.row == imageArray.count -1) {
        
        if (imageArray.count == 4) return NSLog(@"已经达到图片上限3张");
        
        @weakify(self);
        _sheet = [ALActionSheetView showActionSheetWithTitle:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"拍照",@"相册"] handler:^(ALActionSheetView *actionSheetView, NSInteger buttonIndex) {
            @strongify(self);
            
            if (buttonIndex < 0) return ;
            
            UIImagePickerController *picker = [UIImagePickerController new];
            
            picker.delegate = self;
            
            picker.navigationBar.tintColor = RGB(0, 0, 0);
            
            if (buttonIndex == 0) {
                
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                
            } else {
                
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                
            }
            
            if ([_photoCellDelegate respondsToSelector:@selector(photoCollectionCell:presentNavigationController:)]) {
                [_photoCellDelegate photoCollectionCell:self presentNavigationController:picker];
            }
            
        }];
        
        [_sheet show];
        
        
        
    } else {
        
        // 加载本地图片
        NSMutableArray *browseItemArray = [[NSMutableArray alloc]init];
        int i = 0;
        for(i = 0;i < imageArray.count - 1;i++)
        {
            UIImage *image = imageArray[i];
            
            MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
            // browseItem.bigImageLocalPath 建议传本地图片的路径来减少内存使用
            browseItem.bigImage = image;// 大图赋值
            [browseItemArray addObject:browseItem];
        }
        MSSBrowseLocalViewController *bvc = [[MSSBrowseLocalViewController alloc]initWithBrowseItemArray:browseItemArray currentIndex:self.phoneImage.tag - 500];
        [bvc showBrowseViewController];
        
    }
    
    self.imageArray = [NSMutableArray arrayWithArray:imageArray];
    
    self.urls = [NSMutableArray arrayWithArray:urls];
}

/**
 *  拍照回调
 *
 *  @param picker pickerController
 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if ([_photoCellDelegate respondsToSelector:@selector(photoCollectionCellDidDismissVC:)]) {
        [_photoCellDelegate photoCollectionCellDidDismissVC:self];
    }
}

/**
 *  拍照回调
 *
 *  @param picker 拍完照片回调
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        AYQiniuCloudUploadmage *qiniuCloudUploadmage = [[AYQiniuCloudUploadmage alloc] initWithData:UIImageJPEGRepresentation(image, 1)];
        
        qiniuCloudUploadmage.uploadImageDelegate = self;
        
        [self.imageArray insertObject:image atIndex:0];
        
        [MBProgressHUD showHUDAddedTo:self.superview.superview animated:YES];
        
    }];
}

#pragma mark -- AYQiniuCloudUploadmageDelegate
- (void)qiniuCloudUploadmage:(AYQiniuCloudUploadmage *)qiniuCloudUploadmage urlString:(NSString *)urlString image:(NSString *)image domain:(NSString *)domain
{
    [self.urls insertObject:urlString atIndex:0];
    
    if ([self.photoCellDelegate respondsToSelector:@selector(photoCollectionCell:photos:urls:)]) {
        [self.photoCellDelegate photoCollectionCell:self photos:self.imageArray urls:self.urls];
    }
    
    [MBProgressHUD hideHUDForView:self.superview.superview animated:YES];
    
}

@end

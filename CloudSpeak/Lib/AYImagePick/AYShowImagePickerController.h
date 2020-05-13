//  展示相册或拍照并将选中后的图片字符串返回
//  ShowImagePickerController.h
//
//  Created by FLY_AY on 16/2/17.
//  Copyright © 2016年 FLY_AY. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AYShowImagePickerController;

@protocol AYShowImagePickerControllerDelegate <NSObject>

@required

/**
 *  跳转到相册还是拍照界面
 */
- (void)showImagePickerController:(UINavigationController *)navigationController;

- (void)showImagePickerControllerWithDismissCurrentVC:(AYShowImagePickerController *)showImagePickerController;

/**
 *  选中图片或是拍照完成返回图片串
 *
 *  @param imageUrl 图片String
 */
- (void)showImagePickerControllerWithSelectImageUrl:(NSString *)imageUrl;

@end

@interface AYShowImagePickerController : NSObject
/**
 *  代理属性
 */
@property (weak, nonatomic) id <AYShowImagePickerControllerDelegate> showImageDelegate;
/**
 *  展示AlertView（相册or拍照）
 */
- (void)showImagePickerController;

@end

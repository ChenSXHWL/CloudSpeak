//
//  ShowImagePickerController.m
//  Test
//
//  Created by FLY_AY on 16/2/17.
//  Copyright © 2016年 FLY_AY. All rights reserved.
//

#import "AYShowImagePickerController.h"
//仿微信ActionSheet
#import "ALActionSheetView.h"
#import "AYQiniuCloudUploadmage.h"

@interface AYShowImagePickerController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, AYQiniuCloudUploadmageDelegate>

@property (strong, nonatomic) ALActionSheetView *sheet;

@end

@implementation AYShowImagePickerController

- (void)showImagePickerController
{
    [self.sheet show];
}

- (ALActionSheetView *)sheet{
    
    @weakify(self);
    if (!_sheet) {
        _sheet = [ALActionSheetView showActionSheetWithTitle:@"选择图片" cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"拍照",@"从手机相册选择"] handler:^(ALActionSheetView *actionSheetView, NSInteger buttonIndex) {
                @strongify(self);
                
                if (buttonIndex < 0) return ;
                
                UIImagePickerController *picker = [UIImagePickerController new];
                picker.delegate = self;
                if (buttonIndex == 1) {
                    //;
                    picker.navigationBar.tintColor = [UIColor blackColor];
                    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    
                } else {
                    //拍照;
                    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    
                }
            
                if ([_showImageDelegate respondsToSelector:@selector(showImagePickerController:)]) {
                [_showImageDelegate showImagePickerController:picker];
            }
            
            
        }];
    }
    return _sheet;
}

/**
 *  拍照回调
 *
 *  @param picker pickerController
 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if ([_showImageDelegate respondsToSelector:@selector(showImagePickerControllerWithDismissCurrentVC:)]) {
        [_showImageDelegate showImagePickerControllerWithDismissCurrentVC:self];
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
        
        AYQiniuCloudUploadmage *qiniuCloudUploadmage = [[AYQiniuCloudUploadmage alloc] initWithData:UIImageJPEGRepresentation(image, 0.1)];
        
        qiniuCloudUploadmage.uploadImageDelegate = self;
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        
        [hud hide:YES afterDelay:5];
        
    }];
}

#pragma mark -- AYQiniuCloudUploadmageDelegate
- (void)qiniuCloudUploadmage:(AYQiniuCloudUploadmage *)qiniuCloudUploadmage urlString:(NSString *)urlString domain:(NSString *)domain
{
    if ([_showImageDelegate respondsToSelector:@selector(showImagePickerControllerWithSelectImageUrl:)]) {
        
        [_showImageDelegate showImagePickerControllerWithSelectImageUrl:urlString];
    }
    
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    
}

@end

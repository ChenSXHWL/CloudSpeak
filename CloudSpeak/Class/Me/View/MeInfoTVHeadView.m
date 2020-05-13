//
//  MeInfoTVHeadView.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/14.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "MeInfoTVHeadView.h"
#import "ALActionSheetView.h"
#import "AYQiniuCloudUploadmage.h"
#import "AYBrowseImage.h"

@interface MeInfoTVHeadView () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, AYQiniuCloudUploadmageDelegate>

@property (strong, nonatomic) UILabel *headLabel;

@property (strong, nonatomic) UIImageView *indicatorImage;

@property (strong, nonatomic) UIImageView *headImageView;

@property (nonatomic, strong) ALActionSheetView *sheet;

@property (strong, nonatomic) NSString *imgUrl;

@end

@implementation MeInfoTVHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *headLabel = [UILabel new];
        headLabel.textColor = TextDeepGaryColor;
        headLabel.text = @"头像";
        [self addSubview:headLabel];
        self.headLabel = headLabel;
        
        UIImageView *indicatorImage = [UIImageView new];
        indicatorImage.image = [UIImage imageNamed:@"RightItem"];
        [self addSubview:indicatorImage];
        self.indicatorImage = indicatorImage;
        
        UIImageView *headImageView = [UIImageView new];
        headImageView.contentMode = UIViewContentModeScaleAspectFill;
        headImageView.clipsToBounds = YES;
        headImageView.layer.cornerRadius = SCREEN_WIDTH / 8 - 10;
        [self addSubview:headImageView];
        headImageView.image = [UIImage imageNamed:@"me_head"];
        self.headImageView = headImageView;
        
        @weakify(self);
        [self whenTapped:^{
            @strongify(self);
            
            @weakify(self);
            _sheet = [ALActionSheetView showActionSheetWithTitle:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"相册",@"拍照",@"查看大图"] handler:^(ALActionSheetView *actionSheetView, NSInteger buttonIndex) {
                @strongify(self);
                
                if (buttonIndex < 0) return ;
                
                UIImagePickerController *picker = [UIImagePickerController new];
                
                picker.delegate = self;
                
                picker.navigationBar.tintColor = RGB(0, 0, 0);
                
                if (buttonIndex == 0) {
                    
                    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    
                } else if (buttonIndex == 1) {
                    
                    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    
                } else {
                    //查看大图
                    if (!self.userInfoEntity.imgUrl.length) {
                        
                        [AYProgressHud progressHudShowShortTimeMessage:@"暂无图片"];
                        
                    } else {
                        
                        [AYBrowseImage browseNetworkImageWithImages:[NSMutableArray arrayWithArray:@[self.imgUrl]] currentIndex:1];
                        
                    }
                    
                    return;
                    
                }
                
                [[URLNavigation navigation].currentViewController presentViewController:picker animated:YES completion:nil];
                
            }];
            
            [_sheet show];
            
        }];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(16);
        make.centerY.equalTo(self.mas_centerY);
    }];

    [self.indicatorImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-16);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(10);
    }];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.right.equalTo(self.indicatorImage.mas_left).offset(-8);
        make.width.equalTo(self.headImageView.mas_height);
    }];
    
}

- (void)setUserInfoEntity:(UserInfoEntity *)userInfoEntity
{
    _userInfoEntity = userInfoEntity;
    
    self.imgUrl = [NSString stringWithFormat:@"%@%@", userInfoEntity.domain, userInfoEntity.imgUrl];
    
    [self.headImageView imageShwoActivityIndicatorWithUrlString:self.imgUrl placeHolder:@"me_head"];
    
    
}

/**
 *  拍照回调
 *
 *  @param picker pickerController
 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
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
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.superview.superview animated:YES];
        
        [hud hide:YES afterDelay:5];
        
    }];
}

#pragma mark -- AYQiniuCloudUploadmageDelegate

- (void)qiniuCloudUploadmage:(AYQiniuCloudUploadmage *)qiniuCloudUploadmage urlString:(NSString *)urlString image:(NSString *)image domain:(NSString *)domain
{
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@", domain, image];
    
    [self.headImageView imageShwoActivityIndicatorWithUrlString:imageUrl placeHolder:@"me_head"];
    
    [MBProgressHUD hideHUDForView:self.superview.superview animated:YES];
    
    self.meInfoTVHeadViewBlock(image, domain);
    
    self.imgUrl = imageUrl;
    
}

@end

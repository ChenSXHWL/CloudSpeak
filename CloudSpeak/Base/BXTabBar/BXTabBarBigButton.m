//
//  BXTabBarBigButton.m
//  IrregularTabBar
//
//  Created by JYJ on 16/5/3.
//  Copyright © 2016年 baobeikeji. All rights reserved.
//

#import "BXTabBarBigButton.h"

@interface BXTabBarBigButton ()
/**
 *  背景
 */
@property(nonatomic, weak) UIImageView *bgView;
@end

@implementation BXTabBarBigButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 1.设置字体
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 2.图片的内容模式
        self.imageView.contentMode = UIViewContentModeCenter;
        
        UIImageView *image = [[UIImageView alloc] init];
        image.backgroundColor = [UIColor whiteColor];
        image.layer.cornerRadius = 30;
        [self insertSubview:image atIndex:0];
        self.bgView = image;
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.x = 0;
    self.titleLabel.width = self.width;
    self.titleLabel.height = 16;
    self.titleLabel.y = self.height - self.titleLabel.height;
    
    self.imageView.width = self.currentImage.size.width;
    self.imageView.height = self.currentImage.size.height;
    self.imageView.x = (self.width - self.imageView.width) / 2;
    self.imageView.y = self.titleLabel.y - self.imageView.height - 1;
    
    self.bgView.width = 60;
    self.bgView.height = self.height;
    self.bgView.x = (self.width - self.bgView.width) / 2;
    if (iPhoneX) {
        self.bgView.y = 20;
    }else{
        self.bgView.y = 0;
    }
}

- (void)setHighlighted:(BOOL)highlighted {

}
@end

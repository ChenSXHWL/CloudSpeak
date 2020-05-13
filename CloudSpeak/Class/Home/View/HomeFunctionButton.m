//
//  HomeFunctionButton.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 17/3/14.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "HomeFunctionButton.h"

@interface HomeFunctionButton ()

@property (strong, nonatomic) NSString *imageString;

@property (strong, nonatomic) NSString *titleString;

@end

@implementation HomeFunctionButton

+ (instancetype)setupHomeFunctionButtonWithImageString:(NSString *)string title:(NSString *)title
{
    return [[self alloc] initWithImageString:string title:title];
}

- (instancetype)initWithImageString:(NSString *)string title:(NSString *)title
{
    self = [super init];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self setTitleColor:TextMainBlackColor forState:UIControlStateNormal];
        
        [self setTitle:title forState:UIControlStateNormal];
        
        [self setImage:[UIImage imageNamed:string] forState:UIControlStateNormal];
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return self;
}
-(void)setIsEnble:(BOOL)isEnble{
    _isEnble = isEnble;
    if (isEnble==YES) {
        self.backgroundColor = [UIColor grayColor];
    }else{
        self.backgroundColor = [UIColor whiteColor];
    }
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    
    CGFloat width = contentRect.size.height / 2;
    
    CGFloat height = width;
    
    CGFloat originX = (contentRect.size.width - width) / 2;
    
    CGFloat originY = (contentRect.size.height - height) / 2 - 10;
    
    return CGRectMake(originX, originY, width, height);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat width = contentRect.size.width;
    
    CGFloat height = 30;
    
    CGFloat originX = 0;
    
    CGFloat originY = (contentRect.size.height - height) / 2 - 30 + contentRect.size.height / 2;
    
    return CGRectMake(originX, originY, width, height);
}

@end

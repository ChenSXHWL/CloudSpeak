//
//  SxButton.m
//  CloudSpeak
//
//  Created by 陈思祥 on 2017/11/28.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//



#import "SxButton.h"

@interface SxButton ()

@property (strong, nonatomic) NSString *imageString;

@property (strong, nonatomic) NSString *titleString;

@end

@implementation SxButton

+ (instancetype)setupManageButtonWithImageString:(NSString *)string title:(NSString *)title{
    return [[self alloc] initWithImageString:string title:title];
}

- (instancetype)initWithImageString:(NSString *)string title:(NSString *)title
{
    self = [super init];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self setTitle:title forState:UIControlStateNormal];
        
        self.tintColor = [UIColor blackColor];
        
        [self setImage:[UIImage imageNamed:string] forState:UIControlStateNormal];
        
        self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        
    }
    
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    
    CGFloat width = 16;
    
    CGFloat height = 16;
    
    CGFloat originX = contentRect.size.width * 8 / 10;
    
    CGFloat originY = contentRect.size.height / 2 - height / 2;
    
    return CGRectMake(originX-2, originY, width, height);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat width = contentRect.size.width / 2;
    
    CGFloat height = contentRect.size.height;
    
//    CGFloat originX = contentRect.size.width / 4;
    
    CGFloat originY = 0;
    
    return CGRectMake(0, originY, width+22, height);
}

@end


//
//  UIImageView+ImageLoadingActivityIndicator.m
//  ishanghome
//
//  Created by DNAKE_AY on 16/12/27.
//  Copyright © 2016年 DNAKE_AY. All rights reserved.
//

#import "UIImageView+ImageLoadingActivityIndicator.h"

#import <objc/runtime.h>

static char TAG_ACTIVITY_INDICATOR;

@interface UIImageView (Private)

-(void)addActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle) activityStyle;

@end

@implementation UIImageView (ImageLoadingActivityIndicator)

- (UIActivityIndicatorView *)activityIndicator {
    return (UIActivityIndicatorView *)objc_getAssociatedObject(self, &TAG_ACTIVITY_INDICATOR);
}

- (void)setActivityIndicator:(UIActivityIndicatorView *)activityIndicator {
    objc_setAssociatedObject(self, &TAG_ACTIVITY_INDICATOR, activityIndicator, OBJC_ASSOCIATION_RETAIN);
}

- (void)addActivityIndicatorWithStyle:(UIActivityIndicatorViewStyle)activityStyle {
    
    if (!self.activityIndicator) {
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:activityStyle];
        
        self.activityIndicator.autoresizingMask = UIViewAutoresizingNone;
        
        [self updateActivityIndicatorFrame];
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [self addSubview:self.activityIndicator];
        });
    }
    
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        [self.activityIndicator startAnimating];
    });
    
}

-(void)updateActivityIndicatorFrame {
    if (self.activityIndicator) {
        CGRect activityIndicatorBounds = self.activityIndicator.bounds;
        float x = (self.frame.size.width - activityIndicatorBounds.size.width) / 2.0;
        float y = (self.frame.size.height - activityIndicatorBounds.size.height) / 2.0;
        self.activityIndicator.frame = CGRectMake(x, y, activityIndicatorBounds.size.width, activityIndicatorBounds.size.height);
    }
}

- (void)removeActivityIndicator {
    if (self.activityIndicator) {
        [self.activityIndicator removeFromSuperview];
        self.activityIndicator = nil;
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    [self updateActivityIndicatorFrame];
}

#pragma mark - Methods


- (void)imageShwoActivityIndicatorWithUrlString:(NSString *)urlString placeHolder:(NSString *)placeHolder
{
    
    [self sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:placeHolder == nil ? @"default1" : placeHolder]];
}


@end

//
//  CountryPicker.m
//
//  Version 1.2.3
//
//  Created by Nick Lockwood on 25/04/2011.
//  Copyright 2011 Charcoal Design
//
//  Distributed under the permissive zlib License
//  Get the latest version from here:
//
//  https://github.com/nicklockwood/CountryPicker
//
//  This software is provided 'as-is', without any express or implied
//  warranty. In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  The source code and data files in this project are the sole creation of
//  Charcoal Design and are free for use subject to the terms below. The flag
//  icons were sourced from https://github.com/koppi/iso-country-flags-svg-collection
//  and are available under a Public Domain license
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//     claim that you wrote the original software. If you use this software
//     in a product, an acknowledgment in the product documentation would be
//     appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//     misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

#import "CountryPicker.h"


#pragma GCC diagnostic ignored "-Wselector"
#pragma GCC diagnostic ignored "-Wgnu"


#import <Availability.h>
#if !__has_feature(objc_arc)
#error This class requires automatic reference counting
#endif


@interface CountryPicker () <UIPickerViewDelegate, UIPickerViewDataSource>

@end


@implementation CountryPicker

//doesn't use _ prefix to avoid name clash with superclass
@synthesize delegate;

- (void)setNames:(NSArray *)names
{
    _names = names;
}

- (void)setCodes:(NSArray *)codes
{
    _codes = codes;
}

- (void)setUp
{
    super.dataSource = self;
    super.delegate = self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self setUp];
    }
    return self;
}

- (void)setDataSource:(__unused id<UIPickerViewDataSource>)dataSource
{
    //does nothing
}

- (void)setSelectedCountryCode:(NSString *)countryCode animated:(BOOL)animated
{
    NSUInteger index = [self.codes indexOfObject:countryCode];
    if (index != NSNotFound)
    {
        [self selectRow:(NSInteger)index inComponent:0 animated:animated];
    }
}

- (void)setSelectedCountryCode:(NSString *)countryCode
{
    [self setSelectedCountryCode:countryCode animated:NO];
}

- (NSString *)selectedCountryCode
{
    NSUInteger index = (NSUInteger)[self selectedRowInComponent:0];
    return self.codes[index];
}

- (void)setSelectedCountryName:(NSString *)countryName animated:(BOOL)animated
{
    NSUInteger index = [ self.names indexOfObject:countryName];
    if (index != NSNotFound)
    {
        [self selectRow:(NSInteger)index inComponent:0 animated:animated];
    }
}

- (void)setSelectedCountryName:(NSString *)countryName
{
    [self setSelectedCountryName:countryName animated:NO];
}

- (NSString *)selectedCountryName
{
    NSUInteger index = (NSUInteger)[self selectedRowInComponent:0];
    return self.names[index];
}

- (void)setSelectedLocale:(NSLocale *)locale animated:(BOOL)animated
{
    [self setSelectedCountryCode:[locale objectForKey:NSLocaleCountryCode] animated:animated];
}

- (void)setSelectedLocale:(NSLocale *)locale
{
    [self setSelectedLocale:locale animated:NO];
}

- (NSLocale *)selectedLocale
{
    NSString *countryCode = self.selectedCountryCode;
    if (countryCode)
    {
        NSString *identifier = [NSLocale localeIdentifierFromComponents:@{NSLocaleCountryCode: countryCode}];
        return [NSLocale localeWithLocaleIdentifier:identifier];
    }
    return nil;
}

#pragma mark -
#pragma mark UIPicker

- (NSInteger)numberOfComponentsInPickerView:(__unused UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(__unused UIPickerView *)pickerView numberOfRowsInComponent:(__unused NSInteger)component
{
    return (NSInteger)[self.names count];
}

- (UIView *)pickerView:(__unused UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(__unused NSInteger)component reusingView:(UIView *)view
{
    if (!view)
    {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 100)];
        

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 3, 245, 24)];
        
        
        
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = 1;
        [view addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(view).offset(35);
            make.right.bottom.equalTo(view).offset(-35);
        }];
        
        UILabel *blueView = [UILabel new];
        blueView.backgroundColor = TextBlueColor;
        blueView.layer.cornerRadius = 10;
        blueView.tag = 103;
        blueView.layer.masksToBounds = YES;
        [view addSubview:blueView];
        [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (SCREEN_WIDTH==320) {
                make.left.equalTo(view).offset(42);

            }else{
                make.left.equalTo(view).offset(28);
            }
            make.centerY.equalTo(label);
            make.height.width.mas_equalTo(20);
        }];
        
        if (SCREEN_WIDTH==320) {
            label.font = [UIFont systemFontOfSize:15];
        }else if (SCREEN_WIDTH==375){
            label.font = [UIFont systemFontOfSize:20];
        }else{
            label.font = [UIFont systemFontOfSize:22];
        }
        
        UILabel *flagView = [[UILabel alloc] initWithFrame:CGRectMake(35, 33, 24, 24)];
        flagView.tag = 2;
        flagView.font = [UIFont systemFontOfSize:15];
        flagView.textColor = TextDeepGaryColor;
        [view addSubview:flagView];
        
        [flagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(label);
            make.top.equalTo(label.mas_bottom);
            make.bottom.equalTo(view.mas_bottom);
        }];
        
    }
    
    ((UIView *)[pickerView.subviews objectAtIndex:1]).backgroundColor = [UIColor grayColor];
    
    ((UIView *)[pickerView.subviews objectAtIndex:2]).backgroundColor = [UIColor grayColor];


    ((UILabel *)[view viewWithTag:1]).text = self.names[(NSUInteger)row];
    
//    NSString *imagePath = [NSString stringWithFormat:@"CountryPicker.bundle/%@", [[self class] countryCodes][(NSUInteger) row]];
//    ((UILabel *)[view viewWithTag:2]).textAlignment = NSTextAlignmentCenter;
//    ((UILabel *)[view viewWithTag:2]).text = [NSString stringWithFormat:@"房号 : %@", self.codes[(NSUInteger)row]];

    if ([self.isOnlines[(NSUInteger)row] isEqualToString:@"0"]) {
        ((UILabel *)[view viewWithTag:1]).textColor = TextShallowGaryColor;
        ((UILabel *)[view viewWithTag:103]).backgroundColor = TextShallowGaryColor;

    } else {
        ((UILabel *)[view viewWithTag:1]).textColor = [UIColor blackColor];
        ((UILabel *)[view viewWithTag:103]).backgroundColor = TextBlueColor;
    }

    return view;
}

- (void)pickerView:(__unused UIPickerView *)pickerView
      didSelectRow:(__unused NSInteger)row
       inComponent:(__unused NSInteger)component
{
    __strong id<CountryPickerDelegate> strongDelegate = delegate;
    [strongDelegate countryPicker:self didSelectCountryWithName:self.selectedCountryName code:self.selectedCountryCode];
    
    [strongDelegate countryPicker:self didSelectRow:row];
}

- (CGFloat)pickerView:(__unused UIPickerView *)pickerView widthForComponent:(__unused NSInteger)component {
    
    return 200;
    
}
- (CGFloat)pickerView:(__unused UIPickerView *)pickerView rowHeightForComponent:(__unused NSInteger)component{
    
    return 60;
    
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 

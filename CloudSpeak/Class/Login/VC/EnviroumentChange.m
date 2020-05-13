//
//  EnviroumentChange.m
//  CloudSpeak
//
//  Created by DNAKE_AY on 2017/9/20.
//  Copyright © 2017年 DNAKE_AY. All rights reserved.
//

#import "EnviroumentChange.h"

@interface EnviroumentChange ()

@property (weak, nonatomic) IBOutlet UIButton *sipProduction;
@property (weak, nonatomic) IBOutlet UIButton *sipDevelop;
@property (weak, nonatomic) IBOutlet UIButton *cmpService;
@property (weak, nonatomic) IBOutlet UIButton *sixService;
@property (weak, nonatomic) IBOutlet UIButton *nineService;
@property (weak, nonatomic) IBOutlet UIButton *faceButton;


@end

@implementation EnviroumentChange

+ (instancetype)setupEnviroumentChange
{
    return [[[NSBundle mainBundle] loadNibNamed:@"EnviroumentChange" owner:nil options:nil] firstObject];
}


- (IBAction)sipServiceSelect:(UIButton *)sender {
    
    if (sender.tag == 400) {
        
        [sender setBackgroundColor:RGB(0, 146, 205)];
        
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.sipDevelop setBackgroundColor:[UIColor clearColor]];
        
        [self.sipDevelop setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    } else {
        
        [sender setBackgroundColor:RGB(0, 146, 205)];
        
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.sipProduction setBackgroundColor:[UIColor clearColor]];
        
        [self.sipProduction setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    
    if ([_delegate respondsToSelector:@selector(enviroumentChange:selectSipServiceWithLoc:)]) {
        [_delegate enviroumentChange:self selectSipServiceWithLoc:(int)sender.tag - 400];
    }
    
}

- (IBAction)urlServiceSelect:(UIButton *)sender {
    
    if (sender.tag == 402) {
        
        [sender setBackgroundColor:RGB(0, 146, 205)];
        
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.sixService setBackgroundColor:[UIColor clearColor]];
        
        [self.sixService setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.nineService setBackgroundColor:[UIColor clearColor]];
        
        [self.nineService setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.faceButton setBackgroundColor:[UIColor clearColor]];
        
        [self.faceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    } else if (sender.tag == 403) {
        
        [sender setBackgroundColor:RGB(0, 146, 205)];
        
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.cmpService setBackgroundColor:[UIColor clearColor]];
        
        [self.cmpService setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.nineService setBackgroundColor:[UIColor clearColor]];
        
        [self.nineService setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.faceButton setBackgroundColor:[UIColor clearColor]];
        
        [self.faceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    } else if (sender.tag == 404){
        
        [sender setBackgroundColor:RGB(0, 146, 205)];
        
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.sixService setBackgroundColor:[UIColor clearColor]];
        
        [self.sixService setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.cmpService setBackgroundColor:[UIColor clearColor]];
        
        [self.cmpService setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.faceButton setBackgroundColor:[UIColor clearColor]];
        
        [self.faceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    } else {
        
        [sender setBackgroundColor:RGB(0, 146, 205)];
        
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.sixService setBackgroundColor:[UIColor clearColor]];
        
        [self.sixService setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.cmpService setBackgroundColor:[UIColor clearColor]];
        
        [self.cmpService setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.nineService setBackgroundColor:[UIColor clearColor]];
        
        [self.nineService setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    
    if ([_delegate respondsToSelector:@selector(enviroumentChange:selectUrlServiceWithLoc:)]) {
        [_delegate enviroumentChange:self selectUrlServiceWithLoc:(int)sender.tag - 402];
    }
}

- (void)setUrl:(NSString *)url
{
    _url = url;
    
    if ([url isEqualToString:ISHome_Host] || url == nil) {
        
        [self.cmpService setBackgroundColor:RGB(0, 146, 205)];
        
        [self.cmpService setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.sixService setBackgroundColor:[UIColor clearColor]];
        
        [self.sixService setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.nineService setBackgroundColor:[UIColor clearColor]];
        
        [self.nineService setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.faceButton setBackgroundColor:[UIColor clearColor]];
        
        [self.faceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    } else if ([url isEqualToString:CeSi_Host]){
        
        [self.sixService setBackgroundColor:RGB(0, 146, 205)];
        
        [self.sixService setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.cmpService setBackgroundColor:[UIColor clearColor]];
        
        [self.cmpService setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.nineService setBackgroundColor:[UIColor clearColor]];
        
        [self.nineService setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.faceButton setBackgroundColor:[UIColor clearColor]];
        
        [self.faceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    } else if ([url isEqualToString:SanXing_Host]) {
        
        [self.nineService setBackgroundColor:RGB(0, 146, 205)];
        
        [self.nineService setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.cmpService setBackgroundColor:[UIColor clearColor]];
        
        [self.cmpService setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.sixService setBackgroundColor:[UIColor clearColor]];
        
        [self.sixService setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.faceButton setBackgroundColor:[UIColor clearColor]];
        
        [self.faceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    } else {
        
        [self.faceButton setBackgroundColor:RGB(0, 146, 205)];
        
        [self.faceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.cmpService setBackgroundColor:[UIColor clearColor]];
        
        [self.cmpService setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.sixService setBackgroundColor:[UIColor clearColor]];
        
        [self.sixService setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self.nineService setBackgroundColor:[UIColor clearColor]];
        
        [self.nineService setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
}

@end

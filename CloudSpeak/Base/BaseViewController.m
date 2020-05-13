//
//  LHBaseViewController.m
//  LaHuo
//
//  Created by ljh on 14-10-23.
//  Copyright (c) 2014年 LaHuo. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseNavigationController.h"
#import "BaseTabBarController.h"
#import "AYAlertViewController.h"
#import "GuideVC.h"

@interface BaseViewController ()
@property (assign, nonatomic) BOOL isOut;
@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [MTA trackPageViewBegin:[URLNavigation navigation].currentViewController.title];

    [super viewWillAppear:animated];

    self.isVedio = NO;
    
    self.isOut = NO;
}
-(void)viewDidDisappear:(BOOL)animated{

    [MTA trackPageViewEnd:[URLNavigation navigation].currentViewController.title];

    [super viewDidDisappear:animated];
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:RGB(230,230,230)];
    if (self.navigationController.viewControllers.count > 1) {
        
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        
        self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_return"] style:UIBarButtonItemStyleDone target:self action:@selector(popToVC)];
        self.navigationController.navigationBar.tintColor = TextBlueColor;
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;

    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    @weakify(self);
 
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"successLoginOut" object:nil] subscribeNext:^(NSNotification *x) {
        @strongify(self);
        if (self.isOut==YES) {//防止一个界面多次进入
            return ;
        }
        self.isOut = YES;

        NSString *title = x.object;
        
        NSString *scheme = [LoginEntity shareManager].scheme;
        
        NSString *url = [LoginEntity shareManager].url;
        
        [LoginManage loginOut];
        [AYAlertViewController alertViewController:self message:title confirmStr:@"确定" alert:^(UIAlertController *action) {
            
            GuideVC *guideVC = [GuideVC new];
            
            guideVC.isLogin = YES;
            
            guideVC.scheme = scheme;
            
            guideVC.formalStr = url;
            
            [URLNavigation setRootViewController:[[BaseNavigationController alloc] initWithRootViewController:guideVC]];
            
            
        }];
        
        
    }];
    
}

-(void)popToVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if ([self isViewLoaded])
    {
        [self deleteTableViewDelegate:self.view];
    }
    EZLog(@"dealloc vc = %@",self);
}

- (void)deleteTableViewDelegate:(UIView *)view
{
    NSArray *array = view.subviews;
    for (UIView *view in array)
    {
        if ([view isKindOfClass:[UIScrollView class]])
        {
            UITableView *tableView = (id) view;
            
            tableView.delegate = nil;
            
            if ([tableView respondsToSelector:@selector(setDataSource:)])
            {
                [tableView setDataSource:nil];
            }
        }
        else if ([view respondsToSelector:@selector(setDelegate:)])
        {
//            [((id) view) setDelegate:nil];
        }
        
        if (view.subviews.count)
        {
            [self deleteTableViewDelegate:view];
        }
    }
}
//关闭左滑
- (void)forbidLeftSlide
{
    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
    [self.view addGestureRecognizer:pan];
}

//以下两个代理方法可以防止键盘遮挡textview

-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    //这里的offset的大小是控制着呼出键盘的时候view上移多少。比如上移20，就给offset赋值-20，以此类推。也可以根据屏幕高度的不同做一个if判断。
    
    float offset = 0.0f;
    
//    if(_szTextView == textView){
    
        offset = -20;
        
//    }
    
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyBoard"context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    float width = self.view.frame.size.width;
    
    float height = self.view.frame.size.height;
    
    CGRect rect = CGRectMake(0.0f, offset , width, height);
    
    self.view.frame = rect;
    
    [UIView commitAnimations];
    
}

//完成编辑的时候下移回来（只要把offset重新设为0就行了）

-(void)textViewDidEndEditing:(UITextView *)textView{
    
    float offset = 0.0f;
    
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyBoard"context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    float width = self.view.frame.size.width;
    
    float height = self.view.frame.size.height;
    
    CGRect rect = CGRectMake(0.0f, offset , width, height);
    
    self.view.frame = rect;
    
    [UIView commitAnimations];
    
}

/**
 判断是不是九宫格
 @param string  输入的字符
 @return YES(是九宫格拼音键盘)
 */
-(BOOL)isNineKeyBoard:(NSString *)string
{
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for(int i=0;i<len;i++)
    {
        if(!([other rangeOfString:string].location != NSNotFound))
            return NO;
    }
    return YES;
}
/**
 *  判断字符串中是否存在emoji
 * @param string 字符串
 * @return YES(含有表情)
 */
- (BOOL)hasEmoji:(NSString*)string;
{
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (textView.text.length>=200&&![text isEqualToString:@""]){
        [AYProgressHud progressHudShowShortTimeMessage:@"限制输入字数200个"];
        return NO;
    }
    if ([textView isFirstResponder]) {
        
        if ([[[textView textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textView textInputMode] primaryLanguage]) {
            return NO;
        }
        
        //判断键盘是不是九宫格键盘
        if ([self isNineKeyBoard:text] ){
            return YES;
        }else{
            if ([self hasEmoji:text] || [self stringContainsEmoji:text]){
                [AYProgressHud progressHudShowShortTimeMessage:@"禁止输入表情"];
                
                return NO;
            }
        }
    }
    
    return YES;
}
//表情符号的判断
- (BOOL)stringContainsEmoji:(NSString *)string {
    
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}
@end

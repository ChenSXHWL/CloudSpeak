//
//  AdviceVC.m
//  Linkhome
//
//  Created by 陈思祥 on 2017/9/18.
//  Copyright © 2017年 陈思祥. All rights reserved.
//

#import "AdviceVC.h"
#import "AdviceVM.h"
#import "AYPhotoCollectionView.h"
#import "IQKeyboardManager.h"

@interface AdviceVC ()<AYPhotoCollectionViewDelegate,UITextViewDelegate>

@property (strong, nonatomic)AdviceVM *adviceVM;

@property (strong, nonatomic)UITextView *textView;

@property (strong, nonatomic) AYPhotoCollectionView *ayPhotoCollectionView;

@end

@implementation AdviceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self forbidLeftSlide];
    
    self.title = NSLocalizedString(@"建议反馈", 帮助中心);
    
    self.navigationItem.rightBarButtonItem =  [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"提交", 提交) style:UIBarButtonItemStyleDone target:self action:@selector(submitTouch)];
    

    
    [self buildUI];

    
    [self setupRAC];

    // Do any additional setup after loading the view.
}
-(void)submitTouch{
    
    if (self.textView.text.length>0) {
        self.adviceVM.adviceRequest.content = self.textView.text;
        
        self.adviceVM.adviceRequest.requestNeedActive = YES;

    }else{
        [AYProgressHud progressHudShowShortTimeMessage:@"请输入反馈内容"];
    }
    
    
}
-(void)setupRAC{
    
    self.adviceVM = [AdviceVM SceneModel];
    
    [[RACObserve(self.adviceVM.adviceRequest, state) filter:^BOOL(id value) {
        return value == RequestStateSuccess;
    }] subscribeNext:^(id x) {
        
        [super popToVC];
        
    }];
    
}

-(void)buildUI{
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
    textView.text =NSLocalizedString(@"您的每一条建议都在帮助我们变得更好，非常感谢", nil);
    textView.textColor = [UIColor grayColor];
    textView.delegate = self;
    textView.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:textView];
    self.textView = textView;
    
    
    AYPhotoCollectionView *ayPhotoCollectionView = [AYPhotoCollectionView photoWithCollectionView];
    ayPhotoCollectionView.photoDelegate = self;
    [self.view addSubview:ayPhotoCollectionView];
    self.ayPhotoCollectionView = ayPhotoCollectionView;
    [self.ayPhotoCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.textView.mas_bottom);
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.width / 3);
    }];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.textView resignFirstResponder];
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

- (void)photoCollectionView:(AYPhotoCollectionView *)phoneCollectionView didSelectPlusAtLastItem:(UINavigationController *)navigationController
{
    [self.textView resignFirstResponder];

    [self presentViewController:navigationController animated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)photoCollectionViewWithDismissVC:(AYPhotoCollectionView *)phoneCollectionView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)photoCollectionView:(AYPhotoCollectionView *)phoneCollectionView arrayWithPhotos:(NSMutableArray *)photos width:(CGFloat)width height:(CGFloat)heigh{
    
    
    if (photos.count == 0) {
        
        
        return;
        
    }
    
    for (int i = 0; i < photos.count; i ++) {
        
        NSString *photo = photos[i];
        
        if (i == 0) {
            
            self.adviceVM.adviceRequest.imgUrl = photo;
            
        } else if (i == 1) {
            
            self.adviceVM.adviceRequest.imgUrl = [NSString stringWithFormat:@"%@,%@",self.adviceVM.adviceRequest.imgUrl,photo];
            
        } else {
            
            self.adviceVM.adviceRequest.imgUrl = [NSString stringWithFormat:@"%@,%@",self.adviceVM.adviceRequest.imgUrl,photo];
        }
        
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    [IQKeyboardManager sharedManager].enable = NO;
    
}

//

-(void)viewWillDisappear:(BOOL)animated{
    
    [_textView resignFirstResponder];
    
    [IQKeyboardManager sharedManager].enable = YES;
    
}

//以下两个代理方法可以防止键盘遮挡textview

-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    //这里的offset的大小是控制着呼出键盘的时候view上移多少。比如上移20，就给offset赋值-20，以此类推。也可以根据屏幕高度的不同做一个if判断。
    if([textView.text isEqualToString:NSLocalizedString(@"您的每一条建议都在帮助我们变得更好，非常感谢", nil)]){
        textView.text=@"";
        textView.textColor=[UIColor blackColor];
    }

    float offset = 0.0f;
    
    if(_textView == textView){
        
        offset = 0;
        
    }
    
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
    if(textView.text.length < 1){
        textView.text = NSLocalizedString(@"您的每一条建议都在帮助我们变得更好，非常感谢", nil);
        textView.textColor = [UIColor grayColor];
    }
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  FeedbackViewController.m
//  TNF
//
//  Created by 李立 on 15/12/17.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()
{
   UIWebView *_phoneCallWebView;
}
@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //导航栏标题
    self.text = @"意见反馈";
    
    //当前视图的背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化视图
    [self _initView];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    //改变导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:UIColor(深色背景)];
    
    
    
}

//初始化视图
-(void)_initView
{
    //输入框
    _textView1 = [[UITextView alloc]initWithFrame:CGRectMake(5, 0, kScreenWidth-10, 180)];
    _textView1.textColor = UIColor6(正文小字);
    _textView1.font = [UIFont systemFontOfSize:13 * ratioHeight];
    _textView1.delegate = self;
    _textView1.scrollEnabled = YES;//是否可以拖动
    _textView1.showsHorizontalScrollIndicator = NO;
    _textView1.shouldGroupAccessibilityChildren = NO;
    _textView1.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:_textView1];
    
    //默认输入Label
    _lael1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 200, 20)];
    _lael1.text = @"输入内容(200字以内)";
    _lael1.textColor = UIColor6(正文小字);
    _lael1.font = [UIFont systemFontOfSize:13 * ratioHeight];
    [_textView1 addSubview:_lael1];
   
    //线条
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _textView1.bottom, kScreenWidth, 1)];
    lineView.backgroundColor = UIColor2(<#灰色背景#>);
    [self.view addSubview:lineView];
    
    //提交按钮
    UIButton *lingquButton = [UIButton buttonWithType:UIButtonTypeCustom];
    lingquButton.frame = CGRectMake((kScreenWidth-200 * ratioWidth) / 2.0, lineView.bottom+15, 200*ratioWidth, 40 * ratioHeight);
    [lingquButton setTitle:@"提交" forState:UIControlStateNormal];
    lingquButton.titleLabel.font = [UIFont boldSystemFontOfSize:15 * ratioWidth];
    [lingquButton setBackgroundColor:UIColor1(蓝)];
    lingquButton.tag = 11;
    [lingquButton addTarget:self action:@selector(lingquButton:) forControlEvents:UIControlEventTouchUpInside];
    lingquButton.layer.cornerRadius = 20 * ratioHeight;
    // 按钮边框宽度
    lingquButton.layer.borderWidth = 0;
    [self.view addSubview:lingquButton];
    
    
    
    //默认输入Label
    UILabel *lael2 = [[UILabel alloc]initWithFrame:CGRectMake(0, lingquButton.bottom + 70, kScreenWidth, 30)];
    lael2.text = @"email：natechen@tuoninfu.com";
    lael2.textAlignment = NSTextAlignmentCenter;
    lael2.textColor = UIColor6(正文小字);
    lael2.font = [UIFont systemFontOfSize:15 * ratioHeight];
    [self.view addSubview:lael2];
    
    UILabel *lael3 = [[UILabel alloc]initWithFrame:CGRectMake(0, lael2.bottom, kScreenWidth, 30)];
    lael3.text = @"联系电话：400-812-8512";
    lael3.textAlignment = NSTextAlignmentCenter;
    lael3.textColor = UIColor6(正文小字);
    lael3.userInteractionEnabled = YES;
    lael3.font = [UIFont systemFontOfSize:15 * ratioHeight];
    [self.view addSubview:lael3];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playphone)];
    [lael3 addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *hiddnkey = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddnkeyAction)];
    [self.view addGestureRecognizer:hiddnkey];


}

- (void)playphone
{
    
    NSString *number = @"400-812-8512";
    if ([[[UIDevice currentDevice]model]isEqualToString:@"ipod touch"]||[[[UIDevice currentDevice]model]isEqualToString:@"ipad"]||[[[UIDevice currentDevice]model ]isEqualToString:@"iPhone Simulator"]){
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的设备不能打电话" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    } else {
        _phoneCallWebView = [[UIWebView alloc]init];
        NSURL *callUrl = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",number]];
        NSURLRequest *request = [NSURLRequest requestWithURL:callUrl];
        [_phoneCallWebView loadRequest:request];
    }
    
}


//提交按钮点击事件
-(void)lingquButton:(UIButton *)button
{
    if (_textView1.text.length == 0) {
        [MBProgressHUD showError:@"请填写内容" toView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    if (_textView1.text.length >=  200) {
        [MBProgressHUD showError:@"字数过多" toView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    NSLog(@"提交----%@",_textView1.text);

    [WXDataService requestAFWithURL:Url_feedback params:@{@"member_id":[UserDefaults objectForKey:Userid],@"content":_textView1.text} httpMethod:@"POST" finishBlock:^(id result) {
        
        [self hiddnkeyAction];
        //请求失败
        if ([[result objectForKey:@"status"] integerValue] == 0) {
            
            
            [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            [self.navigationController popViewControllerAnimated:YES];
            
        }

        //请求失败
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
        }

    } errorBlock:^(NSError *error) {
        
    }];
    
}

//隐藏键盘
- (void)hiddnkeyAction
{
    [self keyfile];
    
}

- (void)keyfile
{
    if (![_textView1 isExclusiveTouch]) {
        [_textView1 resignFirstResponder];
    }
    
    
}

//开始编辑
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView

{
    _lael1.hidden = YES;
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{
    
    if ([text isEqualToString:@"\n"]) {
        [self hiddnkeyAction];
        return NO;
    }
    return YES;
}

@end

//
//  ZhiboViewController.m
//  TNF
//
//  Created by 李江 on 16/1/26.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "ZhiboViewController.h"

@interface ZhiboViewController ()<UIWebViewDelegate>
{
    UIWebView *_webView;
    
    UIActivityIndicatorView *_actView;  //风火轮视图
}
@end

@implementation ZhiboViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.text = _titlestr;
    
    [self _initViews];
}

- (void)_initViews
{
    
    _actView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    //设置代理对象
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *resquest = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:resquest];
    
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //开始加载
    [_actView startAnimating];
    //开启状态上的加载提示
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //结束加载
    [_actView stopAnimating];
    
    //关闭状态上的加载提示
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
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

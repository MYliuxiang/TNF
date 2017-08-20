//
//  FileContentViewController.m
//  TNF
//
//  Created by 李江 on 16/1/14.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "FileContentViewController.h"

@implementation FileContentViewController
{
    NSString *_content;
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor2(灰色背景);
    
    [self _initData];
    
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.contentMode = UIViewContentModeScaleAspectFit;
        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
    }
    return _webView;
}

- (void)_initData
{
    [WXDataService requestAFWithURL:Url_getFileContent params:@{@"id":_ID} httpMethod:@"POST" finishBlock:^(id result) {
        NSLog(@"result==:%@",result);
        if ([[result objectForKey:@"status"] integerValue] == 0) {
            //            [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
            _content = result[@"result"][@"info"][@"content"];
            self.text = result[@"result"][@"info"][@"subtitle"];
//
            [self.webView loadHTMLString:[NSString stringWithFormat:@"%@",_content] baseURL:nil];
            [self.view addSubview:_webView];

            
            
            
        }
        //请求失败
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            
            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
        }
        
    } errorBlock:^(NSError *error) {
        
    }];

}

@end

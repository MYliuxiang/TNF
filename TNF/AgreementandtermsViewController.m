//
//  AgreementandtermsViewController.m
//  TNF
//
//  Created by 李立 on 15/12/17.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "AgreementandtermsViewController.h"

@interface AgreementandtermsViewController ()
{
    UIWebView *_webView;

}
@end

@implementation AgreementandtermsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //导航栏标题
    self.text = @"协议与条款";
    
    //当前视图的背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self _initData];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    //改变导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:UIColor(深色背景)];
    
    
    
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
    }
    return _webView;
}
- (void)_initData
{
    [WXDataService requestAFWithURL:Url_getAgreement params:nil httpMethod:@"POST" finishBlock:^(id result) {
        
        //请求失败
        if ([[result objectForKey:@"status"] integerValue] == 0) {
            
            NSString *titilt = [NSString stringWithFormat:@"\n<p style=\"clear:both;font-family:sans-serif;font-size:16px;white-space:normal;text-align:center;line-height:1.75em;\">\n\t<span style=\"color:#0070C0;font-size:16px;line-height:1.5;\">-- &nbsp;%@ &nbsp;--</span> ",result[@"result"][@"title"]];
            [self.webView loadHTMLString:[NSString stringWithFormat:@"%@%@",titilt,result[@"result"][@"content"]] baseURL:nil];
            [self.view addSubview:_webView];
            
            
//            [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
//            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
        //请求失败
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
        }
        
    } errorBlock:^(NSError *error) {
        
    }];


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

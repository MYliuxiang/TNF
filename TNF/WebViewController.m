
//
//  WebViewController.m
//  TNF
//
//  Created by 李立 on 16/1/9.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "WebViewController.h"
#import "TabBarItem.h"
@interface WebViewController ()
{
    UIImageView *_titleImageView;
    UILabel *_titleLabel;
    UIView *view;

}
@end

@implementation WebViewController

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBarTintColor:[MyColor colorWithHexString:@"#0172fe"]];
    
   
    
}


- (void)_addbtu
{

    view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 44)];
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ItmeAction)];
    [view addGestureRecognizer:tap];
    //1.创建标题图片
    _titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, (view.height - 28/2*ratioHeight) / 2.0, 28/2*ratioHeight, 28/2*ratioHeight)];
    //图片的填充方式
    _titleImageView.contentMode = UIViewContentModeScaleAspectFit;
    //设置图片
    [view addSubview:_titleImageView];

    //2.标题文本
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleImageView.right,(view.height - 20*ratioHeight)/ 2.0, 130, 20*ratioHeight)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    _titleLabel.text = @"收藏到我的课程";
    [view addSubview:_titleLabel];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    // 添加到当前导航控制器上
    self.navigationItem.rightBarButtonItem = backItem;
        

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _initViews];
   
    if (_isZhibo == YES) {
        [self _addbtu];
        [self _initData];
    }
    
}


- (void)_initData
{
    
    [WXDataService requestAFWithURL:Url_getZhiboIsCollection params:@{@"id":self.ID,@"member_id":[UserDefaults objectForKey:Userid]} httpMethod:@"POST" finishBlock:^(id result) {
        
        if ([[result objectForKey:@"status"] integerValue] == 0) {
//            [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            if ([[result objectForKey:@"result"] integerValue] == 0)
            {
              _titleImageView.image = [UIImage imageNamed:@"starmy"];
                view.userInteractionEnabled = YES;
             
            } else {
            
                _titleImageView.image = [UIImage imageNamed:@"star_04"];
                view.userInteractionEnabled = NO;
            }
           
        }
        //请求失败
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
        }

        
    } errorBlock:^(NSError *error) {
        
    }];





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

//收藏
-(void)ItmeAction
{
    
        NSLog(@"收藏");
        [WXDataService requestAFWithURL:Url_collectionZhiboCourse params:@{@"id":_ID,@"member_id":[UserDefaults objectForKey:Userid]} httpMethod:@"POST" finishBlock:^(id result) {
            NSLog(@"result==:%@",result);
            if ([[result objectForKey:@"status"] integerValue] == 0) {
                [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                
                [self _initData];
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

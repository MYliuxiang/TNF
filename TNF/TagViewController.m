//
//  TagViewController.m
//  TNF
//
//  Created by 李善 on 15/12/21.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "TagViewController.h"
#import "MycourseViewController.h"
#import "CollectionView.h"
@interface TagViewController ()<UIWebViewDelegate>

@end

@implementation TagViewController{
 
    NSString *_content;
    NSArray * _recommendList;
    UIWebView *_webView;
    CollectionView *coView ;
    UIScrollView *ScrollView;
    UILabel *titlelabel;

}


- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBarTintColor:[MyColor colorWithHexString:@"#0172fe"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor2(灰色背景);
   
    [self _initData];
    
}


- (void)_initData
{
    [WXDataService requestAFWithURL:Url_weakLabelCont params:@{@"id":_ID,@"member_id":[UserDefaults objectForKey:Userid]} httpMethod:@"POST" finishBlock:^(id result) {
        NSLog(@"result==:%@",result);
        if ([[result objectForKey:@"status"] integerValue] == 0) {
//            [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
         
            _content = result[@"result"][@"info"][@"content"];
            self.text = result[@"result"][@"info"][@"title"];
            _recommendList = result[@"result"][@"recommendList"];
             [self createSR];
            
            
            
        }
        //请求失败
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            
            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
        }
        
    } errorBlock:^(NSError *error) {
        
    }];



}

- (void)createSR{

    ScrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    ScrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight);
    ScrollView.backgroundColor = UIColor2(灰色背景);
    [self.view addSubview:ScrollView];
    
   
    //标题label
//    titlelabel = [WXLabel UIlabelFrame:CGRectMake(0,0 , kScreenWidth, 35*ratioHeight) textColor:UIColor6(正文小字) textFont:[UIFont boldSystemFontOfSize:15 *ratioHeight] labelTag:100];
//    titlelabel.backgroundColor = [UIColor clearColor];
//    [ScrollView addSubview:titlelabel];
    
    
    //正文
//    UILabel *comments= [[UILabel alloc]initWithFrame:CGRectZero];
//    comments.text =@"非官方的三国杀的风格的非官方大哥的法规法规和幅度为个梵蒂冈地方刚好是大法官";
//    CGFloat commentsWidth = kScreenWidth-30*ratioHeight;
//    comments.lineBreakMode = NSLineBreakByWordWrapping;
//    comments.numberOfLines = 0;
//    comments.font= [UIFont systemFontOfSize:13];
//    CGFloat commetsheih= [WXLabel getTextHeight:13 width:commentsWidth text:@"非官方的三国杀的风格的非官方大哥的法规法规和幅度为个梵蒂冈地方刚好是大法官" linespace:10];
//    comments.frame = CGRectMake(titlelabel.left, titlelabel.bottom+50*ratioHeight/2, commentsWidth, commetsheih);
//    [ScrollView addSubview:comments];
    
    _webView  = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth   , 20)];
    _webView.delegate = self;
    _webView.scrollView.bounces=NO;
    _webView.scrollView.scrollEnabled = NO;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    [_webView setBackgroundColor:[UIColor clearColor]];
    [_webView setOpaque:NO];
    //下部Web
    [_webView loadHTMLString:_content  baseURL:nil];

    [ScrollView addSubview:_webView];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
//    titlelabel.backgroundColor = [UIColor whiteColor];
//    titlelabel.text = [NSString stringWithFormat:@"     %@",self.text];

    
    NSString *height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    int height = [height_str intValue];
    _webView.height = height + 30;
    NSLog(@"height: %@", [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"]);
    _webView.scrollView.backgroundColor = [UIColor whiteColor];
    _webView.backgroundColor = [UIColor whiteColor];
    
    
    NSArray*recommendListAry = _recommendList;
    
    NSInteger aa;
    
    if(recommendListAry.count%2 == 0) {
        
        aa = recommendListAry.count/2;
        
    }else {
        aa = recommendListAry.count/2 + 1;
    }
    
    UILabel *titlelabel1 = [WXLabel UIlabelFrame:CGRectMake(10,_webView.bottom , kScreenWidth, 30*ratioHeight) textColor:UIColor6(正文小字) textFont:[UIFont systemFontOfSize:13 *ratioHeight] labelTag:100];
    titlelabel1.text = [NSString stringWithFormat:@"%@",@"提升课程"];
    [ScrollView addSubview:titlelabel1];
    
    if (recommendListAry.count !=0) {
        coView = [[CollectionView alloc]initWithFrame:CGRectMake(0, titlelabel1.bottom,kScreenWidth, (ratioHeight*250/2)*aa) recommendLisrAry:recommendListAry];
//        coView.backgroundColor = UIColor(深色背景);
        coView.tag = 607;
        [ScrollView addSubview:coView];
         ScrollView.contentSize = CGSizeMake(kScreenWidth, coView.bottom + 10);
    } else {
        titlelabel1.hidden = YES;
        ScrollView.contentSize = CGSizeMake(kScreenWidth, _webView.bottom);
    
    }

   
}

@end

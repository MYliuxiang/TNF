//
//  LognViewController.m
//  TNF
//
//  Created by 李善 on 15/12/21.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "LognViewController.h"
#import "TFViewController.h"
#import "WXApi.h"
#import "WXApiObject.h"

@interface LognViewController ()<UIScrollViewDelegate>
{
   UIPageControl *pageControl;
   UIScrollView *scrollView;
    
    UITextField *_textFieldName;
    UITextField *_textFielePassd;
        
}
@end

@implementation LognViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBar.hidden = YES;
 
    //    [_tableview reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
//    self.text = @"登陆";

    
    
    
    //判断设备上是否有微信
    if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {
      
        NSLog(@"有微信");
        UIImageView  *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth , kScreenHeight)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:@"bg2.png"];
        [self.view addSubview:imageView];
        
//        UIImageView  *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 150) / 2.0, 80 * ratioHeight,150  , 150)];
//        imageView1.contentMode = UIViewContentModeScaleAspectFit;
//        imageView1.image = [UIImage imageNamed:@"guide_img01"];
//        [self.view addSubview:imageView1];
        
       

        
        UIButton *logn = [UIButton buttonWithType:UIButtonTypeCustom];
        logn.frame = CGRectMake(0, kScreenHeight - 45 *ratioHeight , kScreenWidth, 45 *ratioHeight);
//        logn.layer.cornerRadius = 20 * ratioHeight;
//        logn.layer.masksToBounds = YES;
        logn.backgroundColor = UIColor1(<#蓝#>);
        [logn addTarget:self action:@selector(LognAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:logn];
    
        UIImageView  *imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake((logn.width - 30 * ratioHeight -  75 * ratioWidth) / 2.0  ,(logn.height - 30 * ratioHeight) / 2.0  ,30 * ratioHeight , 30 * ratioHeight)];
        imageView3.contentMode = UIViewContentModeScaleAspectFit;
        imageView3.image = [UIImage imageNamed:@"weixin"];
        [logn addSubview:imageView3];
    
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imageView3.right + 5 * ratioWidth, imageView3.top, 70 * ratioWidth, imageView3.height)];
        label.font = [UIFont systemFontOfSize:17 * ratioWidth];
        label.text = @"微信登录";
        label.textColor = [UIColor whiteColor];
        [logn addSubview:label];

    } else {
        
        UIImageView  *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth , kScreenHeight)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:@"bg.png"];
        [self.view addSubview:imageView];
        
        UIImageView  *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 150) / 2.0, 80 * ratioHeight,150  , 150)];
        imageView1.contentMode = UIViewContentModeScaleAspectFit;
        imageView1.image = [UIImage imageNamed:@"guide_img07"];
        [self.view addSubview:imageView1];
        
        UIImageView  *imageView4 = [[UIImageView alloc]initWithFrame:CGRectMake(40 * ratioWidth, imageView1.bottom + 50 * ratioHeight,  20 , 20)];
        imageView4.contentMode = UIViewContentModeScaleAspectFit;
        imageView4.image = [UIImage imageNamed:@"guide_login_ico01"];
        [self.view addSubview:imageView4];
        
        _textFieldName = [[UITextField alloc]initWithFrame:CGRectMake(imageView4.right + 10,imageView4.top  ,kScreenWidth - 40 * ratioWidth * 2, 20)];
        _textFieldName.textColor = [UIColor whiteColor];
        _textFieldName.placeholder = @"Username";
        [_textFieldName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        //    _textFieldName.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_textFieldName];
        
        UIView *bgLine1 = [[UIView alloc]initWithFrame:CGRectMake(30 * ratioWidth, imageView4.bottom + 10, kScreenWidth - 30 * ratioWidth * 2, 1)];
        bgLine1.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bgLine1];
        
        
        
        UIImageView  *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(imageView4.left , bgLine1.bottom + 15 ,imageView4.width , imageView4.height)];
        imageView2.contentMode = UIViewContentModeScaleAspectFit;
        imageView2.image = [UIImage imageNamed:@"guide_login_ico02"];
        [self.view addSubview:imageView2];
        
        _textFielePassd = [[UITextField alloc]initWithFrame:CGRectMake(imageView2.right + 10,imageView2.top  ,kScreenWidth - 40 * ratioWidth * 2, 20)];
        _textFielePassd.placeholder = @"Password";
        _textFielePassd.secureTextEntry = YES;
        [_textFielePassd setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];_textFielePassd.textColor = [UIColor whiteColor];
        //    _textFielePassd.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_textFielePassd];
        
        
        UIView *bgLine2 = [[UIView alloc]initWithFrame:CGRectMake(30 * ratioWidth, imageView2.bottom + 10, kScreenWidth - 30 * ratioWidth * 2, 1)];
        bgLine2.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:bgLine2];
        
        UIButton *logn = [UIButton buttonWithType:UIButtonTypeCustom];
        logn.frame = CGRectMake((kScreenWidth - 210 *ratioWidth) / 2.0, kScreenHeight - 90 * ratioHeight - 65 *ratioHeight , 210 *ratioWidth, 45 *ratioHeight);
        logn.layer.cornerRadius = 20 * ratioHeight;
        logn.layer.masksToBounds = YES;
        logn.backgroundColor = UIColor1(<#蓝#>);
        UIImageView *imgview = [[UIImageView alloc]init];
        imgview.frame = CGRectMake((logn.width-70*ratioWidth/2)/2, 15*ratioHeight/2, 70*ratioWidth/2, logn.height-15*ratioHeight);
        imgview.image = [UIImage imageNamed:@"jiantou_01"];
        [logn addSubview:imgview];
        
        [logn addTarget:self action:@selector(LognAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:logn];
        

        
        NSLog(@"fasfa");

    }
    
   
    [self lanuch];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hiddnkeyAction];
}

//隐藏键盘
- (void)hiddnkeyAction
{
    [self keyfile];
    
}

- (void)keyfile
{
    
    
    if (![_textFieldName isExclusiveTouch]) {
        [_textFieldName resignFirstResponder];
    }
    if (![_textFielePassd isExclusiveTouch]) {
        [_textFielePassd resignFirstResponder];
    }
}
#pragma MARK ------ 引导图 ---------------
-(void)lanuch{
    
    //判断是不是第一次启动应用
    if(![UserDefaults boolForKey:@"firstLaunch"])
    {
        [UserDefaults setBool:YES forKey:@"firstLaunch"];
        [UserDefaults synchronize];
        NSLog(@"第一次启动");
        
                [self initGuide];
        
    }
    else
    {
        NSLog(@"不是第一次启动");
        
        
    }

    
}

- (void)initGuide
{
    
    UIWindow *WIN = [UIApplication sharedApplication].keyWindow;
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    [scrollView setPagingEnabled:YES];  //视图整页显示
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.alwaysBounceHorizontal = NO;
    //    [scrollView setBounces:NO]; //避免弹跳效果,避免把根视图露出来
    NSArray *array = @[[UIImage imageNamed:@"page1"],[UIImage imageNamed:@"page2"],[UIImage imageNamed:@"page3"],[UIImage imageNamed:@"page1"]];
    [scrollView setContentSize:CGSizeMake(kScreenWidth*array.count, kScreenHeight)];
    for (int i = 0; i<array.count; i++) {
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, kScreenHeight)];
        if (i < array.count - 1) {
            [imageview setImage:array[i]];
        }
        
        imageview.contentMode = UIViewContentModeScaleToFill;
        imageview.userInteractionEnabled = YES;
        [scrollView addSubview:imageview];
        
    }
    [WIN addSubview:scrollView];
    
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((kScreenWidth-80)/2, kScreenHeight- 40, 80, 25)];
    pageControl.numberOfPages = array.count - 1;
    //    pageControl.backgroundColor = [UIColor redColor];
    pageControl.currentPage = 0;
    //    pageControl.currentPageIndicatorTintColor = ColorPageSel;
    //    pageControl.pageIndicatorTintColor = ColorPageNor;
    //    pageControl.alpha = 0.4;
    
    [WIN addSubview:pageControl];
    
    
}

- (void)firstpressed
{
    [scrollView removeFromSuperview];
    [pageControl removeFromSuperview];
    
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int count = (int)scrollView.contentOffset.x/scrollView.width;
    if (count == 3) {
        [self firstpressed];
    } else {
        pageControl.currentPage = count;
    }
    
    
    
}




#pragma mark -- 登录成功
//- (void)wxLogin
//{
//
//    TFViewController *TFVC = [[TFViewController alloc]init];
//    [self.navigationController pushViewController:TFVC animated:NO];
//}

- (void)LognAction:(UIButton *)button{

    //判断是否有微信
    if ([WXApi isWXAppInstalled]&&[WXApi isWXAppSupportApi]) {
        //有微信
        [self weixinClick];

    }
    else
    {
       
        [self _zhanghaoLogin];
        
    }
    
}


//账号登录
- (void)_zhanghaoLogin
{

    if (_textFieldName.text.length == 0) {
         [MBProgressHUD showError:@"请填写账号" toView:[UIApplication sharedApplication].keyWindow];
    }
    if (_textFielePassd.text.length == 0) {
        [MBProgressHUD showError:@"请填写密码" toView:[UIApplication sharedApplication].keyWindow];
    }
    [WXDataService requestAFWithURL:Url_studentLogin params:@{@"username":_textFieldName.text,@"password":_textFielePassd.text
                                                       } httpMethod:@"POST" finishBlock:^(id result) {
                                                           NSLog(@"result:== %@",result);
                                                           if ([[result objectForKey:@"status"] integerValue] == 0) {
                                                               [UserDefaults setBool:YES forKey:ISLogin];
                                                               NSDictionary *subdict = [result objectForKey:@"result"];
                                                               NSString *headimgurl = [subdict objectForKey:@"headimgurl"];
                                                               NSString *nickname = [subdict objectForKey:@"nickname"];
                                                               NSString *userid = [subdict objectForKey:@"id"];
                                                               [UserDefaults setObject:userid forKey:Userid];
                                                               [UserDefaults setObject:headimgurl forKey:IcanUrl];
                                                               [UserDefaults setObject:nickname forKey:Nickname];
                                                               [UserDefaults setObject:subdict[@"subject"] forKey:subject];
                                                               [UserDefaults setObject:subdict[@"amount"] forKey:Useramount];
                                                               [UserDefaults setObject:subdict[@"app_ex_time"] forKey:app_ex_time];
                                                               [UserDefaults setObject:subdict[@"app_t_score"]  forKey:app_t_score];
                                                               [UserDefaults setObject:subdict[@"name"] forKey:Username];
                                                               [UserDefaults setObject:subdict[@"mobile"] forKey:mobile1];
                                                               [UserDefaults setObject:subdict[@"weixin"]  forKey:weixin1];
                                                               [UserDefaults synchronize];
                                                               [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                                                               
                                                               [[NSNotificationCenter defaultCenter] postNotificationName:Noti_Dismiss object:nil];
                                                           }
                                                           if ([[result objectForKey:@"status"] integerValue] == 1) {
                                                               [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                                                           }
                                                           
                                                       } errorBlock:^(NSError *error) {
                                                           
                                                       }];


}

#pragma mark 微信登录
- (void)weixinClick
{
    NSLog(@"微信登录");
    
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc] init];
    
    req.scope = @"snsapi_userinfo" ;
    req.state = @"123" ;
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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

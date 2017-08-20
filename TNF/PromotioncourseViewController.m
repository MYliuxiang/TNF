//
//  PromotioncourseViewController.m
//  TNF
//
//  Created by 李立 on 15/12/22.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "PromotioncourseViewController.h"
#import "MycourseViewController.h"
#import "BypredictiomModel.h"
#import "BypredictiomTeacherModel.h"
#import "LJHongbaoAlertView.h"
#import "BgView4.h"
#import "FuYuanViewController.h"
#import "PersonViewController.h"
#import "LDZMoviePlayerController.h"
#import "BgView3.h"
@interface PromotioncourseViewController ()<LXDelegate,LJDelegate,BgView4delegate,BgView3delegate,UIWebViewDelegate,UIAlertViewDelegate,NetWorkManagerDelegate>
{
    BypredictiomModel *_bypredictiomModel;
    BypredictiomTeacherModel *_bypredictiomTeacherModel;
    UIImageView *bjImageView;
    UIView *view1;
    UIImageView *suoImageView;
    
    UIImageView *touxiangImageView;
    NSArray *_dataArray;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UILabel *label4;
    UILabel *label5;
    UILabel *label6;
    UILabel *label7;
    UILabel *label8;
    UILabel *label9;
    UIButton *lingquButton;
    
    UIView *_VideoView;
    UIView *_BgVideoView;
    UIView *_view;
    UIImageView *_imageView;
    UIImageView *_imageView1;
    UIImageView *_donghuaImageView;
    UIView *_zhegaiView;
    
    UIWebView *_webView;
    
    UIView *view2;
    
    
    BOOL _isdianjidown;
}


@property (nonatomic, strong) UIView *progressView;

@property (nonatomic, strong) AFHTTPRequestOperation *operation;

@property (nonatomic, assign, getter=isNowDownload) BOOL nowDownload;

@property (nonatomic,strong)NetWorkManager *networkManager;
@end

@implementation PromotioncourseViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    //改变导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[MyColor colorWithHexString:@"#0172fe"]];
    

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.nowDownload = NO;
    // 暂停任务
    [LCDownloadManager pauseWithOperation:self.operation];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    _networkManager = [NetWorkManager sharedManager];
    _networkManager.delegate = self;
    [_networkManager startNetWorkeWatch];
    
    //导航栏标题
//    self.text = @"提升课程";
    
    //当前视图的背景视图
    self.view.backgroundColor = UIColor2(灰色背景);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(VideoDonghua) name:Noti_VideoDonghua object:nil];

    _isdianjidown = NO;
    
    [self _initView];
    
    [self _initData];
    
    [self _initDonghuaView];
    
    
}


- (void)_initDonghuaView
{

    _BgVideoView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _BgVideoView.backgroundColor = [UIColor blackColor];
    _BgVideoView.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:_BgVideoView];
    
    _zhegaiView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 170 * ratioHeight)];
    _zhegaiView.backgroundColor = UIColor2(灰色背景);
    _zhegaiView.hidden = YES;
    [self.view addSubview:_zhegaiView];
    
    _VideoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 170 * ratioHeight)];
    _VideoView.backgroundColor = UIColor6(正文小字);
    _VideoView.hidden = YES;
    [self.view addSubview:_VideoView];
    
    
    
    _donghuaImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 170 * ratioHeight)];
    _donghuaImageView.backgroundColor = [UIColor clearColor];
    _donghuaImageView.userInteractionEnabled = YES;
    [_VideoView addSubview:_donghuaImageView];
    
    _view = [[UIView alloc]initWithFrame:CGRectMake((bjImageView.width - 50 * ratioHeight) / 2.0, (bjImageView.height  - 50 * ratioHeight) / 2.0 , 50 * ratioHeight, 50 * ratioHeight)];
    _view.backgroundColor = [UIColor clearColor];
    _view.userInteractionEnabled = YES;
    _view.layer.cornerRadius = 25 *ratioHeight;
    _view.layer.masksToBounds = YES;
    [_VideoView addSubview:_view];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((_view.width - 50 * ratioHeight) / 2.0, (_view.height - 50 * ratioHeight) / 2.0 , 50 * ratioHeight, 50 * ratioHeight)];
    _imageView.image = imageNamed(@"play_icon");
    _imageView.userInteractionEnabled = YES;
    [_view addSubview:_imageView];



}

- (void)_initData
{
    
    [WXDataService requestAFWithURL:Url_getVideoCont params:@{@"id":self.Videoid,@"member_id":[UserDefaults objectForKey:Userid]} httpMethod:@"POST" finishBlock:^(id result) {
        NSLog(@"result==:%@",result);
        if ([[result objectForKey:@"status"] integerValue] == 0) {
            
            //            [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
            NSDictionary *subDic = result[@"result"][@"info"];
            _bypredictiomModel = [[BypredictiomModel alloc]initWithDataDic:subDic];
            NSDictionary *subDic1 = result[@"result"][@"teacher_info"];
            _bypredictiomTeacherModel = [[BypredictiomTeacherModel alloc]initWithDataDic:subDic1];
            self.text = _bypredictiomModel.title;
            _teacherID = _bypredictiomTeacherModel.teacherID;
            _moenyCost = _bypredictiomModel.cost;
            
            [bjImageView sd_setImageWithURL:[NSURL URLWithString:_bypredictiomModel.thumb_cont] placeholderImage:nil];
            
            [_donghuaImageView sd_setImageWithURL:[NSURL URLWithString:_bypredictiomModel.thumb_cont] placeholderImage:nil];
          
            if ([_bypredictiomModel.is_get integerValue] == 1) {
    
                _imageView1.hidden = NO;
                suoImageView.hidden = YES;
                view1.backgroundColor = [UIColor clearColor];
                
                
                
            } else {
                 suoImageView.hidden = NO;
                 _imageView1.hidden = YES;
                view1.backgroundColor = [UIColor whiteColor];
                //未解锁 删除本地
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *docDir = [paths objectAtIndex:0];//
                NSFileManager * fileManager = [[NSFileManager alloc]init];
                [fileManager removeItemAtPath:[docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"/Download/Video/%@%@.mp4",_bypredictiomModel.title,_Videoid]] error:nil];

                
            }
            
            if ([_bypredictiomModel.is_gave integerValue] == 0) {
                [lingquButton setTitle:@"打赏" forState:UIControlStateNormal];
                lingquButton.userInteractionEnabled = YES;
                [lingquButton setBackgroundColor:UIColor3(金色)];
            } else {
                [lingquButton setTitle:@"已打赏" forState:UIControlStateNormal];
                lingquButton.userInteractionEnabled = NO;
                [lingquButton setBackgroundColor:UIColor4(所有的灰色)];
                
            }
            
            TabBarItem *tabBar1 = (TabBarItem *)[self.view viewWithTag:2000];
            if([_bypredictiomModel.is_collection intValue] == 0)
            {
                tabBar1.titleLabel.text = @"收藏";
//                tabBar1.titleLabel.textColor = UIColor6(正文小字);
//                tabBar1.backgroundColor = [UIColor whiteColor];
                tabBar1.titleImageView.image = [UIImage imageNamed:@"star_05"];
                tabBar1.userInteractionEnabled = YES;
                
            } else {
                
                tabBar1.titleLabel.text = @"已收藏";
//                tabBar1.titleLabel.textColor = [UIColor whiteColor];
                tabBar1.titleImageView.image = [UIImage imageNamed:@"star_04"];
//                tabBar1.backgroundColor  =UIColor4(所有的灰色);
                tabBar1.userInteractionEnabled = NO;
            }
            
             TabBarItem *tabBar2 = (TabBarItem *)[self.view viewWithTag:2001];
            if([_bypredictiomModel.is_down integerValue] == 0)
            {
                tabBar2.titleLabel.text = @"下载";
                tabBar2.titleImageView.image = [UIImage imageNamed:@"down_02"];
                tabBar2.titleLabel.textColor = UIColor6(正文小字);
                tabBar2.backgroundColor = UIColor9(白色);
                tabBar2.userInteractionEnabled = YES;
                
                if ([UserDefaults boolForKey:[NSString stringWithFormat:@"%@%@",_bypredictiomModel.title,_Videoid]] == YES) {
                    TabBarItem *tabBar2 = (TabBarItem *)[self.view viewWithTag:2001];
                    tabBar2.titleLabel.text = @"下载中";
                    tabBar2.titleImageView.image = [UIImage imageNamed:@"down_02"];
                    tabBar2.titleLabel.textColor = UIColor6(正文小字);
                    tabBar2.backgroundColor = UIColor9(白色);
                    tabBar2.userInteractionEnabled = NO;
                    [self _downVido];
                }
                
            
            } else {
            
                //判断文件路径是否存在
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *docDir = [paths objectAtIndex:0];
                NSFileManager *fileManager = [NSFileManager defaultManager];
                if ([fileManager fileExistsAtPath:[docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"/Download/Video/%@%@.mp4",_bypredictiomModel.title,_Videoid]]]==YES) {
               
                    NSLog(@"存在");
                    tabBar2.titleLabel.text = @"已下载";
                    tabBar2.titleImageView.image = [UIImage imageNamed:@"down_01"];
                    tabBar2.titleLabel.textColor = [UIColor whiteColor];
                    tabBar2.backgroundColor = UIColorBtn(灰色);
                    tabBar2.userInteractionEnabled = NO;
                    
                    //已下载完了
                    if ([UserDefaults boolForKey:[NSString stringWithFormat:@"%@%@",_bypredictiomModel.title,_Videoid]] == NO) {
                        _progressView.width = kScreenWidth;
                        label9.hidden = NO;
                        label8.hidden = YES;
                        view2.hidden = YES;
//                        label8.text = @"该视频已下载";
                    }


                } else {
                    
                    NSLog(@"不存在");
                    //告诉服务器不存本地视频
                    [self _delCourseViedo];
//                     return;
                }

                
            }
            
            //下部Web
            [_webView loadHTMLString:_bypredictiomModel.content  baseURL:nil];
           
    
            _dataArray = @[@"",@"",@""];
            
        }
        //请求失败
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            
            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
        }
        
        [_promotionTableView reloadData];
        
        
    } errorBlock:^(NSError *error) {
        
    }];
    
}

#pragma mark ---- 告诉服务器本地下载视频不存在了 ------------
- (void)_delCourseViedo
{
   
    [WXDataService requestAFWithURL:Url_delCourseViedo params:@{@"id":_Videoid,@"member_id":[UserDefaults objectForKey:Userid]} httpMethod:@"POST" finishBlock:^(id result) {
        if ([[result objectForKey:@"status"] integerValue] == 0) {
//            [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            [self _initData];
            
        }
        //请求失败
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
        }

    } errorBlock:^(NSError *error) {
        
    }];




}

//初始化视图
-(void)_initView
{

    //创建表视图
    _promotionTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth  , kScreenHeight-64-45) style:UITableViewStyleGrouped];
    _promotionTableView.delegate = self;
    _promotionTableView.dataSource = self;
    _promotionTableView.showsHorizontalScrollIndicator = NO;
    _promotionTableView.showsVerticalScrollIndicator = NO;
    _promotionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _promotionTableView.bounces = YES;
    
    _webView  = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth , 20)];
    _webView.delegate = self;
    _webView.scrollView.bounces = NO;
    _webView.scrollView.scrollEnabled = NO;
    _promotionTableView.tableFooterView = _webView;
    
    //头视图
    _promotionTableView.tableHeaderView = ({
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, (170 + 50) * ratioHeight)];
        headerView.backgroundColor = [UIColor clearColor];
        
        bjImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 170 * ratioHeight)];
//        bjImageView.backgroundColor = UIColor3(金色);
        bjImageView.userInteractionEnabled = YES;
        [headerView addSubview:bjImageView];
        
        
        //遮罩视图lock_01
        view1 = [[UIView alloc]initWithFrame:CGRectMake((bjImageView.width - 50 * ratioHeight) / 2.0, (bjImageView.height - 50 * ratioHeight) / 2.0 , 50 * ratioHeight, 50 * ratioHeight)];
        view1.backgroundColor = [UIColor clearColor];
        view1.userInteractionEnabled = YES;
        view1.layer.cornerRadius = 25 *ratioHeight;
        view1.layer.masksToBounds = YES;
        [headerView addSubview:view1];
        
        _imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake((view1.width - 50 * ratioHeight) / 2.0, (view1.height - 50 * ratioHeight) / 2.0 , 50 * ratioHeight, 50 * ratioHeight)];
        _imageView1.image = imageNamed(@"play_icon");
        _imageView1.hidden = YES;
        _imageView1.userInteractionEnabled = YES;
        [view1 addSubview:_imageView1];
        
        suoImageView = [[UIImageView alloc]initWithFrame:CGRectMake((view1.width - 18 * ratioHeight) / 2.0, (view1.height - 18 * ratioHeight) / 2.0 , 18 * ratioHeight, 18 * ratioHeight)];
        suoImageView.image = imageNamed(@"lock_01");
        suoImageView.hidden = YES;
        suoImageView.userInteractionEnabled = YES;
        [view1 addSubview:suoImageView];
        
        if ([_bypredictiomModel.is_get integerValue] == 1) {
            
            _imageView1.hidden = NO;
            suoImageView.hidden = YES;
            view1.backgroundColor = [UIColor clearColor];
            
        } else {
            suoImageView.hidden = NO;
            _imageView1.hidden = YES;
            view1.backgroundColor = [UIColor whiteColor];
            
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHeader)];
        [bjImageView addGestureRecognizer:tap];
        [view1 addGestureRecognizer:tap];
        
        
        //建议WIFF环境下观看视图
        view2 = [[UIView alloc]initWithFrame:CGRectMake(0, bjImageView.height - 30, kScreenWidth, 30 )];
        view2.backgroundColor = [UIColor blackColor];
        view2.alpha = 0.7;
        [headerView addSubview:view2];
        
        _progressView = [[UIView alloc]initWithFrame:CGRectMake(0, bjImageView.height - 30, 0, 30 )];
        _progressView.backgroundColor = UIColor1(蓝);
        _progressView.alpha = .8;
        [headerView addSubview:_progressView];
        
        //建议WIFF环境下观看
        label8 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, kScreenWidth, 20)];
        label8.text = @"建议Wifi环境下观看";
        label8.hidden = NO;
        label8.font = [UIFont systemFontOfSize:13*ratioHeight];
        label8.textColor = [UIColor whiteColor];
        [view2 addSubview:label8];
        
        label9 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, kScreenWidth, 20)];
        label9.text = @"已下载到本地";
        label9.hidden = YES;
        label9.font = [UIFont systemFontOfSize:13*ratioHeight];
        label9.textColor = [UIColor whiteColor];
        [_progressView addSubview:label9];
        
    
        
        LXSgement *lxsegement  = [[LXSgement alloc]initWithFrame:CGRectMake(0, bjImageView.bottom, kScreenWidth, 45 * ratioHeight) titles:@[@"课程介绍",@"练习题"] normalColor:[UIColor blackColor] selectedColor:UIColor1(蓝) bottomColor:[MyColor colorWithHexString:@"#0172fe"] divisionColor:UIColor2(灰色背景)];
        lxsegement.delegate = self;
        lxsegement.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:lxsegement];

        headerView;
        
    });
    
    [self.view addSubview:_promotionTableView];
    
    NSArray *titiles = @[@"收藏",@"下载"];
    NSArray *images = @[@"star_05",@"down_02"];
    for (int i = 0; i<2; i++) {
        _tab = [[TabBarItem alloc]initWithFrame:CGRectMake(kScreenWidth/2*i, kScreenHeight- 45* ratioHeight - 64, kScreenWidth/2, 45* ratioHeight) imageName:images[i] title:titiles[i]];
        _tab.backgroundColor = UIColor9(白色);
        [_tab addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        _tab.tag = 2000+i;
        [self.view addSubview:_tab];

        _tab.titleLabel.textColor = UIColor6(正文小字);
            
        
        [self.view addSubview:_tab];
    }
    UIView *linview = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2, _tab.top, 1, _tab.height)];
    linview.backgroundColor = UIColor2(灰色背景);
    [self.view addSubview:linview];
}
#pragma mark - NetWorkManagerDelegate
- (void) netWorkStatusWillChange:(NetworkStatus)status
{
    if(status == ReachableViaWiFi)
    {
      
        label8.hidden = YES;
        view2.hidden = YES;
    
    } else {
        
        //判断文件路径是否存在
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDir = [paths objectAtIndex:0];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:[docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"/Download/Video/%@%@.mp4",_bypredictiomModel.title,_Videoid]]]==YES) {
            label8.hidden = YES;
            view2.hidden = YES;
        } else {
            label8.hidden = NO;
            view2.hidden = NO;
        
        }
        
      
    
    }
    
}
//判断wifi
- (void)netWorkStatusWillEnabledViaWifi
{
    label8.hidden = YES;
    view2.hidden = YES;

}

//------------------------- LXDelegate -------------------------------
- (void)clickindex:(int)index
{
    //视频介绍
    if(index == 0){
        
        
    
        
    }
    
    //练习题
    if(index == 1){
        
        PersonViewController *PersonVC = [[PersonViewController alloc]initWithIsHaveSgemengt:NO IshavePlayView:NO Url:Url_getVideoContPracticeList ID:self.Videoid texttitle:@"练习题"];
        PersonVC.ishaveweilian = NO;
        [self.navigationController pushViewController:PersonVC animated:YES];
        
    }
    
}


//返回单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row == 0) {
        return 80*ratioHeight;
        
    }else if ( indexPath.row == 1){
        
        return 90*ratioHeight;
    }else{
        return 35 * ratioHeight;
        
    }
}

//返回多少组表视图
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//每一组返回多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return _dataArray.count;
}

//尾视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}


//创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"Cell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //线条
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(20, 80*ratioHeight - .5, kScreenWidth, .5)];
    lineview.backgroundColor = UIColorFromRGB(0xcccccc);
    [cell.contentView addSubview:lineview];
        
        if (indexPath.row == 0) {
            
            //课程标题
            label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, kScreenWidth-20, 20*ratioHeight)];
            label1.font = [UIFont systemFontOfSize:15*ratioHeight];
            label1.textColor = UIColor5(标题大字);
            label1.text = _bypredictiomModel.title;;
            [cell addSubview:label1];
            
            //主讲老师
            label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, label1.bottom+5, kScreenWidth-20, 20*ratioHeight)];
            label2.font = [UIFont systemFontOfSize:13*ratioHeight];
            label2.textColor = UIColor6(正文小字);
            label2.text = _bypredictiomModel.subtitle;;
            [cell addSubview:label2];
            
         }else if (indexPath.row == 1){
            
            //主讲老师
            label3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 20*ratioHeight)];
            label3.font = [UIFont systemFontOfSize:15*ratioHeight];
            label3.textColor = UIColor6(正文小字);
            label3.text = @"主讲老师";
            [cell addSubview:label3];
            
            //线条
            lineview.frame = CGRectMake(20, 90*ratioHeight - .5, kScreenWidth, .5);
            
            //头像
            touxiangImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, label3.bottom+10, 30*ratioHeight, 30*ratioHeight)];
            touxiangImageView.layer.cornerRadius = 15*ratioHeight;
             touxiangImageView.layer.masksToBounds = YES;
            [touxiangImageView sd_setImageWithURL:[NSURL URLWithString:_bypredictiomTeacherModel.headimgurl] placeholderImage:nil];
            [cell addSubview:touxiangImageView];
            
            //姓名
            label4 = [[UILabel alloc]initWithFrame:CGRectMake(touxiangImageView.right+10, label3.bottom+10, 100, 20)];
             label4.font = [UIFont systemFontOfSize:13*ratioHeight];
             label4.textColor = UIColor6(正文小字);
            label4.text = _bypredictiomTeacherModel.nickname;
            [cell addSubview:label4];
            
            //老师类型
            label5 = [[UILabel alloc]initWithFrame:CGRectMake(touxiangImageView.right+10 , label4.bottom, 100*ratioHeight, 20*ratioHeight)];
            label5.font = [UIFont systemFontOfSize:13*ratioHeight];
            label5.textColor = UIColor6(正文小字);
            label5.text = _bypredictiomTeacherModel.subjectCN;
            [cell addSubview:label5];
            
            
            //打赏老师按钮
            lingquButton = [UIButton buttonWithType:UIButtonTypeCustom];
            lingquButton.frame = CGRectMake(kScreenWidth-80*ratioWidth, 40, 70*ratioWidth, 26*ratioHeight);
//            [lingquButton setTitle:@"打赏" forState:UIControlStateNormal];
//            [lingquButton setBackgroundColor:UIColor3(金色)];
            lingquButton.titleLabel.font = [UIFont systemFontOfSize:13*ratioHeight];
            lingquButton.tag = 10;
            [lingquButton addTarget:self action:@selector(lingquButton:) forControlEvents:UIControlEventTouchUpInside];
            lingquButton.layer.cornerRadius = 13 * ratioHeight;
            
            // 按钮边框宽度
            lingquButton.layer.borderWidth = 0;
            [cell addSubview:lingquButton];
             
             
             if ([_bypredictiomModel.is_gave integerValue] == 0) {
                 [lingquButton setTitle:@"打赏" forState:UIControlStateNormal];
                 lingquButton.userInteractionEnabled = YES;
                 [lingquButton setBackgroundColor:UIColor3(金色)];
             } else {
                 [lingquButton setTitle:@"已打赏" forState:UIControlStateNormal];
                 lingquButton.userInteractionEnabled = NO;
                 [lingquButton setBackgroundColor:UIColorBtn(灰色)];
                 
             }

            
        }else{
            
            lineview.alpha = 0;
            
            //内容概述
            label6 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth, 15*ratioHeight)];
            label6.textColor = UIColor6(正文小字);
            label6.font = [UIFont systemFontOfSize:15*ratioHeight];
            label6.text = @"内容概述";
            [label6 sizeToFit];
            [cell addSubview:label6];
            
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(label6.left, label6.bottom + 10, label6.width, .5)];
            line.backgroundColor = UIColor3(金色);
            [cell addSubview:line];

            
            //概述内容
//            label7 = [[UILabel alloc]initWithFrame:CGRectMake(10, label6.bottom, kScreenWidth-20, 100*ratioHeight)];
//            label7.numberOfLines = 0;
//            NSString * string1 = _bypredictiomModel.content;
//            label7.text = string1;
//            label7.font = [UIFont systemFontOfSize:13*ratioHeight];
//            label7.textColor = UIColor6(正文小字);
//            CGSize size1 = CGSizeMake(kScreenWidth-20, 10000);
//            CGSize labelsize = [string1 sizeWithFont:[UIFont systemFontOfSize:13*ratioHeight] constrainedToSize:size1];
//            [label7 setFrame:CGRectMake(10, label6.bottom, kScreenWidth-20, (labelsize.height)*ratioHeight)];
//            [cell addSubview:label7];
            
            
        }
    
    return cell;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    int height = [height_str intValue];
    _webView.height = height + 20;
    _promotionTableView.tableFooterView = _webView;
    NSLog(@"height: %@", [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"]);
    
}

//单元格点击事件

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];// 取消选中
    
    
    
}


//打赏按钮点击事件
-(void)lingquButton:(UIButton *)button
{
    NSLog(@"打赏");
    [WXDataService requestAFWithURL:Url_getGaveTeacher params:nil httpMethod:@"POST" finishBlock:^(id result) {
        NSLog(@"result==:%@",result);
        if ([[result objectForKey:@"status"] integerValue] == 0) {
            
            NSDictionary *subDic = result[@"result"];
            NSArray *array = subDic[@"list"];
            
            NSMutableArray *muArray = [NSMutableArray new];
            for (int i = 0;i < array.count; i ++) {
                [muArray addObject:[NSString stringWithFormat:@"%@",array[i]]];
            }
            NSArray * array1 = muArray;
            
            LJHongbaoAlertView *liView = [[LJHongbaoAlertView alloc]initWithFrame:CGRectMake(20 * ratioWidth, (kScreenHeight - 195 * ratioHeight ) / 2.0, kScreenWidth  - 20 * ratioWidth * 2 , 195 * ratioHeight) monenyArray:array1 title:subDic[@"title"] text:subDic[@"text"] delegate:self];
            [self.view addSubview:liView];
        }
        //请求失败
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            
            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
        }
    } errorBlock:^(NSError *error) {
        
    }];
}

#pragma mark -------LJDelegale ---------------------
- (void)selecetmoeny:(NSString *)moeny
{
    
    [WXDataService requestAFWithURL:Url_setGaveTeacher params:@{@"cost":moeny,@"teacher_id":_teacherID,@"id":_Videoid,@"member_id":[UserDefaults objectForKey:Userid]} httpMethod:@"POST" finishBlock:^(id result) {
        NSLog(@"result==:%@",result);
        if ([[result objectForKey:@"status"] integerValue] == 0) {
            [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
            [self _initData];
        }
        //请求失败
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            if(result[@"result"] != nil && ![result[@"result"] isKindOfClass:[NSNull class]])
            {
                    BgView4 *view = [[BgView4 alloc]initWithFrame:CGRectMake(20 * ratioWidth, (kScreenHeight - 180 * ratioHeight ) / 2.0, kScreenWidth  - 20 * ratioWidth * 2 , 180 * ratioHeight) Title:@"您的福币不够了" Delegate:self Mycost:@"" Cost:[NSString stringWithFormat:@"你目前拥有%@个福币",result[@"result"][@"amount"]]];
                    [self.view addSubview:view];
            } else {
                
                [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];

            }

    
            
        }
        
    } errorBlock:^(NSError *error) {
        
    }];
    
}

//------获取福币  BgView4delegate-----
- (void)selecetbtn
{
    FuYuanViewController * fuFuYuan = [[FuYuanViewController alloc]init];
    [self.navigationController pushViewController:fuFuYuan animated:YES];
    
    
}

//收藏，下载
-(void)tapAction:(TabBarItem *)tab
{
    if (tab.tag == 2000) {
        NSLog(@"收藏");
        [WXDataService requestAFWithURL:Url_collectionCourse params:@{@"teacher_id":_bypredictiomTeacherModel.teacherID,@"id":_Videoid,@"member_id":[UserDefaults objectForKey:Userid]} httpMethod:@"POST" finishBlock:^(id result) {
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
      
    }else{
        NSLog(@"下载");
        
        //是否购买
        if ([_bypredictiomModel.is_get integerValue] == 0) {
           
            UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您尚未购买此视频，请先购买" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [aler show];
        
        } else {
            
            if (_isdianjidown == NO) {
                 _isdianjidown = YES;
                tab.titleLabel.text = @"下载中";
                tab.titleImageView.image = [UIImage imageNamed:@"down_02"];
                tab.titleLabel.textColor = UIColor6(正文小字);
                tab.backgroundColor = UIColor9(白色);
                tab.userInteractionEnabled = NO;
                [UserDefaults setBool:YES forKey:[NSString stringWithFormat:@"%@%@",_bypredictiomModel.title,_Videoid]];
                 [self _downVido];
                
                
            }
           
           
        
        }
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        //解锁
        BgView3 *bgView3 = [[BgView3 alloc]initWithFrame:self.view.bounds Title:@"解锁课程" ImgName:nil bgviewdelegate:self Text:_moenyCost Text1:[NSString stringWithFormat:@"使用福币解锁课程 \n有效期%@天",_bypredictiomModel.endtime]];
        [self.view addSubview:bgView3];
        
    }


}


#pragma mark ------  视频下载 ---------------------
- (void)_downVido
{
    
    // 禁止重复下载
    if (self.isNowDownload) return;
    
      self.nowDownload = YES;

     //@"http://mw2.dwstatic.com/2/8/1528/133366-99-1436362095.mp4"
       self.operation = [LCDownloadManager downloadFileWithURLString:_bypredictiomModel.video cachePath:[NSString stringWithFormat:@"%@%@.mp4",_bypredictiomModel.title,_Videoid] progress:^(CGFloat progress, CGFloat totalMBRead, CGFloat totalMBExpectedToRead) {
        
//        NSLog(@"Task2 -> progress: %.2f -> download: %fMB -> all: %fMB", progress, totalMBRead, totalMBExpectedToRead);
    
           dispatch_async(dispatch_get_main_queue(), ^{
               
               //回调通知主线程刷新，
              self.progressView.width = progress *kScreenWidth;
               
           });
           

        
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.nowDownload = NO;
        // 暂停任务
        [LCDownloadManager pauseWithOperation:self.operation];
        
        [UserDefaults setBool:NO forKey:[NSString stringWithFormat:@"%@%@",_bypredictiomModel.title,_Videoid]];
      
        [self downfinish];

        
        
        NSLog(@"Task2 -> Download finish");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        //删除本地视频路径
        _isdianjidown = NO;
        self.progressView.width = 0;
        [MBProgressHUD showError:@"下载失败" toView:[UIApplication sharedApplication].keyWindow];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDir = [paths objectAtIndex:0];//
        NSFileManager * fileManager = [[NSFileManager alloc]init];
        [fileManager removeItemAtPath:[docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"/Download/Video/%@%@.mp4",_bypredictiomModel.title,_Videoid]] error:nil];

        if (error.code == -999) NSLog(@"Task2 -> Maybe you pause download.");
        [UserDefaults setBool:NO forKey:[NSString stringWithFormat:@"%@%@",_bypredictiomModel.title,_Videoid]];
        
        [self _initData];
        
        NSLog(@"Task2 -> %@", error);
    }];

}

#pragma  mark ------- 下载完成的回调 --------------
- (void)downfinish
{

    [WXDataService requestAFWithURL:Url_downloadCourseViedo params:@{@"id":_Videoid,@"member_id":[UserDefaults objectForKey:Userid]} httpMethod:@"POST" finishBlock:^(id result) {
        
        if ([[result objectForKey:@"status"] integerValue] == 0) {
            
            [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
            [UserDefaults setBool:NO forKey:[NSString stringWithFormat:@"%@%@",_bypredictiomModel.title,_Videoid]];
            
            [self _initData];
        }
        //请求失败
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            self.progressView.width = 0;
            _isdianjidown = NO;
            //删除本地视频路径
            [MBProgressHUD showError:@"下载失败" toView:[UIApplication sharedApplication].keyWindow];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *docDir = [paths objectAtIndex:0];//
            NSFileManager * fileManager = [[NSFileManager alloc]init];
            [fileManager removeItemAtPath:[docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"/Download/Video/%@%@.mp4",_bypredictiomModel.title,_Videoid]] error:nil];
            [UserDefaults setBool:NO forKey:[NSString stringWithFormat:@"%@%@",_bypredictiomModel.title,_Videoid]];
            
            [self _initData];
            
        }
        
        
    } errorBlock:^(NSError *error) {
        
    }];
    
}

//头试图点击
- (void)tapHeader
{
    //播放
    if ([_bypredictiomModel.is_get integerValue] == 1) {
        
        _BgVideoView.alpha = .5;
        _zhegaiView.hidden = NO;
        [UIView animateWithDuration:.5 animations:^{
            _VideoView.hidden = NO;
            _VideoView.top = kScreenHeight / 2.0 - _VideoView.height / 2.0 - 64;
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:.5 animations:^{
                _VideoView.width = kScreenWidth;
                _VideoView.height = kScreenHeight;
//                _imageView.center = CGPointMake(kScreenWidth / 2.0, (kScreenHeight ) / 2.0);
                _donghuaImageView.center = CGPointMake(kScreenWidth / 2.0, kScreenHeight / 2.0);
                _view.center = CGPointMake(kScreenWidth / 2.0, (kScreenHeight ) / 2.0);
                _VideoView.center = CGPointMake(kScreenWidth / 2.0, (kScreenHeight ) / 2.0);
           
            } completion:^(BOOL finished) {
                   _BgVideoView.alpha = 0;
                    LDZMoviePlayerController *moviewPlayerVC = [[LDZMoviePlayerController alloc] init];
        
                //是否下载（未下载）
                if ([_bypredictiomModel.is_down integerValue] == 0) {
                  
                    NSURL *URL = [NSURL URLWithString: _bypredictiomModel.video];
                    moviewPlayerVC.movieURL = URL;
               
                } else {
                
                    // 播放本地
                    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                    NSString *docDir = [paths objectAtIndex:0];
                    moviewPlayerVC.movieURL = [NSURL fileURLWithPath:[docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"/Download/Video/%@%@.mp4",_bypredictiomModel.title,_Videoid]]];
                }
           

////                //删除本地视频路径
//                NSFileManager * fileManager = [[NSFileManager alloc]init];
//                [fileManager removeItemAtPath:[docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"/Download/Video/%@%@.mp4",_bypredictiomModel.title,_Videoid]] error:nil];
                
            
//                      播放网络
//                    NSString *urlString = @"http://mw2.dwstatic.com/2/8/1528/133366-99-1436362095.mp4";
        
               
                [self presentViewController:moviewPlayerVC animated:NO completion:nil];
            }];
            
        }];
        
        


    //解锁
    } else {
        
        BgView3 *bgView3 = [[BgView3 alloc]initWithFrame:self.view.bounds Title:@"解锁课程" ImgName:nil bgviewdelegate:self Text:_moenyCost Text1:[NSString stringWithFormat:@"使用福币解锁课程 \n有效期%@天",_bypredictiomModel.endtime]];
        [self.view addSubview:bgView3];
    
    }
}

//通知动画
- (void)VideoDonghua
{
     _BgVideoView.alpha = .5;
    [UIView animateWithDuration:.5 animations:^{
        _VideoView.width = kScreenWidth;
        _VideoView.height = 170 * ratioHeight;
        _donghuaImageView.center = _VideoView.center;
        _view.center = _VideoView.center;
        _VideoView.center = CGPointMake(kScreenWidth / 2.0, (kScreenHeight ) / 2.0);
        
    } completion:^(BOOL finished) {
         [UIView animateWithDuration:.5 animations:^{
             _VideoView.top = 0;
             
         } completion:^(BOOL finished) {
             _VideoView.hidden = YES;
             _BgVideoView.alpha = 0;
             _zhegaiView.hidden = YES;
         }];
    }];
    
    
    
}


#pragma mark ------ bgView3代理 ----------------
- (void)lingquClik
{
    
    [WXDataService requestAFWithURL:Url_unlockVideo params:@{@"cost":_moenyCost,@"teacher_id":_teacherID,@"id":_Videoid,@"member_id":[UserDefaults objectForKey:Userid]} httpMethod:@"POST" finishBlock:^(id result) {
        NSLog(@"result==:%@",result);
        if ([[result objectForKey:@"status"] integerValue] == 0) {
            [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            [self clickOK];
         
        }
        //请求失败
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            BgView4 *view = [[BgView4 alloc]initWithFrame:CGRectMake(20 * ratioWidth, (kScreenHeight - 180 * ratioHeight ) / 2.0, kScreenWidth  - 20 * ratioWidth * 2 , 180 * ratioHeight) Title:@"您的福币不够了" Delegate:self Mycost:[NSString stringWithFormat:@"你目前拥有%@个福币",result[@"result"][@"amount"]] Cost:[NSString stringWithFormat:@"解锁本课程需%@个福币",_moenyCost]];
            [self.view addSubview:view];
            
            
            //            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
        }
        
    } errorBlock:^(NSError *error) {
        
    }];

}

- (void)clickOK
{
    // 完成
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 65 * ratioHeight) / 2.0, kScreenHeight - 20 * ratioHeight - 65 * ratioHeight - 64, 65 * ratioHeight, 65 * ratioHeight)];
    
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 65 / 2.0 * ratioHeight;
    imageView.backgroundColor = UIColor3(金色);
    [self.view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, imageView.width, imageView.height / 2.0)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15 * ratioHeight];
    label.text = [NSString stringWithFormat:@"-%@",_moenyCost];
    [imageView addSubview:label];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake((imageView.width - imageView.width / 2.0) / 2.0, imageView.height / 2.0 - 10, imageView.width / 2.0, imageView.height / 2.0)];
    imageView1.contentMode = UIViewContentModeScaleAspectFit;
    imageView1.image = [UIImage imageNamed:@"photo_01"];
    [imageView addSubview:imageView1];
    
    
    [UIView animateWithDuration:.5 animations:^{
//        imageView.frame = CGRectMake((kScreenWidth - 65 * ratioHeight) / 2.0, kScreenHeight - 20 * ratioHeight - 65 * ratioHeight - 64, 65 * ratioHeight, 65 * ratioHeight);
        
         imageView.frame =  CGRectMake((kScreenWidth - 65 * ratioHeight) / 2.0, kScreenHeight - 20 * ratioHeight - 65 * ratioHeight - 64 - 65 * ratioHeight * 2, 65 * ratioHeight, 65 * ratioHeight);
        
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
        [self _initData];
    }];
    
    
    
    
    


}

@end


//
//  OralController.m
//  TNF
//
//  Created by 刘翔 on 15/12/21.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "OralController.h"
#import "HADirect.h"
#import "MachineController.h"
#import "ClassController.h"
#import "TPOController.h"
#import "Oralbanner.h"
#import "OralList.h"
#import "TrainingrecordViewController.h"
#import "TiShengViewController.h"
#import "MycourseViewController.h"
#import "WebViewController.h"
#import "DCWebImageManager.h"
#import "BypredictingViewController.h"
#import "PromotioncourseViewController.h"




@implementation OralController


- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[MyColor colorWithHexString:@"#0172fe"]];
    
}




- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}


- (void)viewDidLoad{
    
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:[MyColor colorWithHexString:@"#0172fe"]];
    
    self.text = @"口语练习";
    
    
    //左边的导航蓝按钮
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0,9 , 3, 13)];
    imageV.image = [UIImage imageNamed:@"点点点"];
    [view addSubview:imageV];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(6, 0, 30, 30)];
    imageView.backgroundColor = [UIColor clearColor];
    
    [imageView sd_setImageWithURL:[[NSUserDefaults standardUserDefaults] objectForKey:IcanUrl] ];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 15;
    imageView.userInteractionEnabled = YES;
    [view addSubview:imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [view addGestureRecognizer:tap];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.leftBarButtonItems = @[item];
    
    
    
    //右边的导航兰按钮
    //我的咨询
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(0, 0, 80, 20);
    [left setTitleColor:[MyColor colorWithHexString:@"#f0f0f0"] forState:UIControlStateNormal];
    [left setTitle:@"我的练习" forState:UIControlStateNormal];
    [left addTarget:self action:@selector(lianxi:) forControlEvents:UIControlEventTouchUpInside];
    left.titleLabel.font  = [UIFont boldSystemFontOfSize:18];
    [left.titleLabel sizeToFit];
    [rightView addSubview:left];
    
    
//    UILabel *_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 8, 8)];
//    _label.center = CGPointMake(left.right, left.top);
//    _label.backgroundColor = [UIColor redColor];
//    _label.layer.cornerRadius = 4;
//    _label.layer.masksToBounds = YES;
////    [rightView addSubview:_label];
    
    UIBarButtonItem *Item = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    
    UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSeperator.width = -12;
    self.navigationItem.rightBarButtonItems = @[negativeSeperator,Item];
    self.view.backgroundColor = [UIColor whiteColor];
    [self _loadData];

}



- (void)_loadData
{
    
    _banners = [NSMutableArray array];
    _listarray = [NSMutableArray array];
    NSString *useid = [UserDefaults objectForKey:Userid];
    NSDictionary *params = @{@"member_id":useid};
    [WXDataService requestAFWithURL:Url_oralPractice params:params httpMethod:@"POST" finishBlock:^(id result) {
        if(result){
            NSLog(@"ggggg%@",result);
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                return;
            }

            NSDictionary *dic = result[@"result"];
            NSArray *array = dic[@"banner"];
            for (int i = 0; i < array.count; i++) {
                Oralbanner *banner = [[Oralbanner alloc] initWithDataDic:array[i]];
                [self.banners addObject:banner];
            }
            NSArray *array1 = dic[@"list"];
            for ( int i = 0; i< array1.count; i++) {
                OralList *list = [[OralList alloc] initWithDataDic:array1[i]];
                [self.listarray addObject:list];
            }
            
            [self _initViews];
            
            
            
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
    
}

- (void)_initViews
{
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    NSMutableArray *marray = [NSMutableArray array];
    for (int i = 0; i < self.banners.count; i++) {
    Oralbanner *banner = self.banners[i];
        [marray addObject:banner.thumb];
    
    }
    DCPicScrollView *picView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 160 * ratioHeight) WithImageUrls:marray];
    [scrollView addSubview:picView];
    [picView setImageViewDidTapAtIndex:^(NSInteger index) {

        Oralbanner *recommeDic = self.banners[index];
        NSString *type = recommeDic.type;
        NSString *ID = recommeDic.relationid;
        NSString *title = recommeDic.title;
        NSString *url = recommeDic.url;
        /*
         type类型  array(1=>"机经",2=>"分类",3=>"TPO",4=>"课程",5=>"讲座",6=>"题目",7=>"链接");
         url链接 只有当类型为链接时才有值
         */
        //"机经
        if ([type integerValue] == 1) {
            //机经预测
            MachineController *machineVC = [[MachineController alloc] init];
            [self.navigationController pushViewController:machineVC animated:YES];
            
        }
        //2=>"分类"
        if ([type integerValue] == 2) {
            //分类练习
            ClassController *classVC = [[ClassController alloc] init];
            [self.navigationController pushViewController:classVC animated:YES];
            
        }
        //3=>"TPO
        if ([type integerValue] == 3) {
            //TPO真题
            TPOController *tpoVC = [[TPOController alloc] init];
            [self.navigationController pushViewController:tpoVC animated:YES];
            
        }
        //4=>"课程"
        if ([type integerValue] == 4) {
            
            PromotioncourseViewController *promoVC = [[PromotioncourseViewController alloc]init];
            promoVC.Videoid = ID;
            [self.navigationController pushViewController:promoVC animated:YES];
            
        }
        //5=>"讲座
        if ([type integerValue] == 5) {
            BypredictingViewController *bypredictingVC = [[BypredictingViewController alloc]init];
            bypredictingVC.ID = ID;
            [self.navigationController pushViewController:bypredictingVC animated:YES];
        }
        //6=>"题目"
        if ([type integerValue] == 6) {
            
            
            MycourseViewController *mycourseVC = [[MycourseViewController alloc]init];
            [self.navigationController pushViewController:mycourseVC animated:YES];
            
        }
        if ([type integerValue] == 7) {
            
            WebViewController *webVC = [[WebViewController alloc] init];
            webVC.text = title;
            webVC.url =  url;
            [self.navigationController pushViewController:webVC animated:YES];
        }

        
    }];
    
    
    //下载失败重复下载次数,默认不重复,
    [[DCWebImageManager shareManager] setDownloadImageRepeatCount:1];
    
    //图片下载失败会调用该block(如果设置了重复下载次数,则会在重复下载完后,假如还没下载成功,就会调用该block)
    //error错误信息
    //url下载失败的imageurl
    [[DCWebImageManager shareManager] setDownLoadImageError:^(NSError *error, NSString *url) {
        NSLog(@"%@",error);
    }];

//    NSMutableArray *marrayView = [NSMutableArray array];
//    for (int i = 0; i < self.banners.count; i++) {
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth , 160 * ratioHeight)];
//        Oralbanner *banner = self.banners[i];
//        [imageView sd_setImageWithURL:[NSURL URLWithString:banner.thumb]];
//        [marrayView addObject:imageView];
//    }
//    
//    
//    __weak OralController *this = self;
//    HADirect *headView = [HADirect direcWithtFrame:CGRectMake(0, 0, kScreenWidth, 160 * ratioHeight) ViewArr:marrayView];
//    headView.time = 3.0;
//    
//    headView.clickBlock = ^(NSInteger index){
//        
//        [this clickIndex:index];
//        
//    };
//    [scrollView addSubview:headView];
    
    
    NSArray *imageNames = @[@"practiceli_01",@"practiceli_02",@"practiceli_03"];
    for (int i = 0; i < self.listarray.count; i++) {
        OralList *list = self.listarray[i];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(10, 170 * ratioHeight + i * (100 + 10)* ratioHeight, kScreenWidth - 20, 100 * ratioHeight);
        [imageView sd_setImageWithURL:[NSURL URLWithString:list.thumb]];
//        imageView.backgroundColor = [UIColor grayColor];
        imageView.tag = 100 + i;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickkaoshi:)];
        [imageView addGestureRecognizer:tap];
        [scrollView addSubview:imageView];
        
        
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30 * ratioHeight, 20 * ratioHeight, 20* ratioHeight)];
        imageView1.image = [UIImage imageNamed:imageNames[i]];
        [imageView addSubview:imageView1];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 30 * ratioHeight, kScreenWidth - 20 - 70, 17)];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:17];
        label.text = list.title;
        [imageView addSubview:label];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(60, label.bottom + 5 * ratioHeight, kScreenWidth - 20 - 70, 15)];
        label1.textColor = [UIColor whiteColor];
        label1.font = [UIFont systemFontOfSize:15];
        label1.text = list.text;
        [imageView addSubview:label1];
        if([list.is_show boolValue]){
            imageView.hidden = NO;
        }else{
        
            imageView.hidden = YES;
        }

        
    }
    
    
}

#pragma mark ---------------三个点击事件 机经 分类  TPO-------------
- (void)clickkaoshi:(UITapGestureRecognizer *)sender
{
    UIImageView *imageView = (UIImageView *)sender.view;
    int index = (int)imageView.tag;
    if (index == 100) {
        //机经预测
        MachineController *machineVC = [[MachineController alloc] init];
        [self.navigationController pushViewController:machineVC animated:YES];
        
        
    }else if (index == 101){
        //分类练习
        ClassController *classVC = [[ClassController alloc] init];
        [self.navigationController pushViewController:classVC animated:YES];
        
    }else{
        //TPO真题
        TPOController *tpoVC = [[TPOController alloc] init];
        [self.navigationController pushViewController:tpoVC animated:YES];
        
    }
    
    
}

#pragma mark -------我的练习---------
- (void)lianxi:(UIButton *)button
{
    
    TrainingrecordViewController *vc = [[TrainingrecordViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//头像的点击事件
- (void)tap
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}


@end

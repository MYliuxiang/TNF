//
//  BypredictingViewController.m
//  TNF
//
//  Created by 李立 on 15/12/21.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "BypredictingViewController.h"
#import "MycourseViewController.h"
#import "BypredictiomModel.h"
#import "BypredictiomTeacherModel.h"
#import "LJHongbaoAlertView.h"
#import "BgView4.h"
#import "FuYuanViewController.h"
@interface BypredictingViewController ()<LJDelegate,BgView4delegate,UIWebViewDelegate>
{
    BypredictiomModel *_bypredictiomModel;
    BypredictiomTeacherModel *_bypredictiomTeacherModel;
    UIImageView *_headerImageview;
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
    UILabel *label10;
    UIButton *lingquButton;
    
    UIWebView *_webView;

}
@end

@implementation BypredictingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //导航栏标题
//    self.text = @"机经预测专题讲座";
    
    //当前视图的背景视图
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化视图
    [self _initView];
    
    [self _initData];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    //改变导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[MyColor colorWithHexString:@"#0172fe"]];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    if ([self.delegate respondsToSelector:@selector(suanxinDown)]) {
          [self.delegate suanxinDown];
    }
  

}
- (void)_initData
{

    [WXDataService requestAFWithURL:Url_getLectureCont params:@{@"id":self.ID,@"member_id":[UserDefaults objectForKey:Userid]} httpMethod:@"POST" finishBlock:^(id result) {
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
            
            [_headerImageview sd_setImageWithURL:[NSURL URLWithString:_bypredictiomModel.thumb_cont] placeholderImage:nil];
            
            if ([_bypredictiomModel.is_gave integerValue] == 0) {
                [lingquButton setTitle:@"打赏" forState:UIControlStateNormal];
                lingquButton.userInteractionEnabled = YES;
                [lingquButton setBackgroundColor:UIColor3(金色)];
            } else {
                [lingquButton setTitle:@"已打赏" forState:UIControlStateNormal];
                lingquButton.userInteractionEnabled = NO;
                [lingquButton setBackgroundColor:UIColor4(所有的灰色)];
                
            }
            
            TabBarItem *tabBar = (TabBarItem *)[self.view viewWithTag:101];
            tabBar.hidden = NO;
            if([_bypredictiomModel.is_get intValue] == 0)
            {
                tabBar.titleLabel.text = @"报名";
                tabBar.backgroundColor = UIColor1(蓝);
                tabBar.userInteractionEnabled = YES;
        
            } else {
              
                tabBar.titleLabel.text = @"已报名";
                tabBar.backgroundColor = UIColorBtn(灰色);
                tabBar.userInteractionEnabled = NO;
            }
            
            TabBarItem *tabBar1 = (TabBarItem *)[self.view viewWithTag:100];
            tabBar1.hidden = NO;
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
            if ([_bypredictiomModel.is_get integerValue] == 1) {
                label5.text = _bypredictiomModel.address;
            } else {
                label5.text = @"(报名后显示地址)";
            }
            
             [_webView loadHTMLString:_bypredictiomModel.content  baseURL:nil];
        
            _dataArray = @[@"",@"",@""];
            
        }
        //请求失败
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
          
            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
        }
        
        [_bypredictiTabelView reloadData];

        
    } errorBlock:^(NSError *error) {
    
    }];


}

//初始化视图
-(void)_initView
{
    //创建表视图
    _bypredictiTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight-64-45*ratioHeight) style:UITableViewStyleGrouped];
    _bypredictiTabelView.delegate = self;
    _bypredictiTabelView.dataSource = self;
    _bypredictiTabelView.showsHorizontalScrollIndicator = NO;
    _bypredictiTabelView.showsVerticalScrollIndicator = NO;
    _bypredictiTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _bypredictiTabelView.bounces = YES;
    
    _webView  = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth , 20)];
    _webView.delegate = self;
    _webView.scrollView.bounces = NO;
    _webView.scrollView.scrollEnabled = NO;
    _bypredictiTabelView.tableFooterView = _webView;
    
    //头视图
    _bypredictiTabelView.tableHeaderView = ({
        _headerImageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 170 * ratioHeight)];
        _headerImageview.backgroundColor = [UIColor clearColor];
        _headerImageview;
        
    });

    [self.view addSubview:_bypredictiTabelView];
    
//    NSArray *titiles = @[@"收藏",@"报名"];
    NSArray *images = @[@"star_05",@""];
//    NSArray *colors = @[UIColor9(白色),UIColor1(蓝)];
    for (int i = 0; i<2; i++) {
        _tab.hidden = YES;
        _tab = [[TabBarItem alloc]initWithFrame:CGRectMake(kScreenWidth/2*i, kScreenHeight- 45* ratioHeight - 64, kScreenWidth/2, 45* ratioHeight) imageName:images[i] title:@""];
        _tab.backgroundColor = [UIColor clearColor];
        [_tab addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        _tab.tag = 100+i;
        if (_tab.tag == 100) {
            _tab.titleLabel.textColor = UIColor6(正文小字);
        }
        [self.view addSubview:_tab];
    }
    
}


//返回单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if (indexPath.row == 0) {
        return (270/2.0)*ratioHeight;

    }else if ( indexPath.row == 1){
    
        return 90*ratioHeight;
        
    }else{
        
        return 35 *ratioHeight;
    
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
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(20, (270/2.0)*ratioHeight - .5, kScreenWidth, .5)];
    lineview.backgroundColor = UIColorFromRGB(0xcccccc);
    [cell.contentView addSubview:lineview];
    
    if (indexPath.row == 0) {
        
        //课程标题
        label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, kScreenWidth-20, 20)];
        label1.font = [UIFont systemFontOfSize:15*ratioHeight];
        label1.textColor = UIColor5(标题大字);
        label1.text = _bypredictiomModel.title;
        [cell addSubview:label1];
        
        //主讲老师
        label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, label1.bottom+15, kScreenWidth-20, 20*ratioHeight)];
        label2.font = [UIFont systemFontOfSize:13*ratioHeight];
        label2.textColor = UIColor6(正文小字);
        label2.text = [NSString stringWithFormat:@"主讲老师：%@",_bypredictiomTeacherModel.nickname];
        [cell addSubview:label2];
        
        //课程安排
        label3 = [[UILabel alloc]initWithFrame:CGRectMake(10, label2.bottom, kScreenWidth-20, 20*ratioHeight)];
        label3.font = [UIFont systemFontOfSize:13*ratioHeight];
        label3.textColor = UIColor6(正文小字);
        label3.text = _bypredictiomModel.subtitle; // @"课程安排: 2015.12.148:00-9:00";
        [cell addSubview:label3];
        
        //上课方式
        label4 = [[UILabel alloc]initWithFrame:CGRectMake(10, label3.bottom + 5, 150*ratioHeight, 20*ratioHeight)];
        label4.font = [UIFont systemFontOfSize:13*ratioHeight];
        label4.textColor = UIColor6(正文小字);
        label4.text = [NSString stringWithFormat:@"上课方式：%@",_bypredictiomModel.class_mode];
        [cell addSubview:label4];
        [label4 sizeToFit];
        
        //报名后显示地址
        label5 = [[UILabel alloc]initWithFrame:CGRectMake(label4.right, label4.top, kScreenWidth- label4.right - 10, 20*ratioHeight)];
        label5.font = [UIFont systemFontOfSize:13*ratioHeight];
        label5.textAlignment = NSTextAlignmentLeft;
        label5.textColor = UIColor1(蓝);
        if ([_bypredictiomModel.is_get integerValue] == 1) {
            label5.text = [NSString stringWithFormat:@"(%@)",_bypredictiomModel.address] ;
        } else {
            label5.text = @"(报名后显示地址)";
        }
        
        [cell addSubview:label5];
        
        [label5 sizeToFit];

    }else if (indexPath.row == 1){
    
        //主讲老师
        label6 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 20*ratioHeight)];
        label6.font = [UIFont systemFontOfSize:15*ratioHeight];
        label6.textColor = UIColor6(正文小字);
        label6.text = @"主讲老师";
        [cell addSubview:label6];
        
        //线条
        lineview.frame = CGRectMake(20, 90*ratioHeight - .5, kScreenWidth, .5);

        touxiangImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, label6.bottom+10, 30*ratioHeight, 30*ratioHeight)];
         touxiangImageView.layer.cornerRadius = 15*ratioHeight;
//             touxiangImageView.backgroundColor = UIColor3(金色);
        touxiangImageView.layer.masksToBounds = YES;
        [touxiangImageView sd_setImageWithURL:[NSURL URLWithString:_bypredictiomTeacherModel.headimgurl] placeholderImage:nil];
        [cell addSubview:touxiangImageView];
        
       

        //姓名
        label7 = [[UILabel alloc]initWithFrame:CGRectMake(touxiangImageView.right+10, label6.bottom+10, 100*ratioHeight, 20*ratioHeight)];
        label7.font = [UIFont systemFontOfSize:13*ratioHeight];
        label7.textColor = UIColor6(正文小字);
        label7.text = _bypredictiomTeacherModel.nickname;
        [cell addSubview:label7];
        
        //老师类型
        label8 = [[UILabel alloc]initWithFrame:CGRectMake(touxiangImageView.right+10 , label7.bottom, 100*ratioHeight, 20*ratioHeight)];
        label8.font = [UIFont systemFontOfSize:13*ratioHeight];
        label8.textColor = UIColor6(正文小字);
        label8.text = _bypredictiomTeacherModel.subjectCN;;
        [cell addSubview:label8];
        
        
        //打赏老师按钮
        lingquButton = [UIButton buttonWithType:UIButtonTypeCustom];
        lingquButton.frame = CGRectMake(kScreenWidth-70*ratioHeight, 40, 60*ratioHeight, 25*ratioHeight);
        lingquButton.titleLabel.font = [UIFont systemFontOfSize:13*ratioHeight];
        lingquButton.tag = 10;
        [lingquButton addTarget:self action:@selector(lingquButton:) forControlEvents:UIControlEventTouchUpInside];
        lingquButton.layer.cornerRadius = 13;
        
        // 按钮边框宽度
        lingquButton.layer.borderWidth = 0;
        lingquButton.hidden = YES;
        [cell addSubview:lingquButton];
        
        
        
        if ([_bypredictiomModel.is_gave integerValue] == 0) {
            [lingquButton setTitle:@"打赏" forState:UIControlStateNormal];
            lingquButton.userInteractionEnabled = YES;
            [lingquButton setBackgroundColor:UIColor3(金色)];
        } else {
            [lingquButton setTitle:@"已打赏" forState:UIControlStateNormal];
            lingquButton.userInteractionEnabled = NO;
            [lingquButton setBackgroundColor:UIColor4(所有的灰色)];
            
        }


    }else{
    
        lineview.alpha = 0;
        
        //内容概述
        label9 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth, 15*ratioHeight)];
        label9.textColor = UIColor6(正文小字);
        label9.font = [UIFont systemFontOfSize:15*ratioHeight];
        label9.text = @"内容概述";
        [label9 sizeToFit];
        [cell addSubview:label9];
        
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(label9.left, label9.bottom + 10, label9.width, .5)];
        line.backgroundColor = UIColor3(金色);
        [cell addSubview:line];
        
        //概述内容
        //概述内容
//            label10 = [[UILabel alloc]initWithFrame:CGRectMake(10, label9.bottom, kScreenWidth-20, 100*ratioHeight)];
//            label10.numberOfLines = 0;
//             NSString * string1 = _bypredictiomModel.content;
//            label10.text = string1;
//            label10.font = [UIFont systemFontOfSize:13*ratioHeight];
//            label10.textColor = UIColor6(正文小字);
//            CGSize size1 = CGSizeMake(kScreenWidth-20, 10000);
//            CGSize labelsize = [string1 sizeWithFont:[UIFont systemFontOfSize:13*ratioHeight] constrainedToSize:size1];
//            [label10 setFrame:CGRectMake(10, label9.bottom, kScreenWidth-20, labelsize.height)];
//            [cell addSubview:label10];
        
    }
    
    
    return cell;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    int height = [height_str intValue];
    _webView.height = height + 20;
    _bypredictiTabelView.tableFooterView = _webView;
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

    [WXDataService requestAFWithURL:Url_setGaveTeacher params:@{@"cost":moeny,@"teacher_id":_teacherID,@"id":_ID,@"member_id":[UserDefaults objectForKey:Userid]} httpMethod:@"POST" finishBlock:^(id result) {
        NSLog(@"result==:%@",result);
        if ([[result objectForKey:@"status"] integerValue] == 0) {
            [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
            [self _initData];
        }
        //请求失败
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
           BgView4 *view = [[BgView4 alloc]initWithFrame:CGRectMake(20 * ratioWidth, (kScreenHeight - 180 * ratioHeight ) / 2.0, kScreenWidth  - 20 * ratioWidth * 2 , 180 * ratioHeight) Title:@"您的福币不够了" Delegate:self Mycost:@"" Cost:[NSString stringWithFormat:@"你目前拥有%@个福币",result[@"result"][@"amount"]]];
            [self.view addSubview:view];
            
//            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
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
//收藏，报名
-(void)tapAction:(TabBarItem *)tab
{
    if (tab.tag == 100) {
        NSLog(@"收藏");
        [WXDataService requestAFWithURL:Url_collectionCourse params:@{@"teacher_id":_teacherID,@"id":_ID,@"member_id":[UserDefaults objectForKey:Userid]} httpMethod:@"POST" finishBlock:^(id result) {
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
        NSLog(@"报名");
        [WXDataService requestAFWithURL:Url_signUpLecture params:@{@"cost":_moenyCost,@"teacher_id":_teacherID,@"id":_ID,@"member_id":[UserDefaults objectForKey:Userid]} httpMethod:@"POST" finishBlock:^(id result) {
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

}
@end

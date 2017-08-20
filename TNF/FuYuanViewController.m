//
//  FuYuanViewController.m
//  TNF
//
//  Created by 李立 on 15/12/17.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "FuYuanViewController.h"
#import "BillViewController.h"
#import "FuYuanModel.h"
#import "UMSocial.h"
@interface FuYuanViewController ()<UMSocialUIDelegate>
{
    FuYuanModel *_model;
    UILabel *fuyuanLabel;
    UILabel *smLabel;
    UILabel *jieshaoLabel;
    UILabel *jiageLabel;
    NSArray *_dataArray;
    UILabel *weishiLabel;
    UIButton *lingquButton;
    UIButton *lingquButton1;
}
@property(nonatomic,assign)BOOL isFenxiang;
@end

@implementation FuYuanViewController

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    //改变导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:UIColor(深色背景)];
    _isFenxiang = YES;

    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //导航栏标题
    self.text = @"我的福币";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _isFenxiang = YES;
    //初始化视图
    [self _initViews];
    
    //初始化数据
    [self _initDate];
}

-(void)_initDate
{

    [WXDataService requestAFWithURL:Url_getMyAmount params:@{@"member_id":[UserDefaults objectForKey:Userid]} httpMethod:@"POST" finishBlock:^(id result) {
        NSLog(@"-----result==%@",result);
        //请求成功
        if ([[result objectForKey:@"status"] integerValue] == 0) {
            
            
//            [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
            NSDictionary *subDic = result[@"result"];
            
            _model = [[FuYuanModel alloc]initWithDataDic:subDic];
//            self.datelist = @[@"",_model.text,_model.isGet1,_model.isGet2,_model.buyList];
            jieshaoLabel.text = _model.text2;
            [jieshaoLabel sizeToFit];
            jieshaoLabel.width = kScreenWidth - 20;
            bjview.height = jieshaoLabel.bottom + 15;
            _fuyuanTableview.tableHeaderView = bjview;
            smLabel.text = _model.text1;
            weishiLabel.text = _model.text9;
            fuyuanLabel.text = _model.amount;
            
            
            if ([_model.isget1 integerValue] == 0) {
                [lingquButton setTitle:@"领取" forState:UIControlStateNormal];
                lingquButton.userInteractionEnabled = YES;
                [lingquButton setBackgroundColor:UIColor3(金色)];
            } else {
                [lingquButton setTitle:@"已领取" forState:UIControlStateNormal];
                lingquButton.userInteractionEnabled = NO;
                [lingquButton setBackgroundColor:UIColor4(所有的灰色)];
            }
            
            if ([_model.isget2 integerValue] == 0) {
                [lingquButton1 setTitle:@"分享" forState:UIControlStateNormal];
                lingquButton1.userInteractionEnabled = YES;
                [lingquButton1 setBackgroundColor:UIColor3(金色)];
            } else {
                [lingquButton1 setTitle:@"已分享" forState:UIControlStateNormal];
                lingquButton1.userInteractionEnabled = NO;
                [lingquButton1 setBackgroundColor:UIColor4(所有的灰色)];
            }
            
            _imageViews = @[@"",@"gift_01.png",@"gift_02.png",@"gift_03.png"];
            _titiles = @[@"",_model.text4,_model.text6,_model.text8];
            _dataArray = @[@"",@"",@""];
       
        }
        
        //请求失败
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
        }
        [_fuyuanTableview reloadData];
        
    } errorBlock:^(NSError *error) {
        
    }];



}
//初始化视图
-(void)_initViews
{
    
    //创建表视图
    _fuyuanTableview = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    _fuyuanTableview.delegate = self;
    _fuyuanTableview.dataSource = self;
    _fuyuanTableview.showsHorizontalScrollIndicator = NO;
    _fuyuanTableview.showsVerticalScrollIndicator = NO;
    //    _setupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _fuyuanTableview.bounces = YES;
    
    //头视图
        //头视图背景视图
        bjview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, 230*ratioHeight)];
        bjview.backgroundColor = [UIColor whiteColor];
        
        //金色背景视图
        UIView *jinseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 90)];
        jinseView.backgroundColor = UIColor3(金色);
        [bjview addSubview:jinseView];
        
        //拥有福币数
        UILabel *yongyouLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 100*ratioHeight, 13*ratioHeight)];
        yongyouLabel.text = @"拥有福币";
        yongyouLabel.textColor = [UIColor whiteColor];
        yongyouLabel.font = [UIFont fontWithName:@"Arial" size:13*ratioHeight];
        [jinseView addSubview:yongyouLabel];
        
        
        //福币的个数
        fuyuanLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 40*ratioHeight)];
        fuyuanLabel.textColor = [UIColor whiteColor];
        fuyuanLabel.textAlignment = NSTextAlignmentCenter;
        fuyuanLabel.font = [UIFont fontWithName:@"Arial" size:30*ratioHeight];
        [jinseView addSubview:fuyuanLabel];
        
        //什么是福币
        smLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, jinseView.bottom+15, 150*ratioHeight, 15*ratioHeight)];
        smLabel.textColor = UIColor5(标题大字);
        smLabel.font = [UIFont systemFontOfSize:15*ratioHeight];
        [bjview addSubview:smLabel];
        
        //福币介绍
        jieshaoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, smLabel.bottom+15, kScreenWidth-20, 100*ratioHeight)];
        jieshaoLabel.font = [UIFont systemFontOfSize:13*ratioHeight];
        jieshaoLabel.textColor = UIColor6(正文小字);
        jieshaoLabel.numberOfLines = 0;
        jieshaoLabel.width = kScreenWidth - 20;
        [bjview addSubview:jieshaoLabel];
        bjview.height = jieshaoLabel.bottom + 15;
    _fuyuanTableview.tableHeaderView = bjview;
        
    
    //尾视图
    _fuyuanTableview.tableFooterView = ({
        UIView *footerbjView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 60*ratioHeight)];
        footerbjView.backgroundColor = UIColor2(灰色背景);
        weishiLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, kScreenWidth, 20*ratioHeight)];
        weishiLabel.textColor = UIColor6(正文小字);
        weishiLabel.font = [UIFont systemFontOfSize:13*ratioHeight];
        [footerbjView addSubview:weishiLabel];
        footerbjView;
        
    });
    
    [self.view addSubview:_fuyuanTableview];
    
    //创建账单按钮
    UIButton *zhangdanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    zhangdanButton.frame = CGRectMake(0, 0, 40, 20);
    [zhangdanButton setTitle:@"账单" forState:UIControlStateNormal];
    //    button.backgroundColor = [UIColor redColor];
    zhangdanButton.titleLabel.font = [UIFont systemFontOfSize:14*ratioHeight];
    [zhangdanButton addTarget:self action:@selector(shaixuanAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:zhangdanButton];
    // 添加到当前导航控制器上
//    self.navigationItem.rightBarButtonItem = backItem;
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                   target:nil action:nil];
    negativeSpacer.width = -10;//这个数值可以根据情况自由变化
    self.navigationItem.rightBarButtonItems = @[negativeSpacer,backItem];
    
}

//返回单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        return 45 * ratioHeight;
        
    }else if(indexPath.row == 1){
    
        return 175/2.0*ratioHeight;
    }
    
    else if(indexPath.row == 2 ){
        
        return 175/2.0*ratioHeight;
        
    }else{
    
        return 150*ratioHeight;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1;

}

//创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"Cell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        //线条
        UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(20, (45 - .5)*ratioHeight, kScreenWidth, .5)];
        lineview.backgroundColor = UIColorFromRGB(0xcccccc);
        cell.textLabel.font = [UIFont systemFontOfSize:13*ratioHeight];
        cell.textLabel.textColor = UIColor6(正文小字);
        
        //图标
        UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 16 * ratioHeight, 16*ratioHeight)];
        imageView1.image = imageNamed(_imageViews[indexPath.row]);
        [cell addSubview:imageView1];
        
        //文字
        _label1 = [[UILabel alloc]initWithFrame:CGRectMake(imageView1.right+10, 15, 100*ratioHeight, 17*ratioHeight)];
        _label1.textColor = UIColor3(金色);
        _label1.text = _titiles[indexPath.row];
        _label1.font = [UIFont systemFontOfSize:17*ratioHeight];
        [cell addSubview:_label1];
        
        if (indexPath.row ==0 ) {
//            imageView1.hidden = YES;
            UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
            view1.backgroundColor = UIColor2(灰色背景);
            [cell addSubview:view1];
            cell.textLabel.font = [UIFont systemFontOfSize:15*ratioHeight];
            cell.textLabel.textColor = UIColor5(标题大字);
            cell.textLabel.text = _model.text3;
            lineview.frame = CGRectMake(20, 45 * ratioHeight - 0.5, kScreenWidth, .5);
            
        }else if (indexPath.row == 1){
            UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(_label1.left, _label1.bottom+5, 200*ratioHeight, 40*ratioHeight)];
            label2.text = _model.text5;
            label2.textColor = UIColor6(正文小字);
            label2.font = [UIFont systemFontOfSize:13*ratioHeight];
            label2.numberOfLines = 0;
            [cell addSubview:label2];
            
            //线条坐标改变
            lineview.frame = CGRectMake(20, 175/2.0*ratioHeight- 0.5, kScreenWidth, 0.5);
            
            //领取按钮
            lingquButton = [UIButton buttonWithType:UIButtonTypeCustom];
            lingquButton.frame = CGRectMake(kScreenWidth-70*ratioHeight, _label1.bottom, 60*ratioHeight, 26*ratioHeight);
            lingquButton.titleLabel.font = [UIFont systemFontOfSize:13 * ratioWidth];
//            [lingquButton setTitle:@"领取" forState:UIControlStateNormal];
//            [lingquButton setBackgroundColor:UIColor3(金色)];
            lingquButton.tag = 10;
            [lingquButton addTarget:self action:@selector(lingquButton:) forControlEvents:UIControlEventTouchUpInside];
            lingquButton.layer.cornerRadius = 13 * ratioHeight;
            
            // 按钮边框宽度
            lingquButton.layer.borderWidth = 0;
            [cell addSubview:lingquButton];
            
            
            if ([_model.isget1 integerValue] == 0) {
                [lingquButton setTitle:@"领取" forState:UIControlStateNormal];
                lingquButton.userInteractionEnabled = YES;
                [lingquButton setBackgroundColor:UIColor3(金色)];
            } else {
                [lingquButton setTitle:@"已领取" forState:UIControlStateNormal];
                lingquButton.userInteractionEnabled = NO;
                [lingquButton setBackgroundColor:UIColor4(所有的灰色)];
            }
            
        }else if (indexPath.row == 2){
            
            UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(_label1.left, _label1.bottom+5, 200*ratioHeight, 40*ratioHeight)];
            label3.text = _model.text7;
            label3.textColor = UIColor6(正文小字);
            label3.font = [UIFont systemFontOfSize:13*ratioHeight];
            label3.numberOfLines = 0;
            [cell addSubview:label3];
            //领取按钮
            lingquButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
            lingquButton1.frame = CGRectMake(kScreenWidth-70*ratioHeight, _label1.bottom, 60*ratioHeight, 26*ratioHeight);
            lingquButton1.titleLabel.font = [UIFont systemFontOfSize:13 * ratioWidth];
//            [lingquButton1 setTitle:@"领取" forState:UIControlStateNormal];
//            [lingquButton1 setBackgroundColor:UIColor3(金色)];
            lingquButton1.tag = 11;
            [lingquButton1 addTarget:self action:@selector(lingquButton:) forControlEvents:UIControlEventTouchUpInside];
            lingquButton1.layer.cornerRadius = 13 * ratioHeight;
            
            // 按钮边框宽度
            lingquButton1.layer.borderWidth = 0;
            [cell addSubview:lingquButton1];
        
            if ([_model.isget2 integerValue] == 0) {
                [lingquButton1 setTitle:@"分享" forState:UIControlStateNormal];
                lingquButton1.userInteractionEnabled = YES;
                [lingquButton1 setBackgroundColor:UIColor3(金色)];
            } else {
                [lingquButton1 setTitle:@"已分享" forState:UIControlStateNormal];
                lingquButton1.userInteractionEnabled = NO;
                [lingquButton1 setBackgroundColor:UIColor4(所有的灰色)];
            }
            
            lineview.frame = CGRectMake(20, 175/2.0*ratioHeight-0.5, kScreenWidth, 0.5);

        }else {
            
         //隐藏线条
         lineview.hidden = YES;
            
        //循环创建价格视图
          
            NSArray *shuzis = @[@"100",@"200",@"300"];
            NSArray *jiages = @[@"￥39",@"￥69",@"￥99"];
            for (int i=0; i< _model.buyList.count; i++) {
                UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(i*(kScreenWidth/3)+20, _label1.bottom+20, 120/2.0*ratioHeight, 80/2.0*ratioHeight)];
                imageView1.image = imageNamed(@"momey_01.png");
                [cell addSubview:imageView1];
                
//                NSDictionary *dic = _model.buyList[i];
                //价格数字
                UILabel *lael1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 40*ratioHeight, 20*ratioHeight)];
                lael1.font = [UIFont systemFontOfSize:13*ratioHeight];
                lael1.textColor = UIColor6(正文小字);
//                lael1.text = dic.allKeys.lastObject;
                lael1.text = shuzis[i];
                [imageView1 addSubview:lael1];
                
                //创建按钮
                UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
                button1.frame = CGRectMake(imageView1.left, imageView1.bottom+10, 45*ratioHeight, 35/2.0*ratioHeight);
                button1.backgroundColor = [UIColor whiteColor];
                button1.layer.cornerRadius = 8;
                CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
                // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
                CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 0.6980, 0.5294, 0.3216, 1 });
                button1.tag = 20+i;
                [button1 addTarget:self action:@selector(button1A:) forControlEvents:UIControlEventTouchUpInside];
                [button1.layer setBorderColor:borderColorRef];//边框颜色
                button1.titleLabel.font = [UIFont systemFontOfSize:13*ratioHeight];
//                [button1 setTitle:[NSString stringWithFormat:@"￥%@",dic.allValues.lastObject] forState:UIControlStateNormal];
              [button1 setTitle:jiages[i] forState:UIControlStateNormal];

                [button1 setTitleColor:UIColor3(金色) forState:UIControlStateNormal];
                // 按钮边框宽度
                button1.layer.borderWidth = .5;
                [cell addSubview:button1];
                
                
            }
        
        }
        
        [cell.contentView addSubview:lineview];
    }
    
    return cell;
}


//单元格点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];// 取消选中
    
}

//领取按钮
-(void)lingquButton:(UIButton *)button
{
    if (button.tag == 10) {
        NSLog(@"每日任务");
        
        NSString *member = [UserDefaults objectForKey:Userid];
        NSString *amount = @"5";
        NSDictionary *parmas = @{@"member_id":member,
                                 @"amount":amount};
        
        [WXDataService requestAFWithURL:Url_setAmount params:parmas httpMethod:@"POST" finishBlock:^(id result) {
            NSLog(@"领取福币:%@",result);
            if ([result[@"status"] integerValue] == 0) {
                [self _initDate];
            }
            if ([result[@"status"] integerValue] == 1) {
                [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            }
            
        } errorBlock:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }else {
        NSLog(@"分享任务");
        if (!_isFenxiang) {
            return;
        }
        
        _isFenxiang = NO;
        NSString *member = [UserDefaults objectForKey:Userid];

        NSDictionary *parmas = @{@"member_id":member};
        

        [WXDataService requestAFWithURL:Url_getMyAmount params:parmas httpMethod:@"POST" finishBlock:^(id result) {

            if ([result[@"status"] integerValue] == 0) {
                NSDictionary *dic = result[@"result"];
                NSString *title = dic[@"share_title"];
                NSString *connent = dic[@"share_content"];
                NSString *url = dic[@"share_url"];
                NSString *image = dic[@"share_thumb"];
                
                [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:image] options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                    
                } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
                    if (finished) {
                        [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
                        [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
                        [UMSocialData defaultData].extConfig.qzoneData.url = url;
                        [UMSocialData defaultData].extConfig.qqData.url = url;

                        [UMSocialData defaultData].extConfig.qqData.title = title;
                        [UMSocialData defaultData].extConfig.qzoneData.title = title;
                        [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
                        [UMSocialData defaultData].extConfig.wechatTimelineData.title = title;
                        [UMSocialSnsService presentSnsIconSheetView:self
                                                             appKey:@"55c45a7de0f55abdef000e7e"
                                                          shareText:connent
                                                         shareImage:image
                                                    shareToSnsNames:@[UMShareToQQ,UMShareToQzone,UMShareToWechatTimeline,UMShareToWechatSession,UMShareToSina]
                                                           delegate:self];

                        double delayInSeconds = .5;
                        __block FuYuanViewController* bself = self;
                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                            [bself isfenxiang123]; });
                    }else{
                        
                        [MBProgressHUD showError:@"亲，网速不好哦！！！" toView:[UIApplication sharedApplication].keyWindow];

                    }
                    
                }];
                
                
                
            }
            if ([result[@"status"] integerValue] == 1) {
                [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            }
            
        } errorBlock:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
        
        
        
    
    }

}

- (void)isfenxiang123
{
    
    _isFenxiang = YES;
    
}


//实现回调方法（可选）：
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        _isFenxiang = YES;
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
        
        NSString *member = [UserDefaults objectForKey:Userid];
        
        NSDictionary *parmas = @{@"member_id":member};
        
        
        [WXDataService requestAFWithURL:Url_setAmountShare params:parmas httpMethod:@"POST" finishBlock:^(id result) {
            
            if ([result[@"status"] integerValue] == 0) {
                
                [MBProgressHUD showSuccess:@"分享成功!" toView:[UIApplication sharedApplication].keyWindow];
            }
            if ([result[@"status"] integerValue] == 1) {
                [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            }
            [self _initDate];
            
        } errorBlock:^(NSError *error) {
            NSLog(@"%@",error);
        }];

        
    }else{
    
        _isFenxiang = YES;
     [MBProgressHUD showError:@"分享失败!" toView:[UIApplication sharedApplication].keyWindow];
        
    }
    
}

//购买按钮
-(void)button1A:(UIButton *)button
{
    if (button.tag == 20) {
        NSLog(@"39");
    }else if (button.tag ==21){
        NSLog(@"69");
    }else{
        NSLog(@"99");
    }

}

//账单
-(void)shaixuanAction
{
    //跳转到福币账单界面
    BillViewController *billVC = [[BillViewController alloc]init];
    [self.navigationController pushViewController:billVC animated:YES];
    
    
}
@end















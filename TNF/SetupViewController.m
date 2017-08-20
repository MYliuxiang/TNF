//
//  SetupViewController.m
//  TNF
//
//  Created by 李立 on 15/12/17.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "SetupViewController.h"
#import "PersonalinformationViewController.h"
#import "FuYuanViewController.h"
#import "ProformainformationViewController.h"
#import "TrainingrecordViewController.h"
#import "MycourseViewController.h"
#import "AgreementandtermsViewController.h"
#import "FeedbackViewController.h"
#import "JoinUsViewController.h"
#import "SetupModel.h"
@interface SetupViewController ()
{
    SetupModel * _model;


}
@end

@implementation SetupViewController

-(void)viewWillAppear:(BOOL)animated
{

    self.navigationController.navigationBar.hidden = NO;
    //改变导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:UIColor(深色背景)];

      [self _initDate];


}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //图片数组
    _images = @[@"setlb_01.png",@"setlb_02.png",@"setlb_03.png",@"setlb_04.png"];
    
    //文字数组
    _titles1 = @[@"我的福币",@"备考信息",@"练习记录",@"我的课程"];
    _titles = @[@"加入我们",@"意见反馈",@"协议与条款"];
       //导航栏标题
    self.text = @"设置";
    
    //当前视图背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //
    //初始化视图
    [self _initViews];
}


//初始化数据
-(void)_initDate
{
    [WXDataService requestAFWithURL:Url_getSetting params:@{@"member_id":[UserDefaults objectForKey:Userid]} httpMethod:@"POST" finishBlock:^(id result) {
        NSLog(@"-----result==%@",result);
        //请求成功
        if ([[result objectForKey:@"status"] integerValue] == 0) {
            
            
//            [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
            NSDictionary *subDic = result[@"result"];
            
            
            _model = [[SetupModel alloc]initWithDataDic:subDic];

            _nameLabel.text = _model.name;
            if (_model.app_address.length != 0) {
                _dimingLabel.text = _model.app_address;

            }else{
            
                _dimingLabel.text = @"未填写地址";

            }
            [_touxiangImageView sd_setImageWithURL:[NSURL URLWithString:_model.headimgurl] placeholderImage:nil];
            _banbenLabel.text = _model.version;
            _label1.text = _model.amount;
            _label2.text = _model.subjectCN;
            _label3.text = _model.recordCount;
            

                }
        //请求失败
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
        }
        [_setupTableView reloadData];
    } errorBlock:^(NSError *error) {
        
    }];
    



}
//初始化视图
-(void)_initViews
{
    
    //创建表视图
    _setupTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth  , kScreenHeight-64) style:UITableViewStyleGrouped];
    _setupTableView.delegate = self;
    _setupTableView.dataSource = self;
    _setupTableView.showsHorizontalScrollIndicator = NO;
    _setupTableView.showsVerticalScrollIndicator = NO;
    _setupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _setupTableView.bounces = NO;
    
    //头视图
    _setupTableView.tableHeaderView = ({
        UIView *bjview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 95*ratioHeight)];
        bjview.backgroundColor = [UIColor whiteColor];
        bjview.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tpa = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tpaAction:)];
        [bjview addGestureRecognizer:tpa];
        //灰色背景
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10*ratioHeight)];
        view1.backgroundColor = UIColor2(灰色背景);
        [bjview addSubview:view1];
        
        //头像
        _touxiangImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, view1.bottom+10, 70*ratioHeight, 55*ratioHeight)];
        _touxiangImageView.contentMode = UIViewContentModeScaleAspectFit;

        [bjview addSubview:_touxiangImageView];
        
        //姓名
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_touxiangImageView.right + 10, view1.bottom+10, 150*ratioHeight, 20*ratioHeight)];
        _nameLabel.font = [UIFont systemFontOfSize:17*ratioHeight];
        _nameLabel.textColor = UIColor5(标题大字);
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [bjview addSubview:_nameLabel];
        
        //所在地
        UIImageView *tubiaoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_touxiangImageView.right+10, _nameLabel.bottom+15, 36/3.0*ratioHeight, 48/3.0*ratioHeight)];
        tubiaoImageView.image = imageNamed(@"ditu_01.png");
        [bjview addSubview:tubiaoImageView];
        
        //所在地名显示
        _dimingLabel = [[UILabel alloc]initWithFrame:CGRectMake(tubiaoImageView.right+5, tubiaoImageView.top-3, 100*ratioHeight, 20*ratioHeight)];
        _dimingLabel.textColor = UIColor6(正文小字);
        _dimingLabel.font = [UIFont systemFontOfSize:13*ratioHeight];
        [bjview addSubview:_dimingLabel];
        //线条
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _touxiangImageView.bottom+10, kScreenWidth, 1)];
        lineView.backgroundColor = UIColorFromRGB(0xdfdfdf);
        [bjview addSubview:lineView];
        
        //下面的灰色背景
        UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, lineView.bottom, kScreenWidth, 10*ratioHeight)];
        view2.backgroundColor = UIColor2(灰色背景);
        [bjview addSubview:view2];
        
        bjview;
        
    });
    
    //尾视图
    _setupTableView.tableFooterView = ({
        UIView *footerbjView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 70*ratioHeight)];
        footerbjView.backgroundColor = UIColor2(灰色背景);
        
        //版本信息
        _banbenLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, kScreenWidth, 20*ratioHeight)];
        _banbenLabel.font = [UIFont systemFontOfSize:13*ratioHeight];
        _banbenLabel.textAlignment = NSTextAlignmentCenter;
        _banbenLabel.textColor = UIColor6(正文小字);
        [footerbjView addSubview:_banbenLabel];
        footerbjView;
    
    
    });
    
    [self.view addSubview:_setupTableView];



}
//返回单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45*ratioHeight;
    
}

//返回多少组表视图
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

//每一组返回多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0) {
        return 4;
    }else{
    return 3;
    }
}

//尾视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

//组视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        view1.backgroundColor=UIColor2(灰色背景);
        return view1;
        
    }else{
        UIView *view2 = [[UIView alloc]init];
        view2.backgroundColor = [UIColor clearColor];
        return view2;
    }
}
//创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"Cell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(20, 45*ratioHeight - 0.5, kScreenWidth, .5)];
        lineview.backgroundColor = UIColorFromRGB(0xcccccc);
        [cell.contentView addSubview:lineview];

        if (indexPath.section == 0) {
//            lineview.hidden = YES;
            //图片
            UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, (45*ratioHeight - 80 / 4.5 * ratioHeight) / 2.0, 70/4.0*ratioHeight, 86/4.5*ratioHeight)];
            imageview.image =[UIImage imageNamed:_images[indexPath.row]];
            [cell.contentView addSubview:imageview];
            
            // 文字
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imageview.right+10, (45*ratioHeight - 20 * ratioHeight) / 2.0, 100*ratioHeight, 20*ratioHeight)];
            label.text = _titles1[indexPath.row];
            label.font = [UIFont systemFontOfSize:13*ratioHeight];
            label.textColor = UIColor6(正文小字);
            [cell.contentView addSubview:label];
            
            if (indexPath.row ==0) {
                //状态
                _label1 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-100*ratioHeight, (45*ratioHeight - 20 * ratioHeight) / 2.0, 70*ratioHeight, 20*ratioHeight)];
                _label1.font = [UIFont systemFontOfSize:13*ratioHeight];
                _label1.textAlignment = NSTextAlignmentRight;
                _label1.textColor = UIColor6(正文小字);
                [cell.contentView addSubview:_label1];
            }else if (indexPath.row == 1){
                //状态
                _label2 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-100*ratioHeight, (45*ratioHeight - 20 * ratioHeight) / 2.0, 70*ratioHeight, 20*ratioHeight)];
                _label2.font = [UIFont systemFontOfSize:13*ratioHeight];
                _label2.textAlignment = NSTextAlignmentRight;
                _label2.textColor = UIColor6(正文小字);
                [cell.contentView addSubview:_label2];
            }else if (indexPath.row == 2){
                //状态
                _label3 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-100*ratioHeight, (45*ratioHeight - 20 * ratioHeight) / 2.0, 70*ratioHeight, 20*ratioHeight)];
                _label3.font = [UIFont systemFontOfSize:13*ratioHeight];
                _label3.textAlignment = NSTextAlignmentRight;
                _label3.textColor = UIColor6(正文小字);
                [cell.contentView addSubview:_label3];

            
            }
            }else{
             cell.textLabel.text = _titles[indexPath.row];
             cell.textLabel.font = [UIFont systemFontOfSize:13*ratioHeight];
                        cell.textLabel.textColor = UIColor6(正文小字);
                        
                        if (indexPath.row == 2) {
                            lineview.frame = CGRectMake(0, 45*ratioHeight-0.5, kScreenWidth, .5);
                        }
        }
            }
    
    return cell;
}

//单元格点击事件

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中

    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            //跳转到我的福币界面
            FuYuanViewController *fuyuanVC = [[FuYuanViewController alloc]init];
            [self.navigationController pushViewController:fuyuanVC animated:YES];
            
        }else if (indexPath.row == 1){
            
            //跳转到备考信息
            ProformainformationViewController *proformainVC = [[ProformainformationViewController alloc]init];
            [self.navigationController pushViewController:proformainVC animated:YES];
        }else if (indexPath.row == 2){
           
            //跳转到练习记录界面
            TrainingrecordViewController *trainingrecordVC = [[TrainingrecordViewController alloc]init];
            trainingrecordVC.zongshu = _model.recordCount;
            [self.navigationController pushViewController:trainingrecordVC animated:YES];
        
        }else{
        
            //跳转到我的课程
            MycourseViewController *mycourseVC = [[MycourseViewController alloc]init];
            [self.navigationController pushViewController:mycourseVC animated:YES];
        
        }
    }
    else
    {
        if (indexPath.row == 0) {
            
            //跳转到加入我们界面
            JoinUsViewController *joinusVC = [[JoinUsViewController alloc]init];
            [self.navigationController pushViewController:joinusVC animated:YES];
        }else if (indexPath.row == 1){
            
            //跳转到意见反馈界面
            FeedbackViewController *feedbackVC = [[FeedbackViewController alloc]init];
            [self.navigationController pushViewController:feedbackVC animated:YES];
        
        }else {
        
        //跳转到协议与条款界面
            AgreementandtermsViewController *agreementVC = [[AgreementandtermsViewController alloc]init];
            [self.navigationController pushViewController:agreementVC animated:YES];
        
        }
        
        
    
    }
    
    
    
}

//头像点击方法
-(void)tpaAction:(UITapGestureRecognizer *)tap
{
    
    //PUSH到个人信息界面
    PersonalinformationViewController *personlinVC = [[PersonalinformationViewController alloc]init];
    [self.navigationController pushViewController:personlinVC animated:YES];
}

@end

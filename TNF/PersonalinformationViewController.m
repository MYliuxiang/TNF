//
//  PersonalinformationViewController.m
//  TNF
//
//  Created by 李立 on 15/12/17.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "PersonalinformationViewController.h"
#import "PersonaModel.h"
@interface PersonalinformationViewController ()
{
    PersonaModel *_model;
    NSString *_str1;
    NSString *_str2;
    NSString *_str3;
    NSString *_str4;
    NSString *_str5;
    NSString *_str6;
    NSString *shuzi;
}
@end

@implementation PersonalinformationViewController


-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    //改变导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:UIColor(深色背景)];
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //导航栏标题
    self.text = @"个人信息";
    
    //当前视图的背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    _titles = @[@"头像",@"姓名",@"性别",@"手机号",@"微信",@"所在城市",@"学历"];
    
        //初始化视图
    [self _initViews];
    
    //请求数据
    [self _initDate];
    

    
    
}


//请求数据
-(void)_initDate
{

    
    [WXDataService requestAFWithURL:Url_getUpdateSetting params:@{@"member_id":[UserDefaults objectForKey:Userid]} httpMethod:@"POST" finishBlock:^(id result) {
        NSLog(@"-----result==%@",result);
        //请求成功
        if ([[result objectForKey:@"status"] integerValue] == 0) {
            
            
//            [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
            NSDictionary *subDic = result[@"result"];
            
           
            _model = [[PersonaModel alloc]initWithDataDic:subDic];
            self.datelist = @[@"",_model.name,_model.sex,_model.mobile,_model.weixin,_model.app_address,_model.education];
                              }

        //请求失败
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
        }
        [_personalinfTableView reloadData];
        } errorBlock:^(NSError *error) {
        
   }];


}
//初始化视图
-(void)_initViews
{
    
    //创建表视图
    _personalinfTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth  , kScreenHeight-64) style:UITableViewStyleGrouped];
    _personalinfTableView.delegate = self;
    _personalinfTableView.dataSource = self;
    _personalinfTableView.showsHorizontalScrollIndicator = NO;
    _personalinfTableView.showsVerticalScrollIndicator = NO;
    //    _setupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _personalinfTableView.bounces = YES;
    

    //头视图
    _personalinfTableView.tableHeaderView = ({
        UIView *bjview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        bjview.backgroundColor = UIColor2(灰色背景);
        
        bjview;
        
    });
    
    //尾视图
    _personalinfTableView.tableFooterView = ({
        UIView *footerbjView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        footerbjView.backgroundColor = UIColor2(灰色背景);
        
        //退出按钮
        UIButton *extibutton = [UIButton buttonWithType:UIButtonTypeCustom];
        extibutton.frame = CGRectMake(0, 20, kScreenWidth, 40*ratioHeight);
        extibutton.backgroundColor = [UIColor whiteColor];
        [extibutton setTitle:@"退出登录" forState:UIControlStateNormal];
        [extibutton setTitleColor:UIColor6(正文小字) forState:UIControlStateNormal];
        extibutton.titleLabel.font = [UIFont systemFontOfSize:13*ratioHeight];
        [extibutton addTarget:self action:@selector(extibuttonACtion:) forControlEvents:UIControlEventTouchUpInside];
        [footerbjView addSubview:extibutton];
        footerbjView.userInteractionEnabled = YES;
                       footerbjView;
        
        
    });
    
    [self.view addSubview:_personalinfTableView];
    
    
    
    
    //创建保存按钮
    _baocunbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    _baocunbutton.frame = CGRectMake(0, 0, 80 / 2.0*ratioHeight, 40 / 2.0*ratioHeight);
            [_baocunbutton setTitle:@"保存" forState:UIControlStateNormal];
    _baocunbutton.titleLabel.font = [UIFont systemFontOfSize:14*ratioHeight];
    [_baocunbutton addTarget:self action:@selector(shaixuanAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:_baocunbutton];
    _baocunbutton.hidden = YES;
    // 添加到当前导航控制器上
    self.navigationItem.rightBarButtonItem = backItem;

    
}
//返回单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 75;
    }
    return 45;
    
}

//返回多少组表视图
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//每一组返回多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.datelist.count;
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
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //线条
        UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(20, 45 - .5, kScreenWidth, .5)];
        lineview.backgroundColor = UIColorFromRGB(0xcccccc);
        
        //
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, (45-25)/2.0, 80, 20)];
        nameLabel.text = _titles[indexPath.row];
        nameLabel.textColor = UIColor6(正文小字);
        nameLabel.font = [UIFont systemFontOfSize:13*ratioHeight];
        [cell addSubview:nameLabel];
        
        if (indexPath.row ==0 ) {
            //头像
            UIImageView *touxiangImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-100, 10, 70, 55)];
            touxiangImageView.contentMode = UIViewContentModeScaleAspectFit;
            touxiangImageView.backgroundColor = [UIColor clearColor];
            [touxiangImageView sd_setImageWithURL:[NSURL URLWithString:_model.headimgurl] placeholderImage:nil];
            [cell addSubview:touxiangImageView];
            lineview.frame = CGRectMake(20, 75-0.5, kScreenWidth, .5);
            nameLabel.frame = CGRectMake(10, (75-20)/2, 80, 20);
        }

        if (indexPath.row == 1) {
            _nameLabel = [[UITextField alloc]initWithFrame:CGRectMake(90, nameLabel.top, kScreenWidth-90-10, 25)];
            _nameLabel.text = self.datelist[1];
            _nameLabel.textColor = UIColor6(正文小字);
            _nameLabel.delegate = self;
            _nameLabel.font = [UIFont systemFontOfSize:13*ratioHeight];
            [cell addSubview:_nameLabel];

        }
        if (indexPath.row == 2) {
            //性别
            _pickLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, nameLabel.top, kScreenWidth-90-10, 25)];
            _pickLabel.text = self.datelist[2];
            _pickLabel.textColor = UIColor6(正文小字);
            _pickLabel.font = [UIFont systemFontOfSize:13*ratioHeight];
            [cell addSubview:_pickLabel];
            
            if ([_pickLabel.text isEqualToString:@"男"]) {
                shuzi = @"1";
            }else if ([_pickLabel.text isEqualToString:@"女"]){
                shuzi = @"2";
            }else{
                shuzi = @"0";
            }

        }
        if (indexPath.row == 3) {
            
            //电话号码
            _iphoneLabel = [[UITextField alloc]initWithFrame:CGRectMake(90, nameLabel.top, kScreenWidth-90-10, 25)];
            _iphoneLabel.text = self.datelist[3];
            _iphoneLabel.textColor = UIColor6(正文小字);
            _iphoneLabel.delegate = self;
            _iphoneLabel.font = [UIFont systemFontOfSize:13*ratioHeight];
            _iphoneLabel.keyboardType = UIKeyboardTypeNumberPad;
            [cell addSubview:_iphoneLabel];

        }if (indexPath.row == 4) {
            _weixinField = [[UITextField alloc]initWithFrame:CGRectMake(90, nameLabel.top, kScreenWidth-90-10, 25)];
            _weixinField.text = self.datelist[4];
            _weixinField.textColor = UIColor6(正文小字);
            _weixinField.delegate = self;
            _weixinField.font = [UIFont systemFontOfSize:13*ratioHeight];
            [cell addSubview:_weixinField];
        }if (indexPath.row == 5) {
            _app_addressField = [[UITextField alloc]initWithFrame:CGRectMake(90, nameLabel.top, kScreenWidth-90-10, 25)];
            _app_addressField.text = self.datelist[5];
            _app_addressField.textColor = UIColor6(正文小字);
            _app_addressField.delegate = self;
            _app_addressField.font = [UIFont systemFontOfSize:13*ratioHeight];
            [cell addSubview:_app_addressField];

        }if (indexPath.row == 6) {
            _educationField = [[UITextField alloc]initWithFrame:CGRectMake(90, nameLabel.top, kScreenWidth-90-10, 25)];
            _educationField.text = self.datelist[6];
            _educationField.textColor = UIColor6(正文小字);
            _educationField.delegate = self;
            _educationField.font = [UIFont systemFontOfSize:13*ratioHeight];
            [cell addSubview:_educationField];

        }
       
        [cell.contentView addSubview:lineview];
    }
    
    return cell;
}


//单元格点击事件

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];// 取消选中
    
    if (indexPath.row == 2) {
//        [self hiddnkeyActionWith:nil];
         [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        //弹出下面的view
        if (_view1 ==nil) {
            [self pickerviewchulai];
        }else{
            [UIView animateWithDuration:.35 animations:^{
                _view1.frame = CGRectMake(0, kScreenHeight-200, kScreenWidth, 200);
                
            }];

        
        }
        
        

    }
    
    
}

//弹出PICKVIEW
-(void)pickerviewchulai
{         _baocunbutton.hidden = NO;
    _view1 = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 200)];
    _view1.backgroundColor = UIColor2(灰色背景);
    [UIView animateWithDuration:.35 animations:^{
        _view1.frame = CGRectMake(0, kScreenHeight-200, kScreenWidth, 200);
        
    }];
    _pickerView =[[UIPickerView alloc] initWithFrame:CGRectMake(0, -50, kScreenWidth , 200)];
    //            // 显示选中框
                _pickerView.showsSelectionIndicator=YES;
                _pickerView.dataSource = self;
                _pickerView.delegate = self;
                _pickerView.shouldGroupAccessibilityChildren = NO;
                _pickerView.showsSelectionIndicator = NO;
                [_view1 addSubview:_pickerView];
                _proTimeList = [[NSArray alloc]initWithObjects:@"男",@"女",@"未知",nil];
    if ([_pickLabel.text isEqualToString:@"男"]) {
        [_pickerView selectRow:0 inComponent:0 animated:NO];
    }else if ([_pickLabel.text isEqualToString:@"女"]){
        [_pickerView selectRow:1 inComponent:0 animated:NO];

    }else{
        [_pickerView selectRow:2 inComponent:0 animated:NO];

    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth-60, 5, 40, 20);
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setTitleColor:UIColor3(<#金色#>) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_view1 addSubview:button];
    [self.view addSubview:_view1];

}
#pragma mark-PICK代理
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [_proTimeList count];
}

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
        return 60;
}
//每个item显示的内容
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    
    return _proTimeList[row];
    
}


//监听选择单元格
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _pickLabel.text = _proTimeList[row];
    

    if ([_pickLabel.text isEqualToString:@"男"]) {
        shuzi = @"1";
    }else if ([_pickLabel.text isEqualToString:@"女"]){
        shuzi = @"2";
    }else{
        shuzi = @"0";
    }
}

//退出按钮
-(void)extibuttonACtion:(UIButton *)button
{
    NSLog(@"退出");
    
    [UserDefaults setBool:NO forKey:ISLogin];
    [UserDefaults setObject:@"" forKey:Userid];
    [UserDefaults setObject:@"" forKey:IcanUrl];
    [UserDefaults setObject:@"" forKey:Nickname];
    [UserDefaults setObject:@"" forKey:subject];
    [UserDefaults setObject:@"" forKey:Useramount];
    [UserDefaults setObject:@"" forKey:app_ex_time];
    [UserDefaults setObject:@""  forKey:app_t_score];
    [UserDefaults setObject:@""  forKey:Username];
    [UserDefaults setObject:@""  forKey:mobile1];
    [UserDefaults setObject:@""  forKey:weixin1];
    [UserDefaults synchronize];
//    [MBProgressHUD showSuccess:@"退出登录" toView:self.view];
    [self.navigationController popToRootViewControllerAnimated:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:Noti_LoginOut object:nil];

}
//开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //开始编辑时触发，文本字段将成为first responder

    [UIView animateWithDuration:.35 animations:^{
        _view1.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 200);
        
    }];

    //保存按钮出现
    _baocunbutton.hidden = NO;
    [UIView animateWithDuration:.35 animations:^{
        
        if (textField == _iphoneLabel) {
            CGPoint Y = CGPointMake(0, 160);
            _personalinfTableView.contentOffset = Y;
            
        }
            else if (textField == _weixinField){
            CGPoint Y = CGPointMake(0, 180);
            _personalinfTableView.contentOffset = Y;
            }else if (textField == _app_addressField){
                CGPoint Y = CGPointMake(0, 200);
                _personalinfTableView.contentOffset = Y;
            }else if (textField == _educationField){
                CGPoint Y = CGPointMake(0, 220);
                _personalinfTableView.contentOffset = Y;
            }
    }];
    
    
    
}


//隐藏键盘
- (void)hiddnkeyActionWith:(UITextField *)textView
{
    [self keyfileActionWith:textView];
    CGPoint Y = CGPointMake(0, 0);
    _personalinfTableView.contentOffset = Y;
    
}

- (void)keyfileActionWith:(UITextField *)textView
{
    if (![textView isExclusiveTouch]) {
         [textView resignFirstResponder];
      }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    [self hiddnkeyActionWith:textField];

    return YES;
}


//保存按钮
-(void)shaixuanAction
{

    [WXDataService requestAFWithURL:Url_setSettingField params:@{@"member_id":[UserDefaults objectForKey:Userid],@"name":_nameLabel.text,@"sex":shuzi,@"mobile":_iphoneLabel.text,@"weixin":_weixinField.text,@"app_address":_app_addressField.text,@"education":_educationField.text} httpMethod:@"POST" finishBlock:^(id result) {
        NSLog(@"-----result==%@",result);
        //请求成功
        if ([[result objectForKey:@"status"] integerValue] == 0) {
            
            
            [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            _baocunbutton.hidden = YES;
            
            }
        
        //请求失败
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
        }
    } errorBlock:^(NSError *error) {
        
    }];


}


//完成按钮点击事件
-(void)buttonAction:(UIButton *)button
{
    NSLog(@"完成");
    [UIView animateWithDuration:.35 animations:^{
        _view1.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 200);
        
    }];


}
@end

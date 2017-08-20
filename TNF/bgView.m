//
//  bgView.m
//  TNF
//
//  Created by 李善 on 15/12/17.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "bgView.h"
#import "TFViewController.h"
#import "Bgmodel.h"


@implementation bgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _allDic = [[NSMutableDictionary alloc]init];
        [WXDataService requestAFWithURL:Url_getSubject params:nil httpMethod:@"POST" finishBlock:^(id result) {
            NSLog(@"%@",result);
            NSArray *re = result[@"result"];
            _BgAry = [[NSMutableArray alloc]init];
            [re enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                Bgmodel *model = [[Bgmodel alloc]initWithDataDic:obj];
                model.subject1 = obj[@"subject"];
                model.time = obj[@"time"];
                model.fen = obj[@"fen"];
                [_BgAry addObject:model];
            }];
            [self CreateWhiteBjViewFrame:frame];
    
        } errorBlock:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    
    return self;
}





//创建白色背景视图
- (void)CreateWhiteBjViewFrame:(CGRect)frame{

    [self  setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
//    _whiltBgView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-(ratioWidth*540/2))/2,(kScreenHeight-(ratioHeight*960/2))/2, ratioWidth*540/2, ratioHeight*960/2)];
    
    _whiltBgView = [[UIView alloc]initWithFrame:frame];
    _whiltBgView.backgroundColor = [MyColor colorWithHexString:@"0xf0f0f0"];
    _whiltBgView.layer.masksToBounds =YES;
    _whiltBgView.layer.cornerRadius= 5;
    
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(ratioWidth*200/2, 20*ratioHeight/2, _whiltBgView.bounds.size.width-400*ratioWidth/2, ratioHeight*70/2)];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:17*ratioHeight];
    [titleLabel setTintColor:[MyColor colorWithHexString:@"0x000000"]];
    titleLabel.text = @"备考科目";
    [_whiltBgView addSubview:titleLabel];
    [self addSubview:_whiltBgView];
    
    
    CGFloat Xi = (_whiltBgView.width-(ratioWidth*210))/3;
    for (int i =0; i<2; i++) {
        Bgmodel *model =_BgAry[i];
        NSString *kouyuAry = model.subject1;
        UIButton *bu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [bu.layer setMasksToBounds:YES];
        [bu.layer setBorderWidth:1.0];
        bu.layer.borderColor=[UIColor grayColor].CGColor;
        bu.frame = CGRectMake((Xi+(ratioWidth*210/2))*i+Xi,CGRectGetMaxY(titleLabel.frame)+ 20 * ratioHeight, ratioWidth*210/2,ratioHeight*70/2) ;
        [bu.layer setCornerRadius:ratioHeight*70/4];
        bu.backgroundColor = [UIColor whiteColor];
        bu.titleLabel.font = [UIFont systemFontOfSize:16*ratioHeight];
        [bu setTitle:kouyuAry forState:UIControlStateNormal];
        [bu setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        bu.tag =i+3000;
        [bu addTarget:self action:@selector(KoUYuction:) forControlEvents:UIControlEventTouchUpInside];
        [_whiltBgView addSubview:bu];
    }
    
    
    //划线
    UILabel *develi= [[UILabel alloc]initWithFrame:CGRectMake(0,titleLabel.bottom+130*ratioHeight/2 , _whiltBgView.width, 0.5)];
    develi.backgroundColor = [MyColor colorWithHexString:@"0x555555"];
    [_whiltBgView addSubview:develi];
    
    
    
    UILabel *TestTime = [WXLabel UIlabelFrame:CGRectMake(100, CGRectGetMaxY(develi.frame)+8, _whiltBgView.bounds.size.width-200, 25) textColor:[MyColor colorWithHexString:@"0x000000"] textFont:[UIFont systemFontOfSize:17*ratioHeight] labelTag:6];
    TestTime.text = @"考试时间";
    TestTime.textAlignment = NSTextAlignmentCenter;
    [_whiltBgView addSubview:TestTime];
    
    
    
    //时间选择器
    int hei = kScreenHeight > 480 ? 120  : 80 ;
    _PickView= [[UIPickerView alloc]init];
    _PickView.frame = CGRectMake(0, TestTime.bottom + 5 ,_whiltBgView.width ,hei * ratioHeight);
    _PickView.delegate = self;
    _PickView.dataSource =self;
    [_PickView selectRow:3 inComponent:0 animated:YES];
    NSString *time = _timeAry[3];
    [_allDic setValue:time forKey:@"time"];
    [_whiltBgView addSubview:_PickView];
    
    
    //划线
    UILabel *develi2= [[UILabel alloc]initWithFrame:CGRectMake(0,_PickView.bottom+10/2*ratioHeight , _whiltBgView.width, .5)];
    develi2.backgroundColor = [MyColor colorWithHexString:@"0x555555"];
    [_whiltBgView addSubview:develi2];
    UILabel *Souce = [WXLabel UIlabelFrame:CGRectMake(ratioWidth*200/2, develi2.bottom+40*ratioHeight/2, _whiltBgView.width-ratioWidth*400/2, ratioHeight*40/2) textColor:[MyColor colorWithHexString:@"0x000000"] textFont:[UIFont systemFontOfSize:17*ratioHeight] labelTag:7];
    Souce.text = @"目标分数";
    Souce.textAlignment = NSTextAlignmentCenter;
    [_whiltBgView addSubview:Souce];
    
    
    
    UILabel *ss = [WXLabel UIlabelFrame:CGRectMake(ratioWidth*160/2, Souce.bottom+20*ratioHeight/2, _whiltBgView.bounds.size.width-ratioWidth*320/2, ratioWidth*40/2) textColor:[MyColor colorWithHexString:@"0x555555"] textFont:[UIFont systemFontOfSize:13*ratioHeight] labelTag:8];
   
    Bgmodel *model = _BgAry[0];
    ss.text = model.full;
    ss.textAlignment = NSTextAlignmentCenter;
    [_whiltBgView addSubview:ss];
    
    index = 100;
    
    CGFloat kwid = (_whiltBgView.width-(ratioWidth*50/2*7))/8;
    NSArray *fenAry = model.fen;
    [fenAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *bu = [UIButton buttonWithType:UIButtonTypeCustom];
        [bu.layer setMasksToBounds:YES];
        [bu.layer setCornerRadius:ratioWidth*50/4];
        //设置边框宽度
        [bu.layer setBorderWidth:1];
        bu.layer.borderColor = [MyColor colorWithHexString:@"0x555555"].CGColor;
        bu.frame = CGRectMake((kwid+(ratioWidth*50/2))*idx+kwid,CGRectGetMaxY(ss.frame)+ 20 * ratioHeight, ratioWidth*50/2,ratioHeight*50/2) ;
        bu.titleLabel.font = [UIFont systemFontOfSize:13];
        [bu setTitle:obj forState:UIControlStateNormal];
        [bu setTitleColor:[MyColor colorWithHexString:@"0x555555"] forState:UIControlStateNormal];
        [_whiltBgView addSubview:bu];
        bu.tag =idx+100;
        [bu addTarget:self action:@selector(buAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }];
    
    UIButton *sele = (UIButton *)[_whiltBgView viewWithTag:100];
    
    UIControl *enterButton = [[UIControl alloc]init];
    enterButton.frame = CGRectMake((_whiltBgView.width- (370*ratioWidth/2))/2,sele.bottom + 20*ratioHeight, ratioWidth*370/2,ratioHeight*90/2) ;
    enterButton.backgroundColor = [MyColor colorWithHexString:@"0x0172fe"];
//    [enterButton setImage:[UIImage imageNamed:@"jiantou_01"] forState:UIControlStateNormal];
    UILabel *lable = [[UILabel alloc]init];
    lable.frame = CGRectMake((enterButton.width-50*ratioWidth)/2.0, 0, 50 * ratioWidth, enterButton.height);
    lable.text = @"OK";
    lable.textColor = [UIColor whiteColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont boldSystemFontOfSize:25.0];
    [enterButton addSubview:lable];
    [enterButton.layer setMasksToBounds:YES];
    [enterButton.layer setCornerRadius:ratioHeight*80/4];
    [_whiltBgView addSubview:enterButton];
    enterButton.tag =90;
    [enterButton addTarget:self action:@selector(buttonAction1:) forControlEvents:UIControlEventTouchUpInside];

}


#pragma mark -- 分数的点击事件
- (void)buAction:(UIButton *)button{
    
    NSInteger tag= button.tag;
    NSString*shuzi = button.titleLabel.text;
    [_allDic setValue:shuzi forKey:@"source"];
    _source = shuzi;
    button.backgroundColor = [MyColor colorWithHexString:@"0x0172fe"];
    selebutton = (UIButton *)[_whiltBgView viewWithTag:tag];
    [selebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    selebutton.layer.borderColor = [UIColor whiteColor].CGColor;
    UIButton *button1 = (UIButton *)[_whiltBgView viewWithTag:index];
    button1.backgroundColor = [MyColor colorWithHexString:@"#00000"];
    [button1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    button1.layer.borderColor = [MyColor colorWithHexString:@"0x555555"].CGColor;
    index = button.tag;
    
}



#pragma mark-----确定按钮的点击事件
- (void)buttonAction1:(UIButton*)button
{
    if (_titleType != nil) {
        if (_source !=nil) {
            self.hidden = YES;
            //    member_id用户ID
            //    subject APP考试科目 1托福 2雅思
            //    app_ex_time APP考试时间(2015年12月21日)
            //    app_t_score APP目标分数
            
            NSString *useid = [UserDefaults objectForKey:Userid];
            NSString *sub = _allDic[@"sub"];
            NSString *source =_allDic[@"source"];
            NSString *seletime = _allDic[@"time"];
             _parms = @{@"member_id":useid,
                           @"subject":sub,
                           @"app_ex_time":seletime,
                           @"app_t_score":source};
            //    上传数据
            [WXDataService requestAFWithURL:Url_setSubject
                                     params:_parms
                                 httpMethod:@"POST"
                                finishBlock:^(id result) {
                                    
                                    if (result){
                                        if ([result[@"status"] integerValue]==0){
                                            NSLog(@"ghggg:%@",result);
                                            [UserDefaults setObject:_allDic[@"sub"] forKey:subject];
                                            [UserDefaults setObject:_allDic[@"source"] forKey:app_t_score];
                                            [UserDefaults setObject:_allDic[@"time"] forKey:app_ex_time];
                                            [self.BgViewdelegate amount];
                                        }
                                       
                                    }
                                }
                                 errorBlock:^(NSError *error) {
                                     NSLog(@"%@",error);
                                 }];
    
        }else{
            [MBProgressHUD showError:@"请选择目标分数" toView:self ];
        }
 }else{
        [MBProgressHUD showError:@"请选择备考科目" toView:self];
    }
}


#pragma mark--雅思,托福点击事件
- (void)KoUYuction:(UIButton *)button{
    
    if (button.tag == 3000) {
        //更改选中颜色
        selebutton = (UIButton *)[_whiltBgView viewWithTag:3001];
        selebutton.backgroundColor = [UIColor whiteColor];
        [selebutton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        selebutton.layer.borderColor = [MyColor colorWithHexString:@"0x555555"].CGColor;
        button.backgroundColor = [MyColor colorWithHexString:@"0x0172fe"];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.layer.borderColor = [UIColor whiteColor].CGColor;
        
       
        //选取托福,雅思口语
        Bgmodel *model =_BgAry[0];
        _timeAry =model.time;
        [_allDic setValue:@"1" forKey:@"sub"];
        _titleType = model.subject1;
        UILabel *fenlabel  = (UILabel *)[_whiltBgView viewWithTag:8];
        fenlabel.text = model.full;
        [_PickView reloadAllComponents];
        
        
       //选取分数
        NSArray *fenAry = model.fen;
        CGFloat kwid = (_whiltBgView.width-(ratioWidth*50/2*7))/8;
        [fenAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *fenbu = (UIButton *)[_whiltBgView viewWithTag:100+idx];
            fenbu.hidden =NO;
            [fenbu setTitle:fenAry[idx] forState:UIControlStateNormal];
            fenbu.frame = CGRectMake((kwid+(ratioWidth*50/2))*idx+kwid,fenlabel.bottom+15, ratioWidth*50/2,ratioHeight*50/2);
        }];
    }
    
    if (button.tag == 3001) {
        
        //更改选中背景颜色
        selebutton = (UIButton *)[_whiltBgView viewWithTag:3000];
        selebutton.backgroundColor = [UIColor whiteColor];
        [selebutton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        selebutton.layer.borderColor = [MyColor colorWithHexString:@"0x555555"].CGColor;
        button.backgroundColor = [MyColor colorWithHexString:@"0x0172fe"];
        button.layer.borderColor = [UIColor whiteColor].CGColor;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        ////选取托福,雅思口语
        Bgmodel *model =_BgAry[1];
        _timeAry =model.time;
        [_allDic setValue:@"2" forKey:@"sub"];
        UILabel *fenlabel  = (UILabel *)[_whiltBgView viewWithTag:8];
        fenlabel.text = model.full;
        _titleType = model.subject1;
        [_PickView reloadAllComponents];
        
        
        ///将默认托福隐藏
        Bgmodel*TFmodel = _BgAry[0];
        NSArray *fenAry = TFmodel.fen;
        [fenAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *fenbu = (UIButton *)[_whiltBgView viewWithTag:100+idx];
            fenbu.hidden = YES;
        }];

        //分数
            Bgmodel *YSmodel = _BgAry[1];
            NSArray *fenAry1 = YSmodel.fen;
            CGFloat kwid = (_whiltBgView.width-((ratioWidth*50/2)*fenAry1.count))/(fenAry1.count+1);
            [fenAry1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *fenbu = (UIButton *)[_whiltBgView viewWithTag:100+idx];
            fenbu.hidden = NO;
            
            [fenbu setTitle:fenAry1[idx] forState:UIControlStateNormal];
            fenbu.frame = CGRectMake((kwid+(ratioWidth*50/2))*idx+kwid,fenlabel.bottom+15, ratioWidth*50/2,ratioHeight*50/2);
}];
}
}

#pragma mark---UIpickViewdelegate------
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
 
    return 1;
}


//确定picker的每个轮子的item数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    if (_timeAry==nil) {
        
        Bgmodel *model = _BgAry[0];
        _timeAry = model.time;
    }
    
    return _timeAry.count;
    
}

//每个item显示的内容
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    
        return _timeAry[row];

}


//监听选择单元格
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *time = _timeAry[row];
    [_allDic setValue:time forKey:@"time"];
}



- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{

    return ratioHeight*50/2;
}


@end

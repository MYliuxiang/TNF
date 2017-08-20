//
//  ProformainformationViewController.m
//  TNF
//
//  Created by 李立 on 15/12/17.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "ProformainformationViewController.h"
#import "bgView.h"
#import "Bgmodel.h"

@interface ProformainformationViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,strong)NSMutableArray *BgAry;
@property(nonatomic,strong)NSMutableDictionary *allDic;
@property(nonatomic,copy)NSString *source;
@property(nonatomic,copy)NSString *titleType;
@property(nonatomic,assign)NSUInteger picksele;//默认选中行

@property(nonatomic,assign)NSUInteger fensele;//记录分数按钮的tag值
@end

@implementation ProformainformationViewController{

    UIView *_whiltBgView;
    UIPickerView *_PickView;
    NSInteger index;
    NSArray *_timeAry;
    UIButton *selebutton;
    NSDictionary *_parms;//网络请求参数
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    //改变导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:UIColor(深色背景)]; 
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //导航栏标题
    self.text = @"备考信息";
    //当前视图的背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
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
        [self CreateWhiteBjViewFrame:self.view.bounds];
        [self moren];
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


- (void)moren{
    
    if ([UserDefaults boolForKey:ISLogin]) {
        
        //#define subject @"subject" //APP考试科目 1托福 2雅思
        //#define app_ex_time @"app_ex_time" //APP考试时间
        //#define app_t_score @"app_t_score" //APP目标分数
        
        NSString *su = [UserDefaults objectForKey:subject];
        NSString *time = [UserDefaults objectForKey:app_ex_time];
        NSString *score = [UserDefaults objectForKey:app_t_score];
        
        if ([su integerValue]==1) {

            UIButton *tuofu = (UIButton *)[_whiltBgView viewWithTag:3000];
            tuofu.backgroundColor = [MyColor colorWithHexString:@"0x0172fe"];
            [tuofu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            tuofu.layer.borderColor = [UIColor whiteColor].CGColor;
            [_allDic setValue:@"1" forKey:@"sub"];
            [self aa];

        }else if([su integerValue]==2){

            UIButton *tuofu = (UIButton *)[_whiltBgView viewWithTag:3001];
            tuofu.backgroundColor = [MyColor colorWithHexString:@"0x0172fe"];
            [tuofu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            tuofu.layer.borderColor = [UIColor whiteColor].CGColor;
            [_allDic setValue:@"1" forKey:@"sub"];
            [self bb];
        }
        
        for (int i =0; i<_BgAry.count; i++) {
            Bgmodel *model = _BgAry[i];

            if ([model.subject1 isEqualToString:@"托福口语"]) {
                NSArray *fenbutton = model.fen;
                for (int i=0; i<fenbutton.count; i++) {
                    if ([score integerValue] == [fenbutton[i] integerValue]) {
                        self.fensele = 100+i;
                        break;
                    }
                }
                
            }else if ([model.subject1 isEqualToString:@"雅思口语"]){
                NSArray *fenbutton = model.fen;
                for (int aa=0; aa<fenbutton.count; aa++) {
                    NSInteger ss =[score floatValue]*10;
                    NSInteger sss = [fenbutton[aa] floatValue]*10;
                    if (ss == sss) {
                        self.fensele = 100+aa;
                        break;
                    }
                }
               

            }
        }
    
        UIButton *fenshou = (UIButton *)[_whiltBgView viewWithTag:self.fensele];
        fenshou.backgroundColor = [MyColor colorWithHexString:@"0x0172fe"];
        [fenshou setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        fenshou.layer.borderColor = [UIColor whiteColor].CGColor;
        NSString *ss= fenshou.titleLabel.text;
        _source=ss;
        [_allDic setValue:ss forKey:@"source"];
        
        
//        if ([su integerValue]==1) {
//            
//            UIButton *tuofu = (UIButton *)[_whiltBgView viewWithTag:3000];
//            tuofu.backgroundColor = [MyColor colorWithHexString:@"0x0172fe"];
//            [tuofu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            tuofu.layer.borderColor = [UIColor whiteColor].CGColor;
//           
//            
//            NSInteger tag = (12-(30.0-[score integerValue]))/2+100;
//            UIButton *fenshou = (UIButton *)[_whiltBgView viewWithTag:tag];
//            fenshou.backgroundColor = [MyColor colorWithHexString:@"0x0172fe"];
//            [fenshou setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            fenshou.layer.borderColor = [UIColor whiteColor].CGColor;
//            [_allDic setValue:score forKey:@"source"];
//            _source = score;
//            [self aa];
//            
//            
//            
//            
//        }else if([su integerValue]==2){
//           
//            UIButton *tuofu = (UIButton *)[_whiltBgView viewWithTag:3001];
//            tuofu.backgroundColor = [MyColor colorWithHexString:@"0x0172fe"];
//            [tuofu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            tuofu.layer.borderColor = [UIColor whiteColor].CGColor;
//            
//            NSInteger tag = (3.0-(8.0-[score floatValue]))/0.5+100;
//            UIButton *fenshou = (UIButton *)[_whiltBgView viewWithTag:tag];
//            fenshou.backgroundColor = [MyColor colorWithHexString:@"0x0172fe"];
//            [fenshou setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            fenshou.layer.borderColor = [UIColor whiteColor].CGColor;
//            [_allDic setValue:score forKey:@"source"];
//            _source = score;
//            [self bb];
//        }
        
        [_timeAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqualToString:time]) {
                [_PickView selectRow:idx inComponent:0 animated:NO];
                self.picksele = idx;
                [_allDic setValue:time forKey:@"time"];
                return ;
            }
        }];
        
    }
}



//创建白色背景视图
- (void)CreateWhiteBjViewFrame:(CGRect)frame{
    
    _whiltBgView = [[UIView alloc]initWithFrame:frame];
    _whiltBgView.backgroundColor = [UIColor whiteColor];
    _whiltBgView.layer.masksToBounds =YES;
    _whiltBgView.layer.cornerRadius= 5;
    
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(ratioWidth*200/2, 15*ratioHeight, _whiltBgView.bounds.size.width-400*ratioWidth/2, ratioHeight * 17)];
    NSLog(@"%f",ratioHeight);
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:17*ratioHeight];
    [titleLabel setTintColor:[MyColor colorWithHexString:@"0x000000"]];
    titleLabel.text = @"备考科目";
    [_whiltBgView addSubview:titleLabel];
    [self.view addSubview:_whiltBgView];
    
    
    CGFloat Xi = (_whiltBgView.width-(ratioWidth*210))/3;
    for (int i =0; i<2; i++) {
        Bgmodel *model =_BgAry[i];
        NSString *kouyuAry = model.subject1;
        UIButton *bu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [bu.layer setMasksToBounds:YES];
        [bu.layer setBorderWidth:1.0];
        bu.layer.borderColor=[UIColor grayColor].CGColor;
        bu.frame = CGRectMake((Xi+(ratioWidth*210/2))*i+Xi,titleLabel.bottom+ 10 * ratioWidth, ratioWidth*210/2,ratioHeight*70/2) ;
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
    
    
    
    UILabel *TestTime = [WXLabel UIlabelFrame:CGRectMake(ratioWidth*100/2, develi.bottom+ 15 * ratioHeight, _whiltBgView.width-200*ratioHeight/2, 17*ratioHeight) textColor:[MyColor colorWithHexString:@"0x000000"] textFont:[UIFont systemFontOfSize:17*ratioHeight] labelTag:6];
    TestTime.text = @"考试时间";
    TestTime.textAlignment = NSTextAlignmentCenter;
    [_whiltBgView addSubview:TestTime];
    
    
    
    //时间选择器
    int hei = kScreenHeight > 480 ? 200  : 10 ;
    _PickView= [[UIPickerView alloc]init];
    _PickView.frame = CGRectMake(0, TestTime.bottom,_whiltBgView.width ,hei * ratioHeight);
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
    
    UILabel *Souce = [WXLabel UIlabelFrame:CGRectMake(ratioWidth*200/2, develi2.bottom + 15*ratioHeight, _whiltBgView.width-ratioWidth*400/2, ratioHeight*40/2) textColor:[MyColor colorWithHexString:@"0x000000"] textFont:[UIFont systemFontOfSize:17*ratioHeight] labelTag:7];
    Souce.text = @"目标分数";
    Souce.textAlignment = NSTextAlignmentCenter;
    [_whiltBgView addSubview:Souce];
    
    
   //满分介绍
    UILabel *ss = [WXLabel UIlabelFrame:CGRectMake(ratioWidth*160/2, Souce.bottom + 15 *ratioHeight, _whiltBgView.width-ratioWidth*320/2, ratioWidth*13) textColor:[MyColor colorWithHexString:@"0x555555"] textFont:[UIFont systemFontOfSize:13*ratioHeight] labelTag:8];
    
    Bgmodel *model = _BgAry[0];
    ss.text = model.full;
    ss.textAlignment = NSTextAlignmentCenter;
    [_whiltBgView addSubview:ss];
    
    index = 10;
    
    CGFloat kwid = (_whiltBgView.width-(ratioWidth*50/2*7))/8;
    NSArray *fenAry = model.fen;
    [fenAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *bu = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //设置边框宽度
        [bu.layer setBorderWidth:1];
        bu.layer.borderColor = [MyColor colorWithHexString:@"0x555555"].CGColor;
        bu.frame = CGRectMake((kwid+(ratioWidth*50/2))*idx+kwid,ss.bottom + 20 * ratioWidth, 50/2.0 * ratioWidth,50/2.0 * ratioWidth);
        bu.titleLabel.font = [UIFont systemFontOfSize:13];
        [bu setTitle:obj forState:UIControlStateNormal];
        
        [bu.layer setCornerRadius:48/4.0 * ratioWidth];
        [bu.layer setMasksToBounds:YES];
        [bu setTitleColor:[MyColor colorWithHexString:@"0x555555"] forState:UIControlStateNormal];
        [_whiltBgView addSubview:bu];
        bu.tag =idx+100;
        [bu addTarget:self action:@selector(buAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }];
    
    UIButton *sele = (UIButton *)[_whiltBgView viewWithTag:100];
    UIControl *enterButton = [[UIControl alloc]init];
    int h = kScreenHeight > 480 ? 15  : 6 ;
    enterButton.frame = CGRectMake((_whiltBgView.width-(370*ratioWidth/2))/2,sele.bottom + h * ratioHeight, ratioWidth*370/2,ratioHeight * 80/2) ;
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
    
    
    button.selected =! button.selected;
    if (button.selected) {
        NSLog(@"选中");
        NSString*shuzi = button.titleLabel.text;
        [_allDic setValue:shuzi forKey:@"source"];
        _source = shuzi;
    }else{
        [_allDic setValue:@"" forKey:@"source"];
        _source =nil;
        NSLog(@"没选中");
    }
   
 
    
    
    NSString *su = [UserDefaults objectForKey:subject];
    if ([su integerValue]==1) {
        UIButton *fenshou = (UIButton *)[_whiltBgView viewWithTag:self.fensele];
        fenshou.backgroundColor = [MyColor colorWithHexString:@"#00000"];
        [fenshou setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
         fenshou.layer.borderColor = [MyColor colorWithHexString:@"0x555555"].CGColor;
      
        
    }else if([su integerValue]==2){
        UIButton *fenshou = (UIButton *)[_whiltBgView viewWithTag:self.fensele];
        fenshou.backgroundColor = [MyColor colorWithHexString:@"#00000"];
        [fenshou setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        fenshou.layer.borderColor = [MyColor colorWithHexString:@"0x555555"].CGColor;
    }
    
    NSInteger tag= button.tag;
  
   
    button.backgroundColor = [MyColor colorWithHexString:@"0x0172fe"];
    selebutton = (UIButton *)[_whiltBgView viewWithTag:tag];
    [selebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     selebutton.layer.borderColor = [UIColor whiteColor].CGColor;
    
    //防止记录上一个button点击更改不了状态
    for (int i =0; i<_BgAry.count; i++) {
        Bgmodel *model = _BgAry[i];
        if ([model.subject1 isEqualToString:@"托福口语"]) {
            NSArray *fenbutton = model.fen;
            if (index>=100 &&index<fenbutton.count+100) {
                UIButton *button1 = (UIButton *)[_whiltBgView viewWithTag:index];
                button1.backgroundColor = [MyColor colorWithHexString:@"#00000"];
                [button1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                button1.layer.borderColor = [MyColor colorWithHexString:@"0x555555"].CGColor;
            }
        }else if ([model.subject1 isEqualToString:@"雅思口语"]){
            NSArray *fenbutton = model.fen;
            if (index>=100 &&index<fenbutton.count+100) {
                UIButton *button1 = (UIButton *)[_whiltBgView viewWithTag:index];
                button1.backgroundColor = [MyColor colorWithHexString:@"#00000"];
                [button1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                button1.layer.borderColor = [MyColor colorWithHexString:@"0x555555"].CGColor;
               
            }
        }
    }
    
   
    
    if (button.tag == index) {
        if (button.selected) {
            button.backgroundColor = [MyColor colorWithHexString:@"0x0172fe"];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.layer.borderColor = [UIColor whiteColor].CGColor;
        }else {;
            button.backgroundColor = [MyColor colorWithHexString:@"#00000"];
            [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            button.layer.borderColor = [MyColor colorWithHexString:@"0x555555"].CGColor;
        }
    }
    index = button.tag;
    
}



#pragma mark-----确定按钮的点击事件
- (void)buttonAction1:(UIButton*)button
{
    if (_titleType != nil) {
        if (_source !=nil) {
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
                                        NSLog(@"%@",result);
                                        [UserDefaults setObject:result[@"subject"] forKey:subject];
                                        [UserDefaults setObject:result[@"app_t_score"] forKey:app_t_score];
                                        [UserDefaults setObject:result[@"app_ex_time"] forKey:app_ex_time];
                                        [self.navigationController popViewControllerAnimated:YES];
                                        NSLog(@"hjhgggggg%@",[UserDefaults objectForKey:subject]);
                                    }
                                }
                                 errorBlock:^(NSError *error) {
                                     NSLog(@"%@",error);
                                 }];
            
        }else{
            [MBProgressHUD showError:@"请选择目标分数" toView:self.view ];
        }
    }else{
        [MBProgressHUD showError:@"请选择备考科目" toView:self.view];
    }
}


#pragma mark--雅思,托福点击事件
- (void)KoUYuction:(UIButton *)button{
    
//    static NSInteger taggg;
    
    if (button.tag == 3000) {
        
        //更改选中颜色
        selebutton = (UIButton *)[_whiltBgView viewWithTag:3001];
        selebutton.backgroundColor = [UIColor whiteColor];
        [selebutton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        selebutton.layer.borderColor = [MyColor colorWithHexString:@"0x555555"].CGColor;
        button.backgroundColor = [MyColor colorWithHexString:@"0x0172fe"];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.layer.borderColor = [UIColor whiteColor].CGColor;
        [self aa];
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
        [self bb];
   
    }
    
    
    if ([[UserDefaults objectForKey:subject]integerValue]==1) {
        if(_source !=nil){
            UIButton *fenshou = (UIButton *)[_whiltBgView viewWithTag:self.fensele];
            NSString  *fen = fenshou.titleLabel.text;
            [_allDic setValue:fen forKey:@"source"];
            _source=fen;
            NSLog(@"hhhh:%@",fen);
        }
      
        
        [_PickView selectRow:self.picksele inComponent:0 animated:YES];
        NSString *time = _timeAry[self.picksele];
        [_allDic setValue:time forKey:@"time"];

    }
    
    
    if ([[UserDefaults objectForKey:subject]integerValue]==2) {
        if (_source !=nil) {
            UIButton *fenshou = (UIButton *)[_whiltBgView viewWithTag:self.fensele];
            NSString  *fen = fenshou.titleLabel.text;
            [_allDic setValue:fen forKey:@"source"];
            _source=fen;
            NSLog(@"kkkk:%@",fen);
        }
      
     
        [_PickView selectRow:self.picksele inComponent:0 animated:YES];
        NSString *time = _timeAry[self.picksele];
        [_allDic setValue:time forKey:@"time"];

    
//    [_allDic setValue:_source forKey:@"source"];
}
}

-(void)aa{
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
        fenbu.frame = CGRectMake((kwid+(ratioWidth*50/2))*idx+kwid,fenlabel.bottom+15*ratioWidth, ratioWidth*50/2,ratioHeight*50/2);
    }];

}

- (void)bb{

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
        fenbu.frame = CGRectMake((kwid+(ratioWidth*50/2))*idx+kwid,fenlabel.bottom+ 15*ratioWidth, ratioWidth*50/2,ratioHeight*50/2);
    }];
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
//    NSString *num = [NSString stringWithFormat:@"%ld",row];
//    [UserDefaults setObject:num forKey:timepickline];
    [_allDic setValue:time forKey:@"time"];
}



- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return ratioHeight*50/2;
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

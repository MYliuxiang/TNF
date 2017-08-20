//
//  BgView1.m
//  TNF
//
//  Created by 李善 on 15/12/18.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "BgView1.h"

@implementation BgView1

- (instancetype)initWithFrame:(CGRect)frame
                    TodayFubi:(NSString *)TodayFubi
                 TomorrowFubi:(NSString *)TomorrowFubi{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.hidden = NO;
        //半透明背景视图
        [self  setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
        
        UIView *whiltBgView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-(ratioWidth*540/2))/2,(kScreenHeight-(ratioHeight*600/2))/2, ratioWidth*540/2, ratioHeight*600/2)];
        [whiltBgView.layer setMasksToBounds:YES ];
        [whiltBgView.layer setCornerRadius:5];
        //白色背景视图
        whiltBgView.backgroundColor = [MyColor colorWithHexString:@"0xf0f0f0"];
        [self addSubview:whiltBgView];
        
        
        
        //标题
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(ratioWidth*200/2, ratioHeight*40/2, whiltBgView.width-ratioWidth*400/2, ratioHeight*30/2)];
        titleLabel.textAlignment=NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:17*ratioHeight];
        [titleLabel setTintColor:[MyColor colorWithHexString:@"0x000000"]];
        titleLabel.text = @"今日奖励";
        [whiltBgView addSubview:titleLabel];
        
        
        
        
        //背景图片
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, ratioWidth*100/2, ratioWidth*540/2, ratioHeight*240/2)];
//        imgView.backgroundColor = [UIColor darkGrayColor];
        imgView.image = imageNamed(@"qiandaobg");
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake((whiltBgView.width-180*ratioWidth/2)/2, 25*ratioHeight/2, 180*ratioWidth/2, 180*ratioWidth/2)];
        [view.layer setMasksToBounds:YES];
        [view.layer setCornerRadius:180*ratioWidth/4];
        view.backgroundColor =[UIColor colorWithRed:161/255.0 green:116/255.0 blue:58/255.0 alpha:1];
        [whiltBgView addSubview:imgView];
        [imgView addSubview:view];
        
        
        
        UILabel *TestTime = [WXLabel UIlabelFrame:CGRectMake(0, 30*ratioWidth/2,view.width, 70*ratioHeight/2) textColor:[UIColor whiteColor] textFont:[UIFont boldSystemFontOfSize:50*ratioHeight/2]labelTag:6];
        TestTime.text = [NSString stringWithFormat:@"+%@",TodayFubi];
        TestTime.textAlignment = NSTextAlignmentCenter;
        [view addSubview:TestTime];
        
        UIImageView *fubi = [[UIImageView alloc]initWithFrame:CGRectMake(50*ratioWidth/2, TestTime.bottom,80*ratioWidth/2, 50*ratioHeight/2)];
        fubi.image =[UIImage imageNamed:@"photo_01"];
        [view addSubview:fubi];
        _amount = TodayFubi;
        
        
        UILabel *label2 = [WXLabel UIlabelFrame:CGRectMake(100*ratioWidth/2, imgView.bottom+10*ratioHeight/2,whiltBgView.width-200*ratioWidth/2, 40*ratioHeight/2) textColor:UIColor6(<#正文小字#>) textFont:[UIFont systemFontOfSize:13*ratioHeight]labelTag:6];
        CGFloat height = [WXLabel getTextHeight:13*ratioHeight width:whiltBgView.width-200*ratioWidth/2 text:TomorrowFubi linespace:10];
        label2.numberOfLines = 0;
        label2.lineBreakMode = NSLineBreakByWordWrapping;
        label2.textAlignment = NSTextAlignmentCenter;
        label2.text =TomorrowFubi;
        [label2 setHeight:height];
        [whiltBgView addSubview:label2];

        
        
        UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        enterButton.frame = CGRectMake((whiltBgView.width-(370*ratioWidth/2))/2,label2.bottom+20, ratioWidth*370/2,ratioHeight*90/2) ;
        enterButton.backgroundColor = [MyColor colorWithHexString:@"0x0172fe"];
        //弧形
        [enterButton.layer setMasksToBounds:YES];
        [enterButton.layer setCornerRadius:ratioHeight*90/4];
        enterButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [enterButton setTitle:@"领取" forState:UIControlStateNormal];
        [whiltBgView addSubview:enterButton];
        enterButton.tag =100;
        [enterButton addTarget:self action:@selector(enterAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)enterAction:(UIButton *)button{
    self.hidden = YES;
    NSString *member = [UserDefaults objectForKey:Userid];
    NSString *amount =_amount;
    NSDictionary *parmas = @{@"member_id":member,
                             @"amount":amount};
    
    
    [WXDataService requestAFWithURL:Url_setAmount params:parmas httpMethod:@"POST" finishBlock:^(id result) {
        NSLog(@"领取福币:%@",result);
        if ([result[@"states"] intValue]== 0) {
            [_BgViewdelegate amount1];
             [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
        }
        
        if([result[@"states"] intValue]== 1){
            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
        }
        
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];

    NSLog(@"点击了");
}

@end

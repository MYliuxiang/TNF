//
//  BgView2.m
//  TNF
//
//  Created by 李善 on 15/12/18.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "BgView2.h"

@implementation BgView2

- (instancetype)initWithFrame:(CGRect)frame
                        Title:(NSString *)title
                         Text:(NSString *)text
                        Text1:(NSString*)text1{
  
    self = [super initWithFrame:frame];
  
    if (self) {
      
        //创建背景视图
        [self  setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        
        
        
        //创建白色背景视图
        UIView *whiltBgView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-(ratioWidth*540/2))/2,(kScreenHeight-(ratioHeight*600/2))/2, ratioWidth*540/2, ratioHeight*500/2)];
        whiltBgView.backgroundColor = [MyColor colorWithHexString:@"0xf0f0f0"];
        [whiltBgView.layer setMasksToBounds:YES];
        [whiltBgView.layer setCornerRadius:5];
        [self addSubview:whiltBgView];
        
        
        //创建标题label
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, whiltBgView.bounds.size.width-200, 30)];
        titleLabel.textAlignment=NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:17*ratioHeight];
        [titleLabel setTintColor:[MyColor colorWithHexString:@"0x000000"]];
        titleLabel.text = @"预估分数";
        [whiltBgView addSubview:titleLabel];
        
        
        //数
        UILabel *label1 = [WXLabel UIlabelFrame:CGRectMake(ratioWidth*120/2, titleLabel.bottom+40*ratioHeight/2,whiltBgView.width-ratioWidth*240/2, ratioHeight*100/2) textColor:[MyColor colorWithHexString:@"0x000000"] textFont:[UIFont boldSystemFontOfSize:40*ratioHeight] labelTag:12];
        label1.text=title;
        label1.textAlignment = NSTextAlignmentCenter;
        [whiltBgView addSubview:label1];
        
        
        
        //数字0.1.2.3.4.5
        UILabel *label2 = [WXLabel UIlabelFrame:CGRectZero
                                      textColor:[UIColor darkGrayColor]
                                       textFont:[UIFont systemFontOfSize:13*ratioHeight]
                                       labelTag:11];
        //换行
        label2.lineBreakMode = NSLineBreakByWordWrapping;
        label2.numberOfLines = 0;
        CGFloat label2width =whiltBgView.width-20;
        //自动获取高度
        CGFloat titleheight = [WXLabel getTextHeight:13*ratioHeight
                                               width:label2width
                                                text:text
                                           linespace:10];
        label2.text = text;
        label1.textColor = UIColor6(正文小字);
        label2.frame = CGRectMake(ratioWidth*40/2, label1.bottom+30*ratioHeight/2, whiltBgView.width-ratioWidth*40/2, titleheight);
        [whiltBgView addSubview:label2];
        
        
        //确定按钮
        UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        enterButton.frame = CGRectMake((whiltBgView.width-(370*ratioWidth/2))/2,label2.bottom+30*ratioHeight/2, ratioWidth*370/2,ratioHeight*90/2) ;
        enterButton.backgroundColor = [MyColor colorWithHexString:@"0x0172fe"];
        [enterButton.layer setMasksToBounds:YES];
        [enterButton.layer setCornerRadius:ratioHeight*90/4];
        enterButton.titleLabel.font = [UIFont systemFontOfSize:20];
        [enterButton setTitle:@"OK" forState:UIControlStateNormal];
        [enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [whiltBgView addSubview:enterButton];
        enterButton.tag =102;
        [enterButton addTarget:self action:@selector(enterAction:) forControlEvents:UIControlEventTouchUpInside];
    
    }
    
    return self;
}


#pragma mark -- OK点击事件
- (void)enterAction:(UIButton *)button{

    self.hidden =YES;

}


@end

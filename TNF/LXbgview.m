//
//  LXbgview.m
//  TNF
//
//  Created by 刘翔 on 16/1/4.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "LXbgview.h"

@implementation LXbgview

- (instancetype)initWithFrame:(CGRect)frame
                        Title:(NSString *)title
                         Text:(NSString *)text
                     delegate:(id<LXbgviewDelegate>)delegate{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _delegate = delegate;
        //创建背景视图
        [self  setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
                
        //创建白色背景视图
        UIView *whiltBgView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-(ratioWidth * 270))/2 ,(kScreenHeight - (ratioHeight * 600 / 2))/2, ratioWidth * 270, ratioHeight * 250)];
        whiltBgView.backgroundColor = [MyColor colorWithHexString:@"0xf0f0f0"];
        [whiltBgView.layer setMasksToBounds:YES];
        [whiltBgView.layer setCornerRadius:5];
        [self addSubview:whiltBgView];
        
        
        //创建标题label
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, whiltBgView.bounds.size.width , 20 * ratioHeight)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:15 * ratioHeight];
        [titleLabel setTintColor:[MyColor colorWithHexString:@"0x000000"]];
        titleLabel.text = title;
        [whiltBgView addSubview:titleLabel];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((whiltBgView.width - 64) / 2.0, titleLabel.bottom + 20 * ratioHeight, 60 * ratioHeight, 60 * ratioHeight)];
        imageView.image = [UIImage imageNamed:@"gou_02"];
        [whiltBgView addSubview:imageView];
        
        //数字0.1.2.3.4.5
        UILabel *label2 = [WXLabel UIlabelFrame:CGRectZero
                                      textColor:[UIColor darkGrayColor]
                                       textFont:[UIFont systemFontOfSize:13*ratioHeight]
                                       labelTag:11];
        //换行
        label2.lineBreakMode = NSLineBreakByWordWrapping;
        label2.numberOfLines = 0;
        CGFloat label2width = 13 * ratioHeight * 9;
        //自动获取高度
        CGFloat titleheight = [WXLabel getTextHeight:13*ratioHeight
                                               width:label2width
                                                text:text
                                           linespace:10];
        label2.text = text;
        label2.textAlignment = NSTextAlignmentCenter;
        label2.frame = CGRectMake((whiltBgView.width - label2width) / 2.0, imageView.bottom+30*ratioHeight/2, 13 * ratioHeight * 9, titleheight);
        [whiltBgView addSubview:label2];
        
        
        //确定按钮
        UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        enterButton.frame = CGRectMake((whiltBgView.width-(370*ratioWidth/2))/2,label2.bottom + 40 * ratioHeight/2, ratioWidth*370/2,ratioHeight*90/2) ;
        enterButton.backgroundColor = [MyColor colorWithHexString:@"0x0172fe"];
        [enterButton.layer setMasksToBounds:YES];
        [enterButton.layer setCornerRadius:ratioHeight*90/4];
        enterButton.titleLabel.font = [UIFont systemFontOfSize:20];
        [enterButton setTitle:@"OK" forState:UIControlStateNormal];
        [enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [whiltBgView addSubview:enterButton];
        enterButton.tag =102;
        [enterButton addTarget:self action:@selector(enterAction:) forControlEvents:UIControlEventTouchUpInside];
        
        whiltBgView.height = enterButton.bottom + 20 * ratioHeight;
        
    }
    
    return self;
}


#pragma mark -- OK点击事件
- (void)enterAction:(UIButton *)button{
    
    [self removeFromSuperview];
    [self.delegate clickOK];
    
}


@end

//
//  BgView5.m
//  TNF
//
//  Created by 李善 on 15/12/18.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "BgView5.h"

@implementation BgView5

- (instancetype)initWithFrame:(CGRect)frame
                        Title:(NSString *)title
                      ImgNames:(NSArray *)imgNames
               bgviewdelegate:(id<BgView5delegate>)delegate
                         Text:(NSString *)text
                        Text1:(NSString*)text1
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //背景视图
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        
        
        //白色背景视图
        UIView *whiltBgView = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-(ratioWidth*540/2))/2,(kScreenHeight-(ratioHeight*600/2))/2+40, ratioWidth*540/2, ratioHeight*400/2)];
        whiltBgView.backgroundColor = [MyColor colorWithHexString:@"0xf0f0f0"];
        [self addSubview:whiltBgView];
        
        
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, whiltBgView.bounds.size.width-100, 30)];
        titleLabel.backgroundColor = [UIColor darkGrayColor];
        titleLabel.textAlignment=NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:18];
        [titleLabel setTintColor:[MyColor colorWithHexString:@"0x000000"]];
        titleLabel.text = @"打赏老师";
        [whiltBgView addSubview:titleLabel];
        
        
        
        UILabel *TestTime = [WXLabel UIlabelFrame:CGRectMake(50, titleLabel.bottom+10, whiltBgView.width-100, 20) textColor:[MyColor colorWithHexString:@"0x000000"] textFont:[UIFont systemFontOfSize:15]labelTag:6];
        TestTime.text = @"感谢老师的帮助,对我很有帮助!";
        TestTime.textAlignment = NSTextAlignmentCenter;
        [whiltBgView addSubview:TestTime];
        
        
        CGFloat ButtonWidth = (whiltBgView.width-120)/3;
        
        for (int index =0 ; index<3;index++) {
            
        UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            enterButton.frame = CGRectMake((ButtonWidth +30)*index+30, TestTime.bottom+35, ButtonWidth, 105);
            
            enterButton.backgroundColor = [UIColor yellowColor];
            
            [whiltBgView addSubview:enterButton];
            
            enterButton.tag = index;
            
        }
        
    }
    
    return self;
}

#pragma mark -- 确定按钮点击事件
- (void)EnterAction:(UIButton *)button{
    
    if (button.tag == 0) {
        
        NSLog(@"1");
    }
    
    if (button.tag == 1) {
        
        NSLog(@"2");
    }
    
    
    if (button.tag == 2) {
        
        NSLog(@"3");
    }
    
}


@end

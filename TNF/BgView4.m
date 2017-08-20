//
//  BgView4.m
//  TNF
//
//  Created by 李善 on 15/12/18.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "BgView4.h"

@implementation BgView4

- (instancetype)initWithFrame:(CGRect)frame
                        Title:(NSString *)title
                     Delegate:(id<BgView4delegate>)delegate
                       Mycost:(NSString *)mycost
                         Cost:(NSString*)cost
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _BgViewdelegate = delegate;
       
        
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = .8;
        [[UIApplication sharedApplication].keyWindow addSubview:_bgView];
        
        _whiteView = [[UIView alloc]initWithFrame:CGRectMake(self.left, self.top, self.width, self.height)];
        _whiteView.backgroundColor = [MyColor colorWithHexString:@"0xf0f0f0"];
        _whiteView.layer.cornerRadius = 5;
        _whiteView.layer.masksToBounds = YES;
        [[UIApplication sharedApplication].keyWindow addSubview:_whiteView];
        
        
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 10 * ratioHeight, _whiteView.bounds.size.width-100, 30)];
        titleLabel.textAlignment=NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:17 *ratioHeight];
        [titleLabel setTintColor:[MyColor colorWithHexString:@"0x000000"]];
        titleLabel.text = title;
        [_whiteView addSubview:titleLabel];
        
        //删除按钮
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        deleteButton.frame = CGRectMake(_whiteView.width - 15 * ratioHeight - 10, 10, 15 * ratioHeight, 15 * ratioHeight);
        
        [deleteButton setImage:[UIImage imageNamed:@"close_01"] forState:UIControlStateNormal];
        
        [deleteButton addTarget:self action:@selector(deleteButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_whiteView addSubview:deleteButton];
        
        UILabel *TestTime = [WXLabel UIlabelFrame:CGRectMake(50, titleLabel.bottom+ 20 * ratioHeight , _whiteView.width-100, 20) textColor:UIColor6(正文小字) textFont:[UIFont systemFontOfSize:15 * ratioHeight]labelTag:6];
        TestTime.text = cost;
        TestTime.textAlignment = NSTextAlignmentCenter;
        [_whiteView addSubview:TestTime];
        
        
        UILabel *label2 = [WXLabel UIlabelFrame:CGRectMake(40, TestTime.bottom + 3, _whiteView.bounds.size.width-80, 20) textColor:UIColor6(正文小字) textFont:[UIFont systemFontOfSize:15 * ratioHeight]labelTag:6];
        label2.text = mycost;
        label2.textAlignment = NSTextAlignmentCenter;
        [_whiteView addSubview:label2];
        
        
        UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        enterButton.frame = CGRectMake((_whiteView.width-(370*ratioWidth/2))/2,_whiteView.height - 15 * ratioHeight - ratioHeight*90/2, ratioWidth*370/2,ratioHeight*90/2) ;
        enterButton.backgroundColor = [MyColor colorWithHexString:@"0x0172fe"];
        //弧形
        [enterButton.layer setMasksToBounds:YES];
        [enterButton.layer setCornerRadius:ratioHeight*90/4];
        enterButton.titleLabel.font = [UIFont systemFontOfSize:17 *ratioHeight];
        [enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [enterButton setTitle:@"获取福币" forState:UIControlStateNormal];
        [_whiteView addSubview:enterButton];
        enterButton.tag =100;
        [enterButton addTarget:self action:@selector(EnterAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

#pragma mark -- 确定按钮点击事件
- (void)EnterAction:(UIButton *)UIbutton{

    NSLog(@"确定");
    [self.BgViewdelegate selecetbtn];
    [_whiteView removeFromSuperview];
    [_bgView removeFromSuperview];
    [self removeFromSuperview];


}

- (void)deleteButtonAction
{
    
    [_whiteView removeFromSuperview];
    [_bgView removeFromSuperview];
    [self removeFromSuperview];
    
}

@end

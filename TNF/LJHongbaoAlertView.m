//
//  LJHongbaoAlertView.m
//  TNF
//
//  Created by lijiang on 15/12/24.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "LJHongbaoAlertView.h"

@implementation LJHongbaoAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
        monenyArray:(NSArray *)monenyArray
              title:(NSString *)title
               text:(NSString *)text
           delegate:(id)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
    
        _ljdelegate = delegate;
        _dataArray = monenyArray;
        
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = .8;
        [[UIApplication sharedApplication].keyWindow addSubview:_bgView];
        
        _whiteView = [[UIView alloc]initWithFrame:CGRectMake(self.left, self.top, self.width, self.height)];
        _whiteView.backgroundColor = [MyColor colorWithHexString:@"0xf0f0f0"];
        _whiteView.layer.cornerRadius = 5;
        _whiteView.layer.masksToBounds = YES;
        [[UIApplication sharedApplication].keyWindow addSubview:_whiteView];
        
        
        

        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, _whiteView.width, 30)];
        titleLabel.textAlignment=NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:17 * ratioHeight];
        [titleLabel setTintColor:[MyColor colorWithHexString:@"0x000000"]];
        titleLabel.text = title;
        [_whiteView addSubview:titleLabel];
        
        
        
        UILabel *TestTime = [[UILabel alloc]initWithFrame:CGRectMake(0, titleLabel.bottom+10, _whiteView.width, 20 * ratioHeight) ];
        TestTime.textAlignment = NSTextAlignmentCenter;
        TestTime.font = [UIFont systemFontOfSize:13 * ratioHeight];
        TestTime.textColor = UIColor6(正文小字);
        TestTime.text = text;
        [_whiteView addSubview:TestTime];
        
        
        //删除按钮
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        deleteButton.frame = CGRectMake(_whiteView.width - 15 * ratioHeight - 10, 10, 15 * ratioHeight, 15 * ratioHeight);
        
        [deleteButton setImage:[UIImage imageNamed:@"close_01"] forState:UIControlStateNormal];
        
        [deleteButton addTarget:self action:@selector(deleteButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_whiteView addSubview:deleteButton];
        
        CGFloat ButtonWidth = (_whiteView.width-120 * ratioWidth)/3;
        CGFloat ButtonHeight  = _whiteView.height - TestTime.bottom - 25 - 25 * ratioHeight;
        
        for (int index =0 ; index< monenyArray.count;index++) {
            
            UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            enterButton.frame = CGRectMake((_whiteView.width - monenyArray.count * ButtonWidth) / 4.0 *(index + 1) + ButtonWidth * index, TestTime.bottom+25, ButtonWidth, ButtonHeight);
            
            [enterButton setImage:[UIImage imageNamed:@"momey_03"] forState:UIControlStateNormal];
            
            [enterButton addTarget:self action:@selector(enterButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [_whiteView addSubview:enterButton];
            
             enterButton.tag = index + 100;
            
            UILabel *moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 15 * ratioHeight, enterButton.width, 20)];
            moneyLabel.textAlignment=NSTextAlignmentCenter;
            moneyLabel.font = [UIFont boldSystemFontOfSize:13 * ratioHeight];
            moneyLabel.textColor = [UIColor whiteColor];
            moneyLabel.text = monenyArray[index];
            [enterButton addSubview:moneyLabel];
            
            
        }

        
    }
    return self;
}

- (void)enterButtonAction:(UIButton *)enterButton
{

    [self.ljdelegate selecetmoeny:_dataArray[enterButton.tag - 100]];

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

//
//  TitleView.m
//  TNF
//
//  Created by 李江 on 16/1/6.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "TitleView.h"

@implementation TitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _initViews];
    }
    return self;
    
}

- (void)_initViews
{
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 155 * ratioHeight - 20, kScreenWidth - 20, 20)];
//    [button setImage:[UIImage imageNamed:@"jiantou_04"] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:button];
    
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20 - 10, 20 * ratioHeight)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:17 * ratioHeight];
    [self addSubview:titleLabel];
    
  
  
    
    answer = [[UILabel alloc] initWithFrame:CGRectMake(10, titleLabel.bottom + 10, kScreenWidth - 20 , 14 * 3 * ratioHeight)];
    answer.textColor = UIColor(深色背景);
    answer.font = [UIFont systemFontOfSize:13 * ratioHeight];
    answer.textAlignment = NSTextAlignmentLeft;
    answer.numberOfLines = 3;
    [self addSubview:answer];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, self.height - 60, kScreenWidth - 20, 60)];
    [button setImage:[UIImage imageNamed:@"jiantou_04"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.imageEdgeInsets = UIEdgeInsetsMake(40, 0, 0, 0);
    [self addSubview:button];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    titleLabel.text = self.model.title;
    answer.text = self.model.question;
    [answer sizeToFit];
    answer.top = titleLabel.bottom + 10;

}

- (void)buttonAction:(UIButton *)sender
{
    [self animation];
    
}

- (void)animation
{
    [self _initbganimation];
    [UIView animateWithDuration:0.4 animations:^{
        
        animationView.height = kScreenHeight - 64 - 10 - 20 - 65 * ratioHeight / 2.0;
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)_initAnimation
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 20 - 10, 40 * ratioHeight)];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:15 * ratioHeight];
    label.text = self.model.title;
    [animationView addSubview:label];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 40 * ratioHeight, kScreenWidth - 40, .5)];
    imageView.backgroundColor = UIColor4(所有的灰色);
    [animationView addSubview:imageView];
    
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, imageView.bottom, kScreenWidth - 20, kScreenHeight - 64 - 10 - 20 - 65 * ratioHeight / 2.0 - imageView.bottom)];
    [animationView addSubview:scrollView];
    int y = 10;
    
    if (self.model.reading.length == 0) {
        
        
    }else{
        
        UILabel *reading = [[UILabel alloc] initWithFrame:CGRectMake(10, y, kScreenWidth - 90 , 15 * ratioHeight)];
        reading.textColor = UIColor1(蓝);
        reading.font = [UIFont systemFontOfSize:13 * ratioHeight];
        reading.textAlignment = NSTextAlignmentLeft;
        reading.text = @"Reading part:";
        [scrollView addSubview:reading];
        
        float height;
        
        if (self.model.reading.length == 0) {
            height = 0;
        }else{
            height = [self heightForString:self.model.reading fontSize:13 * ratioHeight andWidth:kScreenWidth - 40];
        }
        
        UILabel *part = [[UILabel alloc] initWithFrame:CGRectMake(10, reading.bottom + 10, kScreenWidth - 40 , height)];
        part.textColor = UIColor(深色背景);
        part.font = [UIFont systemFontOfSize:13 * ratioHeight];
        part.textAlignment = NSTextAlignmentLeft;
        part.numberOfLines = 0;
        part.text = self.model.reading;
        [part sizeToFit];
        [scrollView addSubview:part];
        
        y = part.bottom + 10;
        scrollView.contentSize = CGSizeMake(0, part.bottom + 20);
        
    }
    
    if (self.model.mp3.length == 0) {
        
        
        
    }else{
        
        UILabel *listen = [[UILabel alloc] initWithFrame:CGRectMake(10, y, kScreenWidth - 90 , 15 * ratioHeight)];
        listen.textColor = UIColor1(蓝);
        listen.font = [UIFont systemFontOfSize:13 * ratioHeight];
        listen.textAlignment = NSTextAlignmentLeft;
        listen.text = @"Listenning part:";
        [scrollView addSubview:listen];
        
        
        playView = [[PlayView alloc] initWithFrame:CGRectMake(10, listen.bottom + 10, kScreenWidth / 2.0, 20)];
        playView.backgroundColor = [UIColor yellowColor];
        //        playView.contentURL = @"http://m.tuoninfu.com/Public/upload/media/20160103/14517771427645.mp3";
        playView.contentURL = self.model.mp3;
        [scrollView addSubview:playView];
        
        y = playView.bottom + 10;
        scrollView.contentSize = CGSizeMake(0, playView.bottom + 20);
    }
    
    if (self.model.question.length == 0) {
        
    }else{
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10,  y, kScreenWidth - 90 , 15 * ratioHeight)];
        label1.textColor = UIColor1(蓝);
        label1.font = [UIFont systemFontOfSize:13 * ratioHeight];
        label1.textAlignment = NSTextAlignmentLeft;
        label1.text = @"Question:";
        [scrollView addSubview:label1];
        
        float height1;
        if (self.model.question.length == 0) {
            height1 = 0;
        }else{
            height1 = [self heightForString:self.model.question fontSize:13 * ratioHeight andWidth:kScreenWidth - 40];
        }
        
        UILabel *question1 = [[UILabel alloc] initWithFrame:CGRectMake(10, label1.bottom + 10, kScreenWidth - 40 , height1)];
        question1.textColor = UIColor(深色背景);
        question1.font = [UIFont systemFontOfSize:13 * ratioHeight];
        question1.textAlignment = NSTextAlignmentLeft;
        question1.numberOfLines = 0;
        question1.text = self.model.question;
        [question1 sizeToFit];
        [scrollView addSubview:question1];
        scrollView.contentSize = CGSizeMake(0, question1.bottom + 20);
        
    }
    
    
}

//计算文本高度
- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.height;
}


- (void)_initbganimation
{
    
    _bganimationView = [[UIView alloc] initWithFrame:CGRectMake(0,0 , kScreenWidth, kScreenHeight)];
    _bganimationView.backgroundColor = [UIColor clearColor];
    _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.6];
    [_bganimationView addSubview:_maskView];
    
    animationView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 64 + 10 * ratioHeight, kScreenWidth - 20, 155 * ratioHeight)];
    animationView.showsHorizontalScrollIndicator = NO;
    animationView.showsVerticalScrollIndicator = NO;
    [self _initAnimation];
    animationView.backgroundColor = [UIColor whiteColor];
    [_bganimationView addSubview:animationView];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(animationView.width - 50, 10, 40, 40);
    //    [closeButton setBackgroundImage:[UIImage imageNamed:@"close_01"] forState:UIControlStateNormal];
    [closeButton setImage:[UIImage imageNamed:@"close_01"] forState:UIControlStateNormal ];
    [closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    closeButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 10, 0);

    [animationView addSubview:closeButton];
    
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:_bganimationView];
    
    
}

#pragma mark ------关闭-------
- (void)close
{


    [UIView animateWithDuration:0.4 animations:^{
        
        animationView.height = 155 * ratioHeight;
        _maskView.alpha = 0;
    } completion:^(BOOL finished) {
        [playView stop];
        [_bganimationView removeFromSuperview];
        
    }];
    
    
    
}


@end

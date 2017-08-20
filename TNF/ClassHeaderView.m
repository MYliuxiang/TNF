//
//  ClassHeaderView.m
//  TNF
//
//  Created by 刘翔 on 15/12/27.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "ClassHeaderView.h"

@implementation ClassHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self _initViews];
        
    }
    return self;
}

- (void)_initViews
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45 * ratioHeight)];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
    
    label1 = [[UILabel alloc] initWithFrame:CGRectMake(10,0, kScreenWidth - 200, 45 * ratioHeight)];
    label1.textColor = [UIColor blackColor];
    label1.font = [UIFont systemFontOfSize:15 * ratioHeight];
    label1.textAlignment = NSTextAlignmentLeft;
    [view addSubview:label1];
    
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 200 - 10, 0, 200, 45 * ratioHeight)];
    
    label2.textColor = UIColor1(蓝);
    label2.font = [UIFont systemFontOfSize:15 * ratioHeight];
    label2.textAlignment = NSTextAlignmentRight;
    [view addSubview:label2];
    
    self.backgroundColor = [UIColor clearColor];


}

- (void)setText1:(NSString *)text1
{
    _text1 = text1;
    label1.text = _text1;
    
}


- (void)setText2:(NSString *)text2
{
    _text2 = text2;
    label2.text = text2;
    
    
}


@end

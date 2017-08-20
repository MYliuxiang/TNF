//
//  HeadCollectionReusableView.m
//  TNF
//
//  Created by 李立 on 15/12/19.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "HeadCollectionReusableView.h"

@implementation HeadCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //初始化视图
        [self _initViews];
    }
    return self;
}


//初始化视图
-(void)_initViews
{
    self.backgroundColor = [UIColor whiteColor];
    UIView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    imageView.backgroundColor = [UIColor whiteColor];
    [self  addSubview:imageView];
    
    
}

@end

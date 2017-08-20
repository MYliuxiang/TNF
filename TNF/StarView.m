//
//  StarView.m
//  UI_高级搭建01
//
//  Created by student on 15-8-7.
//  Copyright (c) 2015年 www.iphonetrion.com无限互联. All rights reserved.
//

#import "StarView.h"

@implementation StarView

//不加载xib的时候调用此初始化方法

- (instancetype)initWithFrame:(CGRect)frame  starmore:(NSInteger)more Grayindex:(NSInteger )Grayindex{

    self = [super initWithFrame:frame];
    
    if (self) {
        [self _createYellowStarview:more Grayindex:Grayindex];
    }


    return self;
}

//思路：创建两个视图，金色和灰色的视图，利用传进来的平均分来使金色覆盖灰色

//1、创建金色和灰色的量的视图，利用平铺的效果取得五颗星星的背景颜色视图

- (void)_createYellowStarview:(NSInteger)more Grayindex:(NSInteger)Grayindex{
    
    UIImage *yellow = [UIImage imageNamed:@"star_04"];
    UIImage *gray;
    if (_islianxi == YES) {
         gray = [UIImage imageNamed:@"star_03"];

    } else {
        gray = [UIImage imageNamed:@"star_01"];
    }
        CGFloat grayKwidth = ratioHeight*30/2;
    
    for (int i =0; i<Grayindex; i++) {
        _grayview = [[UIImageView alloc]initWithFrame:CGRectMake((grayKwidth+10*ratioWidth/2)*i,0, ratioHeight*30/2, grayKwidth)];
        _grayview.image = gray;
        [self addSubview:_grayview];
    }
    
    for (int a = 0; a<more; a++) {
       _YellowView = [[UIImageView alloc]initWithFrame:CGRectMake((grayKwidth+10*ratioWidth/2)*a,0, ratioHeight*30/2, grayKwidth)];
        _YellowView.image = yellow;
        [self addSubview:_YellowView];
    }

}





@end

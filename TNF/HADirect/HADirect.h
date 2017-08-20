//
//  HADirect.h
//  Test
//
//  Created by mac on 15/9/19.
//  Copyright (c) 2015年 HA. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^imageClickBlock)(NSInteger index);

@interface HADirect : UIView

//轮播的ScrollView
@property(strong,nonatomic) UIScrollView *direct;
//轮播的页码
@property(strong,nonatomic) UIPageControl *pageVC;
//轮播滚动时间间隔
@property(assign,nonatomic) CGFloat time;
//点击图片出发Block
@property(copy,nonatomic) imageClickBlock clickBlock;


//初始化图片格式的HADirect
+(instancetype)direcWithtFrame:(CGRect)frame ImageArr:(NSArray *)imageNameArray AndImageClickBlock:(imageClickBlock)clickBlock;

//初始化自定义样式的HADirect
+(instancetype)direcWithtFrame:(CGRect)frame ViewArr:(NSArray *)customViewArr;

//开始定时器
-(void)beginTimer;

//暂停定时器
-(void)stopTimer;
@end

//
//  StarView.h
//  UI_高级搭建01
//
//  Created by student on 15-8-7.
//  Copyright (c) 2015年 www.iphonetrion.com无限互联. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarView : UIView{

    //创建星星视图
    //1、金色星星视图.视图全局变量
    UIImageView *_YellowView;

    UIImageView *_grayview;

}


- (instancetype)initWithFrame:(CGRect)frame starmore:(NSInteger)more Grayindex:(NSInteger )Grayindex;

- (void)_createYellowStarview:(NSInteger)more Grayindex:(NSInteger)Grayindex;

@property (nonatomic,assign)BOOL islianxi;

@property(nonatomic,assign)float avreage1;

@end

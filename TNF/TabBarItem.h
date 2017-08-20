//
//  TabBarItem.h
//  MyMovie
//
//  Created by zsm on 14-8-15.
//  Copyright (c) 2014年 zsm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarItem : UIControl
{
//    UIImageView *_titleImageView;
}
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong)  UIImageView *titleImageView;

//自定义初始化方法
- (id)initWithFrame:(CGRect)frame
          imageName:(NSString *)imageName
              title:(NSString *)title;

@end

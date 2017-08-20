//
//  TabBarItem.m
//  MyMovie
//
//  Created by zsm on 14-8-15.
//  Copyright (c) 2014年 zsm. All rights reserved.
//

#import "TabBarItem.h"

@implementation TabBarItem

- (id)initWithFrame:(CGRect)frame
          imageName:(NSString *)imageName
              title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //1.创建标题图片
        _titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40*ratioHeight, (self.height - 28/1.5*ratioHeight) / 2.0, 28/1.5*ratioHeight, 28/1.5*ratioHeight)];
        //图片的填充方式
        _titleImageView.contentMode = UIViewContentModeScaleAspectFit;
        //设置图片
        _titleImageView.image = [UIImage imageNamed:imageName];
        [self addSubview:_titleImageView];
        
        //2.标题文本
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleImageView.right,(self.height - 20*ratioHeight)/ 2.0, 100/2*ratioHeight, 20*ratioHeight)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:13*ratioHeight];
        _titleLabel.text = title;
        [self addSubview:_titleLabel];
    }
    self.userInteractionEnabled=YES;
    return self;
}
@end

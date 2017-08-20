//
//  LXStarView.m
//  TNF
//
//  Created by 刘翔 on 15/12/27.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "LXStarView.h"

@implementation LXStarView

- (instancetype)initWithFrame:(CGRect)frame
{    self = [super initWithFrame:frame];
    
    if (self) {
        [self _initViews];
    }
    
    
    return self;
}

- (void)_initViews
{
    
    yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    yellowView.clipsToBounds = YES;
    for (int i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * (self.width/ 4.0 + 2), 0, 14 * ratioHeight, 14 * ratioHeight)];
        imageView.image = [UIImage imageNamed:@"star_04"];
        [yellowView addSubview:imageView];
        
    }
    
    grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    for (int i = 0; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * (self.width/ 4.0 + 2) , 0, 14 * ratioHeight, 14 * ratioHeight)];
        imageView.image = [UIImage imageNamed:@"star_05"];
        [grayView addSubview:imageView];
        
    }
    [self addSubview:grayView];
    [self addSubview:yellowView];

}

- (void)setCount:(int)count
{
    _count = count;
    yellowView.width = self.width / 4 * count;

}

@end

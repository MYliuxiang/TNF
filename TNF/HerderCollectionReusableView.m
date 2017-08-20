//
//  HerderCollectionReusableView.m
//  XINRUE
//
//  Created by yunhe on 14/12/23.
//  Copyright (c) 2014年 yunhe. All rights reserved.
//

#import "HerderCollectionReusableView.h"


@implementation HerderCollectionReusableView

- (void)_initViews
{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 160 * ratioHeight)];
    _imageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_imageView];
    
    label1 = [[UILabel alloc] initWithFrame:CGRectMake(5, _imageView.bottom, kScreenWidth - 200, 45 * ratioHeight)];
    label1.textColor = [UIColor blackColor];
    label1.font = [UIFont systemFontOfSize:15 * ratioHeight];
    label1.textAlignment = NSTextAlignmentLeft;
    [self addSubview:label1];
    
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 200 - 10, _imageView.bottom, 200, 45 * ratioHeight)];
    
    label2.textColor = UIColor1(蓝);
    label2.font = [UIFont systemFontOfSize:15 * ratioHeight];
    label2.textAlignment = NSTextAlignmentRight;
    [self addSubview:label2];
    
    self.backgroundColor = [UIColor whiteColor];

    
    
    
}


#pragma mark ------LXDelegate--------------
- (void)clickindex:(int)index
{
    [self.delegate clickindex:index];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self _initViews];
        
    }
    return self;
}

- (void)setUrl:(NSString *)url
{
    _url = url;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_url]];

}

- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    
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

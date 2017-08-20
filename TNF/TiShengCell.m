//
//  TiShengCell.m
//  TNF
//
//  Created by 李江 on 15/12/22.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "TiShengCell.h"

@implementation TiShengCell
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
////    self.contentView.backgroundColor = UIColor2(灰色背景);
//    self.contentView.backgroundColor = [UIColor blackColor];
    
    titleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, self.width, 160 / 2.0 * ratioHeight)];
    titleImageView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:titleImageView];
    self.backgroundColor = [UIColor redColor];
    videoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(titleImageView.width - 18 * ratioWidth - 5 , titleImageView.height - 14 * ratioHeight - 5 , 18 * ratioWidth , 14 * ratioHeight)];
    videoImageView.image = [UIImage imageNamed:@"play_01"];
    [titleImageView addSubview:videoImageView];
    
    titleLabel  = [[UILabel alloc] initWithFrame:CGRectMake(titleImageView.left, titleImageView.bottom, titleImageView.width, self.height - titleImageView.height)];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:13 * ratioHeight];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
//    titleLabel.text = @"口语培训班";
    [self.contentView addSubview:titleLabel];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    titleLabel.text = _model.title;
    [titleImageView sd_setImageWithURL:[NSURL URLWithString:_model.thumb] placeholderImage:nil];
    if ([_model.is_video integerValue] == 1) {
        videoImageView.hidden = NO;
    } else
    {
        videoImageView.hidden = YES;
    }
    
}
@end

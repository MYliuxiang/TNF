//
//  ClassCell.m
//  TNF
//
//  Created by 刘翔 on 15/12/27.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "ClassCell.h"

@implementation ClassCell

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
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, (kScreenWidth - 25) / 2.0, 80 * ratioHeight)];
    imageView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:imageView];
    
    videoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageView.width - 18 * ratioHeight - 5, imageView.height - 14 * ratioHeight - 5, 18 * ratioHeight, 14 * ratioHeight)];
    videoImageView.backgroundColor = [UIColor clearColor];
    videoImageView.image = [UIImage imageNamed:@"play_01"];
    [imageView addSubview:videoImageView];

    
    label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.left, imageView.bottom, imageView.width, 35 * ratioHeight)];
    label.textColor = UIColor4(所有的灰色);
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:13 * ratioHeight];
    label.textColor = [UIColor blackColor];
    [self addSubview:label];

}

- (void)layoutSubviews
{
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.thumb]];
    NSString *str = [NSString stringWithFormat:@"  共%@题/已练%@",self.model.count_total,self.model.count_finish];
    label.text = str;
    if (self.type == 0) {
        imageView.left = 10;
        label.left = 10;
        videoImageView.frame = CGRectMake(imageView.width - 30, imageView.height - 23, 25, 18);
    }else{
    
        imageView.left = 2.5;
        label.left = 2.5;
        videoImageView.frame = CGRectMake(imageView.width - 30, imageView.height - 23, 25, 18);
    }
    
    if ([self.model.Is_video boolValue]) {
        videoImageView.hidden = NO;
    }else{
        videoImageView.hidden = YES;
    }
    

}

@end
















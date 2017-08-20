//
//  SourceCell.m
//  TNF
//
//  Created by 刘翔 on 15/12/27.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "SourceCell.h"

@implementation SourceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    {
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        if (self) {
            // Initialization code
            [self _initViews];
        }
        return self;
    }
}

- (void)_initViews
{

    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 * ratioHeight, 10 * ratioHeight, 80 * ratioHeight, 60 * ratioHeight)];
    _imageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_imageView];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(_imageView.right + 10, 20 * ratioHeight, 200, 17 * ratioHeight)];
    label.text = @"机经预测素材";
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:15 * ratioHeight];
    [self addSubview:label];
    
    label1 = [[UILabel alloc] initWithFrame:CGRectMake(_imageView.right + 10, label.bottom + 15 * ratioHeight, 200, 13 * ratioHeight)];
    label1.text = @"机经预测素材";
    label1.textColor = UIColor4(所有的灰色);
    label1.font = [UIFont systemFontOfSize:13 * ratioHeight];

    [self addSubview:label1];


}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:self.model.thumb]];
    label.text = self.model.title;


}

@end




















//
//  WhizkidCell.m
//  TNF
//
//  Created by 刘翔 on 15/12/27.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "WhizkidCell.h"

@implementation WhizkidCell

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
    headimageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20 * ratioHeight, 40 * ratioHeight, 40 * ratioHeight)];
    headimageView.backgroundColor = [UIColor clearColor];
    headimageView.layer.masksToBounds = YES;
    headimageView.layer.cornerRadius = 20 * ratioHeight;
    [self addSubview:headimageView];
    
    nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(headimageView.right + 10, 25 * ratioHeight, kScreenWidth - 115 - headimageView.right - 20, 15 * ratioHeight)];
    nickLabel.font = [UIFont systemFontOfSize:15 * ratioWidth];
    nickLabel.textColor = [UIColor blackColor];
    nickLabel.text = @"我答的好看见对方";
    [self addSubview:nickLabel];
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(headimageView.right + 10, nickLabel.bottom + 10 , 40 * ratioHeight, 20 * ratioHeight)];
    timeLabel.textColor = UIColor4(所有的灰色);
    timeLabel.layer.masksToBounds = YES;
    timeLabel.layer.cornerRadius = 10 * ratioHeight;
    timeLabel.layer.borderColor = UIColor4(所有的灰色).CGColor;
    timeLabel.layer.borderWidth = 1.0;
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.text = @"45‘";
    timeLabel.font = [UIFont systemFontOfSize:13 * ratioWidth];
    [self addSubview:timeLabel];
    
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeLabel.right + 10, nickLabel.bottom + 10, 100, 20 * ratioHeight)];
    dateLabel.textColor = UIColor4(所有的灰色);
    dateLabel.text = @"2015.12.25";
    dateLabel.font = [UIFont systemFontOfSize:13 * ratioWidth];
    [self addSubview:dateLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 115, 10, .5, 80 * ratioHeight - 20)];
    imageView.backgroundColor = [MyColor colorWithHexString:@"#555555"];
    [self.contentView addSubview:imageView];

    
    star = [[LXStarView alloc] initWithFrame:CGRectMake(imageView.right + ((kScreenWidth  -  imageView.right) - 70 * ratioWidth) / 2.0 , nickLabel.top, 70 * ratioWidth, 14 * ratioWidth)];
    [self addSubview:star];
    
    dipinLabel = [[UILabel alloc] initWithFrame:CGRectMake(star.left, star.bottom + 10, star.width, 25 * ratioHeight)];
    dipinLabel.textColor = UIColor4(所有的灰色);
    dipinLabel.font = [UIFont systemFontOfSize:13 * ratioWidth];
    dipinLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:dipinLabel];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [headimageView sd_setImageWithURL:[NSURL URLWithString:self.model.headimgurl]];
    star.count = [self.model.fen intValue];
    nickLabel.text = self.model.nickname;
    timeLabel.text = [NSString stringWithFormat:@"%@s",self.model.time];
    dateLabel.text = self.model.addtime;
    
    if ([self.model.isComment isEqualToString:@"0"]) {
        dipinLabel.text = @"未点评";

    }else{
    
        dipinLabel.text = self.model.isCommentCN;

    }

}


@end

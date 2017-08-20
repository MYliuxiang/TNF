//
//  Zhibocell.m
//  TNF
//
//  Created by 李江 on 16/1/26.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "Zhibocell.h"

@implementation Zhibocell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //1.创建子视图
        [self initCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

//初始化cell
-(void)initCell
{
    self.backgroundColor = UIColor2(灰色背景);
    _titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth - 20, 100 *ratioHeight)];
    _titleImage.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_titleImage];
    

    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleImage.left , _titleImage.bottom, _titleImage.width, 25 * ratioHeight)];
    _titleLabel.font = [UIFont systemFontOfSize:13 * ratioHeight];
    _titleLabel.textColor = UIColor6(正文小字);
    _titleLabel.backgroundColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    //    _titleLabel.text = @"基津预测专题讲座";
    [self.contentView addSubview:_titleLabel];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0,_titleLabel.bottom, kScreenWidth, 5 * ratioHeight)];
    bgView.backgroundColor = UIColor2(灰色背景);
    [self.contentView addSubview:bgView];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _titleLabel.text = _model.title;

    [_titleImage sd_setImageWithURL:[NSURL URLWithString:_model.thumb] placeholderImage:nil];
 
    
}



@end

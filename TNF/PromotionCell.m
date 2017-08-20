//
//  PromotionCell.m
//  TNF
//
//  Created by 李江 on 15/12/27.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "PromotionCell.h"

@implementation PromotionCell

- (void)awakeFromNib {
    // Initialization code
}

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
    //标题
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, kScreenWidth - 20, 15 * ratioWidth)];
   
    _titleLabel.font = [UIFont systemFontOfSize:15 * ratioWidth];
    _titleLabel.textColor = UIColor5(标题大字);
    _titleLabel.textAlignment=NSTextAlignmentLeft;
    [self.contentView addSubview:_titleLabel];
    
    //收费日期
    _contenLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom + 15, _titleLabel.width, 13)];
    _contenLabel.textColor = UIColor6(正文小字);
    _contenLabel.font = [UIFont systemFontOfSize:13 * ratioWidth];
    _contenLabel.numberOfLines = 3;
    [self.contentView  addSubview:_contenLabel];
    
    
    }

- (void)layoutSubviews
{
    [super layoutSubviews];
   
    _titleLabel.text = _model.title;
    _contenLabel.text = _model.question;
    
//    CGSize constraintSize = CGSizeMake(_contenLabel.width, MAXFLOAT);
//    //    CGSize labelSize = [string sizeWithFont:[UIFont fontWithName:@"Helvetica" size:14.0] constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
//    CGSize labelSize = [_contenLabel.text sizeWithFont:[UIFont systemFontOfSize:13.0 * ratioWidth] constrainedToSize:constraintSize];
//    CGFloat  height = labelSize.height > 20 ? labelSize.height : 20;
    [_contenLabel sizeToFit];
    _contenLabel.width = _titleLabel.width;
    _contenLabel.top = _titleLabel.bottom + 10;
//    _contenLabel.height = height;




}
//-(void)setTitleLabel:(NSString *)titleLabel CategoryLabel:(NSString *)categoryLabel TimeLable:(NSString *)timeLable StateName:(NSString *)StateName StateValue:(NSString *)StateValue MoneyLabel:(NSString *)moneyLabel
//{
//    
//    CGSize constraintSize = CGSizeMake(_categoryLabel.width, MAXFLOAT);
//    //    CGSize labelSize = [string sizeWithFont:[UIFont fontWithName:@"Helvetica" size:14.0] constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
//    CGSize labelSize = [categoryLabel sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:constraintSize];
//    _.height = labelSize.height > 20 ? labelSize.height : 20;
//    
//    _titleLabel.text = titleLabel;
//    
//    
//}
//

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

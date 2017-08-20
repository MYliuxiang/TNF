//
//  LectureCell.m
//  TNF
//
//  Created by lijiang on 15/12/23.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "LectureCell.h"

@implementation LectureCell

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

    _titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 100 * ratioWidth, 145 / 2.0 *ratioHeight)];
    _titleImage.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_titleImage];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleImage.right + 10 , _titleImage.top, kScreenWidth - _titleImage.right - 5 - 10, 17 * ratioHeight)];
    _titleLabel.font = [UIFont systemFontOfSize:17 * ratioHeight];
    _titleLabel.textColor = UIColor5(标题大字);
//    _titleLabel.text = @"基津预测专题讲座";
    [self.contentView addSubview:_titleLabel];
    
    _teacherLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left , _titleLabel.bottom + 10 , _titleLabel.width, 13 * ratioHeight)];
    _teacherLabel.font = [UIFont systemFontOfSize:12 * ratioHeight];
    _teacherLabel.textColor = UIColor6(正文小字);
//    _teacherLabel.text = @"主演老师：Cindy";
    [self.contentView addSubview:_teacherLabel];
    
    _timeLable = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left , _teacherLabel.bottom + 10, _titleLabel.width, 30 * ratioHeight)];
    _timeLable.font = [UIFont systemFontOfSize:12 * ratioHeight];
    _timeLable.numberOfLines = 0;
    _timeLable.textColor = UIColor6(正文小字);
//    _timeLable.text = @"课程安排：2015.12.14 8:00-9:00";
    [self.contentView addSubview:_timeLable];
    
   
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 195 / 2.0 * ratioHeight,kScreenWidth, 1)];
    _lineView.backgroundColor = UIColor2(灰色背景);
    [self.contentView addSubview:_lineView];
    
    
    _fubiImage = [[UIImageView alloc]initWithFrame:CGRectMake(_titleImage.left, _lineView.bottom + (45 * ratioHeight - 15 * ratioWidth) / 2.0 , 20 * ratioWidth, 15 * ratioHeight)];
    _fubiImage.image = [UIImage imageNamed:@"momey_02"];
    [self.contentView addSubview:_fubiImage];
    
    
    _moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(_fubiImage.right + 3 , _fubiImage.top , 100, 15 * ratioHeight)];
    _moneyLabel.font = [UIFont systemFontOfSize:15 * ratioHeight];
    _moneyLabel.textAlignment = NSTextAlignmentLeft;
    _moneyLabel.textColor = UIColor3(金色);
    _moneyLabel.text = @"10";
    [self.contentView addSubview:_moneyLabel];
    
    
    _stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 10 - 130 / 2.0 * ratioWidth , _lineView.bottom + (45 * ratioHeight - 25 * ratioHeight) / 2.0 , 130 / 2.0 * ratioWidth, 25 * ratioHeight)];
    _stateLabel.backgroundColor = UIColor1(蓝);
    _stateLabel.layer.cornerRadius = 12 * ratioHeight;
    _stateLabel.layer.masksToBounds = YES;
    _stateLabel.font = [UIFont boldSystemFontOfSize:13 * ratioHeight];
    _stateLabel.textAlignment = NSTextAlignmentCenter;;
    _stateLabel.textColor = [UIColor whiteColor];
    _stateLabel.text = @"报名";
    [self.contentView addSubview:_stateLabel];
    
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, (195 + 100) / 2.0 * ratioHeight - 5 * ratioHeight, kScreenWidth, 5 * ratioHeight)];
    bgView.backgroundColor = UIColor2(灰色背景);
    [self.contentView addSubview:bgView];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _titleLabel.text = _model.title;
    _teacherLabel.text = [NSString stringWithFormat:@"主演老师：%@",_model.nickname];
    
    if([_model.cost floatValue] == 0){
    
        _moneyLabel.text = @"免费";

    }else{
    
        _moneyLabel.text = _model.cost;

    
    }
    
    _timeLable.text = [NSString stringWithFormat:@"课程安排：%@",_model.subtitle];
    [_titleImage sd_setImageWithURL:[NSURL URLWithString:_model.thumb] placeholderImage:nil];
    //是否报名
    if ([_model.is_get integerValue] == 0) {
        _stateLabel.text = @"报名";
        _stateLabel.backgroundColor = UIColor1(蓝);
    } else
    {
        _stateLabel.text = @"已报名";
        _stateLabel.backgroundColor = UIColorBtn(灰色);
    }
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  LectureCell.h
//  TNF
//
//  Created by lijiang on 15/12/23.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JiangzuoModel.h"
@interface LectureCell : UITableViewCell

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *teacherLabel;
@property(nonatomic,strong) UILabel *timeLable;

@property(nonatomic,strong) UILabel *stateLabel;
@property(nonatomic,strong) UILabel *moneyLabel;
@property(nonatomic,strong) UIView *lineView;

@property(nonatomic,strong) UIImageView *titleImage;
@property(nonatomic,strong) UIImageView *fubiImage;

@property(nonatomic,strong) JiangzuoModel *model;
@end

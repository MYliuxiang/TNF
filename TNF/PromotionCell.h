//
//  PromotionCell.h
//  TNF
//
//  Created by 李江 on 15/12/27.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonModel.h"
@interface PromotionCell : UITableViewCell

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *contenLabel;
@property(nonatomic,strong) PersonModel *model;
//-(void)setTitleLabel:(NSString *)titleLabel CategoryLabel:(NSString *)categoryLabel TimeLable:(NSString *)timeLable StateName:(NSString *)StateName StateValue:(NSString *)StateValue MoneyLabel:(NSString *)moneyLabel;

@end

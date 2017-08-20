//
//  Zhibocell.h
//  TNF
//
//  Created by 李江 on 16/1/26.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JiangzuoModel.h"
@interface Zhibocell : UITableViewCell

@property(nonatomic,strong) UILabel *titleLabel;

@property(nonatomic,strong) UIView *lineView;

@property(nonatomic,strong) UIImageView *titleImage;


@property(nonatomic,strong) JiangzuoModel *model;

@end

//
//  Bgmodel.h
//  TNF
//
//  Created by 李善 on 15/12/23.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "LXBaseModel.h"


@interface Bgmodel : LXBaseModel
//subject科目
//time考试时间
//fen考试分数
//full满分
@property(nonatomic,copy)NSString *subject1;
@property(nonatomic,copy)NSString *full;
@property(nonatomic,strong)NSArray *fen;
@property(nonatomic,strong)NSArray *time;
@end

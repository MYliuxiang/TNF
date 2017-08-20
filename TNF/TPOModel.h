//
//  TPOModel.h
//  TNF
//
//  Created by 刘翔 on 15/12/28.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "LXBaseModel.h"

@interface TPOModel : LXBaseModel


@property(nonatomic,copy)NSString *identifire;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,retain)NSArray *lists;




/*count总分类数
count_total总数
count_finish已练习
list练习列表信息
id练习ID
title标题
list题目列表
rid关联ID
id题目ID
type类型
Is_practice是否练习 1已练习 0未练习
 */

@end

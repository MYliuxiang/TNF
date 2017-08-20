//
//  TPOList.h
//  TNF
//
//  Created by 刘翔 on 15/12/28.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "LXBaseModel.h"

@interface TPOList : LXBaseModel

@property(nonatomic,copy)NSString *identifire;
@property(nonatomic,copy)NSString *rid;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *Is_practice;


/*
 rid关联ID
 id题目ID
 type类型
 Is_practice是否练习 1已练习 0未练习
 
 */
@end

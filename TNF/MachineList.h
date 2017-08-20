//
//  MachineList.h
//  TNF
//
//  Created by 刘翔 on 15/12/26.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "LXBaseModel.h"

@interface MachineList : LXBaseModel

@property(nonatomic,copy)NSString *identifire;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *count_total;
@property(nonatomic,copy)NSString *count_finish;

/*
 id练习ID
 title标题
 count_total总数
 count_finish已练习
 */

@end

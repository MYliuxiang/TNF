//
//  SetupModel.h
//  TNF
//
//  Created by 李立 on 15/12/24.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "LXBaseModel.h"

@interface SetupModel : LXBaseModel

@property(nonatomic,copy)NSString *member_info; //用户信息
@property(nonatomic,copy)NSString *name; //姓名
@property(nonatomic,copy)NSString *headimgurl; //头像
@property(nonatomic,copy)NSString *app_address; //地址
@property(nonatomic,copy)NSString *amount; //福币
@property(nonatomic,copy)NSString *subjectCN; //备考科目
@property(nonatomic,copy)NSString *recordCount; //练习记录
@property(nonatomic,copy)NSString *version; //软件版本

@end

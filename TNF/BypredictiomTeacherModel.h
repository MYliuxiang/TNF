//
//  BypredictiomTeacherModel.h
//  TNF
//
//  Created by 李江 on 15/12/24.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "LXBaseModel.h"

@interface BypredictiomTeacherModel : LXBaseModel

//teacher_info老师信息
@property(nonatomic,copy)NSString *teacherID; //内容
@property(nonatomic,copy)NSString *nickname; // 老师昵称
@property(nonatomic,copy)NSString *headimgurl; // 老师头像
@property(nonatomic,copy)NSString *subjectCN; // 教课类型

@end

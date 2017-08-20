//
//  MycourseModel.h
//  TNF
//
//  Created by lijiang on 15/12/25.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "LXBaseModel.h"

@interface MycourseModel : LXBaseModel

@property(nonatomic,copy)NSString *title;//	名称
@property(nonatomic,copy)NSString *thumb;//	图片
@property(nonatomic,copy)NSString *CourseID;//ID
@property(nonatomic,copy)NSString *type; // 1、2为课程 3、4为讲座
@property(nonatomic,copy)NSString *is_save; //1已下载或已报名 0未下载或未报名
@property(nonatomic,copy)NSString *text;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *source; //1课程 2直播课

@property(nonatomic,copy)NSString *app_type; //类型

- (id)initWithDataDic:(NSDictionary *)dic;


@end

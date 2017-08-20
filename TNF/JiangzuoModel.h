//
//  JiangzuoModel.h
//  TNF
//
//  Created by lijiang on 15/12/23.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "LXBaseModel.h"

@interface JiangzuoModel : LXBaseModel

@property(nonatomic,copy)NSString *title;//	名称
@property(nonatomic,copy)NSString *thumb;//	图片
@property(nonatomic,copy)NSString *is_get;//	是否报名
@property(nonatomic,copy)NSString *LectureID;//	讲座ID
@property(nonatomic,copy)NSString *subtitle; // 课程安排
@property(nonatomic,copy)NSString *cost;//	报名费
@property(nonatomic,copy)NSString *nickname; // 主讲老师
@property(nonatomic,copy)NSString *url; //链接地址
-(id)initWithDataDic:(NSDictionary*)data;

@end

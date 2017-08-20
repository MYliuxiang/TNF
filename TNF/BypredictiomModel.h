//
//  BypredictiomModel.h
//  TNF
//
//  Created by 李江 on 15/12/23.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "LXBaseModel.h"

@interface BypredictiomModel : LXBaseModel



//info讲座信息
@property(nonatomic,copy)NSString *title;//	名称
@property(nonatomic,copy)NSString *thumb;//	图片
@property(nonatomic,copy)NSString *is_get;//	是否报名 1已报名 0未报名
@property(nonatomic,copy)NSString *LectureID;//	讲座ID
@property(nonatomic,copy)NSString *subtitle; // 课程安排
@property(nonatomic,copy)NSString *cost;//	报名费
@property(nonatomic,copy)NSString *is_collection; // 是否收藏
@property(nonatomic,copy)NSString *is_gave; //是否已打赏 1已打赏 0未打赏
@property(nonatomic,copy)NSString *content; //内容
@property(nonatomic,copy)NSString *address; // 地址
@property(nonatomic,copy)NSString *thumb_cont; // 内容图
@property(nonatomic,copy)NSString *video; //视频地址
@property(nonatomic,copy)NSString *endtime; //课程有效期
@property(nonatomic,copy)NSString *class_mode;//上课方式


@property(nonatomic,copy)NSString *is_down; // 是否下载


@end

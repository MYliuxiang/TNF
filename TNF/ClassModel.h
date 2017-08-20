//
//  ClassModel.h
//  TNF
//
//  Created by 刘翔 on 15/12/27.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "LXBaseModel.h"

@interface ClassModel : LXBaseModel

@property(nonatomic,copy)NSString *identifire;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *thumb;
@property(nonatomic,copy)NSString *Is_video;
@property(nonatomic,copy)NSString *count_total;
@property(nonatomic,copy)NSString *count_finish;
@property(nonatomic,copy)NSString *video;


/*
 id练习ID
 title标题
 thumb图片
 Is_video是否有视频 1有 0无
 count_total总数
 count_finish已练习
 
 */
@end

//
//  HeaderModel.h
//  TNF
//
//  Created by 刘翔 on 15/12/30.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "LXBaseModel.h"
#import "Info.h"

@interface HeaderModel : LXBaseModel

@property(nonatomic,copy)NSString *cur;
@property(nonatomic,copy)NSString *count;
@property(nonatomic,copy)NSString *pre;
@property(nonatomic,copy)NSString *next;
@property(nonatomic,copy)NSString *amount;
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *lid;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *longs;
@property(nonatomic,retain)Info *infos;
@property(nonatomic,retain)NSMutableArray *titles;
@property(nonatomic,copy)NSString *contents;
@property(nonatomic,retain)NSArray *files;


//@property(nonatomic,retain)NSMutableArray *mytitles;

-(id)initWithDataDic:(NSDictionary*)data;


/*cur当前第几个
count总共几个
pre上一题ID(没有时为0)
next下一题ID(没有时为0)
amount福币数
lid关联ID
type类型
long录音时长
info题目详情
  id题目ID
  title标题
  mp3听力部分
  question问题部分
  reading阅读部分
 */
@end

//
//  Info.h
//  TNF
//
//  Created by 刘翔 on 15/12/30.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "LXBaseModel.h"

@interface Info : LXBaseModel

@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *mp3;
@property(nonatomic,copy)NSString *question;
@property(nonatomic,copy)NSString *reading;


-(id)initWithDataDic:(NSDictionary*)data;


/* info题目详情
 id题目ID
 title标题
 mp3听力部分
 question问题部分
 reading阅读部分
 */

@end

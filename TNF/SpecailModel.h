//
//  SpecailModel.h
//  TNF
//
//  Created by 李善 on 15/12/27.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "LXBaseModel.h"

@interface SpecailModel : LXBaseModel

//id记录ID
//type类型 1托福 2雅思
//title 标题
//isComment是否已点评 1已点评 0未点评
//isCommentCN是否已点评文字
//fen星星数


@property(nonatomic,copy)NSString *fen;

@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *isComment;

@property(nonatomic,copy)NSString *isCommentCN;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *sid;

-(id)initWithDataDic:(NSDictionary*)data;

@end

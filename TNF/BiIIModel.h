//
//  BiIIModel.h
//  TNF
//
//  Created by lijiang on 15/12/28.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "LXBaseModel.h"

@interface BiIIModel : LXBaseModel

@property(nonatomic,copy)NSString *addtime;//时间
@property(nonatomic,copy)NSString *addtime_show;//
@property(nonatomic,copy)NSString *amount;//	金额
@property(nonatomic,copy)NSString *ID;//	ID
@property(nonatomic,copy)NSString *as; // + -
@property(nonatomic,copy)NSString *title;//	标题
@property(nonatomic,copy)NSString *subtitle; //副标题
@property(nonatomic,copy)NSString *type; //
@property(nonatomic,copy)NSString *count; //

//@property(nonatomic,strong)NSArray *list;
-(id)initWithDataDic:(NSDictionary*)data;

@end

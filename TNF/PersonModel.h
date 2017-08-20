//
//  PersonModel.h
//  TNF
//
//  Created by 李江 on 15/12/27.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "LXBaseModel.h"

@interface PersonModel : LXBaseModel

@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *question;
@property(nonatomic,strong)NSString *rid;
@property(nonatomic,strong)NSString *sid;
@property(nonatomic,strong)NSString *type;

-(id)initWithDataDic:(NSDictionary*)data;

@end

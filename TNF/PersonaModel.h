//
//  PersonaModel.h
//  TNF
//
//  Created by 李立 on 15/12/23.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "LXBaseModel.h"

@interface PersonaModel : LXBaseModel

@property(nonatomic,copy)NSString *headimgurl; //头像
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *weixin;
@property(nonatomic,copy)NSString *app_address;
@property(nonatomic,copy)NSString *education;
@end

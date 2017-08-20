//
//  FuYuanModel.h
//  TNF
//
//  Created by 李立 on 15/12/24.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "LXBaseModel.h"

@interface FuYuanModel : LXBaseModel
@property(nonatomic,copy)NSString *text1; //文字信息
@property(nonatomic,copy)NSString *text2; //文字信息
@property(nonatomic,copy)NSString *text3; //文字信息
@property(nonatomic,copy)NSString *text4; //文字信息
@property(nonatomic,copy)NSString *text5; //文字信息
@property(nonatomic,copy)NSString *text6; //文字信息
@property(nonatomic,copy)NSString *text7; //文字信息
@property(nonatomic,copy)NSString *text8; //文字信息
@property(nonatomic,copy)NSString *text9; //文字信息

@property(nonatomic,copy)NSString *isget1; //是否领取每日奖励
@property(nonatomic,copy)NSString *isget2 ; //是否领取分享推荐奖励
@property(nonatomic,copy)NSArray *buyList ; //内部购买信息

@property(nonatomic,strong)NSString *amount;  //福币数

- (id)initWithDataDic:(NSDictionary *)dic;

@end

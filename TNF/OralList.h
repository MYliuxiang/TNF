//
//  OralList.h
//  TNF
//
//  Created by 刘翔 on 15/12/26.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "LXBaseModel.h"

@interface OralList : LXBaseModel

@property(nonatomic,copy)NSString *is_show;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *text;
@property(nonatomic,copy)NSString *thumb;

 /*is_show 是否显示 1显示0隐藏
title标题
text描述
thumb背景图*/


@end

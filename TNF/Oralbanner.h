//
//  Oralbanner.h
//  TNF
//
//  Created by 刘翔 on 15/12/26.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "LXBaseModel.h"

@interface Oralbanner : LXBaseModel

@property(nonatomic,copy)NSString *thumb;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *relationid;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *title;


/*
 thumb图片
 url链接 只有当类型为链接时才生效
 relationid关联ID
 type类型 array(1=>"机经",2=>"分类",3=>"TPO",4=>"课程",5=>"讲座",6=>"题目",7=>"链接");
 
 */


@end

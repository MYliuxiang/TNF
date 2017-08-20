//
//  BypredictiomTeacherModel.m
//  TNF
//
//  Created by 李江 on 15/12/24.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "BypredictiomTeacherModel.h"

@implementation BypredictiomTeacherModel
- (id)initWithDataDic:(NSDictionary *)dic
{
    self = [super initWithDataDic:dic];
    if (self) {
        self.teacherID = dic[@"id"];
    }
    return self;
}

@end

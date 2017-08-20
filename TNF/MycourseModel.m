//
//  MycourseModel.m
//  TNF
//
//  Created by lijiang on 15/12/25.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "MycourseModel.h"

@implementation MycourseModel
- (id)initWithDataDic:(NSDictionary *)dic
{
    self = [super initWithDataDic:dic];
    if (self) {
        self.CourseID = dic[@"id"];
    }
    return self;
}
@end

//
//  JiangzuoModel.m
//  TNF
//
//  Created by lijiang on 15/12/23.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "JiangzuoModel.h"

@implementation JiangzuoModel
- (id)initWithDataDic:(NSDictionary *)dic
{
    self = [super initWithDataDic:dic];
    if (self) {
        self.LectureID = dic[@"id"];
    }
    return self;
}
@end

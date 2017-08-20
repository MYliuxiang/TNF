//
//  BypredictiomModel.m
//  TNF
//
//  Created by 李江 on 15/12/23.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "BypredictiomModel.h"

@implementation BypredictiomModel
- (id)initWithDataDic:(NSDictionary *)dic
{
    self = [super initWithDataDic:dic];
    if (self) {
        self.LectureID = dic[@"id"];
    }
    return self;
}
@end

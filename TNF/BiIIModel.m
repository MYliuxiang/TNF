//
//  BiIIModel.m
//  TNF
//
//  Created by lijiang on 15/12/28.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "BiIIModel.h"

@implementation BiIIModel

- (id)initWithDataDic:(NSDictionary *)dic
{
    self = [super initWithDataDic:dic];
    if (self) {
        self.ID = dic[@"id"];
    }
    return self;
}

@end

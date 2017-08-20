//
//  Mymodel.m
//  TNF
//
//  Created by 刘翔 on 15/12/31.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "Mymodel.h"

@implementation Mymodel

- (id)initWithDataDic:(NSDictionary *)dic
{
    self = [super initWithDataDic:dic];
    if (self) {
        self.ID = dic[@"id"];
    }
    return self;
}

@end

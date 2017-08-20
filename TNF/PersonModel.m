//
//  PersonModel.m
//  TNF
//
//  Created by 李江 on 15/12/27.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "PersonModel.h"

@implementation PersonModel

- (id)initWithDataDic:(NSDictionary *)dic
{
    self = [super initWithDataDic:dic];
    if (self) {
        self.ID = dic[@"id"];
    }
    return self;
}

@end

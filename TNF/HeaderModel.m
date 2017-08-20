//
//  HeaderModel.m
//  TNF
//
//  Created by 刘翔 on 15/12/30.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "HeaderModel.h"

@implementation HeaderModel

- (id)initWithDataDic:(NSDictionary *)dic
{
    self = [super initWithDataDic:dic];
    if (self) {
        self.longs = dic[@"long"];
        self.titles = [NSMutableArray array];
        self.ID = dic[@"id"];
        
    }
    return self;
}

@end

//
//  FileModel.m
//  TNF
//
//  Created by 刘翔 on 16/1/3.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "FileModel.h"

@implementation FileModel

- (id)initWithDataDic:(NSDictionary *)dic
{
    self = [super initWithDataDic:dic];
    if (self) {
        self.ID = dic[@"id"];
    }
    return self;
}

@end

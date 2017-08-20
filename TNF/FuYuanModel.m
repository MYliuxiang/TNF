//
//  FuYuanModel.m
//  TNF
//
//  Created by 李立 on 15/12/24.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "FuYuanModel.h"

@implementation FuYuanModel

- (id)initWithDataDic:(NSDictionary *)dic
{
    self = [super initWithDataDic:dic];
    if (self) {
        self.buyList = dic[@"buyList"];
    }
    return self;
}

@end

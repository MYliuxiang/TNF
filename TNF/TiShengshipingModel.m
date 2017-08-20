//
//  TiShengshipingModel.m
//  TNF
//
//  Created by lijiang on 15/12/23.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "TiShengshipingModel.h"

@implementation TiShengshipingModel
- (id)initWithDataDic:(NSDictionary *)dic
{
    self = [super initWithDataDic:dic];
    if (self) {
        self.videoID = dic[@"id"];
    }
    return self;
}
@end

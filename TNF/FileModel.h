//
//  FileModel.h
//  TNF
//
//  Created by 刘翔 on 16/1/3.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "LXBaseModel.h"

@interface FileModel : LXBaseModel

@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *thumb;

- (id)initWithDataDic:(NSDictionary *)dic;

/*id素材ID
title素材标题
thumb素材图片
 */
@end

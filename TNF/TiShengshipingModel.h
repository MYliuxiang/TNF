//
//  TiShengshipingModel.h
//  TNF
//
//  Created by lijiang on 15/12/23.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "LXBaseModel.h"

@interface TiShengshipingModel : LXBaseModel

@property(nonatomic,copy)NSString *title;//	名称
@property(nonatomic,copy)NSString *thumb;//	图片
@property(nonatomic,copy)NSString *is_video;//	是否有视频
@property(nonatomic,copy)NSString *videoID;//	视频id
@property(nonatomic,copy)NSString *video; // 视频

-(id)initWithDataDic:(NSDictionary*)data;
@end

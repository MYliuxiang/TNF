//
//  Mymodel.h
//  TNF
//
//  Created by 刘翔 on 15/12/31.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "LXBaseModel.h"

@interface Mymodel : LXBaseModel

@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *addtime;
@property(nonatomic,copy)NSString *member_id;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *headimgurl;
@property(nonatomic,copy)NSString *fen;
@property(nonatomic,copy)NSString *isComment;
@property(nonatomic,copy)NSString *isCommentCN;


-(id)initWithDataDic:(NSDictionary*)data;



 /*id优等声ID
time录音时长
member_id用户ID
nickname用户昵称
headimgurl用户头像
fen星星数
  */
@end

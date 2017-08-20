//
//  TFYSmodel.h
//  TNF
//
//  Created by 李善 on 15/12/24.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "LXBaseModel.h"

@interface TFYSmodel : LXBaseModel
//member_info用户信息
//backgroupImg背景图
//app_ex_time考试时间天数
//app_ex_timeCN考试时间描述
//amount福币
//recordCount练习录音
//scoreP预估分数
//app_t_score目标分数
//mp4Url 视频地址
//subject备考科目
//subjectCN 备考科目一周平均分
//com_list 弱点标签
//isSignIn是否签到
//amountSignIn 签到福币
//amountSignInTo 明日签到福币
//recommendList 为您推荐（
//title标题
//type类型  array(1=>"机经",2=>"分类",3=>"TPO",4=>"课程",5=>"讲座",6=>"题目",7=>"链接");
//url链接 只有当类型为链接时才有值
//relationid关联ID
//thumb图片
//）
@property(nonatomic,copy)NSString *backgroupImg;
@property(nonatomic,copy)NSNumber *apptime;
@property(nonatomic,copy)NSString *app_ex_timeCN;
@property(nonatomic,copy)NSString *amount;
@property(nonatomic,copy)NSString *recordCount;
@property(nonatomic,copy)NSString *scoreP;
@property(nonatomic,copy)NSString *appscore;
@property(nonatomic,copy)NSString *mp4Url;
@property(nonatomic,copy)NSString *sub;
@property(nonatomic,strong)NSArray *subjectCN;
@property(nonatomic,copy)NSString *isSignIn;
@property(nonatomic,copy)NSString *amountSignIn;
@property(nonatomic,copy)NSString *amountSignInTo;
@property(nonatomic,strong)NSArray *recommendList;
@property(nonatomic,strong)NSArray *com_list;
@property(nonatomic,assign)NSInteger Grayindex;
@property(nonatomic,copy)NSString *isNewRecord; //是否有练习

@end

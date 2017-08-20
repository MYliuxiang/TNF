//
//  WXLoginService.m
//  YDYWProject
//
//  Created by iOS on 14-9-26.
//  Copyright (c) 2014年 iOS. All rights reserved.
//

#import "WXLoginService.h"
//#import "APService.h"

#define getWXTokenURL @"https://api.weixin.qq.com/sns/oauth2/access_token?"
#define getUnionidURL @"https://api.weixin.qq.com/sns/userinfo?"
@implementation WXLoginService

+(void)getWXLoginAccesstoken:(NSString*)_str{
//    YDYWRequest *request = [YDYWRequest shareInstance];
    //?=APPID&secret=SECRET&code=CODE&grant_type=authorization_code
    [WXDataService requestAFWithURL:getWXTokenURL params:@{@"appid":WXAppID,@"secret":WXAppSecret,@"code":_str,@"grant_type":@"authorization_code"} httpMethod:@"GET" finishBlock:^(id result) {
        
        if(result) {
            NSString *access_token = [result objectForKey:@"access_token"];
            NSString *openid = [result objectForKey:@"openid"];
            //得到unionid
            [self getWXUnionidURL:openid accessToken:access_token];
            //通知 - 绑定UserID
            //            [APService setAlias:[UserDefaults objectForKey:Userid] callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
        }

        
    } errorBlock:^(NSError *error) {
        NSLog(@"getWXLoginAccesstoken fail");
    }];
}

//- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
//    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
//    
//}

/*
 openid	普通用户的标识，对当前开发者帐号唯一
 nickname	普通用户昵称
 sex	普通用户性别，1为男性，2为女性
 province	普通用户个人资料填写的省份
 city	普通用户个人资料填写的城市
 country	国家，如中国为CN
 headimgurl	用户头像，最后一个数值代表正方形头像大小（有0、46、64、96、132数值可选，0代表640*640正方形头像），用户没有头像时该项为空
 privilege	用户特权信息，json数组，如微信沃卡用户为（chinaunicom）
 unionid	用户统一标识。针对一个微信开放平台帐号下的应用，同一用户的unionid是唯一的。
 */

+(void)getWXUnionidURL:(NSString*)_openid accessToken:(NSString*)_access{
   
    [WXDataService requestAFWithURL:getUnionidURL params:@{@"access_token":_access,@"openid":_openid} httpMethod:@"GET" finishBlock:^(id result) {
        NSString *unionid = [result objectForKey:@"unionid"];
        NSString *nickname = [result objectForKey:@"nickname"];
        NSString *openid = [result objectForKey:@"openid"];
        NSString *headimgurl = [result objectForKey:@"headimgurl"];
        NSString *province = [result objectForKey:@"province"];
        NSString *country = [result objectForKey:@"country"];
        NSString *city = [result objectForKey:@"city"];
        NSString *sex = [result objectForKey:@"sex"];
        [WXDataService requestAFWithURL:Url_Login params:@{@"openid":openid,
                                                        @"unionid":unionid,
                                                        @"nickname":nickname,
                                                        @"headimgurl":headimgurl,
                                                        @"province":province,
                                                        @"country":country,
                                                        @"city":city,
                                                        @"sex":sex,
                                                        @"status":@"",
                                                        @"subscribe_tim":@""
                                                           } httpMethod:@"POST" finishBlock:^(id result) {
                                                               NSLog(@"result:== %@",result);
                                                            if ([[result objectForKey:@"status"] integerValue] == 0) {
                                                                                    [UserDefaults setBool:YES forKey:ISLogin];
                                                                                     NSDictionary *subdict = [result objectForKey:@"result"];
                                                                                     NSString *headimgurl = [subdict objectForKey:@"headimgurl"];
                                                                                     NSString *nickname = [subdict objectForKey:@"nickname"];
                                                                                     NSString *userid = [subdict objectForKey:@"id"];
                                                                                     [UserDefaults setObject:userid forKey:Userid];
                                                                                     [UserDefaults setObject:headimgurl forKey:IcanUrl];
                                                                                     [UserDefaults setObject:nickname forKey:Nickname];
                                                                [UserDefaults setObject:subdict[@"subject"] forKey:subject];
                                                                [UserDefaults setObject:subdict[@"amount"] forKey:Useramount];
                                                                [UserDefaults setObject:subdict[@"app_ex_time"] forKey:app_ex_time];
                                                                [UserDefaults setObject:subdict[@"app_t_score"]  forKey:app_t_score];
                                                                [UserDefaults setObject:subdict[@"name"] forKey:Username];
                                                                [UserDefaults setObject:subdict[@"mobile"] forKey:mobile1];
                                                                [UserDefaults setObject:subdict[@"weixin"]  forKey:weixin1];
                                                                                     [UserDefaults synchronize];
                                                                [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                                                                
                                                                [[NSNotificationCenter defaultCenter] postNotificationName:Noti_Dismiss object:nil];
                                                            }
                                                               if ([[result objectForKey:@"status"] integerValue] == 1) {
                                                                   [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                                                               }
 
                                                        } errorBlock:^(NSError *error) {
                                                            
                                                        }];
    } errorBlock:^(NSError *error) {
        
    }];
    
}

- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

@end

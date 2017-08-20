//
//  WXLoginService.h
//  YDYWProject
//
//  Created by iOS on 14-9-26.
//  Copyright (c) 2014年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXLoginService : NSObject

//通过code获取access_token
+(void)getWXLoginAccesstoken:(NSString*)_str;

@end

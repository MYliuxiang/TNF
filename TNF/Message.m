//
//  Message.m
//  15-QQ聊天布局
//
//  Created by Liu Feng on 13-12-3.
//  Copyright (c) 2013年 Liu Feng. All rights reserved.
//

#import "Message.h"

@implementation Message

- (void)setDict:(NSDictionary *)dict{
    
    _dict = dict;
    
    self.icon = dict[@"headimgurl"];

    self.content = dict[@"content"];
    
    if ([dict[@"group"] intValue ] == 1) {
        self.type = MessageTypeMe;

    }else{
    
        self.type = MessageTypeOther;
    }
    if ([dict[@"type"] intValue] == 1) {
        
        self.contentType = Content;
        
    }else{
    
        self.contentType = ContentMP3;
    }
    self.mp3 = dict[@"mp3"];
}



@end

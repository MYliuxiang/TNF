//
//  MessageFrame.m
//  15-QQ聊天布局
//
//  Created by Liu Feng on 13-12-3.
//  Copyright (c) 2013年 Liu Feng. All rights reserved.
//



#import "MessageFrame.h"
#import "Message.h"

@implementation MessageFrame

- (void)setMessage:(Message *)message{
    
    _message = message;
    
    // 0、获取屏幕宽度
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    // 1、计算时间的位置
 
    // 2、计算头像位置
    CGFloat iconX = kMargin;
    // 2.1 如果是自己发得，头像在右边
    if (_message.type == MessageTypeMe) {
        iconX = screenW - kMargin - kIconWH;
    }

    CGFloat iconY = kMargin;
    _iconF = CGRectMake(iconX, iconY, kIconWH, kIconWH);
    
    // 3、计算内容位置
    CGFloat contentX = CGRectGetMaxX(_iconF) + kMargin;
    CGFloat contentY = iconY;
    CGSize contentSize;
    if(_message.contentType == Content){
     contentSize = [_message.content sizeWithFont:kContentFont constrainedToSize:CGSizeMake(kContentW, CGFLOAT_MAX)];
    }else{
    
        contentSize = CGSizeMake(kScreenWidth / 2.0, 30);
    }
    if (_message.type == MessageTypeMe) {
        if (_message.contentType == Content) {
            contentX = iconX - kMargin - contentSize.width - kContentLeft - kContentRight;

        }else{
        
            contentX = iconX - kMargin - contentSize.width;
        }
    }
    
    if(message.contentType == Content){
    
    _contentF = CGRectMake(contentX, contentY, contentSize.width + kContentLeft + kContentRight, contentSize.height + kContentTop + kContentBottom);
        
    }else {
        
    _contentF = CGRectMake(contentX, contentY + 2.5, kScreenWidth / 2.0,25);

    }

    // 4、计算高度
    _cellHeight = MAX(CGRectGetMaxY(_contentF), CGRectGetMaxY(_iconF))  + kMargin;
}

@end

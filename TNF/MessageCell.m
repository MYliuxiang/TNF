//
//  MessageCell.m
//  15-QQ聊天布局
//
//  Created by Liu Feng on 13-12-3.
//  Copyright (c) 2013年 Liu Feng. All rights reserved.
//

#import "MessageCell.h"
#import "Message.h"
#import "MessageFrame.h"
#import "PlayView.h"

@interface MessageCell ()
{
    UIImageView *_iconView;
    UIButton    *_contentBtn;
    PlayView    *playView;
}

@end

@implementation MessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        // 2、创建头像
        _iconView = [[UIImageView alloc] init];
        _iconView.layer.cornerRadius = 15;
        _iconView.layer.masksToBounds = YES;
        [self.contentView addSubview:_iconView];
        
        // 3、创建内容
        _contentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_contentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _contentBtn.titleLabel.font = kContentFont;
        _contentBtn.titleLabel.numberOfLines = 0;
        _contentBtn.userInteractionEnabled = NO;
        UIImage *normal = [UIImage imageNamed:@""];
        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.5];
        [_contentBtn setBackgroundImage:normal forState:UIControlStateNormal];
        [self.contentView addSubview:_contentBtn];
        
        playView = [[PlayView alloc]initWithFrame:CGRectZero];
        playView.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:playView];
        
    }
    return self;
}

- (void)setMessageFrame:(MessageFrame *)messageFrame{
    
    _messageFrame = messageFrame;
    Message *message = _messageFrame.message;
    
    // 2、设置头像
    _iconView.image = [UIImage imageNamed:message.icon];
    [_iconView setImageWithURL:[NSURL URLWithString:message.icon] placeholderImage:[UIImage imageNamed:@"84@2x.png"]];
    _iconView.frame = _messageFrame.iconF;
    
    _contentBtn.frame = _messageFrame.contentF;
    playView.frame = _messageFrame.contentF;
    if (message.type == MessageTypeMe) {
        
        _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentTop, kContentRight, kContentBottom, kContentLeft);
        UIImage *normal = [UIImage imageNamed:@"对话框-右(1)"];
        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
        [_contentBtn setBackgroundImage:normal forState:UIControlStateNormal];
        
        
    }else{
        
        UIImage *normal = [UIImage imageNamed:@"对话框-左(1)"];
        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
        [_contentBtn setBackgroundImage:normal forState:UIControlStateNormal];
    }
    
    // 3、设置内容
    if(message.contentType == Content){
        
        [_contentBtn setTitle:message.content forState:UIControlStateNormal];
        _contentBtn.userInteractionEnabled = NO;
        _contentBtn.hidden = NO;
        playView.hidden = YES;
        if(message.type != MessageTypeMe){
            _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentTop, kContentLeft, kContentBottom, kContentRight);
        }else{
            _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentTop, kContentRight, kContentBottom,kContentLeft);
        }

    }else{
        
        _contentBtn.hidden = YES;
        playView.hidden = NO;
        playView.contentURL = message.mp3;
        
    }

}


@end

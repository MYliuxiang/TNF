//
//  RecoderView.h
//  TNF
//
//  Created by 刘翔 on 15/12/17.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recoder.h"

@protocol RecordViewDelegate <NSObject>

- (void)recordfabuMp3Data:(NSData *)data withTime:(NSString *)time;

@end

@interface RecoderView : UIView<RecordDelegate>
{
    UILabel *stateLabel;
    UILabel *tishiLable;
    UILabel *timeLabel;
    UILabel *stLabel;
    
    UIButton *playbutton;
    UIButton *giveUpbutton;
    UIButton *fabuButton;
    NSTimer *playTimer;
    int playtime;

    Recoder *recoder;
    UIImageView *imageView;
    int state;
}
@property(nonatomic,assign)int times; //录音的总时长
@property(nonatomic,weak)id<RecordViewDelegate> delegate;

- (instancetype)initWithTimes:(int)times;
- (void)show;
- (void)hiddens;


@end

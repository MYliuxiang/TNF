//
//  Recoder.h
//  TNF
//
//  Created by 刘翔 on 15/12/17.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol RecordDelegate <NSObject>

- (void)recordtime:(int)time;
- (void)playEnd;
- (void)recordEnd;


@end

@interface Recoder : NSObject<AVAudioRecorderDelegate,AVAudioPlayerDelegate>
{
    AVAudioRecorder *audioRecoder;
    AVAudioPlayer *audioPlayer;
    NSTimer *recoderTimer;
//    int counterTime;//计时器的时间
//    int times;//总的录音时间长长度

    

}
@property(nonatomic,weak)id<RecordDelegate> delegate;
@property(nonatomic,assign)int times;
@property(nonatomic,assign)int counterTime;
@property(nonatomic,assign)int totalTimes;

- (instancetype)initWithTimes:(int)times;
- (void)startRecoder; //开始录音
- (void)endRecoder;
- (void)startPlay;
- (void)endPlay;
- (void)suspendPlay; //暂停播放
- (NSString *)audio_PCMMP3;//获取MP3文件

@end

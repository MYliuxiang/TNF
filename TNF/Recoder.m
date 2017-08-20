//
//  Recoder.m
//  TNF
//
//  Created by 刘翔 on 15/12/17.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "Recoder.h"
#import "lame.h"
@implementation Recoder

- (instancetype)initWithTimes:(int)times
{
    self = [super init];
    if (self) {
        _totalTimes = times;
        
    }
    return self;
}



- (void)startRecoder
{

    //选用音频会话对象
    NSError *error = nil;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    
    if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
        [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            if (granted) {
                
            }
            else {
                

                
                return;
            }
        }];
    }
    
    
    //选择录音保存路径
    NSString *pathAsString = [self filePathOfRecordAudioView];
    NSURL *audioRecordingURL = [NSURL fileURLWithPath:pathAsString];
    //创建录音对象
    audioRecoder = [[AVAudioRecorder alloc] initWithURL:audioRecordingURL settings:[self audioRecordingSettings] error:&error];

    
    if (!audioRecoder)
    {
        NSLog(@"recoder: %@ %ld %@",[error domain],(long)[error code],[error userInfo]);
    }
    audioRecoder.delegate = self;
    [audioRecoder prepareToRecord];
    //开始录制
    [audioRecoder record];
    //开启仪表计数功能
    audioRecoder.meteringEnabled = YES;
    
    
    if ([audioRecoder record])
    {
        NSLog(@"start record");
        // 开始录音的时候计数器初始化
        _times = 0;
        _counterTime = 0;
        recoderTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCountingRecord) userInfo:nil repeats:YES];
    }
    else
    {
        NSLog(@"recorder0000: %@ %ld %@", [error domain], (long)[error code], [[error userInfo] description]);
        
        NSLog(@"Failed to record.%@\nb%@\n%@\n%@",[error localizedDescription],[error localizedFailureReason],[error localizedRecoverySuggestion],[error localizedRecoveryOptions]);
        [audioRecoder stop];
        audioRecoder = nil;
    }

    
}

//录音计数函数
-(void)timerCountingRecord
{
    
    _counterTime+=1;//每次加一秒
    if (_counterTime == self.totalTimes) {
        
        [audioRecoder stop];
        [recoderTimer invalidate];
        _times = _counterTime;
        [self.delegate recordEnd];

    }else{
    [self.delegate recordtime:_counterTime];

    }
}


- (void)endRecoder
{
    [audioRecoder stop];
    [recoderTimer invalidate];
    _times = _counterTime;
    
}



- (void)startPlay
{
    
    NSError *error = nil;
    //选取音频对象
    BOOL success = [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    if(success)
    {
        NSLog(@"选取音频对象成功！");

        //设置按钮状态
        NSError *playbackErroor = nil;
        NSError *readingError = nil;
        //文件路径选取
        NSData *fileData = [NSData dataWithContentsOfFile:[self audio_PCMMP3] options:NSDataReadingMappedIfSafe error:&readingError];
//        NSData *fileData = [NSData dataWithContentsOfFile:[self filePathOfRecordAudioView] options:NSDataReadingMappedIfSafe error:&readingError];
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        //初始化播放器
        audioPlayer = [[AVAudioPlayer alloc] initWithData:fileData error:&playbackErroor];
        audioPlayer.delegate = self;
        audioPlayer.numberOfLoops = 0;
        if ([audioPlayer prepareToPlay] && [audioPlayer play])
        {
            //counterTime = 0.0;
            //recoderTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeCountingPlay) userInfo:nil repeats:YES];
            NSLog(@"Started palying the recoder audio");

            
        }
        else
        {
            NSLog(@"播放器初始化失败！");
            
        }
    }
}


- (void)endPlay
{
    
    if (audioPlayer)
    {
        audioPlayer.delegate = self;
        [audioPlayer stop];
        
        //安全释放
        audioPlayer = nil;
        //按钮状态改变
    }

    
}

- (void)suspendPlay
{
    [audioPlayer pause];

}

#pragma mark avaudioPlay代理事件
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    
    NSLog(@"audioPlayerDidFinishPlaying");
    [self.delegate playEnd];
    if (flag)
    {
        //[self stopPlay];
        //安全释放
        audioPlayer = nil;
        //按钮状态改变
    }
    else
    {
        NSLog(@"Audio player did not stop correctly.");
    }
    
    if (player == audioPlayer)
    {
        audioPlayer = nil;
        
    }
    else
    {
        NSLog(@"not recordAudioView's player");
    }
}


#pragma mark --------录制完毕---------------
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
   NSString *str = [self audio_PCMMP3];

}


//录音字典设置
-(NSDictionary *)audioRecordingSettings
{
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] init];
    //录音格式 无法使用
    [settings setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey: AVFormatIDKey];
    //采样率
    [settings setValue :[NSNumber numberWithFloat:11025.0] forKey: AVSampleRateKey];//44100.0
    //通道数
    [settings setValue :[NSNumber numberWithInt:2] forKey: AVNumberOfChannelsKey];
    //线性采样位数
    [settings setValue :[NSNumber numberWithInt:16] forKey: AVLinearPCMBitDepthKey];
    //音频质量,采样质量
    [settings setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
    return [NSDictionary dictionaryWithDictionary:settings];
}



#pragma mark 录音后的保存路径
- (NSString *)filePathOfRecordAudioView
{
    NSString *pathAsString = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/recordAudioView.caf"];
    return pathAsString;
}

//录音转化MP3格式

-(NSString *)audio_PCMMP3
{
    
    NSString *cafFilePath = [self filePathOfRecordAudioView];
    NSString *mp3FilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/taskRecordAudioView.mp3"];
    
    @try {
        int read, write;
        
        FILE *pcm = fopen([cafFilePath cStringUsingEncoding:1], "rb"); //source 被转换的音频文件位置
        fseek(pcm, 4*1024, SEEK_CUR); //skip file header
        FILE *mp3 = fopen([mp3FilePath cStringUsingEncoding:1], "wb"); //output 输出生成的Mp3文件位置
        
        const int PCM_SIZE = 100000;
        const int MP3_SIZE = 100000;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 11025.0);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do {
            read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
    }
    @catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
    @finally {

        NSLog(@"MP3生成成功: %@",mp3FilePath);
    }
    return mp3FilePath;
}




@end

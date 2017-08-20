//
//  RecoderView.m
//  TNF
//
//  Created by 刘翔 on 15/12/17.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "RecoderView.h"
#import "UIImage+GIF.h"

@implementation RecoderView

+ (RecoderView *)sharedManager
{
    static RecoderView *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

- (instancetype)initWithTimes:(int)times
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        state = 0;
        recoder = [[Recoder alloc] initWithTimes:times];
        recoder.delegate = self;
        _times = times;
        [self initViews];
        
    }
    return self;
}

- (void)initViews
{
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.8];
    
    stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 160 * ratioHeight, kScreenWidth, 17 * ratioHeight)];
    stateLabel.backgroundColor = [UIColor clearColor];
    stateLabel.textAlignment = NSTextAlignmentCenter;
    stateLabel.font = [UIFont boldSystemFontOfSize:17];
    stateLabel.textColor = [UIColor whiteColor];
    [self addSubview:stateLabel];
    
    tishiLable = [[UILabel alloc] initWithFrame:CGRectMake(0, stateLabel.bottom + 10, kScreenWidth, 15 * ratioHeight)];
    tishiLable.backgroundColor = [UIColor clearColor];
    tishiLable.textAlignment = NSTextAlignmentCenter;
    tishiLable.font = [UIFont systemFontOfSize:15];
    tishiLable.text = @"";
    tishiLable.textColor = [UIColor whiteColor];
    [self addSubview:tishiLable];
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, tishiLable.bottom + 30, kScreenWidth, 50 * ratioHeight)];
    timeLabel.backgroundColor = [UIColor clearColor];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont boldSystemFontOfSize:50];
    timeLabel.font = [UIFont fontWithName:@"Arial" size:50];
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.text = @"0";
    [self addSubview:timeLabel];

    
    giveUpbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    giveUpbutton.frame = CGRectMake(25*ratioHeight, kScreenHeight - 30 * ratioHeight - 45 * ratioHeight, (kScreenWidth - 50 * ratioHeight) / 2.0, 45 * ratioHeight);
    [giveUpbutton setTitle:@"放弃" forState:UIControlStateNormal];
    [giveUpbutton setBackgroundColor:[MyColor colorWithHexString:@"#f0f0f0"]];
    [giveUpbutton setTitleColor:[MyColor colorWithHexString:@"#0172fe"] forState:UIControlStateNormal];
    [giveUpbutton addTarget:self action:@selector(giveUp:) forControlEvents:UIControlEventTouchUpInside];
    [giveUpbutton.layer setMasksToBounds:YES];
    [giveUpbutton.layer setCornerRadius:45 * ratioHeight / 2.0];//
//    giveUpbutton.alpha = 0;
//    [self addSubview:giveUpbutton];
    
    fabuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    fabuButton.frame = CGRectMake(kScreenWidth / 2.0, kScreenHeight - 30 * ratioHeight - 45 * ratioHeight, (kScreenWidth - 50 * ratioHeight) / 2.0, 45 * ratioHeight);
    [fabuButton setBackgroundColor:[MyColor colorWithHexString:@"#0172fe"]];
    [fabuButton setTitle:@"发布" forState:UIControlStateNormal];
    [fabuButton addTarget:self action:@selector(fabu1:) forControlEvents:UIControlEventTouchUpInside];
    [fabuButton.layer setMasksToBounds:YES];
    [fabuButton.layer setCornerRadius:45 * ratioHeight / 2.0];//
//    fabuButton.hidden = YES;

//    fabuButton.alpha = 0;
//    [self addSubview:fabuButton];

    
    

    playbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    playbutton.frame = CGRectMake((kScreenWidth - 65 * ratioHeight) / 2.0, kScreenHeight - 20 * ratioHeight - 65 * ratioHeight, 65 * ratioHeight, 65 * ratioHeight);
    [playbutton setImage:[UIImage imageNamed:@"play_03"] forState:UIControlStateNormal];
    [playbutton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:playbutton];
    
    
    stLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, playbutton.top - 35, kScreenWidth, 15 * ratioHeight)];
    stLabel.backgroundColor = [UIColor clearColor];
    stLabel.textAlignment = NSTextAlignmentCenter;
    stLabel.font = [UIFont systemFontOfSize:15];
    stLabel.textColor = [UIColor whiteColor];
    stLabel.text = @"试听";
    stLabel.hidden = YES;
    [self addSubview:stLabel];

    // 读取gif图片数据
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"录音动画" ofType:@"gif"]];
    
    CGRect frame = CGRectMake(20 * ratioWidth,timeLabel.bottom + 40 * ratioHeight,kScreenWidth - 40 * ratioWidth,40 * ratioWidth);
    
    imageView = [[UIImageView alloc] initWithFrame:frame];
    UIImage *image = [UIImage sd_animatedGIFWithData:gif];
    [image sd_animatedImageByScalingAndCroppingToSize:CGSizeMake(kScreenWidth - 40 * ratioWidth,40 * ratioWidth)];
    imageView.image = image;
    imageView.hidden = YES;
    [self addSubview:imageView];
    
    
    [playbutton setImage:[UIImage imageNamed:@"play_06"] forState:UIControlStateNormal];
    stateLabel.text = @"正在录音";
    tishiLable.text = @"请大声清晰作答，注意时间！";
    state = 1;
    timeLabel.text = [NSString stringWithFormat:@"%d",self.times];
    [recoder startRecoder];
    imageView.hidden = NO;



}


#pragma mark -------发布----------
- (void)fabu1:(UIButton *)sender
{
    [recoder endPlay];
    NSData *recordeData =  [self MP3];
    [self.delegate recordfabuMp3Data:recordeData withTime:[NSString stringWithFormat:@"%d",recoder.times]];


}

#pragma mark --------获取MP3文件
- (NSData *)MP3
{

    NSData *fileData = [NSData dataWithContentsOfFile: [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/taskRecordAudioView.mp3"] options:NSDataReadingMappedIfSafe error:nil];
    return fileData;
}

-(void)deleteFile {
    NSFileManager* fileManager=[NSFileManager defaultManager];
    
    //文件名
    NSString *uniquePath=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/taskRecordAudioView.mp3"];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    if (!blHave) {
        NSLog(@"没有");
        return ;
    }else {
        NSLog(@" 有");
        BOOL blDele= [fileManager removeItemAtPath:uniquePath error:nil];
        if (blDele) {
            NSLog(@"删除成功");
        }else {
            NSLog(@"删除失败");
        }
        
    }
}


- (void)giveUp:(UIButton *)sender
{
    [recoder endPlay];
    [self hiddens];
    [self deleteFile];
    
}

- (void)buttonAction:(UIButton *)sender
{
    if (state == 0){
//       开始录音
        [sender setImage:[UIImage imageNamed:@"play_06"] forState:UIControlStateNormal];
        stateLabel.text = @"正在录音";
        tishiLable.text = @"请大声清晰作答，注意时间！";
        state = 1;
        timeLabel.text = [NSString stringWithFormat:@"%d",self.times];
        [recoder startRecoder];
        imageView.hidden = NO;
        
        
    }else if(state == 1){
//        录制声音结束
        [sender setImage:[UIImage imageNamed:@"play_07"] forState:UIControlStateNormal];
        [recoder endRecoder];
        timeLabel.text = @"0";
        tishiLable.text = [NSString stringWithFormat:@"%.2d:%.2d",recoder.times/60,recoder.times%60];
        stateLabel.text = @"录音结束";
        stLabel.hidden = NO;
        state = 2;
        [self showAnimation];
        imageView.hidden = YES;
        
    
    }else if(state == 2){
//        开始播放
        [sender setImage:[UIImage imageNamed:@"play_06"] forState:UIControlStateNormal];
        state = 3;
        [recoder startPlay];
        playtime = 0;
        timeLabel.text = [NSString stringWithFormat:@"%d",playtime];
        playTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCountingRecord) userInfo:nil repeats:YES];
        imageView.hidden = NO;

    
    }else if (state == 3){
        //播放结束
        [sender setImage:[UIImage imageNamed:@"play_07"] forState:UIControlStateNormal];
        state = 2;
        [recoder endPlay];
        playtime = 0;
        timeLabel.text = [NSString stringWithFormat:@"%d",playtime];
        [playTimer invalidate];
        imageView.hidden = YES;
       
    }

}

- (void)timerCountingRecord
{
    playtime++;
    
    timeLabel.text = [NSString stringWithFormat:@"%d",playtime];

}

- (void)playEnd
{
    [playbutton setImage:[UIImage imageNamed:@"play_07"] forState:UIControlStateNormal];
    timeLabel.text = @"0";
    state = 2;
    playtime = 0;
    [playTimer invalidate];
    imageView.hidden = YES;

}

- (void)recordtime:(int)time
{

    timeLabel.text = [NSString stringWithFormat:@"%d",self.times - time];

}

- (void)recordEnd
{
    [playbutton setImage:[UIImage imageNamed:@"play_07"] forState:UIControlStateNormal];
    [recoder endRecoder];
    tishiLable.text = [NSString stringWithFormat:@"%.2d:%.2d",recoder.times/60,recoder.times%60];
    stateLabel.text = @"录音结束";
    stLabel.hidden = NO;
    timeLabel.text = @"0";
    state = 2;
    [self showAnimation];
    imageView.hidden = YES;

}

- (void)showAnimation{
    
    [UIView animateWithDuration:1 animations:^{
        
        [self insertSubview:fabuButton belowSubview:playbutton];
        [self insertSubview:giveUpbutton belowSubview:playbutton];

    } completion:^(BOOL finished) {

    }];
    
}

- (void)show
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];

}

- (void)hiddens
{
    [self removeFromSuperview];

}


@end

























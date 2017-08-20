//
//  PlayView.m
//  TNF
//
//  Created by 刘翔 on 16/1/3.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "PlayView.h"


#define kFSVoiceBubbleShouldStopNotification @"FSVoiceBubbleShouldStopNotification"
@implementation PlayView

- (instancetype)initWithFrame:(CGRect)frame
{    self = [super initWithFrame:frame];
    
    if (self) {

        self.height = 25;
        [self _initViews];
        
       

    }
    
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.height = 25;
        [self _initViews];
    }

    return self;
}

- (void)_initViews
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 12.5;

    index = 0;
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 15, 15)];
    imageView.image = [UIImage imageNamed:@"listenjt01"];
    [self addSubview:imageView];
    imageView.userInteractionEnabled = YES;
    
    imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2.0 - 25, 5, 15, 15)];
    imageView1.image = [UIImage imageNamed:@"listenjt003"];
    [self addSubview:imageView1];
    imageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bubbleShouldStop:) name:kFSVoiceBubbleShouldStopNotification object:nil];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kFSVoiceBubbleShouldStopNotification object:nil];
}

#pragma mark - Nofication
- (void)bubbleShouldStop:(NSNotification *)notification
{
    if (_player.isPlaying) {
        [self stop];
        imageView.image = [UIImage imageNamed:@"listenjt01"];
        [self stopAnimating];
    }
}


- (void)tap
{
    if (index == 0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kFSVoiceBubbleShouldStopNotification object:nil];

        
        imageView.image = [UIImage imageNamed:@"listenjt02"];
        [self startAnimating];
        index = 1;

        [self play];

        
    }else{
        
        imageView.image = [UIImage imageNamed:@"listenjt01"];
        [self stopAnimating];
        [self stop];
        index = 0;

    
    }

}

- (void)setContentURL:(NSString *)contentURL
{
    _contentURL = contentURL;
    //选取音频对象
    
//    //  后台执行：
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        // something
//        NSError *error = nil;
//        BOOL success = [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
//        if(success)
//        {
//            NSLog(@"选取音频对象成功！");
//            
//            //设置按钮状态
//            NSError *playbackErroor = nil;
//            
//            //文件路径选取
//            NSURL *url = [[NSURL alloc]initWithString:_contentURL];
//            NSData *audioData = [NSData dataWithContentsOfURL:url];
//            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
//            //初始化播放器
//            _player = [[AVAudioPlayer alloc] initWithData:audioData error:&playbackErroor];
//            _player.delegate = self;
//            _player.numberOfLoops = 0;
//            [_player prepareToPlay];
//
//            
//        }
//
//    });
    
    
}

#pragma mark - AVAudioPlayer Delegate

- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
    [self pause];
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags
{
    [self play];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    imageView.image = [UIImage imageNamed:@"listenjt01"];
    [self stop];
    [self stopAnimating];
}




- (void)startAnimating
{
    if (!imageView1.isAnimating) {
        UIImage *image0 = [UIImage imageNamed:@"listenjt001"];
        UIImage *image1 = [UIImage imageNamed:@"listenjt002"];
        UIImage *image2 = [UIImage imageNamed:@"listenjt003"];
        imageView1.animationImages = @[image0, image1, image2];
        imageView1.animationDuration = 2;
        [imageView1 startAnimating];
    }
}

- (void)stopAnimating
{
    if (imageView1.isAnimating) {
        [imageView1 stopAnimating];
    }
}


- (void)play
{
    
    if (!_contentURL) {
        [MBProgressHUD showError:@"地址错误" toView:[UIApplication sharedApplication].keyWindow];
        return;
    }
    if (!_player.playing) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            // http://m.tuoninfu.com/Public/upload/image/20160128/56a9cb91756d3.mp3
            
            
            
            NSURL *url = [[NSURL alloc]initWithString:_contentURL];
            NSData * audioData = [NSData dataWithContentsOfURL:url];
            
            //将数据保存到本地指定位置
            NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", docDirPath , @"temp"];
            [audioData writeToFile:filePath atomically:YES];
            
            //播放本地音乐
            NSURL *fileURL = [NSURL fileURLWithPath:filePath];
            _player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
            [_player play];
            
            //文件路径选取
//            NSURL *url = [[NSURL alloc]initWithString:_contentURL];
//            NSData *audioData = [NSData dataWithContentsOfURL:url];
//            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
//            _player = nil;
//            //NSData *data = [NSData dataWithContentsOfURL:url];
//            _player = [[AVAudioPlayer alloc] initWithData:audioData error:NULL];
//            _player.delegate = self;
//            [_player prepareToPlay];
//            [_player play];

            
        });

        [self startAnimating];
    }

    
//    if (!_contentURL) {
//      [MBProgressHUD showError:@"地址错误" toView:[UIApplication sharedApplication].keyWindow];
//        return;
//    }
//    if (!_player.playing) {
//
//        
//    if ([_player prepareToPlay] || [_player play])
//            {
//                //counterTime = 0.0;
//                //recoderTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeCountingPlay) userInfo:nil repeats:YES];
//
//                //设置按钮状态
//                NSError *playbackErroor = nil;
//                
//                //文件路径选取
//                NSURL *url = [[NSURL alloc]initWithString:_contentURL];
//                NSData *audioData = [NSData dataWithContentsOfURL:url];
//                [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
//                //初始化播放器
//                _player = [[AVAudioPlayer alloc] initWithData:audioData error:&playbackErroor];
//                _player.delegate = self;
//                _player.numberOfLoops = 0;
//                [_player prepareToPlay];
//
//                [self startAnimating];
//                [_player  play];
//                
//            }
//            else
//            {
//                [MBProgressHUD showError:@"地址错误！" toView:[UIApplication sharedApplication].keyWindow];
//                imageView.image = [UIImage imageNamed:@"listenjt01"];
//                [self stopAnimating];
//                
//            }
//
//    }


}

- (void)pause
{
    if (_player.playing) {
        [_player pause];
        [self stopAnimating];
    }
}

- (void)stop
{
    if (_player.playing) {
        [_player stop];
        _player.currentTime = 0;
        
        imageView.image = [UIImage imageNamed:@"listenjt01"];
        [self stopAnimating];
    }
}



@end

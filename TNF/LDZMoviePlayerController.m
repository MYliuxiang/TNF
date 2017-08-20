//
//  LDZMoviePlayerController.m
//  LDZMoviewPlayer_Xib
//
//  Created by rongxun02 on 15/11/24.
//  Copyright © 2015年 DongZe. All rights reserved.
//

#import "LDZMoviePlayerController.h"
#import <AVFoundation/AVFoundation.h>
#import "LDZAVPlayerHelper.h"
#import "AppDelegate.h"
#define TOPVIEW_HEIGHT 64
#define RIGHT_WIDTH 50
#define ROTATOR_BOTTOM_HEIGHT 50
#define VERTICAL_BOTTOM_HEIGHT 90
#define ZERO 0
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define NLSystemVersionGreaterOrEqualThan(version) ([[[UIDevice currentDevice] systemVersion] floatValue] >= version)
#define IOS7 NLSystemVersionGreaterOrEqualThan(7.0)

@interface LDZMoviePlayerController ()<UIGestureRecognizerDelegate>
{
    AVPlayerItem *playItem;
    float progressSlider;
    BOOL isPlay;
    BOOL isFull;
    
}
@property (nonatomic, assign)CMTime currentTime;
@property (nonatomic, assign)BOOL isForward;
//  View
@property (strong, nonatomic) IBOutlet UIView *topView;

- (IBAction)finishAction:(UIButton *)sender;
//  公共的
@property (strong, nonatomic) IBOutlet UILabel *topPastTimeLabel;
@property (strong, nonatomic) IBOutlet UISlider *topProgressSlider;
@property (strong, nonatomic) IBOutlet UILabel *topRemainderLabel;

@property (strong, nonatomic) IBOutlet UIButton *fullBtton;
@property (weak, nonatomic) IBOutlet UIButton *backbutton;

- (IBAction)topSliderValueChangedAction:(id)sender;
- (IBAction)topSliderTouchDownAction:(id)sender;
- (IBAction)topSliderTouchUpInsideAction:(id)sender;
- (IBAction)BackActoin:(id)sender;//返回

//横屏/竖屏下独有的控件


@property (strong, nonatomic) IBOutlet UIButton *verticalPlayButton;//  播放button

- (IBAction)rotatorPlayAction:(UIButton *)sender;



@property (nonatomic, assign) BOOL isFirstRotatorTap;//  横屏下第一次点击
@property (nonatomic, assign) BOOL isFirstVerticalTap;//  竖屏下第一次点击
@property (nonatomic, strong) LDZAVPlayerHelper *playerHelper;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, assign) BOOL isPlayOrParse;
@property (nonatomic, assign) CGFloat totalMovieDuration;//  保存该视频资源的总时长，快进或快退的时候要用

@end

@implementation LDZMoviePlayerController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setMoviePlay];
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isFull = NO;
    self.view.backgroundColor = [UIColor blackColor];
    self.topProgressSlider.value = 0.0;
    [self addGestureRecognizer];
    //  添加观察者
    [self addNotificationCenters];
    [self addAVPlayer];

}

- (void)addAVPlayer{
    playItem = [AVPlayerItem playerItemWithURL: self.movieURL];
    self.playerHelper = [[LDZAVPlayerHelper alloc] init];
    [_playerHelper initAVPlayerWithAVPlayerItem:playItem];
    //  创建显示层
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer: _playerHelper.getAVPlayer];
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    //  竖屏的时候frame
    [self setVerticalFrame];
    //  这是视频的填充模式, 默认为AVLayerVideoGravityResizeAspect
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //  插入到view层上面, 没有用addSubLayer
    [self.view.layer insertSublayer:_playerLayer atIndex:0];
    //  添加进度观察
    [self addProgressObserver];
    [self addObserverToPlayerItem: playItem];
}
//  播放页面添加轻拍手势
- (void)addGestureRecognizer {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAllSubViews:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
}
#pragma mark - 观察者 观察播放完毕 观察屏幕旋转
- (void)addNotificationCenters {
    //  注册观察者用来观察，是否播放完毕
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    //  注册观察者来观察屏幕的旋转
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}
#pragma mark - 横屏 竖屏的时候frame的设置
- (void)statusBarOrientationChange:(NSNotification *)notification {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationLandscapeRight) {
        [self setPlayerLayerFrame];
        self.isFirstRotatorTap = YES;
        [self setTopRightBottomFrame];
    }
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        [self setPlayerLayerFrame];
        self.isFirstRotatorTap = YES;
        [self setTopRightBottomFrame];
    }
    if (orientation == UIInterfaceOrientationPortrait) {
        //  竖屏的时候
        [self setVerticalFrame];
        self.isFirstRotatorTap = YES;
        [self setTopRightBottomFrame];
    }
}
//  横屏的时候frame
- (void)setPlayerLayerFrame {
    CGRect frame = self.view.bounds;
    frame.origin.x = 20;
    frame.origin.y = (SCREEN_HEIGHT - SCREEN_HEIGHT * (SCREEN_WIDTH - 40) / SCREEN_WIDTH) / 2;
    frame.size.width = SCREEN_WIDTH - 40;
    frame.size.height = SCREEN_HEIGHT * (SCREEN_WIDTH - 40) / SCREEN_WIDTH;
    _playerLayer.frame = frame;
}
//  竖屏的时候frame
- (void)setVerticalFrame {
    CGRect frame = self.view.bounds;
    frame.origin.x = ZERO;
    frame.origin.y = (SCREEN_HEIGHT - SCREEN_WIDTH * (SCREEN_WIDTH / SCREEN_HEIGHT)) / 2;
    frame.size.width = SCREEN_WIDTH;
    frame.size.height = SCREEN_WIDTH * (SCREEN_WIDTH / SCREEN_HEIGHT);
    _playerLayer.frame = frame;
}

//  动画(出现或隐藏top - right - bottom)
- (void)dismissAllSubViews:(UITapGestureRecognizer *)tap {
    [self setTopRightBottomFrame];
}
//  设置TopRightBottomFrame
- (void)setTopRightBottomFrame {
    __weak typeof (self) myself = self;
    if (!self.isFirstRotatorTap) {
        [UIView animateWithDuration:.2f animations:^{
            myself.topView.frame = CGRectMake(myself.topView.frame.origin.x, SCREEN_HEIGHT, myself.topView.frame.size.width, myself.topView.frame.size.height);
        }];
        self.isFirstRotatorTap = YES;
        _backbutton.hidden = YES;

    } else {
        [UIView animateWithDuration:.2f animations:^{
            myself.topView.frame = CGRectMake(myself.topView.frame.origin.x,  SCREEN_HEIGHT - TOPVIEW_HEIGHT, myself.topView.frame.size.width, myself.topView.frame.size.height);
           
        }];
        _backbutton.hidden = NO;

        self.isFirstRotatorTap = NO;
    }
}
//  显示top,right,bottom的View
- (void)setTopRightBottomViewHiddenToShow {
    _topView.hidden = NO;
    _isFirstRotatorTap = NO;
}
//  隐藏top,right,bottom的View
- (void)setTopRightBottomViewShowToHidden {
    
    _topView.hidden = YES;
    _isFirstRotatorTap = YES;
    
}
#pragma mark - 暂停
- (void)setMovieParse {
    [_playerHelper.getAVPlayer pause];
    isPlay = NO;
}
#pragma mark - 播放
- (void)setMoviePlay {
    [_playerHelper.getAVPlayer play];
    isPlay = YES;

}

#pragma mark -  添加进度观察 - addProgressObserver
- (void)addProgressObserver {
    //  设置每秒执行一次
    [_playerHelper.getAVPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue: NULL usingBlock:^(CMTime time) {
//NSLog(@"进度观察 + %f", _topProgressSlider.value);
        //  获取当前时间
        CMTime currentTime = _playerHelper.getAVPlayer.currentItem.currentTime;
        //  转化成秒数
        CGFloat currentPlayTime = (CGFloat)currentTime.value / currentTime.timescale;
        //  总时间
        CMTime totalTime = playItem.duration;
        //  转化成秒
        _totalMovieDuration = (CGFloat)totalTime.value / totalTime.timescale;
        //  相减后
        _topProgressSlider.value = CMTimeGetSeconds(currentTime) / _totalMovieDuration;
        progressSlider = CMTimeGetSeconds(currentTime) / _totalMovieDuration;
//NSLog(@"%f", _topProgressSlider.value);
        NSDate *pastDate = [NSDate dateWithTimeIntervalSince1970: currentPlayTime];
         _topPastTimeLabel.text = [self getTimeByDate:pastDate byProgress: currentPlayTime];
        CGFloat remainderTime = _totalMovieDuration - currentPlayTime;
        NSDate *remainderDate = [NSDate dateWithTimeIntervalSince1970: remainderTime];
        _topRemainderLabel.text = [self getTimeByDate:remainderDate byProgress: remainderTime];
        if (_isFirstRotatorTap) {
            [self setTopRightBottomViewShowToHidden];
        } else {
            [self setTopRightBottomViewHiddenToShow];
        }
    }];
    
    //  设置topProgressSlider图片
    UIImage *thumbImage = [UIImage imageNamed:@"slider-metal-handle.png"];
    [self.topProgressSlider setThumbImage:thumbImage forState:UIControlStateHighlighted];
    [self.topProgressSlider setThumbImage:thumbImage forState:UIControlStateNormal];
}

- (NSString *)getTimeByDate:(NSDate *)date byProgress:(float)current {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (current / 3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    return [formatter stringFromDate:date];
}

- (void)addObserverToPlayerItem:(AVPlayerItem *)playerItem {
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)removeObserverFromPlayerItem:(AVPlayerItem *)playerItem {
    [playerItem removeObserver:self forKeyPath:@"status"];
    [playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}

//  观察者的方法, 会在加载好后触发, 可以在这个方法中, 保存总文件的大小, 用于后面的进度的实现
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue];
        if (status == AVPlayerStatusReadyToPlay) {
            NSLog(@"正在播放...,视频总长度: %.2f",CMTimeGetSeconds(playerItem.duration));
            CMTime totalTime = playerItem.duration;
            self.totalMovieDuration = (CGFloat)totalTime.value / totalTime.timescale;
        }
    }
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSArray *array = playerItem.loadedTimeRanges;
        //  本次缓冲时间范围
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        //  缓冲总长度
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;
//        NSLog(@"共缓冲%.2f", totalBuffer);
//        NSLog(@"进度 + %f", progressSlider);
        self.topProgressSlider.value = progressSlider;
    }
}

#pragma mark - UIGestureRecognizerDelegate Method 方法
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    //  不让子视图响应点击事件
    if( CGRectContainsPoint(self.topView.frame, [gestureRecognizer locationInView:self.view])) {
        return NO;
    } else{
        return YES;
    };
}

#pragma mark - 播放进度
- (IBAction)topSliderValueChangedAction:(id)sender {
    UISlider *test = (UISlider *)sender;
//    NSLog(@"进度条进度 + %f", test.value);
    UISlider *senderSlider = sender;
    double currentTime = floor(_totalMovieDuration * senderSlider.value);
    //转换成CMTime才能给player来控制播放进度
    CMTime dragedCMTime = CMTimeMake(currentTime, 1);
    [_playerHelper.getAVPlayer seekToTime:dragedCMTime completionHandler:^(BOOL finished) {
        if (_isPlayOrParse) {
            [_playerHelper.getAVPlayer play];
        }
    }];
}

- (IBAction)topSliderTouchDownAction:(id)sender {
}

- (IBAction)topSliderTouchUpInsideAction:(id)sender {
}

#pragma mark - 播放...
- (IBAction)rotatorPlayAction:(UIButton *)sender {
    if (isPlay) {
        [sender setImage:[UIImage imageNamed:@"mypaly"] forState: UIControlStateNormal];
        [self setMovieParse];
        

    } else {
         [sender setImage:[UIImage imageNamed:@"mystop"] forState: UIControlStateNormal];
        [self setMoviePlay];
    }
}


#pragma mark - #pragma mark -  放大 缩小..
- (IBAction)finishAction:(UIButton *)sender {
   
    
    isFull = !isFull;
    if (isFull == YES) {
        self.view.backgroundColor = [UIColor blackColor];
        [sender setImage:[UIImage imageNamed:@"btn_min"] forState: UIControlStateNormal];
        NSNumber *value = [NSNumber numberWithInt:UIDeviceOrientationLandscapeRight];
        [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
        
    }
    
    if (isFull == NO) {
        self.view.backgroundColor = UIColor6(正文小字);
        [sender setImage:[UIImage imageNamed:@"btn_full"] forState: UIControlStateNormal];
        NSNumber *value = [NSNumber numberWithInt:UIDeviceOrientationPortrait];
        [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
        
    }
}


- (IBAction)BackActoin:(id)sender {
    
    
    NSNumber *value = [NSNumber numberWithInt:UIDeviceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    [_playerHelper.getAVPlayer pause];
    
    [self removeObserverFromPlayerItem: _playerHelper.getAVPlayer.currentItem];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    //  返回前一个页面的时候释放内存
    [self.playerHelper.getAVPlayer replaceCurrentItemWithPlayerItem:nil];
    _playerLayer = nil;
    _playerHelper = nil;
    
   UIView *_BgVideoView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _BgVideoView.backgroundColor = [UIColor blackColor];
    _BgVideoView.alpha = .5;
    [[UIApplication sharedApplication].keyWindow addSubview:_BgVideoView];

    
    [self dismissViewControllerAnimated:NO completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:Noti_VideoDonghua object:nil];
        _BgVideoView.alpha = 0;
        [_BgVideoView removeFromSuperview];
    }];
    
   
}

#pragma mark 播放结束后的代理回调
- (void)moviePlayDidEnd:(NSNotification *)notify
{
    //  LettopRightBottomViewShow
    [self setTopRightBottomViewHiddenToShow];
    [self setMovieParse];
    //  让这个视频循环播放...
}


- (void)dealloc {
    
     NSLog(@"释放");
    
    //  移除观察者,使用观察者模式的时候,记得在不使用的时候,进行移除
    [self removeObserverFromPlayerItem: _playerHelper.getAVPlayer.currentItem];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
     //  返回前一个页面的时候释放内存
     [self.playerHelper.getAVPlayer replaceCurrentItemWithPlayerItem:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////  进入该视图控制器自动横屏进行播放
//- (BOOL)shouldAutorotate
//{
//    return YES;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskLandscape;
//}


@end

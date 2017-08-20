//
//  PlayView.h
//  TNF
//
//  Created by 刘翔 on 16/1/3.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayView : UIView<AVAudioPlayerDelegate>
{
    
    UIImageView *imageView;
    UIImageView *imageView1;
    int index;
    

}
@property (strong, nonatomic) NSString *contentURL;
@property (strong, nonatomic) AVAudioPlayer *player;
@property (strong, nonatomic) AVURLAsset    *asset;


- (void)play;
- (void)stop;

@end

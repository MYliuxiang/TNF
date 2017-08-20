//
//  WhizkidController.h
//  TNF
//
//  Created by 李江 on 16/1/5.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "BaseViewController.h"
#import "Mymodel.h"
#import "Info.h"

@interface WhizkidController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,AVAudioPlayerDelegate,UITextViewDelegate,RecordViewDelegate>
{
    UITableView *_tableView;
    UIView *_ViodeView;
    UIButton *button;
    NSTimer *recoderTimer;
    int _counterTime;
    UILabel *timeLabel;
    int subType;
    UIView *progressView;
    
    NSMutableArray  *_allMessagesFrame;
    UITextView *_messageField;
    UIView *view;
    UIButton *senderButton;
    RecoderView *recode;

}
@property (retain, nonatomic) AVAudioPlayer *player;
@property (nonatomic,retain)Mymodel *model;
@property (nonatomic,retain)NSString *ID;
@property (nonatomic,retain)NSMutableArray *dataList;
@property (nonatomic,retain)Info *info;
@property (nonatomic,retain)NSDictionary *dic;
@property (nonatomic,retain)NSArray *mp3_list;
@property (nonatomic,retain)NSArray *com_list;
@property (nonatomic,retain)NSMutableArray *messages;
@property (nonatomic,copy)NSString *mp4Url;
@property (nonatomic,copy)NSString *mp3Url;
@property (nonatomic,assign)BOOL isSelf;

@end

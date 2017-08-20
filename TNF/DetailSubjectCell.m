//
//  DetailSubjectCell.m
//  TNF
//
//  Created by 刘翔 on 15/12/22.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "DetailSubjectCell.h"
#import "PlayView.h"
#import "FuYuanViewController.h"

@implementation DetailSubjectCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _initViews];
    }
    return self;
    
}

- (void)_initViews
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 155 * ratioHeight - 60, kScreenWidth - 20, 60)];
    [button setImage:[UIImage imageNamed:@"jiantou_04"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    button.imageEdgeInsets = UIEdgeInsetsMake(40, 0, 0, 0);
    [self.contentView addSubview:button];
    
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 20 - 10, 40 * ratioHeight)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:15 * ratioHeight];
    [self addSubview:titleLabel];
    
    count = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 20 - 10 - 50, 0, 50, 40 * ratioHeight)];
    count.textColor = UIColor4(所有的灰色);
    count.font = [UIFont systemFontOfSize:13 * ratioHeight];
    count.textAlignment = NSTextAlignmentRight;
    [self addSubview:count];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 40 * ratioHeight, kScreenWidth - 40, .5)];
    imageView.backgroundColor = [MyColor colorWithHexString:@"#555555"];
    [self addSubview:imageView];
    
    question = [[UILabel alloc] initWithFrame:CGRectMake(10, imageView.bottom + 10, kScreenWidth - 90 , 13 * ratioHeight)];
    question.textColor = UIColor1(蓝);
    question.font = [UIFont systemFontOfSize:13 * ratioHeight];
    question.textAlignment = NSTextAlignmentLeft;
    question.text = @"Question：";
    [self addSubview:question];

    answer = [[UILabel alloc] initWithFrame:CGRectMake(10, question.bottom + 10, kScreenWidth - 40 , 13 * 4 * ratioHeight)];
    answer.textColor = UIColor(深色背景);
    answer.font = [UIFont systemFontOfSize:13 * ratioHeight];
    answer.textAlignment = NSTextAlignmentLeft;
    answer.numberOfLines = 3;
    [self addSubview:answer];

    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    titleLabel.text = self.model.infos.title;
    if ([self.model.count integerValue] == 0) {
        count.text = @"";
    }else{
    count.text = [NSString stringWithFormat:@"%d/%d",[self.model.cur intValue],[self.model.count intValue]];
    }
    answer.text = self.model.infos.question;
    [answer sizeToFit];
    answer.top = question.bottom + 10;
    
}

- (void)buttonAction
{
    [self animation];

}

- (void)animation
{
    [self _initbganimation];
    [UIView animateWithDuration:0.4 animations:^{

        animationView.height = kScreenHeight - 64 - 10 - 20 - 65 * ratioHeight / 2.0;
        
    } completion:^(BOOL finished) {

    }];

    
    
    

}

- (void)_initAnimation
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 20 - 10, 40 * ratioHeight)];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:15 * ratioHeight];
    label.text = self.model.infos.title;
    [animationView addSubview:label];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 40 * ratioHeight, kScreenWidth - 40, .5)];
    imageView.backgroundColor = [MyColor colorWithHexString:@"#555555"];
    [animationView addSubview:imageView];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, imageView.bottom, kScreenWidth - 20, kScreenHeight - 64 - 10 - 20 - 65 * ratioHeight / 2.0 - imageView.bottom)];
    [animationView addSubview:scrollView];
    
    
    int y =  10;
    
    if (self.model.infos.reading.length == 0) {

        
    }else{
        
        UILabel *reading = [[UILabel alloc] initWithFrame:CGRectMake(10, y, kScreenWidth - 90 , 15 * ratioHeight)];
        reading.textColor = UIColor1(蓝);
        reading.font = [UIFont systemFontOfSize:13 * ratioHeight];
        reading.textAlignment = NSTextAlignmentLeft;
        reading.text = @"Reading part:";
        [scrollView addSubview:reading];
        
        float height;
        
        if (self.model.infos.reading.length == 0) {
            height = 0;
        }else{
            height = [self heightForString:self.model.infos.reading fontSize:13 * ratioHeight andWidth:kScreenWidth - 40];
        }
        
        UILabel *part = [[UILabel alloc] initWithFrame:CGRectMake(10, reading.bottom + 10, kScreenWidth - 40 , height)];
        part.textColor = UIColor(深色背景);
        part.font = [UIFont systemFontOfSize:13 * ratioHeight];
        part.textAlignment = NSTextAlignmentLeft;
        part.numberOfLines = 0;
        part.text = self.model.infos.reading;
        [scrollView addSubview:part];
        scrollView.contentSize = CGSizeMake(0, part.bottom + 20);

        y = part.bottom + 10;

    }

    if (self.model.infos.mp3.length == 0) {
        
        
        
    }else{

        UILabel *listen = [[UILabel alloc] initWithFrame:CGRectMake(10, y, kScreenWidth - 90 , 15 * ratioHeight)];
        listen.textColor = UIColor1(蓝);
        listen.font = [UIFont systemFontOfSize:13 * ratioHeight];
        listen.textAlignment = NSTextAlignmentLeft;
        listen.text = @"Listenning part:";
        [scrollView addSubview:listen];
        
        
        playView = [[PlayView alloc] initWithFrame:CGRectMake(10, listen.bottom + 10, kScreenWidth / 2.0, 20)];
        playView.backgroundColor = [UIColor yellowColor];
        playView.contentURL = self.model.infos.mp3;
        [scrollView addSubview:playView];
        scrollView.contentSize = CGSizeMake(0, playView.bottom + 20);

        y = playView.bottom + 10;
        
    }
    
    if (self.model.infos.question.length == 0) {

    }else{

        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10,  y, kScreenWidth - 90 , 15 * ratioHeight)];
        label1.textColor = UIColor1(蓝);
        label1.font = [UIFont systemFontOfSize:13 * ratioHeight];
        label1.textAlignment = NSTextAlignmentLeft;
        label1.text = @"Question:";
        [scrollView addSubview:label1];
        
        float height1;
        if (self.model.infos.question.length == 0) {
            height1 = 0;
        }else{
            height1 = [self heightForString:self.model.infos.question fontSize:13 * ratioHeight andWidth:kScreenWidth - 40];
        }
        
        UILabel *question1 = [[UILabel alloc] initWithFrame:CGRectMake(10, label1.bottom + 10, kScreenWidth - 40 , height1)];
        question1.textColor = UIColor(深色背景);
        question1.font = [UIFont systemFontOfSize:13 * ratioHeight];
        question1.textAlignment = NSTextAlignmentLeft;
        question1.numberOfLines = 0;
        question1.text = self.model.infos.question;
        [question1 sizeToFit];
        [scrollView addSubview:question1];
        scrollView.contentSize = CGSizeMake(0, question1.bottom + 20);


    }


}

//计算文本高度
- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.height;
}


- (void)_initbganimation
{
    
    _bganimationView = [[UIView alloc] initWithFrame:CGRectMake(0,0 , kScreenWidth, kScreenHeight)];
    _bganimationView.backgroundColor = [UIColor clearColor];
   _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.6];
    [_bganimationView addSubview:_maskView];
    
    animationView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 64 + 10 * ratioHeight, kScreenWidth - 20, 155 * ratioHeight)];
    animationView.showsHorizontalScrollIndicator = NO;
    animationView.showsVerticalScrollIndicator = NO;
    [self _initAnimation];
    animationView.backgroundColor = [UIColor whiteColor];
    [_bganimationView addSubview:animationView];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(animationView.width - 50, 10, 40, 40);

//    [closeButton setBackgroundImage:[UIImage imageNamed:@"close_01"] forState:UIControlStateNormal];
    [closeButton setImage:[UIImage imageNamed:@"close_01"] forState:UIControlStateNormal ];
    [closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    closeButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 10, 0);
    [animationView addSubview:closeButton];
    
    playbutton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    playbutton1.frame = CGRectMake((kScreenWidth - 65 * ratioHeight) / 2.0, kScreenHeight - 20 * ratioHeight - 65 * ratioHeight, 65 * ratioHeight, 65 * ratioHeight);
    [playbutton1 setImage:[UIImage imageNamed:@"play_03"] forState:UIControlStateNormal];
    playbutton1.userInteractionEnabled = YES;
    [playbutton1 addTarget:self action:@selector(record1:) forControlEvents:UIControlEventTouchUpInside];
    [_bganimationView addSubview:playbutton1];
    
    playbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    playbutton.frame = CGRectMake((kScreenWidth - 65 * ratioHeight) / 2.0, kScreenHeight - 20 * ratioHeight - 65 * ratioHeight, 65 * ratioHeight, 65 * ratioHeight);
    playbutton.userInteractionEnabled = YES;
    [playbutton setImage:[UIImage imageNamed:@"play_03"] forState:UIControlStateNormal];
    [playbutton addTarget:self action:@selector(record:) forControlEvents:UIControlEventTouchUpInside];
    [_bganimationView addSubview:playbutton];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:_bganimationView];
    

}

#pragma mark -------录制---------
- (void)record1:(UIButton *)sender
{


}
- (void)record:(UIButton *)sender
{
    playbutton.userInteractionEnabled = NO;
    [playView stop];
    NSString *useid = [UserDefaults objectForKey:Userid];
    NSDictionary *params = @{@"member_id":useid};
    
    [WXDataService requestAFWithURL:Url_getAmountUploadMp3Info params:params httpMethod:@"POST" finishBlock:^(id result) {
        if(result){
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                playbutton.userInteractionEnabled = YES;
                return;
                
            }
            NSDictionary *dic = result[@"result"];
            int amount = [dic[@"amount"] intValue];
            if (amount < 5) {
                //福币不够
                
                BgView4 *view = [[BgView4 alloc]initWithFrame:CGRectMake(20 * ratioWidth, (kScreenHeight - 180 * ratioHeight ) / 2.0, kScreenWidth  - 20 * ratioWidth * 2 , 180 * ratioHeight) Title:@"您的福币不够了" Delegate:self Mycost:@"" Cost:[NSString stringWithFormat:@"每次作业点评将花费5个福币你目前拥有%d个福币",amount]];
                [self addSubview:view];
                
                
            }else{
                
                if ([[UserDefaults objectForKey:subject] intValue] == 0) {
                    
                    recode = [[RecoderView alloc] initWithTimes:[_model.longs intValue]];
                    
                }else{
                    
                    recode = [[RecoderView alloc] initWithTimes:[_model.longs intValue]];
                    
                }
                recode.delegate = self;
                [recode show];
                
            }
            playbutton.userInteractionEnabled = YES;
            
        }
        
    } errorBlock:^(NSError *error) {
        playbutton.userInteractionEnabled = YES;
        
        NSLog(@"%@",error);
        
    }];
    

}

#pragma mark -----福币不够了------------
- (void)selecetbtn
{
    
    FuYuanViewController * fuFuYuan = [[FuYuanViewController alloc]init];
    [[self ViewController].navigationController pushViewController:fuFuYuan animated:YES];
    

    
}

#pragma mark ------------recoderViewDelegate-------
- (void)recordfabuMp3Data:(NSData *)data withTime:(NSString *)time
{
    if ([time intValue] < 3) {
        
        //录音时长太短，请重新录制；
        [MBProgressHUD showError:@"录音时长太短，请重新录制；" toView:[UIApplication sharedApplication].keyWindow];
        [recode hiddens];
        return;
    }
    
    [WXDataService postMP3:Url_uploadImgApp params:nil fileData:data finishBlock:^(id result) {
        
        if(result){
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                [recode hiddens];
                return;
                
            }
            NSDictionary *dic = result[@"result"];
            [self loadMP3:dic[@"path"] inttime:time];
            
        }
        
        
    } errorBlock:^(NSError *error) {
        
    }];
    
}

#pragma mark --------上传录音-----------
- (void)loadMP3:(NSString *)path inttime:(NSString *)time;
{

    NSString *useid = [UserDefaults objectForKey:Userid];
    NSDictionary *params = @{@"member_id":useid,@"time":time,@"mp3":path,@"id":self.model.ID,@"lid":self.model.lid,@"type":self.model.type};
    
    [WXDataService requestAFWithURL:Url_uploadMp3Info params:params httpMethod:@"POST" finishBlock:^(id result) {
        if(result){
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                [recode hiddens];
                return;
                
            }
            
            //上传成功
            
            [recode hiddens];
            
            LXbgview *bgview = [[LXbgview alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight) Title:@"录音已发布"  Text:@"老师将为你精心点评请注意消息提醒！" delegate:self];
            [[[UIApplication sharedApplication] keyWindow] addSubview:bgview];
            
            
        }
        
    } errorBlock:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    
    
}

#pragma mark ---------LXviewDelegate-------
- (void)clickOK
{
    // 完成
    [self close];

    [[DetailsubjectController share] clickOK];
      
    
}




#pragma mark ------关闭-------
- (void)close
{
    [playbutton removeFromSuperview];
    playView.player = nil;
    [UIView animateWithDuration:0.4 animations:^{
        
        animationView.height = 155 * ratioHeight;
        
    } completion:^(BOOL finished) {
        
        [_bganimationView removeFromSuperview];
        
    }];



}


@end

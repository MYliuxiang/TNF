//
//  TitleView.h
//  TNF
//
//  Created by 李江 on 16/1/6.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Info.h"
#import "PlayView.h"



#import "DetailsubjectController.h"


@interface TitleView : UIView
{
    UIView *_bganimationView;
    UIScrollView *animationView;
    UIView *_maskView;
    UIButton *playbutton;
    PlayView *playView;
    UIScrollView *scrollView;

    UILabel *titleLabel;
    UILabel *count;
    UILabel *question;
    UILabel *answer;
    RecoderView *recode;

}

@property (nonatomic,retain)Info *model;

@end

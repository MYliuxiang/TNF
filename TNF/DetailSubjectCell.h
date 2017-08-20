//
//  DetailSubjectCell.h
//  TNF
//
//  Created by 刘翔 on 15/12/22.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderModel.h"
#import "PlayView.h"
#import "RecoderView.h"
#import "BgView4.h"
#import "LXbgview.h"
#import "DetailsubjectController.h"

@interface DetailSubjectCell : UICollectionViewCell<BgView4delegate,RecordViewDelegate,LXbgviewDelegate>
{
    UIView *_bganimationView;
    UIScrollView *animationView;
    UIView *_maskView;
    UIButton *playbutton;
    UIButton *playbutton1;
    PlayView *playView;
    UIScrollView *scrollView;

    UILabel *titleLabel;
    UILabel *count;
    UILabel *question;
    UILabel *answer;
    RecoderView *recode;
}

@property (nonatomic,retain)HeaderModel *model;

- (void)buttonAction;

@end

//
//  WhizkidCell.h
//  TNF
//
//  Created by 刘翔 on 15/12/27.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXStarView.h"
#import "Mymodel.h"

@interface WhizkidCell : UITableViewCell
{
    UIImageView *headimageView;
    UILabel *nickLabel;
    UILabel *timeLabel;
    UILabel *dateLabel;
    LXStarView *star;
    UILabel *dipinLabel;
    
}

@property(nonatomic,retain)Mymodel *model;

@end

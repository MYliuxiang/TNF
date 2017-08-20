//
//  TPOCell.h
//  TNF
//
//  Created by 刘翔 on 15/12/28.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPOModel.h"
#import "TPOList.h"

@interface TPOCell : UICollectionViewCell
{
    UIView *bgView;
    UILabel *titleLabel;
    UIImageView *label1;
    UIImageView *label2;
    UIImageView *label3;
    UIImageView *label4;
    UIImageView *label5;
    UIImageView *label6;

    
}

@property(nonatomic,assign)int type;
@property(nonatomic,retain)TPOModel *model;

@end

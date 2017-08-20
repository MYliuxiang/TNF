//
//  ClassCell.h
//  TNF
//
//  Created by 刘翔 on 15/12/27.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassModel.h"

@interface ClassCell : UICollectionViewCell
{
    UIImageView *imageView;
    UILabel *label;
    UIImageView *videoImageView;

}
@property(nonatomic,assign)int type;
@property(nonatomic,retain)ClassModel *model;

@end

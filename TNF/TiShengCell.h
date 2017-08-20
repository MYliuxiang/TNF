//
//  TiShengCell.h
//  TNF
//
//  Created by 李江 on 15/12/22.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiShengshipingModel.h"
@interface TiShengCell : UICollectionViewCell
{
    UILabel *titleLabel;
    UIImageView *titleImageView;
    UIImageView *videoImageView;

}
@property (nonatomic,strong)TiShengshipingModel *model;
@end

//
//  TopCell.h
//  MyMovie
//
//  Created by zsm on 14-8-23.
//  Copyright (c) 2014年 zsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MachineList.h"

@interface TopCell : UICollectionViewCell
{
    UIView *view;
    UILabel *titleLabel;
    UILabel *conentLabel;
}
@property(nonatomic,retain)MachineList *list;
@property(nonatomic,assign)BOOL isFist;

@end

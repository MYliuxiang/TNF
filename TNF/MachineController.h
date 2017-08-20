//
//  MachineController.h
//  TNF
//
//  Created by 刘翔 on 15/12/21.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "BaseViewController.h"
#import "TopCell.h"
#import "HerderCollectionReusableView.h"

@interface MachineController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIAlertViewDelegate,TopViewDelegate>
{
    UICollectionViewFlowLayout *layout;
    UICollectionView *_collectionView;
    HerderCollectionReusableView *_headerView;//头饰图
    int _pageIndex;
    BOOL _isdownLoad;
    BOOL isfist;
    NSMutableArray *mutableArray;



}

@property(nonatomic,retain)NSMutableArray *dataList;

@end

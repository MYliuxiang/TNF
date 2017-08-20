//
//  ClassController.h
//  TNF
//
//  Created by 刘翔 on 15/12/21.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "BaseViewController.h"
#import "ClassHeaderView.h"
#import "ClassCell.h"
#import "ClassModel.h"

@interface ClassController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionViewFlowLayout *layout;
    UICollectionView *_collectionView;
    ClassHeaderView *_headerView;//头饰图
    int _pageIndex;
    BOOL _isdownLoad;


}

@property(nonatomic,retain)NSMutableArray *dataList;


@end

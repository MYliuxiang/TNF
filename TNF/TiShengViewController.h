//
//  TiShengViewController.h
//  TNF
//
//  Created by 李江 on 15/12/22.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "BaseViewController.h"

@interface TiShengViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UICollectionViewFlowLayout *layout;
    UICollectionView *_collectionView;
    UITableView *_tableView;

}
@end

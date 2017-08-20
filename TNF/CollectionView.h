//
//  CollectionView.h
//  TNF
//
//  Created by 李善 on 15/12/22.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionView : UIView<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>

- (instancetype)initWithFrame:(CGRect)frame recommendLisrAry:(NSArray *)recommendLisrAry;
@property(nonatomic,strong)NSArray *commListAry;
@end

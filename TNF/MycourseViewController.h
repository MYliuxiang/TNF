//
//  MycourseViewController.h
//  TNF
//
//  Created by 李立 on 15/12/17.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "BaseViewController.h"

@interface MycourseViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{

    UILabel *tishiLabel;

}

@property(nonatomic,strong)UIView *deleView;
@property(nonatomic,strong)UICollectionView *mycollectionView;
@property(nonatomic,strong)UIButton *zhangdanButton ;
@property(nonatomic,strong)UIView *shangView;
@property(nonatomic,retain)UIImageView *imageView;



@end

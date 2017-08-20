//
//  ClassController.m
//  TNF
//
//  Created by 刘翔 on 15/12/21.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "ClassController.h"
#import "PersonViewController.h"
@implementation ClassController
{
    NSMutableArray *mutableArray;
  
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[MyColor colorWithHexString:@"#0172fe"]];
    
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    //    [self.navigationController.navigationBar setBarTintColor:[MyColor colorWithHexString:@"#0172fe"]];
    
    self.text = @"分类练习";
    self.view.backgroundColor = [MyColor colorWithHexString:@"#f0f0f0"];
    [self _initViews];
    
    
}

- (void)_initViews
{
    //控制UICollectionView 的样式和布局等
    layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kScreenWidth/ 2.0,120 * ratioHeight);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize = CGSizeMake(kScreenWidth , 55 * ratioHeight);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 ) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundView = nil;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.backgroundView = nil;
    
    
    [_collectionView registerClass:[ClassCell class]  forCellWithReuseIdentifier:@"TopCellId"];
    [_collectionView registerClass:[ClassHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerId"];
    [self.view addSubview:_collectionView];
    _collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downLoad)];
    [_collectionView.header beginRefreshing];
    
}


////下啦刷新
- (void)downLoad
{
    
    _isdownLoad = YES;
    _pageIndex = 1;
    [self _loadData];
    
}

//上啦加载
- (void)upLoad
{
    _isdownLoad = NO;
    [self _loadData];
    
}


- (void)_loadData
{
    
    NSString *useid = [UserDefaults objectForKey:Userid];
    NSDictionary *params = @{@"member_id":useid,@"page":[NSString stringWithFormat:@"%d",_pageIndex]};
    
    [WXDataService requestAFWithURL:Url_getPracticeList2 params:params httpMethod:@"POST" finishBlock:^(id result) {
        
        _pageIndex ++;
       
        if(result){
            
            NSDictionary *dic = result[@"result"];

              if ([[result objectForKey:@"status"] integerValue] == 0) {
                 
                  if (_isdownLoad) {
                      mutableArray = [NSMutableArray new];
                  }
                  
                  NSString *str = [NSString stringWithFormat:@"共%@类%@题",dic[@"count"],dic[@"count_total"]];
                  NSString *str1 = [NSString stringWithFormat:@"已练习%@题",dic[@"count_finish"]];
                  _headerView.text1 = str;
                  _headerView.text2 = str1;
                  
                  
                  
                  NSArray *array = dic[@"list"];
                  
                  for (NSDictionary *subDic in array) {
                      ClassModel *model = [[ClassModel alloc] initWithDataDic:subDic];
                      model.identifire = subDic[@"id"];
                      [mutableArray addObject:model];
                  }
                  self.dataList = mutableArray;
                
                  if (_isdownLoad) {
                      [_collectionView.header endRefreshing];
                      _collectionView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upLoad)];
                  } else {
                      [_collectionView.footer endRefreshing];
                  }
                  
                  [_collectionView reloadData];
            
              }
            
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
               
                NSArray *array = dic[@"list"];
                if (array.count == 0) {
                      _pageIndex --;
                }
                for (NSDictionary *subDic in array) {
                    ClassModel *model = [[ClassModel alloc] initWithDataDic:subDic];
                    model.identifire = subDic[@"id"];
                    [mutableArray addObject:model];
                }
                self.dataList = mutableArray;

                if (_isdownLoad) {
                    [_collectionView.header endRefreshing];
                } else {
                    [_collectionView.footer endRefreshing];
                }
                [_collectionView reloadData];

            }
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
        if (_isdownLoad) {
            [_collectionView.header endRefreshing];
        } else {
            [_collectionView.footer endRefreshing];
//            _collectionView.footer = nil;
        }
        
        
    }];
    
    
    
}


#pragma mark - UICollectionView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataList.count;

}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //如果有闲置的就拿到使用,如果没有,系统自动的去创建
    ClassCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TopCellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.type = indexPath.row % 2;
    cell.model = self.dataList[indexPath.row];
    [cell setNeedsLayout];
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath

{
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        
        _headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerId" forIndexPath:indexPath];
        reusableview = _headerView;
        
    }
    
    return reusableview;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ClassModel *list = self.dataList[indexPath.row];
    
    PersonViewController *personVC = [[PersonViewController alloc] initWithIsHaveSgemengt:YES IshavePlayView:[list.Is_video boolValue] Url:Url_getPracticeList2Subject ID:list.identifire texttitle:list.title];
    if([list.Is_video integerValue] == 1){
        personVC.imageUrl = list.thumb;
        personVC.VidioUrl = list.video;
    }
    
    [self.navigationController pushViewController:personVC animated:YES];
    

    
}




@end

















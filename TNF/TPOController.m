//
//  TPOController.m
//  TNF
//
//  Created by 刘翔 on 15/12/21.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "TPOController.h"
#import "TPOCell.h"
#import "TPOModel.h"
#import "TPOList.h"
#import "DetailsubjectController.h"

@implementation TPOController




- (void)viewDidLoad{
    
    [super viewDidLoad];
    //    [self.navigationController.navigationBar setBarTintColor:[MyColor colorWithHexString:@"#0172fe"]];
    
    self.text = @"TPO真题";
    self.view.backgroundColor = [MyColor colorWithHexString:@"#f0f0f0"];
    [self _initViews];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[MyColor colorWithHexString:@"#0172fe"]];
    

    [_collectionView.header beginRefreshing];
}

- (void)_initViews
{
    //控制UICollectionView 的样式和布局等
    layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kScreenWidth/ 2.0,60 * ratioHeight);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize = CGSizeMake(kScreenWidth , 55 * ratioHeight);
    layout.minimumLineSpacing = 5;
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
    
    
    [_collectionView registerClass:[TPOCell class]  forCellWithReuseIdentifier:@"TPOCellId"];
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
    
    [WXDataService requestAFWithURL:Url_getPracticeList3 params:params httpMethod:@"POST" finishBlock:^(id result) {
        if(result){
            
            NSDictionary *dic = result[@"result"];
            
              _pageIndex ++;
            
            if ([[result objectForKey:@"status"] integerValue] == 0) {
               
                NSString *str = [NSString stringWithFormat:@"共%@套 %@题",dic[@"count"],dic[@"count_total"]];
                NSString *str1 = [NSString stringWithFormat:@"已练习%@题",dic[@"count_finish"]];
                _headerView.text1 = str;
                _headerView.text2 = str1;
                
                
                if (_isdownLoad) {
                    mutableArray = [NSMutableArray new];
                }
                
                NSArray *array = dic[@"list"];
                
                for (NSDictionary *subDic in array) {
                    TPOModel *model = [[TPOModel alloc] initWithDataDic:subDic];
                    model.identifire = subDic[@"id"];
                    NSArray *array1 = subDic[@"list"];
                    NSMutableArray *marray = [NSMutableArray array];
                    for (NSDictionary *mdic in array1) {
                        TPOList *list = [[TPOList alloc] initWithDataDic:mdic];
                        list.identifire = mdic[@"id"];
                        [marray addObject:list];
                        
                    }
                    model.lists = marray;
                    [mutableArray addObject:model];
                    
                }
                
                self.dataList = mutableArray;
                
               
                if (_isdownLoad) {
                    
                    [_collectionView.header endRefreshing];
                    _collectionView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upLoad)];
                } else {
                    [_collectionView.footer endRefreshing];
                    
                }

            
            
            }
            
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                NSArray *array = dic[@"list"];
                if (array.count == 0) {
                    _pageIndex --;
                }
                
                for (NSDictionary *subDic in array) {
                    TPOModel *model = [[TPOModel alloc] initWithDataDic:subDic];
                    model.identifire = subDic[@"id"];
                    NSArray *array1 = subDic[@"list"];
                    NSMutableArray *marray = [NSMutableArray array];
                    for (NSDictionary *mdic in array1) {
                        TPOList *list = [[TPOList alloc] initWithDataDic:mdic];
                        list.identifire = mdic[@"id"];
                        [marray addObject:list];
                        
                    }
                    model.lists = marray;
                    [mutableArray addObject:model];
                    
                }

                self.dataList = mutableArray;
                
                if (_isdownLoad) {
                    [_collectionView.header endRefreshing];
                } else {
                    [_collectionView.footer endRefreshing];
//                    _collectionView.footer = nil;
                }
//                [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
    
            }
            
          
            
            
            [_collectionView reloadData];
            
            
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
        if (_isdownLoad) {
            [_collectionView.header endRefreshing];
        } else {
            [_collectionView.footer endRefreshing];
            _collectionView.footer = nil;
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
    TPOCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TPOCellId" forIndexPath:indexPath];
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
    DetailsubjectController *detailVC = [[DetailsubjectController alloc] init];
    TPOModel *model = self.dataList[indexPath.row];
    if(model.lists.count != 0)
    {
        TPOList *list = model.lists[0];
        detailVC.types = list.type;
        detailVC.ID = list.identifire;
        detailVC.lid = list.rid;
        detailVC.index = 0;
        [self.navigationController pushViewController:detailVC animated:YES];

    }
    
    
}



@end

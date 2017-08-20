//
//  MachineController.m
//  TNF
//
//  Created by 刘翔 on 15/12/21.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "MachineController.h"
#import "DetailsubjectController.h"
#import "MachineList.h"
#import "PersonViewController.h"

@implementation MachineController

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[MyColor colorWithHexString:@"#0172fe"]];
    
}


- (void)viewDidLoad{
    
    [super viewDidLoad];
    //    [self.navigationController.navigationBar setBarTintColor:[MyColor colorWithHexString:@"#0172fe"]];
    
    self.text = @"机经预测";
    self.view.backgroundColor = [MyColor colorWithHexString:@"#f0f0f0"];
    _dataList = [NSMutableArray array];
    mutableArray = [NSMutableArray array];
    [self _initViews];
    
}

- (void)_loadData
{
    
        NSString *useid = [UserDefaults objectForKey:Userid];
        NSDictionary *params = @{@"member_id":useid,@"page":[NSString stringWithFormat:@"%d",_pageIndex]};

        [WXDataService requestAFWithURL:Url_getPracticeList1 params:params httpMethod:@"POST" finishBlock:^(id result) {
            if(result){
                NSLog(@"ggggg%@",result);
                NSDictionary *dic = result[@"result"];

                 _pageIndex ++;
                
                if ([[result objectForKey:@"status"] integerValue] == 1) {
                    
                    
                    NSArray *array = dic[@"list"];
                    if(array.count == 0)
                    {
                        _pageIndex --;
                        
                    }
                    for (NSDictionary *subDic in array) {
                        MachineList *list = [[MachineList alloc] initWithDataDic:subDic];
                        list.identifire = subDic[@"id"];
                        [mutableArray addObject:list];
                    }
                    self.dataList = mutableArray;
                    
                    if (_isdownLoad) {
                        [_collectionView.header endRefreshing];
                    } else {
                        [_collectionView.footer endRefreshing];

                    }

                }
                if ([[result objectForKey:@"status"] integerValue] == 0) {
                   
                    
                    _headerView.url = dic[@"backgroupimg"];
                    
                    NSString *str = [NSString stringWithFormat:@"共%@类%@题",dic[@"count"],dic[@"count_total"]];
                    NSString *str1 = [NSString stringWithFormat:@"已练习%@题",dic[@"count_finish"]];
                    _headerView.text1 = str;
                    _headerView.text2 = str1;
                    
                    if (_isdownLoad) {
                        mutableArray = [NSMutableArray new];
                    }
                    
                    NSArray *array = dic[@"list"];
                    //                for (int i = 0; i < array.count; i++) {
                    //
                    //                    MachineList *list = [[MachineList alloc] initWithDataDic:array[i]];
                    //                    list.identifire = array[i][@"id"];
                    //                    [self.dataList addObject:list];
                    //
                    //                }
                    
                    for (NSDictionary *subDic in array) {
                        MachineList *list = [[MachineList alloc] initWithDataDic:subDic];
                        list.identifire = subDic[@"id"];
                        [mutableArray addObject:list];
                    }
                    self.dataList = mutableArray;
                    
                    
                    
                    
                    if (_isdownLoad) {
                        
                        [_collectionView.header endRefreshing];
                        _collectionView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upLoad)];
                    } else {
                        
                        [_collectionView.footer endRefreshing];
                    }
                    
                }
               
                    [_collectionView reloadData];
            }
        } errorBlock:^(NSError *error) {
            NSLog(@"%@",error);
            
            if (_isdownLoad) {
                [_collectionView.header endRefreshing];
            } else {
                [_collectionView.footer endRefreshing];
//                _collectionView.footer = nil;
            }

            
        }];

    
    
}

- (void)_initViews
{
    
    //控制UICollectionView 的样式和布局等
    layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kScreenWidth / 2.0,70 * ratioHeight);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize = CGSizeMake(kScreenWidth , (160 + 50) * ratioHeight);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 ) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundView = nil;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
//    _collectionView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    _collectionView.backgroundView = nil;
    

    [_collectionView registerClass:[TopCell class]  forCellWithReuseIdentifier:@"TopCellId"];
    [_collectionView registerClass:[HerderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerId"];
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


#pragma mark - UICollectionView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //    return self.titles.count;
    return self.dataList.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //如果有闲置的就拿到使用,如果没有,系统自动的去创建
    TopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TopCellId" forIndexPath:indexPath];
    MachineList *list = self.dataList[indexPath.row];
    cell.list = list;
    if (indexPath.row % 2 == 0) {
        cell.isFist = YES;
    }else{
    
        cell.isFist = NO;
    }
    [cell setNeedsLayout];
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath

{
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        
        _headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerId" forIndexPath:indexPath];
        _headerView.delegate = self;
        
        reusableview = _headerView;
        
    }
    
    return reusableview;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MachineList *list = self.dataList[indexPath.row];

    PersonViewController *personVC = [[PersonViewController alloc] initWithIsHaveSgemengt:YES IshavePlayView:NO Url:Url_getPracticeList1Subject ID:list.identifire texttitle:list.title];
    [self.navigationController pushViewController:personVC animated:YES];
    
    
    
}

- (void)clickindex:(int)index
{
    NSLog(@"%d",index);
    
}

@end


















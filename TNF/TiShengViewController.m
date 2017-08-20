//
//  TiShengViewController.m
//  TNF
//
//  Created by 李江 on 15/12/22.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "TiShengViewController.h"
#import "MycourseViewController.h"
#import "TiShengCell.h"
#import "LectureCell.h"
#import "TiShengshipingModel.h"
#import "JiangzuoModel.h"
#import "BypredictingViewController.h"
#import "PromotioncourseViewController.h"
#import "Zhibocell.h"
#import "WebViewController.h"
@interface TiShengViewController ()<LXDelegate,BypredictingViewControllerDegatele>
{
    int _pageIndex;
    BOOL _isdownLoad;
    int _pagejiangzuoIndex;
    BOOL _isdownjiangzuoLoad;
    NSMutableArray *_mutableArray;
    NSMutableArray *_mutableArray1;
    UILabel *_redlabel;
}
@property (nonatomic,strong)NSArray *shipingDataArray;
@property (nonatomic,strong)NSArray *jiangzuoDataArray;

@end

@implementation TiShengViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    //改变导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[MyColor colorWithHexString:@"#0172fe"]];
     self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    [_collectionView.header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.text = @"提升课程";
    
    _pageIndex = 1;
    _pagejiangzuoIndex = 1;
    
    [self _initshipingViews];
    
    [self _initjiangzuoViews];
    
    [_collectionView.header beginRefreshing];

    [self _addrightItem];
    
    self.view.backgroundColor = UIColor2(灰色背景);
    
    LXSgement *lxsegement  = [[LXSgement alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 45 * ratioHeight) titles:@[@"录播课",@"直播课"] normalColor:[UIColor blackColor] selectedColor:UIColor1(蓝) bottomColor:[MyColor colorWithHexString:@"#0172fe"] divisionColor:UIColor2(灰色背景)];
    lxsegement.delegate = self;
    lxsegement.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lxsegement];
   
}

// --------------------------------- 视频请求数据 ------------------
////下啦刷新
- (void)downLoad
{
    
    _isdownLoad = YES;
    _pageIndex = 1;
    [self _initShiPingData];
    
}

//上啦加载
- (void)upLoad
{
    _isdownLoad = NO;
    [self _initShiPingData];
    
}

- (void)_initShiPingData
{

    [WXDataService requestAFWithURL:Url_getVideoList params:@{@"page":[NSString stringWithFormat:@"%d",_pageIndex],@"member_id":[UserDefaults objectForKey:Userid]} httpMethod:@"POST" finishBlock:^(id result) {
        NSLog(@"-----result==%@",result);
        
        _pageIndex ++;
        //请求成功
        if ([[result objectForKey:@"status"] integerValue] == 0) {
            
            if ([result[@"result"][@"is_new"] intValue] == 1) {
                _redlabel.backgroundColor = [UIColor redColor];
            }else {
                 _redlabel.backgroundColor = [UIColor clearColor];
            
            }
            

//            [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
            NSArray *array = result[@"result"][@"list"];
            
           
            if (_isdownLoad) {
                _mutableArray = [NSMutableArray new];
            }
            
            for (NSDictionary *subDic in array) {
                TiShengshipingModel * model = [[TiShengshipingModel alloc]initWithDataDic:subDic];
                [_mutableArray addObject:model];
            }
            self.shipingDataArray = _mutableArray;
            
//            if (array.count >= 10) {
            
//            }
            if (_isdownLoad) {
                [_collectionView.header endRefreshing];
                _collectionView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upLoad)];
            } else {
                [_collectionView.footer endRefreshing];
            }
        }
        //请求失败
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            
            NSArray *array = result[@"result"][@"list"];
            if (array.count == 0) {
                _pageIndex --;
            }
            
            for (NSDictionary *subDic in array) {
                TiShengshipingModel * model = [[TiShengshipingModel alloc]initWithDataDic:subDic];
                [_mutableArray addObject:model];
            }
            self.shipingDataArray = _mutableArray;

            
            if (_isdownLoad) {
                [_collectionView.header endRefreshing];
            } else {
                [_collectionView.footer endRefreshing];
//                _collectionView.footer = nil;
            }
//            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
        }
        
        [_collectionView reloadData];
        
    } errorBlock:^(NSError *error) {
       
        if (_isdownLoad) {
            [_collectionView.header endRefreshing];
        } else {
            [_collectionView.footer endRefreshing];
        }
    }];



}

// --------------------------------- 讲座请求数据 ------------------
////下啦刷新
- (void)downjiangzuoLoad
{
    
    _isdownjiangzuoLoad = YES;
    _pagejiangzuoIndex = 1;
    [self _initjiangzuoData];
    
}

//上啦加载
- (void)upjiangzuoLoad
{
    _isdownjiangzuoLoad = NO;
    [self _initjiangzuoData];
    
}

- (void)_initjiangzuoData
{
    
    [WXDataService requestAFWithURL:Url_getZhiboList params:@{@"page":[NSString stringWithFormat:@"%d",_pagejiangzuoIndex],@"member_id":[UserDefaults objectForKey:Userid]} httpMethod:@"POST" finishBlock:^(id result) {
        NSLog(@"-----result==%@",result);
        
         _pagejiangzuoIndex ++;
        //请求成功
        if ([[result objectForKey:@"status"] integerValue] == 0) {
            
//            if ([result[@"result"][@"is_new"] intValue] == 1) {
//                _redlabel.backgroundColor = [UIColor redColor];
//            }else {
//                _redlabel.backgroundColor = [UIColor clearColor];
//                
//            }
            
//            [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
            NSArray *array = result[@"result"][@"list"];
          
            if (_isdownjiangzuoLoad) {
                _mutableArray1 = [NSMutableArray new];
            }
            
            for (NSDictionary *subDic in array) {
                JiangzuoModel * model = [[JiangzuoModel alloc]initWithDataDic:subDic];
                [_mutableArray1 addObject:model];
            }
            self.jiangzuoDataArray = _mutableArray1;
            
//            if (array.count >= 10) {
            
//            }
            if (_isdownjiangzuoLoad) {
                [_tableView.header endRefreshing];
                _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upjiangzuoLoad)];
            } else {
                [_tableView.footer endRefreshing];
            }
            
        }
        //请求失败
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            
            NSArray *array = result[@"result"][@"list"];
            //新增
            if (array.count == 0) {
                 _pagejiangzuoIndex --;
            }
         
            for (NSDictionary *subDic in array) {
                JiangzuoModel * model = [[JiangzuoModel alloc]initWithDataDic:subDic];
                [_mutableArray1 addObject:model];
            }
            self.jiangzuoDataArray = _mutableArray1;

            
            if (_isdownjiangzuoLoad) {
                [_tableView.header endRefreshing];
                
            } else {
                [_tableView.footer endRefreshing];
//                 _tableView.footer = nil;
            }
//            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
        }
        
        [_tableView reloadData];

    } errorBlock:^(NSError *error) {
        
        if (_isdownjiangzuoLoad) {
            [_tableView.header endRefreshing];
        } else {
            [_tableView.footer endRefreshing];
        }
    }];
    
    
    
}

//------------------------------------ 讲座 -----------------------------------------------------
- (void)_initjiangzuoViews
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50 * ratioHeight, kScreenWidth, kScreenHeight - 64 - 50 * ratioHeight) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 100 *ratioHeight + 30 *ratioHeight;
    _tableView.hidden = YES;
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downjiangzuoLoad)];
    [self.view addSubview:_tableView];
}
#pragma mark  ------- uitableViewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _jiangzuoDataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"cellid";
    Zhibocell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[Zhibocell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.model = _jiangzuoDataArray[indexPath.row];
    [cell layoutSubviews];
    return cell;

}

//单元格点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    JiangzuoModel *model = _jiangzuoDataArray[indexPath.row];
    WebViewController *zhiboVC = [[WebViewController alloc]init];
    zhiboVC.url = model.url;
    zhiboVC.text = @"直播课";
    zhiboVC.ID = model.LectureID;
    zhiboVC.isZhibo = YES;
    [self.navigationController pushViewController:zhiboVC animated:YES];

//    BypredictingViewController *bypredVC = [[BypredictingViewController alloc]init];
//    bypredVC.delegate = self;
//    bypredVC.ID = model.LectureID;
//    bypredVC.text = model.title;
//    [self.navigationController pushViewController:bypredVC animated:YES];

}

//--------------------------------  视频  ----------------------------------------------
- (void)_initshipingViews
{
    
    //控制UICollectionView 的样式和布局等
    layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake((kScreenWidth - 25) / 2.0 ,240 / 2.0 * ratioHeight);
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    layout.minimumLineSpacing = 5;
    
    layout.minimumInteritemSpacing = 0;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 45 * ratioHeight, kScreenWidth - 20, kScreenHeight - 64 - 45 * ratioHeight ) collectionViewLayout:layout];
    _collectionView.hidden = NO;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.backgroundView = nil;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.backgroundView = nil;
    
    [_collectionView registerClass:[TiShengCell class]  forCellWithReuseIdentifier:@"TiShengCellId"];
    
    _collectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downLoad)];
    
    [self.view addSubview:_collectionView];
    
}
    
#pragma mark - UICollectionView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shipingDataArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //如果有闲置的就拿到使用,如果没有,系统自动的去创建
    TiShengCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TiShengCellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.model = self.shipingDataArray[indexPath.row];
    [cell setNeedsLayout];
    return cell;
    
}
//选中事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TiShengshipingModel * model = self.shipingDataArray[indexPath.row];
    PromotioncourseViewController *promotionVC = [[PromotioncourseViewController alloc]init];
    promotionVC.Videoid = model.videoID;
    promotionVC.text = model.title;
    [self.navigationController pushViewController:promotionVC animated:YES];

}

- (void)suanxinDown
{

    _collectionView.hidden = YES;
    _tableView.hidden = NO;
    [_tableView.header beginRefreshing];
}

// --------------------------------- 按钮事件 -------------------------------------
//添加右边按钮
- (void)_addrightItem
{

    //右边的导航兰按钮
    //我的咨询
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 20)];
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = CGRectMake(0, 0, 80, 20);
    [left setTitleColor:[MyColor colorWithHexString:@"#f0f0f0"] forState:UIControlStateNormal];
    [left setTitle:@"我的课程" forState:UIControlStateNormal];
    [left addTarget:self action:@selector(lianxi) forControlEvents:UIControlEventTouchUpInside];
    left.titleLabel.font  = [UIFont boldSystemFontOfSize:18];
    [left.titleLabel sizeToFit];
    [rightView addSubview:left];
    
    _redlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 8, 8)];
    _redlabel.center = CGPointMake(left.right, left.top);
    _redlabel.layer.cornerRadius = 4;
    _redlabel.layer.masksToBounds = YES;
    [rightView addSubview:_redlabel];
    
    UIBarButtonItem *Item = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    
    UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSeperator.width = -12;
    self.navigationItem.rightBarButtonItems = @[negativeSeperator,Item];
    
}

//我的课程
- (void)lianxi
{
    MycourseViewController *mycourseVC = [[MycourseViewController alloc]init];
    [self.navigationController pushViewController:mycourseVC animated:YES];


}

- (void)clickindex:(int)index
{
    //视频课
    if(index == 0){
        
        _collectionView.hidden = NO;
        _tableView.hidden = YES;
        [_collectionView.header beginRefreshing];
    
    }

    //讲座
    if(index == 1){
        
          _collectionView.hidden = YES;
          _tableView.hidden = NO;
          [_tableView.header beginRefreshing];
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

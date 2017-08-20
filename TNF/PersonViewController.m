//
//  PersonViewController.m
//  TNF
//
//  Created by 李江 on 15/12/27.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "PersonViewController.h"
#import "PromotionCell.h"
#import "PersonModel.h"
#import "DetailsubjectController.h"
#import "LDZMoviePlayerController.h"
@interface PersonViewController ()<LXDelegate,UITableViewDataSource,UITableViewDelegate,NetWorkManagerDelegate>
{
    LXSgement *lxsegement;
    UIImageView *bjImageView;
    UIView *view1;
    UIImageView *suoImageView;
    UITableView *_tableView;
    int _pageIndex;
    BOOL _isdownLoad;
    NSArray *_dataArray;
    NSString *_is_practice;
    NSMutableArray *_mutableArray;
    
    
    NSString *_count_finish;
    NSString *_count_total;
    NSString *_count_unfinish;
    
    UIView *_VideoView;
    UIView *_BgVideoView;
    UIView *_view;
    UIImageView *_imageView;
    UIImageView *_imageView1;
    UIImageView *_donghuaImageView;
    UIView *_zhegaiView;
    UILabel *label8;
    UIView *view2;

    
}
@property (nonatomic,strong)NetWorkManager *networkManager;
@end

@implementation PersonViewController

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[MyColor colorWithHexString:@"#0172fe"]];
    
    [_tableView.header beginRefreshing];
    
}

- (id)initWithIsHaveSgemengt:(BOOL)isHaveSgemengt
              IshavePlayView:(BOOL)ishavePlayView
                         Url:(NSString *)url
                          ID:(NSString *)ID
                   texttitle:(NSString *)texttitle

{
    self = [super init];
    if (self) {
        
        self.text = texttitle;
        _ishavePlayView = ishavePlayView;
        _isHaveSgemengt = isHaveSgemengt;
        _url = url;
        _ID = ID;
        _ishaveweilian = YES;
        _is_practice = @"0";
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(VideoDonghua) name:Noti_VideoDonghua object:nil];
    
    
    [self _initView];
    
    if (_ishavePlayView) {
        [self _initDonghuaView];
    }
    
//    [self _initData];
    
    
   
    
    
}


- (void)_initDonghuaView
{
    
    _BgVideoView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _BgVideoView.backgroundColor = [UIColor blackColor];
    _BgVideoView.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:_BgVideoView];
    
    _zhegaiView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 170 * ratioHeight)];
    _zhegaiView.backgroundColor = UIColor2(灰色背景);
    _zhegaiView.hidden = YES;
    [self.view addSubview:_zhegaiView];
    
    _VideoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 170 * ratioHeight)];
    _VideoView.backgroundColor = UIColor6(正文小字);
    _VideoView.hidden = YES;
    [self.view addSubview:_VideoView];
    
    
    
    _donghuaImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 170 * ratioHeight)];
    _donghuaImageView.backgroundColor = UIColor3(金色);
    [_donghuaImageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:nil];
    _donghuaImageView.userInteractionEnabled = YES;
    [_VideoView addSubview:_donghuaImageView];
    
    _view = [[UIView alloc]initWithFrame:CGRectMake((bjImageView.width - 50 * ratioHeight) / 2.0, (bjImageView.height  - 50 * ratioHeight) / 2.0 , 50 * ratioHeight, 50 * ratioHeight)];
    _view.backgroundColor = [UIColor clearColor];
    _view.userInteractionEnabled = YES;
    _view.layer.cornerRadius = 25 *ratioHeight;
    _view.layer.masksToBounds = YES;
    [_VideoView addSubview:_view];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((_view.width - 50 * ratioHeight) / 2.0, (_view.height - 50 * ratioHeight) / 2.0 , 50 * ratioHeight, 50 * ratioHeight)];
    _imageView.image = imageNamed(@"play_icon");
    _imageView.userInteractionEnabled = YES;
    [_view addSubview:_imageView];
    
    
    
}


// --------------------------------- 视频请求数据 ------------------
////下啦刷新
- (void)downLoad
{
    
    _isdownLoad = YES;
    _pageIndex = 1;
    [self _initData];
    
}

//上啦加载
- (void)upLoad
{
    _isdownLoad = NO;
    [self _initData];
    
}




- (void)_initData
{
    NSDictionary *dic;
    if (_ishaveweilian == NO) {
        dic = @{@"page":[NSString stringWithFormat:@"%d",_pageIndex],@"member_id":[UserDefaults objectForKey:Userid],@"id":_ID};
    } else {
        dic = @{@"page":[NSString stringWithFormat:@"%d",_pageIndex],@"member_id":[UserDefaults objectForKey:Userid],@"id":_ID,@"is_practice":_is_practice};
    }
    
    [WXDataService requestAFWithURL:self.url params:dic httpMethod:@"POST" finishBlock:^(id result) {
    NSLog(@"-----result==%@",result);
        _pageIndex ++;
    //请求成功
    if ([[result objectForKey:@"status"] integerValue] == 0) {
        
       
        
        //            [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
        
        _count_finish = result[@"result"][@"count_finish"];
        _count_total =  result[@"result"][@"count_total"];
        _count_unfinish =  result[@"result"][@"count_unfinish"];
        NSString *str1 = [NSString stringWithFormat:@"未练%@",_count_unfinish];
        NSString *str2 = [NSString stringWithFormat:@"已练%@",_count_finish];
        NSArray *array1 = @[str1,str2];
        if (_isHaveSgemengt == YES) {
    
            lxsegement.titlesArray = array1;
        }
        
        NSArray *array = result[@"result"][@"list"];
        
       
        if (_isdownLoad) {
            _mutableArray = [NSMutableArray new];
        }
      

        
        for (NSDictionary *subDic in array) {
            PersonModel * model = [[PersonModel alloc]initWithDataDic:subDic];
            [_mutableArray addObject:model];
        }
        _dataArray = _mutableArray;
        

        if (_isdownLoad) {
            if (_dataArray.count == 0) {
                footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 180)];
                _tableView.tableFooterView = footerView;

              UIImageView *_image1 = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 320) / 2.0, 50 * ratioHeight, 320, 160)];
                _image1.image = [UIImage imageNamed:@"无图片640-320"];
                [footerView addSubview:_image1];
                
                
               UILabel *tishiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _image1.bottom + 20 * ratioHeight, kScreenWidth, 20 * ratioHeight)];
                if ([_is_practice isEqualToString:@"0"]) {
                    tishiLabel.text = @"题目已经练习完了哦";

                }else{
                    tishiLabel.text = @"还没有练习哦";

                }
                tishiLabel.textColor = [UIColor colorWithRed:141 / 255.0 green:142 / 255.0 blue:143 / 255.0 alpha:1];
                tishiLabel.font = [UIFont fontWithName:@"Arial" size:18*ratioHeight];;
                tishiLabel.textAlignment = NSTextAlignmentCenter;
                [footerView addSubview:tishiLabel];
                
            }else{
                _tableView.tableFooterView = nil;
            
            }
           
            [_tableView.header endRefreshing];
             _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upLoad)];
        } else {
            [_tableView.footer endRefreshing];
        }
        
    }
    //请求失败
    if ([[result objectForKey:@"status"] integerValue] == 1) {
        
        //加图片
        _tableView.tableFooterView = nil;
        
        
        
        
        
        NSArray *array = result[@"result"][@"list"];
        if(array.count == 0)
        {
          _pageIndex --;
        
        }
        for (NSDictionary *subDic in array) {
            PersonModel * model = [[PersonModel alloc]initWithDataDic:subDic];
            [_mutableArray addObject:model];
        }
        _dataArray = _mutableArray;
        
        if (_isdownLoad) {
            [_tableView.header endRefreshing];
            
        } else {
            [_tableView.footer endRefreshing];
//            _tableView.footer = nil;
        }
//        [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
        
    }
    
    [_tableView reloadData];
    
   } errorBlock:^(NSError *error) {
    
        if (_isdownLoad) {
        [_tableView.header endRefreshing];
       } else {
        [_tableView.footer endRefreshing];
       }
   }];
}


- (void)_initView
{
    UIView *bgheadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    if (_ishavePlayView == YES) {
        
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, (170 + 50) * ratioHeight)];
        headerView.backgroundColor = [UIColor clearColor];
        
        [bgheadView addSubview:headerView];
        
        bjImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 170 * ratioHeight)];
//        bjImageView.backgroundColor = UIColor3(金色);
        [bjImageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:nil];
        bjImageView.userInteractionEnabled = YES;
        [bgheadView addSubview:bjImageView];
        
        
        //遮罩视图lock_01
        view1 = [[UIView alloc]initWithFrame:CGRectMake((bjImageView.width - 50 * ratioHeight) / 2.0, (bjImageView.height - 50 * ratioHeight) / 2.0 , 50 * ratioHeight, 50 * ratioHeight)];
        view1.backgroundColor = [UIColor clearColor];
        view1.userInteractionEnabled = YES;
        view1.layer.cornerRadius = 25 *ratioHeight;
        view1.layer.masksToBounds = YES;
        [bgheadView addSubview:view1];
        
        _imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake((view1.width - 50 * ratioHeight) / 2.0, (view1.height - 50 * ratioHeight) / 2.0 , 50 * ratioHeight, 50 * ratioHeight)];
        _imageView1.image = imageNamed(@"play_icon");
        _imageView1.userInteractionEnabled = YES;
        [view1 addSubview:_imageView1];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHeader)];
        [bjImageView addGestureRecognizer:tap];
        [view1 addGestureRecognizer:tap];
        
        
        //建议WIFF环境下观看视图
        view2 = [[UIView alloc]initWithFrame:CGRectMake(0, bjImageView.height - 30, kScreenWidth, 30 )];
        view2.backgroundColor = [UIColor blackColor];
        view2.alpha = 0.7;
        [headerView addSubview:view2];

        
        //建议WIFF环境下观看
        label8 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, kScreenWidth, 20)];
        label8.text = @"建议Wifi环境下观看";
        label8.font = [UIFont systemFontOfSize:13*ratioHeight];
        label8.textColor = [UIColor whiteColor];
        [view2 addSubview:label8];
        
        
        _networkManager = [NetWorkManager sharedManager];
        _networkManager.delegate = self;
        [_networkManager startNetWorkeWatch];
    }

    if (_isHaveSgemengt == YES) {
        float top_x = _ishavePlayView == YES ? bjImageView.bottom : 0;
        lxsegement  = [[LXSgement alloc]initWithFrame:CGRectMake(0, top_x, kScreenWidth, 45 * ratioHeight) titles:@[@"未练",@"已练"] normalColor:[UIColor blackColor] selectedColor:UIColor1(蓝) bottomColor:[MyColor colorWithHexString:@"#0172fe"] divisionColor:UIColor2(灰色背景)];
        lxsegement.delegate = self;
        lxsegement.backgroundColor = [UIColor whiteColor];
        [bgheadView addSubview:lxsegement];
    }
    
    float top_x1 = _isHaveSgemengt == YES ? lxsegement.bottom + 5 : 0;
    bgheadView.height = top_x1;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.tableHeaderView = bgheadView;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downLoad)];
    [self.view addSubview:_tableView];
}

#pragma mark - NetWorkManagerDelegate
- (void) netWorkStatusWillChange:(NetworkStatus)status
{
    if(status == ReachableViaWiFi)
    {
        label8.hidden = YES;
        view2.hidden = YES;
        
    } else {
        label8.hidden = NO;
        view2.hidden = NO;
        
    }
    
}
//判断wifi
- (void)netWorkStatusWillEnabledViaWifi
{
    label8.hidden = YES;
    view2.hidden = YES;
    
}


#pragma mark  ------- uitableViewdelegate -----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"cellid";
    PromotionCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[PromotionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.model = _dataArray[indexPath.row];
    [cell layoutSubviews];
    return cell;
    
}

//单元格点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //跳转详情
     PersonModel *model = _dataArray[indexPath.row];
     DetailsubjectController *detailVC = [[DetailsubjectController alloc]init];
     detailVC.selectedIndexPath = indexPath;
     detailVC.ID = model.ID;
//    if(_isHaveSgemengt == NO && _ishavePlayView == NO)
//    {
//       detailVC.lid = model.sid;
//    } else {
//      detailVC.lid = model.rid;
//    }
    detailVC.lid = model.rid;
    
     detailVC.types = model.type;
    [self.navigationController pushViewController:detailVC animated:YES];
   
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PromotionCell *cell = (PromotionCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.contenLabel.bottom + 15;

}

- (void)tapHeader
{
    _BgVideoView.alpha = .5;
    _zhegaiView.hidden = NO;
    [UIView animateWithDuration:.5 animations:^{
        _VideoView.hidden = NO;
        _VideoView.top = kScreenHeight / 2.0 - _VideoView.height / 2.0 - 64;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:.5 animations:^{
            _VideoView.width = kScreenWidth;
            _VideoView.height = kScreenHeight;
            //                _imageView.center = CGPointMake(kScreenWidth / 2.0, (kScreenHeight ) / 2.0);
            _donghuaImageView.center = CGPointMake(kScreenWidth / 2.0, kScreenHeight / 2.0);
            _view.center = CGPointMake(kScreenWidth / 2.0, (kScreenHeight ) / 2.0);
            _VideoView.center = CGPointMake(kScreenWidth / 2.0, (kScreenHeight ) / 2.0);
            
        } completion:^(BOOL finished) {
            _BgVideoView.alpha = 0;
            LDZMoviePlayerController *moviewPlayerVC = [[LDZMoviePlayerController alloc] init];
            
        
            NSURL *URL = [NSURL URLWithString: _VidioUrl];
            moviewPlayerVC.movieURL = URL;
            
           
            //                      播放网络
            //                    NSString *urlString = @"http://mw2.dwstatic.com/2/8/1528/133366-99-1436362095.mp4";
            
            
            [self presentViewController:moviewPlayerVC animated:NO completion:nil];
        }];
        
    }];
}

//通知动画
- (void)VideoDonghua
{
    _BgVideoView.alpha = .5;
    [UIView animateWithDuration:.5 animations:^{
        _VideoView.width = kScreenWidth;
        _VideoView.height = 170 * ratioHeight;
        _donghuaImageView.center = _VideoView.center;
        _view.center = _VideoView.center;
        _VideoView.center = CGPointMake(kScreenWidth / 2.0, (kScreenHeight ) / 2.0);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.5 animations:^{
            _VideoView.top = 0;
            
        } completion:^(BOOL finished) {
            _VideoView.hidden = YES;
            _BgVideoView.alpha = 0;
            _zhegaiView.hidden = YES;
        }];
    }];
    
    
    
}


//------------------------- LXDelegate -------------------------------
- (void)clickindex:(int)index
{
    //未练
    if(index == 0){
        
        _is_practice = @"0";
         [_tableView.header beginRefreshing];
        
        
    }
    
    //已练
    if(index == 1){
         _is_practice = @"1";
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

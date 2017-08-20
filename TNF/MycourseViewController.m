//
//  MycourseViewController.m
//  TNF
//
//  Created by 李立 on 15/12/17.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "MycourseViewController.h"
#import "HeadCollectionReusableView.h"
#import "BypredictingViewController.h"
#import "PromotioncourseViewController.h"
#import "MycourseModel.h"
#import "WebViewController.h"
static NSString *headerIdentifier = @"header";
@interface MycourseViewController ()
{
    BOOL _isbool;
    int _pageIndex;
    BOOL _isdownLoad;
    NSMutableArray *_mutableArray;
}
@property (nonatomic,strong)NSArray *DataArray;
@end

@implementation MycourseViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    //改变导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[MyColor colorWithHexString:@"#0172fe"]];
    
    [_mycollectionView.header beginRefreshing];
 

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //改变导航栏颜色
//    [self.navigationController.navigationBar setBarTintColor:UIColor1(蓝)];

    _isbool = NO;
    _pageIndex = 1;
    
    //导航栏标题
    self.text = @"我的课程";
    
    //当前视图的背景视图
//    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = UIColor2(灰色背景);
    
    //初始化子视图
     [self _initViews];
    
//     [_mycollectionView.header beginRefreshing];
    
    //创建删除按钮
    _zhangdanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _zhangdanButton.frame = CGRectMake(0, 0, 78 / 4.5*ratioHeight, 82 / 4.5*ratioHeight);
    _zhangdanButton.titleLabel.font = [UIFont systemFontOfSize:14*ratioHeight];
    [_zhangdanButton addTarget:self action:@selector(shaixuanAction) forControlEvents:UIControlEventTouchUpInside];
    [_zhangdanButton setImage:imageNamed(@"del_01") forState:UIControlStateNormal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:_zhangdanButton];
    // 添加到当前导航控制器上
    self.navigationItem.rightBarButtonItem = backItem;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 320) / 2.0, 50 * ratioHeight, 320, 160)];
    _imageView.image = [UIImage imageNamed:@"无图片640-320"];
    _imageView.hidden = YES;
    [self.view addSubview:_imageView];
    
    
    tishiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _imageView.bottom + 20 * ratioHeight, kScreenWidth, 20 * ratioHeight)];
    tishiLabel.text = @"没有收藏的课程哦";
    tishiLabel.textColor = [UIColor colorWithRed:141 / 255.0 green:142 / 255.0 blue:143 / 255.0 alpha:1];
    tishiLabel.font = [UIFont fontWithName:@"Arial" size:18*ratioHeight];;
    tishiLabel.hidden = YES;
    tishiLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tishiLabel];

}

-(void)_initViews
{
//创建collectionView

      //item 的大小

      UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
      layout.itemSize = CGSizeMake(kScreenWidth / 2.0-15, 140*ratioHeight);
 
    //设置行 列 间距
      layout.minimumLineSpacing = 5;
      layout.minimumInteritemSpacing = 10;

      _mycollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10,0, kScreenWidth-20, kScreenHeight-64) collectionViewLayout:layout];
       _mycollectionView.dataSource = self;
       _mycollectionView.delegate = self;

      //取消滑动指示器
     _mycollectionView.showsHorizontalScrollIndicator = NO;
     _mycollectionView.showsVerticalScrollIndicator = NO;

     _mycollectionView.backgroundColor = [UIColor clearColor];
     _mycollectionView.backgroundView = nil;
    
     //重用类
      [_mycollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"hello"];
    
      _mycollectionView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downLoad)];
    
    [self.view addSubview:_mycollectionView];

}

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
    
    [WXDataService requestAFWithURL:Url_myCourseList params:@{@"page":[NSString stringWithFormat:@"%d",_pageIndex],@"member_id":[UserDefaults objectForKey:Userid]} httpMethod:@"POST" finishBlock:^(id result) {
        NSLog(@"-----result==%@",result);
        //请求成功
         _pageIndex ++;
        if ([[result objectForKey:@"status"] integerValue] == 0) {
           
           
            
            //            [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
            NSArray *array = result[@"result"][@"list"];
            
            if (_isdownLoad) {
                _mutableArray = [NSMutableArray new];
            }
            
            for (NSDictionary *subDic in array) {
                MycourseModel * model = [[MycourseModel alloc]initWithDataDic:subDic];
                [_mutableArray addObject:model];
            }
            self.DataArray = _mutableArray;
            
//            if (array.count >= 10) {
//                _mycollectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upLoad)];
//            }
            if (_isdownLoad) {
                if (self.DataArray.count == 0) {
                    _imageView.hidden = NO;
                    tishiLabel.hidden = NO;
                }else{
                    _imageView.hidden = YES;
                    tishiLabel.hidden = YES;
                }
               
                [_mycollectionView.header endRefreshing];
                _mycollectionView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upLoad)];
            } else {
                _imageView.hidden = YES;
                tishiLabel.hidden = YES;
                [_mycollectionView.footer endRefreshing];
            }
        }
        //请求失败
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            _imageView.hidden = YES;
            tishiLabel.hidden = YES;
            
            NSArray *array = result[@"result"][@"list"];
            if (array.count == 0) {
               _pageIndex --;
            }

            for (NSDictionary *subDic in array) {
                MycourseModel * model = [[MycourseModel alloc]initWithDataDic:subDic];
                [_mutableArray addObject:model];
            }
            self.DataArray = _mutableArray;

            
            if (_isdownLoad) {

                [_mycollectionView.header endRefreshing];
            } else {
                
                [_mycollectionView.footer endRefreshing];
//                _mycollectionView.footer = nil;
            }
//            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
        }
        
        [_mycollectionView reloadData];
        
    } errorBlock:^(NSError *error) {
        
        if (_isdownLoad) {
            [_mycollectionView.header endRefreshing];
        } else {
            [_mycollectionView.footer endRefreshing];
        }
    }];
    
 
    
}


#pragma mark - collectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  self.DataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *idfiter = @"hello";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:idfiter forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.backgroundView = nil;
   
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    MycourseModel * model = self.DataArray [indexPath.row];
    
    //图片
    UIImageView * imageview1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.width, 160 / 2.0 * ratioHeight)];
    imageview1.backgroundColor = [UIColor clearColor];
    [imageview1 sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:nil];
    [cell.contentView addSubview:imageview1];
    
    //下载过没
    UIView *bgtypeView = [[UIView alloc]initWithFrame:CGRectMake(imageview1.width - 18 * ratioHeight , imageview1.height - 18 * ratioHeight  , 18 * ratioHeight , 18 * ratioHeight)];
    bgtypeView.hidden = YES;
    bgtypeView.backgroundColor = UIColor1(蓝);
    [cell.contentView addSubview:bgtypeView];
    UIImageView *typeImageView = [[UIImageView alloc]initWithFrame:CGRectMake((bgtypeView.width - 15 * ratioHeight) / 2.0 , (bgtypeView.height - 15 * ratioHeight) / 2.0 , 15 * ratioHeight , 15 * ratioHeight)];
    typeImageView.contentMode = UIViewContentModeScaleAspectFit;
    typeImageView.image = [UIImage imageNamed:@"down_01"];
    [bgtypeView addSubview:typeImageView];
    typeImageView.hidden = YES;
    if ([model.type integerValue] == 1 || [model.type integerValue] == 2 ) {
        if ([model.is_save integerValue] == 1) {
            typeImageView.hidden = NO;
            bgtypeView.hidden = NO;
        } else {
            typeImageView.hidden = YES;
            bgtypeView.hidden = YES;
        }
    }
    
//   //报名没
//    UILabel *typeLable = [[UILabel alloc]initWithFrame:CGRectMake(imageview1.width - 50 * ratioWidth , imageview1.height - 18 * ratioHeight  , 50 * ratioWidth , 18 * ratioHeight)];
//    typeLable.font = [UIFont boldSystemFontOfSize:13.0];
//    typeLable.textColor = [UIColor whiteColor];
//    typeLable.textAlignment = NSTextAlignmentCenter;
//    typeLable.hidden = YES;
//    typeLable.backgroundColor = UIColor1(蓝);
//    [cell.contentView addSubview:typeLable];
//    if ([model.type integerValue] == 3 || [model.type integerValue] == 4 ) {
//        typeLable.hidden = NO;
//        if ([model.is_save integerValue] == 1) {
//            typeLable.text = @"已报名";
//        } else {
//            typeLable.text = @"未报名";
//        }
//    }

    
    //课程名字
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, imageview1.bottom+10, cell.width - 5, 20*ratioHeight)];
    label.textColor = UIColor6(正文小字);
    label.font = [UIFont systemFontOfSize:13*ratioHeight];
    label.numberOfLines = 0;
    label.text = model.title;
    [cell.contentView addSubview:label];
    
    //线条
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, imageview1.bottom+35, cell.width, 1)];
    lineView.backgroundColor = UIColor2(灰色背景);
    [cell.contentView addSubview:lineView];
    
    //状态Label
    UILabel *lael2 = [[UILabel alloc]initWithFrame:CGRectMake(10, lineView.bottom, cell.width - 10, 140*ratioHeight - lineView.bottom)];
    lael2.textColor = UIColor1(蓝);
    label.numberOfLines = 0;
    lael2.text = model.text;
    lael2.font = [UIFont systemFontOfSize:13*ratioHeight];
    [cell.contentView addSubview:lael2];
    
    //删除视图
    UIView* deleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cell.width, cell.height)];
    deleView.backgroundColor = [UIColor blackColor];
    if(_isbool == NO){
       deleView.alpha = 0;
    } else {
       deleView.alpha = 0.5;
    }
   
    deleView.tag = 1000+indexPath.row;
    [cell.contentView addSubview:deleView];
    
    //删除按钮视图
    _shangView = [[UIView alloc]initWithFrame:CGRectMake(cell.width/2-20 * ratioHeight, cell.height/2-20 * ratioHeight, 40*ratioHeight, 40*ratioHeight)];
    _shangView.layer.cornerRadius = 20 * ratioHeight;
    _shangView.backgroundColor =  UIColor1(蓝);
    _shangView.hidden = !_isbool;
    _shangView.tag = 2000+indexPath.row;
    // 按钮边框宽度
    _shangView.layer.borderWidth = 0;
    [cell.contentView addSubview:_shangView];
    
    //图片
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake((cell.width -20 * ratioHeight) / 2.0 , cell.height/2 - 10 * ratioHeight, 20*ratioHeight, 20*ratioHeight)];
    imageView2.tag = 3000+indexPath.row;
    imageView2.hidden = !_isbool;
    imageView2.image = imageNamed(@"del_01");
    [cell.contentView addSubview:imageView2];
    
  

    return cell;
    
}

//返回头视图的高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={kScreenWidth,5};
     [self.mycollectionView  registerClass:[HeadCollectionReusableView  class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    return size;
}

//单元格点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MycourseModel *model = _DataArray[indexPath.row];
    //处于删除
    if (_isbool == YES) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除该视频" preferredStyle:(UIAlertControllerStyleAlert)];
        
        // 创建按钮
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            NSLog(@"删除");
            [self deleteCourseID:model.CourseID app_type:model.app_type];
        }];

        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
           
        }];
        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
        // 将UIAlertController模态出来 相当于UIAlertView show 的方法
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    
    //点击详情
    if(_isbool == NO)
    {
       NSLog(@"详情");
        
        if ([model.source integerValue] == 1) {
            //跳转视频课
            PromotioncourseViewController *promotionVC = [[PromotioncourseViewController alloc]init];
            promotionVC.text = model.title;
            promotionVC.Videoid = model.CourseID;
            [self.navigationController pushViewController:promotionVC animated:YES];
        }
        
        if ([model.source integerValue] == 2) {
            //跳转到机经预测专题讲座页面
            WebViewController *zhiboVC = [[WebViewController alloc]init];
            zhiboVC.url = model.url;
            zhiboVC.text = @"直播课";
            zhiboVC.ID = model.CourseID;
            zhiboVC.isZhibo = YES;
            [self.navigationController pushViewController:zhiboVC animated:YES];
        }
        
        
    }
    
    
}


//删除课程
- (void)deleteCourseID:(NSString *)CourseID app_type:(NSString *)app_type
{
    [WXDataService requestAFWithURL:Url_delCourse params:@{@"app_type":app_type,@"id":CourseID,@"member_id":[UserDefaults objectForKey:Userid]} httpMethod:@"POST" finishBlock:^(id result) {
       
        if ([result[@"status"] integerValue] == 0) {
           
           [self downLoad];
           [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
        }
        if ([result[@"status"] integerValue] == 1) {
            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
        }
    } errorBlock:^(NSError *error) {
    
    }];


}


//删除按钮点击事件
-(void)shaixuanAction
{
    
    _isbool = !_isbool;
    
    if (_isbool == NO) {
        
        [_zhangdanButton setImage:imageNamed(@"del_01") forState:UIControlStateNormal];
        _zhangdanButton.frame = CGRectMake(0, 0, 78 / 4.5*ratioHeight, 82 / 4.5*ratioHeight);
        [_zhangdanButton.titleLabel.text isEqualToString:@""];
        for (int i = 0; i<_DataArray.count; i++) {
            UIView *view = (UIView *)[_mycollectionView viewWithTag:1000+i];
            UIView *view2 =(UIView *)[_mycollectionView viewWithTag:2000+i];
            UIImageView *imageView = [_mycollectionView viewWithTag:3000 + i];
            view.alpha = 0;
            view2.hidden = !_isbool;
            imageView.hidden = !_isbool;

        }

    }
    
    if (_isbool == YES) {
        [_zhangdanButton setImage:imageNamed(@"") forState:UIControlStateNormal];
        _zhangdanButton.frame = CGRectMake(0, 0, 40*ratioHeight, 40*ratioHeight);
        [_zhangdanButton setTitle:@"  完成" forState:UIControlStateNormal];
        for (int i = 0; i<_DataArray.count; i++) {
            UIView *view = (UIView *)[_mycollectionView viewWithTag:1000+i];
            UIView *view2 =(UIView *)[_mycollectionView viewWithTag:2000+i];
            UIImageView *imageView = [_mycollectionView viewWithTag:3000 + i];
            view.alpha = .5;
            view2.hidden = !_isbool;
            imageView.hidden = !_isbool;

        }

    }
    
}

@end

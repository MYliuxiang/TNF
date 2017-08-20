//
//  BillViewController.m
//  TNF
//
//  Created by 李立 on 15/12/18.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "BillViewController.h"
#import "BiIIModel.h"
#import "HomeBillmodel.h"
#import "TrainingrecordViewController.h"
@interface BillViewController ()
{
    int _pageIndex;
    BOOL _isdownLoad;
    NSArray *_dataArray;
    NSMutableArray *mutableArray;

}
@end

@implementation BillViewController


-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    //改变导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:UIColor(深色背景)];

    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //导航栏标题
    self.text = @"福币账单";
//    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //初始化子视图
    [self _initView];
    
    [_billTabelView.header beginRefreshing];

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

    [WXDataService requestAFWithURL:Url_getAmountLog params:@{@"page":[NSString stringWithFormat:@"%d",_pageIndex],@"member_id":[UserDefaults objectForKey:Userid]} httpMethod:@"POST" finishBlock:^(id result) {
        NSLog(@"-----result==%@",result);
        //请求成功
         _pageIndex ++;
        if ([[result objectForKey:@"status"] integerValue] == 0) {
            
           
            
            //            [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            if (_isdownLoad) {
                mutableArray = [NSMutableArray new];
            }

            
            NSArray *array = result[@"result"][@"list"];
            for (NSDictionary *dict in array) {
                NSMutableArray *dictArray = [NSMutableArray new];
                NSArray *array1 = dict[@"list"];
                for (NSDictionary *subDic in array1) {
                    BiIIModel * model = [[BiIIModel alloc]initWithDataDic:subDic];
                    [dictArray addObject:model];
                }
                HomeBillmodel *home = [[HomeBillmodel alloc]init];
                home.list = dictArray;
                home.amount = [NSString stringWithFormat:@"%@",dict[@"amount"]];
                home.time = [NSString stringWithFormat:@"%@",dict[@"time"]];
                [mutableArray addObject:home];
            }
            
            _dataArray = mutableArray;
            

            if (_isdownLoad) {
                [_billTabelView.header endRefreshing];
                 _billTabelView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upLoad)];
            } else {
                [_billTabelView.footer endRefreshing];
            }
            
        }
        //请求失败
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            
            NSArray *array = result[@"result"][@"list"];
            if (array.count == 0) {
                _pageIndex --;
            }
            for (NSDictionary *dict in array) {
                NSMutableArray *dictArray = [NSMutableArray new];
                NSArray *array1 = dict[@"list"];
                for (NSDictionary *subDic in array1) {
                    BiIIModel * model = [[BiIIModel alloc]initWithDataDic:subDic];
                    [dictArray addObject:model];
                }
                HomeBillmodel *home = [[HomeBillmodel alloc]init];
                home.list = dictArray;
                home.amount = [NSString stringWithFormat:@"%@",dict[@"amount"]];
                home.time = [NSString stringWithFormat:@"%@",dict[@"time"]];
                [mutableArray addObject:home];
            }
            
            _dataArray = mutableArray;

            
            if (_isdownLoad) {
                [_billTabelView.header endRefreshing];
                
            } else {
                [_billTabelView.footer endRefreshing];
//                 _billTabelView.footer = nil;
            }
            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
        }
        
        [_billTabelView reloadData];

        
        
        
    } errorBlock:^(NSError *error) {
        if (_isdownLoad) {
            [_billTabelView.header endRefreshing];
        } else {
            [_billTabelView.footer endRefreshing];
        }

    }];



}


//初始化子视图
-(void)_initView
{

    //创建表视图
    _billTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth  , kScreenHeight-64) style:UITableViewStyleGrouped];
    _billTabelView.delegate = self;
    _billTabelView.dataSource = self;
    _billTabelView.showsHorizontalScrollIndicator = NO;
    _billTabelView.showsVerticalScrollIndicator = NO;
    //    _setupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _billTabelView.bounces = YES;
    
    //头视图
//    _billTabelView.tableHeaderView = ({
//        UIView *bjview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
//        bjview.backgroundColor = UIColor2(灰色背景);
//        
//        bjview;
//        
//    });
    
    //尾视图
    _billTabelView.tableFooterView = ({
        UIView *footerbjView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, .1)];
        footerbjView.backgroundColor = UIColor2(灰色背景);
        
        footerbjView;
        
        
    });
    
    _billTabelView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downLoad)];
    
    [self.view addSubview:_billTabelView];

}


//返回单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
       return 70;
    
}

//返回多少组表视图
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

//每一组返回多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    
    HomeBillmodel *model = _dataArray[sectionIndex];
    return model.list.count;
}

//尾视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;

}
//创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"Cell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        //线条
        UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(20, 70 - .5, kScreenWidth, .5)];
        lineview.backgroundColor = UIColorFromRGB(0xcccccc);
        cell.textLabel.font = [UIFont systemFontOfSize:13*ratioHeight];
        cell.textLabel.textColor = UIColor6(正文小字);
        [cell.contentView addSubview:lineview];
        
        //大标题
        UILabel *lael1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 150*ratioHeight, 20*ratioHeight)];
        lael1.textColor = UIColor5(标题大字);
        lael1.tag = 100;
        lael1.font = [UIFont systemFontOfSize:15*ratioHeight];
//        lael1.text = @"练习点评15条";
        [cell addSubview:lael1];
        
        //时间（小标题）
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, lael1.bottom+5, 150, 20)];
        label2.textColor = UIColor6(正文小字);
        label2.tag = 101;
        label2.font = [UIFont systemFontOfSize:13*ratioHeight];
//        label2.text = @"2015.11.24";
        [cell addSubview:label2];
        
        //扣除福币数目
        UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-110*ratioHeight, 20, 100*ratioHeight, 20*ratioHeight)];
        label3.textColor = UIColor3(金色);
        label3.tag = 102;
        label3.font = [UIFont systemFontOfSize:15*ratioHeight];
//        label3.text = @"-100";
        label3.textAlignment = NSTextAlignmentRight;
        [cell addSubview:label3];
    }
    UILabel *lable1 = (UILabel *)[cell viewWithTag:100];
    UILabel *lable2 = (UILabel *)[cell viewWithTag:101];
    UILabel *lable3 = (UILabel *)[cell viewWithTag:102];
    
    HomeBillmodel *homeModel =  _dataArray[indexPath.section];
    BiIIModel *model = homeModel.list[indexPath.row];
    if ([model.type intValue] == 2) {
        lable1.text = [NSString stringWithFormat:@"%@ %@条",model.title,model.count] ;
        lable2.text = @"查看联系记录";
    } else {
        lable1.text = model.title;
        lable2.text = model.addtime;
    }
    
    
    if ([model.as isEqualToString:@"-"]) {
        lable3.textColor = UIColor3(金色);
    } else {
        lable3.textColor = UIColor1(蓝);
    }
    lable3.text = [NSString stringWithFormat:@"%@%@",model.as,model.amount];
    
    
    
    return cell;
}

//组视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    HomeBillmodel *homemodel = _dataArray[section];
    //组视图背景视图
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, kScreenWidth, 30*ratioHeight);
    view.backgroundColor = UIColor2(灰色背景);
    
    //组视图label
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 200*ratioHeight, 20*ratioHeight)];
    label.textColor = UIColor6(正文小字);
    label.font = [UIFont systemFontOfSize:13*ratioHeight];
    label.text = homemodel.time;
    [view addSubview:label];
//
    //消费金额
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-210*ratioHeight, 5, 200*ratioHeight, 20*ratioHeight)];
    label1.textAlignment = NSTextAlignmentRight;
    label1.textColor = UIColor6(正文小字);
    label1.font = [UIFont systemFontOfSize:13*ratioHeight];
    label1.text = [NSString stringWithFormat:@"消费%@福币",homemodel.amount];
    [view addSubview:label1];
    return view;


}
//单元格点击事件

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];// 取消选中
    HomeBillmodel *homeModel =  _dataArray[indexPath.section];
    BiIIModel *model = homeModel.list[indexPath.row];
    if ([model.type intValue] == 2) {
        TrainingrecordViewController *travc = [[TrainingrecordViewController alloc]init];
        travc.addtime = model.addtime;
        [self.navigationController pushViewController:travc animated:YES];
    }
}

@end

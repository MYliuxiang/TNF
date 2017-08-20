//
//  TrainingrecordViewController.m
//  TNF
//
//  Created by 李立 on 15/12/17.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "TrainingrecordViewController.h"
#import "StarView.h"
#import "SpecailModel.h"
#import "DetailsubjectController.h"
@interface TrainingrecordViewController ()
{

    int _pageIndex;
    BOOL _isdownLoad;
    NSMutableArray *_mutableKeyArray;
    NSMutableArray *_mutableValueArray;
    UILabel *zongshulabel ;

}
@property (nonatomic,strong)NSArray *DataValueArray;
@property (nonatomic,strong)NSArray *DataKeyArray;
@end

@implementation TrainingrecordViewController


-(void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBar.hidden = NO;
    //改变导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:UIColor(深色背景)];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //导航栏标题
    self.text = @"练习记录";
    self.view.backgroundColor = [UIColor whiteColor];
    _addtime = @"";
    
    //初始化子视图
    [self _initView];
    
    [_trainingTableView.header beginRefreshing];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 320) / 2.0, 50 * ratioHeight, 320, 160)];
    _imageView.image = [UIImage imageNamed:@"无图片640-320"];
    _imageView.hidden = YES;
    [self.view addSubview:_imageView];

    
    tishiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _imageView.bottom + 20 * ratioHeight, kScreenWidth, 20 * ratioHeight)];
    tishiLabel.text = @"还没有练习哦";
    tishiLabel.textColor = [UIColor colorWithRed:141 / 255.0 green:142 / 255.0 blue:143 / 255.0 alpha:1];
    tishiLabel.font = [UIFont fontWithName:@"Arial" size:18*ratioHeight];;
    tishiLabel.hidden = YES;
    tishiLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tishiLabel];
}

////下啦刷新
- (void)downLoad
{
    
    _isdownLoad = YES;
    _pageIndex = 1;
    [self MyDataserview];
    
}

//上啦加载
- (void)upLoad
{
    _isdownLoad = NO;
    [self MyDataserview];
    
}



- (void)MyDataserview{
    
//    member_id用户ID
//    page当前页 默认1（分页时可能出现重复日期的，APP端需要处理下）

    NSString *useid = [UserDefaults objectForKey:Userid];
    NSDictionary *params = @{@"member_id":useid,@"addtime":_addtime,@"page":[NSString stringWithFormat:@"%d",_pageIndex]};
    
    [WXDataService requestAFWithURL:Url_getPracticeLog params:params httpMethod:@"POST" finishBlock:^(id result) {
        NSLog(@"%@",result);
        //请求成功
         _pageIndex ++;
        if ([[result objectForKey:@"status"] integerValue] == 0) {
            
            

            
            //            [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
            NSArray *array = result[@"result"][@"list"];
            _zongshu = result[@"result"][@"count"];
            zongshulabel.text = [NSString stringWithFormat:@"共%@个录音",_zongshu] ;
            if (_isdownLoad) {
                _mutableKeyArray = [NSMutableArray new];
                _mutableValueArray = [NSMutableArray new];
            }
            
            
            for (NSDictionary *arraydict in array) {
                [_mutableKeyArray addObject:arraydict[@"days"]];
                 NSArray *ValueArray = arraydict[@"list"];
                 NSMutableArray *mutables = [NSMutableArray new];
                for (NSDictionary *Valuedic in ValueArray) {
                    SpecailModel * model = [[SpecailModel alloc]initWithDataDic:Valuedic];
                    [mutables addObject:model];
                }
                [_mutableValueArray addObject:mutables];
            }
           
            self.DataValueArray = _mutableValueArray;
            self.DataKeyArray = _mutableKeyArray;
            
        
            if (_isdownLoad) {
                if([_zongshu intValue] == 0){
                _imageView.hidden = NO;
                tishiLabel.hidden = NO;
                bjview.backgroundColor = [UIColor clearColor];

                }else{
                
                    _imageView.hidden = YES;
                    tishiLabel.hidden = YES;
                    bjview.backgroundColor = [UIColor whiteColor];

                }
                

                [_trainingTableView.header endRefreshing];
                _trainingTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upLoad)];
            } else {
                
                _imageView.hidden = YES;
                tishiLabel.hidden = YES;
                [_trainingTableView.footer endRefreshing];
            }
        }
        //请求失败
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
      
            NSArray *array = result[@"result"][@"list"];
            if(array.count == 0)
            {
                _pageIndex --;
            
            }
            for (NSDictionary *arraydict in array) {
                [_mutableKeyArray addObject:arraydict[@"days"]];
                NSArray *ValueArray = arraydict[@"list"];
                NSMutableArray *mutables = [NSMutableArray new];
                for (NSDictionary *Valuedic in ValueArray) {
                    SpecailModel * model = [[SpecailModel alloc]initWithDataDic:Valuedic];
                    [mutables addObject:model];
                }
                [_mutableValueArray addObjectsFromArray:mutables];
            }
            
            self.DataValueArray = _mutableValueArray;
            self.DataKeyArray = _mutableKeyArray;

            
            if (_isdownLoad) {
                [_trainingTableView.header endRefreshing];
                _imageView.hidden = NO;
                tishiLabel.hidden = NO;
                bjview.backgroundColor = [UIColor clearColor];
            } else {
                
                _imageView.hidden = YES;
                tishiLabel.hidden = YES;
                bjview.backgroundColor = [UIColor whiteColor];

                [_trainingTableView.footer endRefreshing];
//                 _trainingTableView.footer = nil;
            }
//            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
        }
        
        [_trainingTableView reloadData];

    } errorBlock:^(NSError *error) {
        if (_isdownLoad) {
            [_trainingTableView.header endRefreshing];
        } else {
            [_trainingTableView.footer endRefreshing];
        }

    }];
    
}

//初始化子视图
-(void)_initView
{
    
    //创建表视图
    _trainingTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth  , kScreenHeight-64) style:UITableViewStyleGrouped];
    _trainingTableView.delegate = self;
    _trainingTableView.dataSource = self;
    _trainingTableView.showsHorizontalScrollIndicator = NO;
    _trainingTableView.showsVerticalScrollIndicator = NO;
    //    _setupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _trainingTableView.bounces = YES;
    
    _trainingTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downLoad)];
    
//    头视图
        _trainingTableView.tableHeaderView = ({
            bjview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,45 )];
            bjview.backgroundColor = [UIColor clearColor];
           
        //一共多少个录音
            zongshulabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (45 -20 * ratioWidth) / 2.0 , kScreenWidth, 20 * ratioWidth)];
            zongshulabel.textColor = UIColor6(正文小字);
//            zongshulabel.text = [NSString stringWithFormat:@"共%@个录音",_zongshu] ;
//            label1.backgroundColor = UIColor3(金色);
            zongshulabel.textAlignment = NSTextAlignmentCenter;
            zongshulabel.font = [UIFont systemFontOfSize:17*ratioWidth];
            [bjview addSubview:zongshulabel];
            bjview;
    
        });
    
//    //尾视图
//    _trainingTableView.tableFooterView = ({
//        UIView *footerbjView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
//        footerbjView.backgroundColor = UIColor2(灰色背景);
//        
//        footerbjView;
//        
//        
//    });
    
    [self.view addSubview:_trainingTableView];
    
}


//返回单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
    
}

//返回多少组表视图
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _DataKeyArray.count;
}

//每一组返回多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    NSArray *array = _DataValueArray[sectionIndex];
    return array.count;
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
        //线条
        UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(20, 45 - .5, kScreenWidth, .5)];
        lineview.backgroundColor = UIColorFromRGB(0xcccccc);
        cell.textLabel.font = [UIFont systemFontOfSize:13*ratioHeight];
        cell.textLabel.textColor = UIColor6(正文小字);
        [cell.contentView addSubview:lineview];
        
        //大标题
        UILabel *lael1 = [[UILabel alloc]initWithFrame:CGRectMake(10, (45 - 20*ratioHeight) / 2.0, kScreenWidth - 110, 20*ratioHeight)];
        lael1.textColor = UIColor6(正文小字);
        lael1.tag =101;
        lael1.font = [UIFont systemFontOfSize:13*ratioHeight];
//        lael1.text = @"题目名称";
        [cell.contentView addSubview:lael1];
        
        
        UILabel *lael2 = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 80 -10, lael1.top, 80, 20*ratioHeight)];
        lael2.textColor = UIColor6(正文小字);
        lael2.hidden = YES;
        lael2.tag =102;
        lael2.font = [UIFont systemFontOfSize:13*ratioHeight];
//        lael2.text = @"题目名称";
        [cell.contentView addSubview:lael2];
        
        //    NSInteger gray = _TFYFmodel.Grayindex;
        //星星视图
        StarView *start = [[StarView alloc]initWithFrame:CGRectMake(kScreenWidth-(ratioHeight*30/2*4+5*ratioWidth*10/2),(45 - ratioHeight*30/2)/2 , ratioHeight*30/2*4+(3*(ratioWidth*10/2)), ratioHeight*30/2) starmore:0 Grayindex:4];
        start.islianxi = YES;
        start.tag = 103;
        start.hidden = YES;
        start.clipsToBounds =YES;
        [cell.contentView addSubview:start];
    }
    
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;

    NSArray *array = _DataValueArray[indexPath.section];
    SpecailModel *model = array[indexPath.row];
    UILabel *titleLable = (UILabel *)[cell.contentView viewWithTag:101];
    titleLable.text = model.title;
    UILabel *tepyLable = (UILabel *)[cell.contentView viewWithTag:102];
    
    StarView *start = (StarView *)[cell.contentView viewWithTag:103];
    if ([model.isComment integerValue] == 0) {
        tepyLable.hidden = NO;
        start.hidden = YES;
        tepyLable.text = @"未点评";
    } else {
        tepyLable.hidden = YES;
        start.hidden = NO;
        [start _createYellowStarview:[model.fen intValue] Grayindex:4];
    
    }
    return cell;
}

//组视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    NSArray *toushus = _DataKeyArray;
    //组视图背景视图
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, kScreenWidth, 30*ratioHeight);
    view.backgroundColor = UIColor2(灰色背景);
    
    //组视图label
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 200*ratioHeight, 20*ratioHeight)];
    label.textColor = UIColor6(正文小字);
    label.font = [UIFont systemFontOfSize:13*ratioHeight];
    label.text = toushus[section];
    [view addSubview:label];
    
       return view;
    
    
}
//单元格点击事件

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];// 取消选中
    
    NSArray *array = _DataValueArray[indexPath.section];
    SpecailModel *model = array[indexPath.row];
    
    DetailsubjectController *detailVC = [[DetailsubjectController alloc]init];
//    detailVC.selectedIndexPath = indexPath;
    detailVC.ID = model.ID;
    detailVC.lid = @"0";
    detailVC.types = model.type;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

@end

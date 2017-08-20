//
//  DetailsubjectController.m
//  TNF
//
//  Created by 刘翔 on 15/12/22.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "DetailsubjectController.h"
#import "DetailSubjectCell.h"
#import "WhizkidCell.h"
#import "SourceCell.h"
#import "HeaderModel.h"
#import "Info.h"
#import "Mymodel.h"
#import "FileModel.h"
#import "WhizkidController.h"
#import "FuYuanViewController.h"
#import "FileContentViewController.h"
static DetailsubjectController *vc;
@implementation DetailsubjectController


- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[MyColor colorWithHexString:@"#0172fe"]];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [MyColor colorWithHexString:@"#f0f0f0"];
    type = 0;
    self.indexdic = [NSMutableDictionary dictionary];
    self.collectionDatalist = [NSMutableArray array];
    self.selectedIndexPath = [[NSIndexPath alloc] init];
    vc = self;
    [self _loadData];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FSVoiceBubbleShouldStopNotification" object:nil];


}

+ (DetailsubjectController *)share
{

    return vc;
}


- (void)_loadData
{
    NSString *useid = [UserDefaults objectForKey:Userid];
    NSDictionary *params = @{@"member_id":useid,@"page":@"1",@"key":@"1",@"id":self.ID,@"lid":self.lid,@"type":self.types};
    
    [WXDataService requestAFWithURL:Url_getSubjectInfo params:params httpMethod:@"POST" finishBlock:^(id result) {
        if(result){
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                
                return;
            }
            NSDictionary *dic = result[@"result"];
            HeaderModel *model = [[HeaderModel alloc] initWithDataDic:dic];
            Info *info = [[Info alloc] initWithDataDic:dic[@"info"]];
            model.infos = info;
            NSArray *myarray = dic[@"mp3_list_my"];
            luyinlong = dic[@"long"];
            NSMutableArray *mymarray = [NSMutableArray array];
            for (NSDictionary *mydic in myarray) {
                Mymodel *mymodel = [[Mymodel alloc] initWithDataDic:mydic];
                [mymarray addObject:mymodel];
            }
            if (mymarray.count == 0) {
                
            }else{
            NSDictionary *xdic = @{@"我的":mymarray};
            [model.titles addObject:xdic];
                
            }
            
            NSArray *myarray1 = dic[@"mp3_list"];
            NSMutableArray *ma = [NSMutableArray array];
            for (NSDictionary *mydic in myarray1) {
                Mymodel *mymodel = [[Mymodel alloc] initWithDataDic:mydic];
                [ma addObject:mymodel];
            }
            if (ma.count == 0) {
                
            }else{

            NSDictionary *xdic = @{@"其他的":ma};
            [model.titles addObject:xdic];
                
            }
            
            if (ma.count !=10) {
                [self.indexdic setObject:@"1" forKey:model.ID];

            }else{
            
                [self.indexdic setObject:@"2" forKey:model.ID];
            }
            
            self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.collectionDatalist addObject:model];
            [self _initViews];
            
           
            [self beginLoadDown:model];
//            [self loadDatanext:model];
            

            [_collectionView reloadData];

            //释放组

            
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];




}

//begin前面

- (void)beginLoadDown:(HeaderModel *)models
{
    if ([models.next integerValue] == 0) {
        [self loadDataup:models];
        return;
    }
    NSLog(@"%@",models.next);
    NSString *useid = [UserDefaults objectForKey:Userid];
    NSDictionary *params = @{@"member_id":useid,@"page":@"1",@"key":@"1",@"id":models.next,@"lid":self.lid,@"type":self.types};
    
    [WXDataService requestAFWithURL:Url_getSubjectInfo params:params httpMethod:@"POST" finishBlock:^(id result) {
        if(result){
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [self loadDataup:models];

                return;
            }
            NSDictionary *dic = result[@"result"];
            HeaderModel *model = [[HeaderModel alloc] initWithDataDic:dic];
            Info *info = [[Info alloc] initWithDataDic:dic[@"info"]];
            model.infos = info;
            
            NSArray *myarray = dic[@"mp3_list_my"];
            NSMutableArray *mymarray = [NSMutableArray array];
            for (NSDictionary *mydic in myarray) {
                Mymodel *mymodel = [[Mymodel alloc] initWithDataDic:mydic];
                [mymarray addObject:mymodel];
            }
            if (mymarray.count == 0) {
                
            }else{
                
                NSDictionary *xdic = @{@"我的":mymarray};
                [model.titles addObject:xdic];
                
            }
            
            NSArray *myarray1 = dic[@"mp3_list"];
            NSMutableArray *ma = [NSMutableArray array];
            for (NSDictionary *mydic in myarray1) {
                Mymodel *mymodel = [[Mymodel alloc] initWithDataDic:mydic];
                [ma addObject:mymodel];
            }
            if (ma.count == 0) {
                
            }else{
                
                NSDictionary *xdic = @{@"其他的":ma};
                [model.titles addObject:xdic];
                
            }
            
            if (ma.count != 10) {
                
                [self.indexdic setObject:@"1" forKey:model.ID];
                
            }else{
                
                [self.indexdic setObject:@"2" forKey:model.ID];
            }
            
            
            [self.collectionDatalist addObject:model];
            [self loadDataup:models];
            
            
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self loadDataup:models];

        
    }];


}


//前面
- (void)loadDataup:(HeaderModel *)model
{
    if ([model.pre integerValue] == 0) {
        [_collectionView reloadData];
        return;
    }
    NSString *useid = [UserDefaults objectForKey:Userid];
    NSDictionary *params = @{@"member_id":useid,@"page":@"1",@"key":@"1",@"id":model.pre,@"lid":self.lid,@"type":self.types};
    
    [WXDataService requestAFWithURL:Url_getSubjectInfo params:params httpMethod:@"POST" finishBlock:^(id result) {
        
        if(result){
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                
                return;
            }
            NSDictionary *dic = result[@"result"];
            HeaderModel *model = [[HeaderModel alloc] initWithDataDic:dic];
            Info *info = [[Info alloc] initWithDataDic:dic[@"info"]];
            model.infos = info;

            NSArray *myarray = dic[@"mp3_list_my"];
            NSMutableArray *mymarray = [NSMutableArray array];
            for (NSDictionary *mydic in myarray) {
                Mymodel *mymodel = [[Mymodel alloc] initWithDataDic:mydic];
                [mymarray addObject:mymodel];
            }
            if (mymarray.count == 0) {
                
            }else{
                NSDictionary *xdic = @{@"我的":mymarray};
                [model.titles addObject:xdic];
                
            }
            
            NSArray *myarray1 = dic[@"mp3_list"];
            NSMutableArray *ma = [NSMutableArray array];
            for (NSDictionary *mydic in myarray1) {
                Mymodel *mymodel = [[Mymodel alloc] initWithDataDic:mydic];
                [ma addObject:mymodel];
            }
            if (ma.count == 0) {
                
            }else{
                
                NSDictionary *xdic = @{@"其他的":ma};
                [model.titles addObject:xdic];
                
            }
            
            if (ma.count !=10) {
                
                [self.indexdic setObject:@"1" forKey:model.ID];
                
            }else{
                
                [self.indexdic setObject:@"2" forKey:model.ID];
            }

            [self.collectionDatalist insertObject:model atIndex:0];
            self.selectedIndexPath = [NSIndexPath indexPathForItem:self.selectedIndexPath.row + 1 inSection:0];

            _collectionView.contentOffset = CGPointMake(kScreenWidth - 5, 0);

            [_collectionView reloadData];

            [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]  atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
            
        }
    } errorBlock:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

}

//后面
- (void)loadDatanext:(HeaderModel *)model
{

    if ([model.next integerValue] == 0) {
        return;
    }
    NSLog(@"%@",model.next);
    NSString *useid = [UserDefaults objectForKey:Userid];
    NSDictionary *params = @{@"member_id":useid,@"page":@"1",@"key":@"1",@"id":model.next,@"lid":self.lid,@"type":self.types};
    
    [WXDataService requestAFWithURL:Url_getSubjectInfo params:params httpMethod:@"POST" finishBlock:^(id result) {
        if(result){
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                return;
            }
            NSDictionary *dic = result[@"result"];
            HeaderModel *model = [[HeaderModel alloc] initWithDataDic:dic];
            Info *info = [[Info alloc] initWithDataDic:dic[@"info"]];
            model.infos = info;

            NSArray *myarray = dic[@"mp3_list_my"];
            NSMutableArray *mymarray = [NSMutableArray array];
            for (NSDictionary *mydic in myarray) {
                Mymodel *mymodel = [[Mymodel alloc] initWithDataDic:mydic];
                [mymarray addObject:mymodel];
            }
            if (mymarray.count == 0) {
                
            }else{
                
                NSDictionary *xdic = @{@"我的":mymarray};
                [model.titles addObject:xdic];
                
            }
            
            NSArray *myarray1 = dic[@"mp3_list"];
            NSMutableArray *ma = [NSMutableArray array];
            for (NSDictionary *mydic in myarray1) {
                Mymodel *mymodel = [[Mymodel alloc] initWithDataDic:mydic];
                [ma addObject:mymodel];
            }
            if (ma.count == 0) {
                
            }else{
                
                NSDictionary *xdic = @{@"其他的":ma};
                [model.titles addObject:xdic];
                
            }
            
            if (ma.count != 10) {
                
                [self.indexdic setObject:@"1" forKey:model.ID];
                
            }else{
                
                [self.indexdic setObject:@"2" forKey:model.ID];
            }


            [self.collectionDatalist addObject:model];
            [_collectionView reloadData];
            
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
        
    }];

    
}

- (void)_initViews
{

    HeaderModel *model = self.collectionDatalist[self.selectedIndexPath.row];
    self.text = model.infos.title;

    
    UIView *hederView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 220 * ratioHeight)];
    hederView.backgroundColor = [UIColor clearColor];
    
    //控制UICollectionView 的样式和布局等
    layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(kScreenWidth - 20,155 * ratioHeight);
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    layout.minimumLineSpacing = 5;
    
    layout.minimumInteritemSpacing = 0;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 175 * ratioHeight) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundView = nil;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = UIColor1(蓝);
    _collectionView.backgroundView = nil;
    _edge = 10;
    _collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    [_collectionView registerClass:[DetailSubjectCell class]  forCellWithReuseIdentifier:@"DetailCellId"];
    [hederView addSubview:_collectionView];
    
    
    NSArray *titles = @[@"优等声",@"解题思路",@"相关素材"];
    
    sgemet = [[LXSgement alloc] initWithFrame:CGRectMake(0, _collectionView.bottom, kScreenWidth, 45 * ratioHeight) titles:titles normalColor:[UIColor blackColor] selectedColor:[MyColor colorWithHexString:@"#0172fe"] bottomColor:[MyColor colorWithHexString:@"#0172fe"] divisionColor:UIColor2(灰色背景)];
    sgemet.delegate = self;
    sgemet.backgroundColor = [UIColor whiteColor];
    [hederView addSubview:sgemet];

    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    HeaderModel *hearder = self.collectionDatalist[self.selectedIndexPath.row];
    NSString *page = [self.indexdic objectForKey:hearder.ID];
    if ([page isEqualToString:@"1"]) {
        
        _tableView.footer = nil;
        
    }else{
        
        _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upLoad)];
        
    }
    
    type = 0;
    [_tableView reloadData];
    [self.view addSubview:_tableView];

    _tableView.tableHeaderView = hederView;

    playbutton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    playbutton1.userInteractionEnabled = YES;
    playbutton1.frame = CGRectMake((kScreenWidth - 65 * ratioHeight) / 2.0, kScreenHeight - 20 * ratioHeight - 65 * ratioHeight - 64, 65 * ratioHeight, 65 * ratioHeight);
    [playbutton1 setImage:[UIImage imageNamed:@"play_03"] forState:UIControlStateNormal];
    [playbutton1 addTarget:self action:@selector(record1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playbutton1];
    
    playbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    playbutton.userInteractionEnabled = YES;
    playbutton.frame = CGRectMake((kScreenWidth - 65 * ratioHeight) / 2.0, kScreenHeight - 20 * ratioHeight - 65 * ratioHeight - 64, 65 * ratioHeight, 65 * ratioHeight);
    [playbutton setImage:[UIImage imageNamed:@"play_03"] forState:UIControlStateNormal];
    [playbutton addTarget:self action:@selector(record:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playbutton];
    
}

#pragma mark -------录音----------
- (void)record1:(UIButton *)sender
{
}
- (void)record:(UIButton *)sender
{
    playbutton.userInteractionEnabled = NO;
    
    NSString *useid = [UserDefaults objectForKey:Userid];
    NSDictionary *params = @{@"member_id":useid};
    
    [WXDataService requestAFWithURL:Url_getAmountUploadMp3Info params:params httpMethod:@"POST" finishBlock:^(id result) {
        if(result){
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                playbutton.userInteractionEnabled = YES;
                return;
                
            }
            NSDictionary *dic = result[@"result"];
            int amount = [dic[@"amount"] intValue];
            if (amount < 5) {
                 //福币不够
                BgView4 *view = [[BgView4 alloc]initWithFrame:CGRectMake(20 * ratioWidth, (kScreenHeight - 180 * ratioHeight ) / 2.0, kScreenWidth  - 20 * ratioWidth * 2 , 180 * ratioHeight) Title:@"您的福币不够了" Delegate:self Mycost:@"" Cost:[NSString stringWithFormat:@"每次作业点评将花费5个福币你目前拥有%d个福币",amount]];
                [self.view addSubview:view];
                playbutton.userInteractionEnabled = YES;
                
            }else{
            
                
                HeaderModel *hearder = self.collectionDatalist[self.selectedIndexPath.row];

                if ([[UserDefaults objectForKey:subject] intValue] == 1) {
                    
                    recode = [[RecoderView alloc] initWithTimes:[hearder.longs intValue]];

                }else{
                
                    recode = [[RecoderView alloc] initWithTimes:[hearder.longs intValue]];

                }
                    recode.delegate = self;
                    [recode show];
                playbutton.userInteractionEnabled = YES;
                
            }
            
            
        }
        
    } errorBlock:^(NSError *error) {
        playbutton.userInteractionEnabled = YES;
        NSLog(@"%@",error);
        
    }];
    

}


#pragma mark -----福币不够了------------
- (void)selecetbtn
{
    FuYuanViewController * fuFuYuan = [[FuYuanViewController alloc]init];
    [self.navigationController pushViewController:fuFuYuan animated:YES];
    

}

//上传之后请求数据
- (void)againLoad
{
    HeaderModel *hearder = self.collectionDatalist[self.selectedIndexPath.row];
    NSString *useid = [UserDefaults objectForKey:Userid];
    NSString *page = [self.indexdic objectForKey:hearder.ID];
    NSDictionary *params = @{@"member_id":useid,@"page":page,@"key":@"1",@"id":hearder.ID,@"lid":hearder.lid,@"type":self.types};
    [WXDataService requestAFWithURL:Url_getSubjectInfo params:params httpMethod:@"POST" finishBlock:^(id result) {
        if(result){
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                NSDictionary *dic = result[@"result"];
                HeaderModel *model = [[HeaderModel alloc] initWithDataDic:dic];
                NSArray *myarray = dic[@"mp3_list_my"];
                NSMutableArray *mymarray = [NSMutableArray array];
                for (NSDictionary *mydic in myarray) {
                    Mymodel *mymodel = [[Mymodel alloc] initWithDataDic:mydic];
                    [mymarray addObject:mymodel];
                }
                if (mymarray.count == 0) {
                    
                }else{
                    NSDictionary *xdic = @{@"我的":mymarray};
                    [model.titles addObject:xdic];
                    
                }
                
                NSArray *myarray1 = dic[@"mp3_list"];
                NSMutableArray *ma = [NSMutableArray array];
                for (NSDictionary *mydic in myarray1) {
                    Mymodel *mymodel = [[Mymodel alloc] initWithDataDic:mydic];
                    [ma addObject:mymodel];
                }
                if (ma.count == 0) {
                    
                }else{
                    
                    NSDictionary *xdic = @{@"其他的":ma};
                    [model.titles addObject:xdic];
                    
                }
                
                if (ma.count !=10) {
                    [self.indexdic setObject:@"1" forKey:model.ID];
                    
                }else{
                    
                    [self.indexdic setObject:@"2" forKey:model.ID];
                }
                
                HeaderModel *model1 = self.collectionDatalist[self.selectedIndexPath.row];
                model1.titles = model.titles;
                [_tableView reloadData];
                

                
                return;
            }
            NSDictionary *dic = result[@"result"];
            HeaderModel *model = [[HeaderModel alloc] initWithDataDic:dic];
            NSArray *myarray = dic[@"mp3_list_my"];
            NSMutableArray *mymarray = [NSMutableArray array];
            for (NSDictionary *mydic in myarray) {
                Mymodel *mymodel = [[Mymodel alloc] initWithDataDic:mydic];
                [mymarray addObject:mymodel];
            }
            if (mymarray.count == 0) {
                
            }else{
                NSDictionary *xdic = @{@"我的":mymarray};
                [model.titles addObject:xdic];
                
            }
            
            NSArray *myarray1 = dic[@"mp3_list"];
            NSMutableArray *ma = [NSMutableArray array];
            for (NSDictionary *mydic in myarray1) {
                Mymodel *mymodel = [[Mymodel alloc] initWithDataDic:mydic];
                [ma addObject:mymodel];
            }
            if (ma.count == 0) {
                
            }else{
                
                NSDictionary *xdic = @{@"其他的":ma};
                [model.titles addObject:xdic];
                
            }
            
            if (ma.count !=10) {
                [self.indexdic setObject:@"1" forKey:model.ID];
                
            }else{
                
                [self.indexdic setObject:@"2" forKey:model.ID];
            }
            
            HeaderModel *model1 = self.collectionDatalist[self.selectedIndexPath.row];
            model1.titles = model.titles;
            [_tableView reloadData];
            
            
            
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
        
        
        
    }];
    

}

#pragma mark ------------recoderViewDelegate-------
- (void)recordfabuMp3Data:(NSData *)data withTime:(NSString *)time
{
    if ([time intValue] < 3) {
        
        //录音时长太短，请重新录制；
    [MBProgressHUD showError:@"录音时长太短，请重新录制；" toView:[UIApplication sharedApplication].keyWindow];
        [recode hiddens];
        return;
    }
   
    [WXDataService postMP3:Url_uploadImgApp params:nil fileData:data finishBlock:^(id result) {

        if(result){
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                [recode hiddens];
               
                return;
                
            }
            NSDictionary *dic = result[@"result"];
            [self loadMP3:dic[@"path"] inttime:time];
            
        }


    } errorBlock:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
    }];

}


#pragma mark --------上传录音-----------
- (void)loadMP3:(NSString *)path inttime:(NSString *)time;
{
    
    HeaderModel *hearder = self.collectionDatalist[self.selectedIndexPath.row];
    NSString *useid = [UserDefaults objectForKey:Userid];
    NSDictionary *params = @{@"member_id":useid,@"time":time,@"mp3":path,@"id":hearder.ID,@"lid":hearder.lid,@"type":self.types};
     [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    [WXDataService requestAFWithURL:Url_uploadMp3Info params:params httpMethod:@"POST" finishBlock:^(id result) {
        if(result){
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                [recode hiddens];
                return;
                
            }
            //上传成功
            [recode hiddens];
            LXbgview *bgview = [[LXbgview alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight) Title:@"录音已发布"  Text:@"老师将为你精心点评\n请注意消息提醒！" delegate:self];
            [[[UIApplication sharedApplication] keyWindow] addSubview:bgview];
            
            NSDictionary *dic = result[@"result"];
            self.amount = [dic[@"amount"] intValue];
            [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
            
        }
        
    } errorBlock:^(NSError *error) {
         [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
        NSLog(@"%@",error);
        
    }];
    

}

#pragma mark ---------LXviewDelegate-------
- (void)clickOK
{
   
    // 完成
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 65 * ratioHeight) / 2.0, kScreenHeight - 20 * ratioHeight - 65 * ratioHeight - 64, 65 * ratioHeight, 65 * ratioHeight)];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 65 / 2.0 * ratioHeight;
    imageView.backgroundColor = UIColor3(金色);
    [self.view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, imageView.width, imageView.height / 2.0)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15 * ratioHeight];
    label.text = [NSString stringWithFormat:@"-%d",self.amount];
    [imageView addSubview:label];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake((imageView.width - imageView.width / 2.0) / 2.0, imageView.height / 2.0 - 10, imageView.width / 2.0, imageView.height / 2.0)];
    imageView1.contentMode = UIViewContentModeScaleAspectFit;
    imageView1.image = [UIImage imageNamed:@"photo_01"];
    [imageView addSubview:imageView1];
    
    
        [UIView animateWithDuration:.5 animations:^{
            imageView.frame =  CGRectMake((kScreenWidth - 65 * ratioHeight) / 2.0, kScreenHeight - 20 * ratioHeight - 65 * ratioHeight - 64 - 65 * ratioHeight * 2, 65 * ratioHeight, 65 * ratioHeight);
    
        } completion:^(BOOL finished) {
            [imageView removeFromSuperview];
        }];
    

    [self againLoad];
    

}

#pragma mark ---------UITableView Delegate--------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (type == 0) {

        HeaderModel *model = self.collectionDatalist[self.selectedIndexPath.row];
        return model.titles.count;
        
    }
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (type == 0) {
        
        HeaderModel *model = self.collectionDatalist[self.selectedIndexPath.row];
        NSDictionary *dic = model.titles[section];
        NSArray *array = [[dic allValues] firstObject];
        return array.count;
        
    }else if(type == 1){
    
        return 0;
        
    }else{
    
        HeaderModel *model = self.collectionDatalist[self.selectedIndexPath.row];

        return model.files.count;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (type == 0) {
        
        static NSString *identifire = @"cellID";
        WhizkidCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[WhizkidCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        
        HeaderModel *model = self.collectionDatalist[self.selectedIndexPath.row];
        NSDictionary *dic = model.titles[indexPath.section];
        NSArray *array = [[dic allValues] firstObject];
        cell.model = array[indexPath.row];
        return cell;

    }else if (type == 2){
    
        static NSString *identifire = @"cellID2";
        SourceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
        if (cell == nil) {
            cell = [[SourceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        
        HeaderModel *model = self.collectionDatalist[self.selectedIndexPath.row];
        cell.model = model.files[indexPath.row];
        return cell;

    }else{
    static NSString *identifire = @"cellID3";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 20)];
        label.textColor = [UIColor blackColor];
        label.tag = 100;
        label.numberOfLines = 0;
        [cell.contentView addSubview:label];
    }
        
        UILabel *label = (UILabel *)[cell.contentView viewWithTag:100];
        HeaderModel *hearder = self.collectionDatalist[self.selectedIndexPath.row];
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[hearder.contents dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];

        label.attributedText = attrStr;

        [label sizeToFit];
    
    return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;


}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (type == 0) {
        return 30 * ratioHeight;
    }

    return .1;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (type == 1) {
        
    HeaderModel *hearder = self.collectionDatalist[self.selectedIndexPath.row];
    
        return [self heightForString:hearder.contents andWidth:kScreenWidth - 20];
           }
    return 80 * ratioWidth;


}

- (float) heightForString:(NSString *)value andWidth:(float)width{
    //获取当前文本的属性
    UILabel *_text = [[UILabel alloc] init];
     NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[value dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    _text.attributedText = attrStr;
    NSRange range = NSMakeRange(0, attrStr.length);
    // 获取该段attributedString的属性字典
    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
    // 计算文本的大小
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width, MAXFLOAT) // 用于计算文本绘制时占据的矩形块
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                        attributes:dic        // 文字的属性
                                           context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    return sizeToFit.height + 16.0;
}

//计算文本高度
- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:UILineBreakModeWordWrap];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.height;
}


#pragma mark ------LXDelegate--------------
- (void)clickindex:(int)index
{
    type = index;
    
    if (index == 0) {
        [self removeFooter];

    }else if (index == 1){
        
        [self loadContent];
        
    
    }else if (index == 2){
    
        [self loadflies];
        [self removeFooter];
    }
    
    [_tableView reloadData];
    
    
}

- (void)addfooter
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 20, 20)];
    label.textColor = [UIColor blackColor];
    label.tag = 100;
    label.numberOfLines = 0;

    HeaderModel *hearder = self.collectionDatalist[self.selectedIndexPath.row];
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[hearder.contents dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];

    label.attributedText = attrStr;
    label.backgroundColor = [UIColor whiteColor];
    [label sizeToFit];
    [view addSubview:label];
    view.height = label.bottom;
    _tableView.tableFooterView = view;

}

- (void)removeFooter
{
    _tableView.tableFooterView = nil;


}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

    if (type == 0) {
        
        HeaderModel *model = self.collectionDatalist[self.selectedIndexPath.row];
        NSDictionary *dic = model.titles[section];
        NSString *str = [[dic allKeys] firstObject];
        return str;

    }

    return @"";
}

#pragma mark - UICollectionView Delegate--------------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionDatalist.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //如果有闲置的就拿到使用,如果没有,系统自动的去创建
    DetailSubjectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DetailCellId" forIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor clearColor];
    //    cell.layer.borderColor = [UIColor colorWithRed:224 /255.0 green:224 /255.0 blue:224/255.0 alpha:1].CGColor;
    //    cell.layer.borderWidth = .5;
    
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.model = self.collectionDatalist[indexPath.row];
    
    [cell setNeedsLayout];
    return cell;
    

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.selectedIndexPath.row == 0) {
        
        HeaderModel *model = [self.collectionDatalist firstObject];
        [self loadDataup:model];
        
    }
    
    if(self.selectedIndexPath.row == self.collectionDatalist.count - 1){
        HeaderModel *model = [self.collectionDatalist lastObject];
        [self loadDatanext:model];
    }

    
}

#pragma mark - UIScrollView Delegate
//手指离开屏幕时候调用的
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    //velocity :加速状态,可以根据它的值判断滑动方向
    
    if (scrollView == _collectionView) {
        
    //1.获取手足滑动之前表示图的偏移量
    double contentOfSet_x = self.selectedIndexPath.row * (kScreenWidth - 20) - _edge;
    //2.获取手指离开时表示图的偏移量
    double touchEnd_x = scrollView.contentOffset.x;
    
    //3.根据原始的位置和手指离开的位置判断滑动到那一个单元格
    if (velocity.x >= .7 || touchEnd_x - contentOfSet_x >= 70) {
        //-----------向左滑动,要现实右边的视图---------------
        if (self.selectedIndexPath.row < self.collectionDatalist.count - 1) {
            self.selectedIndexPath = [NSIndexPath indexPathForRow:self.selectedIndexPath.row + 1 inSection:0];
        }

        targetContentOffset ->x = self.selectedIndexPath.row * (kScreenWidth - 15) - _edge;

        
    } else if (velocity.x < -0.7 || touchEnd_x - contentOfSet_x < -70) {
        //-----------向右滑动,要现实左侧的视图---------------
        if (self.selectedIndexPath.row > 0) {
            self.selectedIndexPath = [NSIndexPath indexPathForRow:self.selectedIndexPath.row - 1 inSection:0];
        }

        targetContentOffset ->x = self.selectedIndexPath.row * (kScreenWidth - 15) - _edge;

    } else {

       targetContentOffset ->x = self.selectedIndexPath.row * (kScreenWidth - 15) - _edge;

    }
                
        
        
        HeaderModel *model = self.collectionDatalist[self.selectedIndexPath.row];
        self.text = model.infos.title;
        
        HeaderModel *hearder = self.collectionDatalist[self.selectedIndexPath.row];
        NSString *page = [self.indexdic objectForKey:hearder.ID];
        
        if ([page isEqualToString:@"1"]) {
            
            _tableView.footer = nil;
            
            
        }else{
        
    _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upLoad)];
        
        }

        type = 0;
        sgemet.seltedIndex = 0;
        [self removeFooter];
        [_tableView reloadData];
    }


}

- (void)upLoad
{
    
    HeaderModel *hearder = self.collectionDatalist[self.selectedIndexPath.row];
    NSString *useid = [UserDefaults objectForKey:Userid];
    NSString *page = [self.indexdic objectForKey:hearder.ID];
    NSDictionary *params = @{@"member_id":useid,@"page":page,@"key":@"1",@"id":hearder.ID,@"lid":hearder.lid,@"type":self.types};
    
    [WXDataService requestAFWithURL:Url_getSubjectInfo params:params httpMethod:@"POST" finishBlock:^(id result) {
        if(result){
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                
                [_tableView.footer endRefreshing];
                _tableView.footer = nil;
                return;
            
            }
            NSDictionary *dic = result[@"result"];
            HeaderModel *model = self.collectionDatalist[self.selectedIndexPath.row];
            NSArray *myarray1 = dic[@"mp3_list"];
            NSMutableArray *ma = [NSMutableArray array];
            for (NSDictionary *mydic in myarray1) {
                
                Mymodel *mymodel = [[Mymodel alloc] initWithDataDic:mydic];
                [ma addObject:mymodel];

            }
            
            for (int i = 0; i < model.titles.count;i++) {
                
                NSDictionary *dic = model.titles[i];
                NSString *str = [[dic allKeys] firstObject];
                if ([str isEqualToString:@"其他的"]) {
                    
                    NSMutableArray *array = [dic objectForKey:str];
                    [array addObjectsFromArray:ma];
                    NSDictionary *xdic = @{@"其他的":array};
                    [model.titles replaceObjectAtIndex:i withObject:xdic];

                }
            }
            
            if (ma.count == 10){
                
                [self.indexdic setObject:[NSString stringWithFormat:@"%d",[[self.indexdic objectForKey:hearder.ID] intValue] + 1] forKey:hearder.ID];
                
            }else{
                
                [self.indexdic setObject:@"1" forKey:hearder.ID];
            }

            
        }
        
        [_tableView.footer endRefreshing];
        HeaderModel *hearder = self.collectionDatalist[self.selectedIndexPath.row];
        NSString *page = [self.indexdic objectForKey:hearder.ID];
        if ([page isEqualToString:@"1"]) {
            
            _tableView.footer = nil;
            
        }else{
            
            _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upLoad)];
            
        }
        
        type = 0;
        [_tableView reloadData];

        
    } errorBlock:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];


}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{


    DetailSubjectCell *cell = (DetailSubjectCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell buttonAction];
    
}

#pragma mark ----------解题思路-----------
- (void)loadContent
{
    _tableView.footer = nil;
    HeaderModel *hearder = self.collectionDatalist[self.selectedIndexPath.row];
    if (hearder.contents != nil) {
        [self addfooter];

        return;
    }
    NSString *useid = [UserDefaults objectForKey:Userid];
    NSDictionary *params = @{@"member_id":useid,@"page":@"1",@"key":@"3",@"id":hearder.ID,@"lid":hearder.lid,@"type":self.types};
    [WXDataService requestAFWithURL:Url_getSubjectInfo params:params httpMethod:@"POST" finishBlock:^(id result) {
        if(result){
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                
                return;
                
            }
            NSDictionary *dic = result[@"result"];
            HeaderModel *model = self.collectionDatalist[self.selectedIndexPath.row];
            model.contents = dic[@"content"];
            
        type = 1;
            [self addfooter];

        [_tableView reloadData];
        }
        
    } errorBlock:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];



}

#pragma mark ----------相关素材-----------
- (void)loadflies
{
    _tableView.footer = nil;
    HeaderModel *hearder = self.collectionDatalist[self.selectedIndexPath.row];
    if (hearder.files != nil) {
        
        return;
    }
    NSString *useid = [UserDefaults objectForKey:Userid];
    NSDictionary *params = @{@"member_id":useid,@"page":@"1",@"key":@"2",@"id":hearder.ID,@"lid":hearder.lid,@"type":self.types};
    
    [WXDataService requestAFWithURL:Url_getSubjectInfo params:params httpMethod:@"POST" finishBlock:^(id result) {
        if(result){
            if ([[result objectForKey:@"status"] integerValue] == 1) {
                
                [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
                
                return;
                
            }
            
            NSDictionary *dic = result[@"result"];
            HeaderModel *model = self.collectionDatalist[self.selectedIndexPath.row];
            NSArray *array = dic[@"file_list"];
            NSMutableArray *marray = [NSMutableArray array];
            for (NSDictionary *subdic in array) {
                
                FileModel *file = [[FileModel alloc] initWithDataDic:subdic];
                [marray addObject:file];
                
            }
            model.files = marray;
            type = 2;
            [_tableView reloadData];
        }
        
    } errorBlock:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (type == 0) {
        
        WhizkidController *whVC = [[WhizkidController alloc] init];
        HeaderModel *model = self.collectionDatalist[self.selectedIndexPath.row];
        NSDictionary *dic = model.titles[indexPath.section];
        NSArray *array = [[dic allValues] firstObject];
        whVC.model = array[indexPath.row];
        Mymodel *model1 = array[indexPath.row];
        whVC.ID = model1.ID;
        [self.navigationController pushViewController:whVC animated:YES];
        
    }
    
    if (type == 2) {
        HeaderModel *model = self.collectionDatalist[self.selectedIndexPath.row];
         FileModel *file = model.files [indexPath.row];
        FileContentViewController *fileVC = [[FileContentViewController alloc]init];
        fileVC.ID = file.ID;
        [self.navigationController pushViewController:fileVC animated:YES];
    }

}


@end



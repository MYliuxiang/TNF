//
//  CollectionView.m
//  TNF
//
//  Created by 李善 on 15/12/22.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "CollectionView.h"
#import "MycourseViewController.h"
#import "BypredictingViewController.h"
#import "PromotioncourseViewController.h"
#import "MachineController.h"
#import "TPOController.h"
#import "ClassController.h"
#import "WebViewController.h"
@implementation CollectionView

- (instancetype)initWithFrame:(CGRect)frame recommendLisrAry:(NSArray *)recommendLisrAry{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.commListAry = recommendLisrAry;
        //创建
        UICollectionViewFlowLayout *collectionlayout = [[UICollectionViewFlowLayout alloc]init];
        collectionlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        collectionlayout.minimumLineSpacing = 0;
        collectionlayout.minimumInteritemSpacing = 0;
        UICollectionView *collectinView = [[UICollectionView alloc]initWithFrame:CGRectMake(20/2, 0, kScreenWidth-20,self.height) collectionViewLayout:collectionlayout];
        collectinView.backgroundColor = [UIColor clearColor];
        collectinView.delegate = self;
        collectinView.dataSource = self;
        collectinView.backgroundView = nil;
        collectinView.showsHorizontalScrollIndicator = NO;
        collectinView.showsVerticalScrollIndicator = NO;
        collectinView.scrollEnabled = NO;
        NSString *identify = @"colletionCell11";
        collectinView.bounces = NO;
        [collectinView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identify];
        [self addSubview:collectinView];

    }
   
    return self;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _commListAry.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"colletionCell11" forIndexPath:indexPath];

    cell.backgroundColor = [UIColor clearColor];
    NSDictionary *recommeDic = _commListAry[indexPath.row];
    NSString *title = recommeDic[@"title"];
    NSString *img = recommeDic[@"thumb"];
    UIImageView *cellimgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (kScreenWidth-50/2)/2, 80 * ratioHeight)];
//    cellimgView.backgroundColor = UIColor1(蓝);
    [cellimgView sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:nil];
    [cell.contentView addSubview:cellimgView];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0,cellimgView.bottom, cell.width, 80 * ratioHeight / 2)];
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = UIColor6(正文小字);
    label.text = title;
    label.font = [UIFont systemFontOfSize:13*ratioHeight];
    [cell addSubview:label];

//    if (indexPath.row ==0) {
//        
//        UIImageView *vedio = [[UIImageView alloc]initWithFrame:CGRectMake(cell.width-55/2*ratioWidth, label.top-45/2*ratioHeight, ratioWidth*35/2, ratioHeight*25/2)];
//        [cell addSubview:vedio];
//        vedio.image = [UIImage imageNamed:@"play_01"];
//        
//    }
//    
//    if (indexPath.row ==2) {
//        
//        UIImageView *vedio = [[UIImageView alloc]initWithFrame:CGRectMake(cell.width-55/2*ratioWidth, label.top-45/2*ratioHeight, ratioWidth*35/2, ratioHeight*25/2)];
//        [cell addSubview:vedio];
//        vedio.image = [UIImage imageNamed:@"play_01"];
//    }
//    
//    
    return cell;
}


#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个UICollectionView 的大小

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((kScreenWidth - 50 / 2)/2, 250 / 2 * ratioHeight);
}


//定义每个UICollectionView 的边距

//-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section
//
//{
//    if(section %2 == 0){
//        
//         return UIEdgeInsetsMake(0, 0, ratioHeight/2*10, 2.5 * ratioHeight);
//        
//    }else{
//    
//        return UIEdgeInsetsMake(0, 2.5 * ratioHeight, ratioHeight/2*10, 0);
//
//    }
//}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *recommeDic = _commListAry[indexPath.row];
    NSString *type = recommeDic[@"type"];
    NSString *ID = recommeDic[@"relationid"];
    NSString *title = recommeDic[@"title"];
    NSString *url = recommeDic[@"url"];
    /*
    type类型  array(1=>"机经",2=>"分类",3=>"TPO",4=>"课程",5=>"讲座",6=>"题目",7=>"链接");
    url链接 只有当类型为链接时才有值
     */
    
    UIViewController *VC = [self ViewController];

//    "机经
    if ([type integerValue] == 1) {
        //机经预测
        MachineController *machineVC = [[MachineController alloc] init];
        [VC.navigationController pushViewController:machineVC animated:YES];
        return;

    }
    //2=>"分类"
    if ([type integerValue] == 2) {
        //分类练习
        ClassController *classVC = [[ClassController alloc] init];
        [VC.navigationController pushViewController:classVC animated:YES];
        return;

    }
    //3=>"TPO
    if ([type integerValue] == 3) {
        //TPO真题
        TPOController *tpoVC = [[TPOController alloc] init];
        [VC.navigationController pushViewController:tpoVC animated:YES];
        return;

    }
    //4=>"课程"
    if ([type integerValue] == 4) {
        
        PromotioncourseViewController *promoVC = [[PromotioncourseViewController alloc]init];
        promoVC.Videoid = ID;
        [VC.navigationController pushViewController:promoVC animated:YES];
        return;
        
    }
    //5=>"讲座
    if ([type integerValue] == 5) {
        BypredictingViewController *bypredictingVC = [[BypredictingViewController alloc]init];
        bypredictingVC.ID = ID;
        UIViewController *VC = [self ViewController];
        [VC.navigationController pushViewController:bypredictingVC animated:YES];
        return;
    }
    //6=>"题目"
    if ([type integerValue] == 6) {
        
            
        MycourseViewController *mycourseVC = [[MycourseViewController alloc]init];
        UIViewController *VC = [self ViewController];
        [VC.navigationController pushViewController:mycourseVC animated:YES];
        return;
        
    }
    if ([type integerValue] == 7) {
       
        WebViewController *webVC = [[WebViewController alloc] init];
        webVC.text = title;
        webVC.url =  url;
        webVC.ID = ID;
        if([recommeDic[@"is_zhibo"] intValue] == 1)
        {
            webVC.isZhibo = YES;
        }
        UIViewController *VC = [self ViewController];
        [VC.navigationController pushViewController:webVC animated:YES];
        return;
    }
    
    PromotioncourseViewController *promoVC = [[PromotioncourseViewController alloc]init];
    promoVC.Videoid = ID;
    [VC.navigationController pushViewController:promoVC animated:YES];
    

    
}


@end

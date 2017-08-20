//
//  BaseViewController.m
//  Familysystem
//
//  Created by 李立 on 15/8/21.
//  Copyright (c) 2015年 LILI. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseNavigationController.h"
#import "MachineController.h"
#import "ClassController.h"
#import "TPOController.h"
#import "FuYuanViewController.h"
#import "TiShengViewController.h"
#import "MycourseViewController.h"
#import "WhizkidController.h"
#import "DetailsubjectController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (iamgeView != nil) {
        [iamgeView removeFromSuperview];
    }
    
    //消息推送通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kviewNSNotificationAction1:) name:YOUPAINOTICE object:nil];
    
}



- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    if (iamgeView != nil) {
        [iamgeView removeFromSuperview];
    }
}




- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    iamgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, kScreenWidth, kScreenHeight)];
    iamgeView.image = [self getSnapshotImage];
    [self.view addSubview:iamgeView];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:YOUPAINOTICE object:nil];

    
}


- (void)kviewNSNotificationAction1:(NSNotification *)notification
{
    _objectDic = notification.object;
   NSString *op = [_objectDic objectForKey:@"op"];

        NSString * alert = _objectDic[@"aps"][@"alert"];
   if ([alert isKindOfClass:[NSString class]]) {
            aleer = [[UIAlertView alloc]initWithTitle:alert message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            aleer.tag = 100;
       if([self isMemberOfClass:[WhizkidController class]]){
           return;
       }
       if([self isKindOfClass:[DetailsubjectController class]])
       {
           return;
       }
    if ([op isEqualToString:@"getPracticeList1"]) {
            //机经预测列表
            if([self isMemberOfClass:[MachineController class]]){
                return;
            }
        
        }else if ([op isEqualToString:@"getPracticeList2"]){
                //分类练习列表
                if([self isMemberOfClass:[ClassController class]]){
                    return;
        
                }
        
        }else if ([op isEqualToString:@"getPracticeList3"]){
                //TPO真题列表
                if([self isMemberOfClass:[TPOController class]]){
        
                    return;
                }
        
        }else if ([op isEqualToString:@"getZhiboList"]){
                //直播
                if([self isMemberOfClass:[TiShengViewController class]]){
        
                    return;
                }
        
        }else if ([op isEqualToString:@"myCourseList"]){
                //课程
                if([self isMemberOfClass:[MycourseViewController class]]){
                    return;
                }
        
        
        }else if ([op isEqualToString:@"getMyAmount"]){
                //积分
                if([self isMemberOfClass:[FuYuanViewController class]]){
                    return;
                }
        
        
        }else if([op isEqualToString:@"mp3Details"]){
        
                if([self isMemberOfClass:[WhizkidController class]]){
                    return;
                }
            
        }
        
            [aleer show];
}
        //    /*
        //     aps =     {
        //     alert = 12345;
        //     sound = default;
        //     };
        //     id = 35;
        //     "member_id" = 1;
        //     op = mp3Details;
        //     
        //     机经
        //     分类
        //     TPO
        //     课程
        //     直播课
        //     积分
        //     
        //     */
        //
        //

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
               NSString *op = [_objectDic objectForKey:@"op"];
        if ([op isEqualToString:@"getPracticeList1"]) {
            //机经预测列表
            if([self isMemberOfClass:[MachineController class]]){
                
                return;
            }
            MachineController *machineVC = [[MachineController alloc] init];
            [self.navigationController pushViewController:machineVC animated:YES];
            
            
        }else if ([op isEqualToString:@"getPracticeList2"]){
            //分类练习列表
            if([self isMemberOfClass:[ClassController class]]){
                
                return;
            }
            ClassController *classVC = [[ClassController alloc] init];
            [self.navigationController pushViewController:classVC animated:YES];
            
        }else if ([op isEqualToString:@"getPracticeList3"]){
            //TPO真题列表
            if([self isMemberOfClass:[TPOController class]]){
                
                return;
            }
            TPOController *tpoVC = [[TPOController alloc] init];
            [self.navigationController pushViewController:tpoVC animated:YES];
            
        }else if ([op isEqualToString:@"getZhiboList"]){
            //直播
            if([self isMemberOfClass:[TiShengViewController class]]){
                
                return;
            }
            TiShengViewController *tisheVC = [[TiShengViewController alloc] init];
            [self.navigationController pushViewController:tisheVC animated:YES];
            
        }else if ([op isEqualToString:@"myCourseList"]){
            //课程
            if([self isMemberOfClass:[MycourseViewController class]]){
                
                return;
            }
            MycourseViewController *myVC = [[MycourseViewController alloc] init];
            [self.navigationController pushViewController:myVC animated:YES];
            
        }else if ([op isEqualToString:@"getMyAmount"]){
            //积分
            if([self isMemberOfClass:[FuYuanViewController class]]){
                
                return;
            }
            FuYuanViewController *fuyuanVC = [[FuYuanViewController alloc] init];
            [self.navigationController pushViewController:fuyuanVC animated:YES];
            
        }else if([op isEqualToString:@"mp3Details"]){
            
            if([self isMemberOfClass:[WhizkidController class]]){
                //                [[NSNotificationCenter defaultCenter] postNotificationName:Noti_tiaozhuan object:[_objectDic objectForKey:@"id"]];
                //                 return;
            }
            
            WhizkidController *whVC = [[WhizkidController alloc] init];
            whVC.ID = [_objectDic objectForKey:@"id"];
            [self.navigationController pushViewController:whVC animated:YES];
        }else{
            if([self isMemberOfClass:[FuYuanViewController class]]){
                
                return;
            }
            FuYuanViewController *fuyuanVC = [[FuYuanViewController alloc] init];
            [self.navigationController pushViewController:fuyuanVC animated:YES];
            
            
            
        }
    }
    
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (iamgeView != nil) {
        [iamgeView removeFromSuperview];
    }

}

- (UIImage *)getSnapshotImage {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)), NO, 1);
    [[UIApplication sharedApplication].keyWindow drawViewHierarchyInRect:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) afterScreenUpdates:NO];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshot;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 禁用 iOS7 返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]init];
     self.navigationController.navigationBar.hidden = NO;
    barButtonItem.title = @" 22  ";
    self.navigationItem.backBarButtonItem = barButtonItem;
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = UIColor2(灰色背景);
    
}

#pragma mark  -- -标题 ---------
- (void)setText:(NSString *)text
{
    _text = text;
    //设置导航栏的标题
    
    UILabel *titleText = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 0, 44)];
    titleText.backgroundColor = [UIColor clearColor];
    titleText.textColor=[UIColor whiteColor];
    [titleText setFont:[UIFont systemFontOfSize:18]];
    titleText.textAlignment = NSTextAlignmentCenter;
    [titleText setText:_text];
    self.navigationItem.titleView=titleText;
    self.navigationItem.title = text;

}



#pragma mark ---- 添加筛选按钮 ---------------
- (void)addrightItem_shaixuan
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 42 / 2.0, 42 / 2.0);
    //        [button setTitle:@"返 回" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"b_filter"] forState:UIControlStateNormal];
    //    button.backgroundColor = [UIColor redColor];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(shaixuanAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    // 添加到当前导航控制器上
    self.navigationItem.rightBarButtonItem = backItem;
    
}

- (void)shaixuanAction
{
    
    NSLog(@"筛选");
    
}

#pragma mark ---- 添加菜单按钮
- (void)addleftItem_Menu
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 42 / 2.0, 42 / 2.0);
    //        [button setTitle:@"返 回" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"b_nav"] forState:UIControlStateNormal];
//    button.backgroundColor = [UIColor redColor];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    // 添加到当前导航控制器上
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    
}


#pragma mark ---- 添加日历选择
- (void)addrightItem_date
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 42 / 2.0, 42 / 2.0);
    //        [button setTitle:@"返 回" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"b_date"] forState:UIControlStateNormal];
    //    button.backgroundColor = [UIColor redColor];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(dateAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    // 添加到当前导航控制器上
    self.navigationItem.rightBarButtonItem = backItem;
    
}

- (void)dateAction
{

    NSLog(@"日历");

}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







@end

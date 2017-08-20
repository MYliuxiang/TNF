//
//  BaseNavigationController.m
//  Familysystem
//
//  Created by 李立 on 15/8/21.
//  Copyright (c) 2015年 LILI. All rights reserved.
//

#import "BaseNavigationController.h"


@interface BaseNavigationController ()


@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
    
    
    //设置系统返回按钮的颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    //取消导航栏的透明效果
    self.navigationBar.translucent = NO;
    self.delegate = self;
    
    //设置导航栏的样式
    //    self.navigationBar.barStyle = UIBarStyleBlack;
    
    //设置导航栏的背景图片

    [self.navigationBar setBarTintColor:[MyColor colorWithHexString:@"#1c1c1c"]];
//    [self.navigationBar setTintColor:[UIColor yellowColor]];
//    self.navigationBar.barTintColor = [UIColor blueColor];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(BOOL)shouldAutorotate
{
    return NO;
    
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
//    return self.orietation;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}


@end

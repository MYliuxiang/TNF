//
//  BaseViewController.h
//  Familysystem
//
//  Created by 李立 on 15/8/21.
//  Copyright (c) 2015年 LILI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController<UIAlertViewDelegate>

{
    UIImageView *iamgeView;
    UIAlertView *aleer;


}
@property (nonatomic,retain)NSDictionary *objectDic;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,assign)BOOL iswhite;


//添加菜单按钮
- (void)addleftItem_Menu;

//添加日历选择
- (void)addrightItem_date;

- (void)dateAction;


//添加筛选按钮
- (void)addrightItem_shaixuan;

- (void)shaixuanAction;

@end

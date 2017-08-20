//
//  AppDelegate.h
//  TNF
//
//  Created by 刘翔 on 15/12/15.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetWorkManager.h"
#import "UMSocial.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,NetWorkManagerDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong)NetWorkManager *networkManager;

@property (nonatomic,retain)UIImageView *imageView;
@property (nonatomic,retain)NSDictionary *objectDic;
@end


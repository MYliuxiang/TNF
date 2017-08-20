//
//  HHViewController.h
//  TNF
//
//  Created by 刘翔 on 15/12/16.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "BaseViewController.h"
#import "TFYSmodel.h"

@interface TFViewController : BaseViewController
@property(nonatomic,copy)NSString *titleType;
@property(nonatomic,assign)CGFloat Collectionbottom;
@property(nonatomic,assign)NSInteger service;
@property(nonatomic,strong)TFYSmodel *TFYFmodel;

@end

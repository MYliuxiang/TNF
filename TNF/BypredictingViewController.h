//
//  BypredictingViewController.h
//  TNF
//
//  Created by 李立 on 15/12/21.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "BaseViewController.h"

@protocol BypredictingViewControllerDegatele <NSObject>

- (void)suanxinDown;

@end

@interface BypredictingViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *bypredictiTabelView;
@property(nonatomic,strong)TabBarItem *tab;
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *teacherID;
@property(nonatomic,strong)NSString *moenyCost;


@property(nonatomic,weak)id<BypredictingViewControllerDegatele>delegate;

@end

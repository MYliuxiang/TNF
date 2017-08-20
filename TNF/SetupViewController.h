//
//  SetupViewController.h
//  TNF
//
//  Created by 李立 on 15/12/17.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "BaseViewController.h"

@interface SetupViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *setupTableView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)NSArray *images;
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)NSArray *titles1;
@property(nonatomic,strong)UILabel *dimingLabel;
@property(nonatomic,strong)UIImageView *touxiangImageView;
@property(nonatomic,strong) UILabel *banbenLabel;
@property(nonatomic,strong) UILabel *label1;
@property(nonatomic,strong) UILabel *label2;
@property(nonatomic,strong) UILabel *label3;
@end

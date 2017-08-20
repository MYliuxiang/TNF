//
//  BillViewController.h
//  TNF
//
//  Created by 李立 on 15/12/18.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "BaseViewController.h"

@interface BillViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)UITableView *billTabelView;

@end

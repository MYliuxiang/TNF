//
//  FuYuanViewController.h
//  TNF
//
//  Created by 李立 on 15/12/17.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "BaseViewController.h"
#import "UMSocial.h"

@interface FuYuanViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate>
{
    UIView *bjview;

}
@property(nonatomic,strong)UITableView *fuyuanTableview;
@property(nonatomic,strong)NSArray *imageViews;
@property(nonatomic,strong)NSArray *titiles;
@property(nonatomic,strong)UILabel *label1;
@property(nonatomic,strong)NSArray *datelist;
@end

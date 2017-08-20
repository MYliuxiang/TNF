//
//  TrainingrecordViewController.h
//  TNF
//
//  Created by 李立 on 15/12/17.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "BaseViewController.h"

@interface TrainingrecordViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIView *bjview;
    UILabel *tishiLabel;
}

@property(nonatomic,strong)UITableView *trainingTableView;
@property(nonatomic,retain)UIImageView *imageView;
@property (nonatomic,strong)NSString *zongshu;
@property (nonatomic,strong)NSString *addtime;


@end

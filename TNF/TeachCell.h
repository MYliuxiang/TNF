//
//  TeachCell.h
//  TNF
//
//  Created by 李立 on 16/1/9.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJHongbaoAlertView.h"
#import "BgView4.h"

@interface TeachCell : UITableViewCell<LJDelegate,BgView4delegate>
{
    UILabel *titleLabel;
    UIImageView *headerImage;
    UIButton *button;
    
}
@property(nonatomic,copy)NSString *Url;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,retain)NSArray *mp3_list;
@property(nonatomic,copy)NSString *teacher_member_id;
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,assign)BOOL isDa;
@property(nonatomic,assign)BOOL ISDASHANG;


@end

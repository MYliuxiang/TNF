//
//  SbjectCell.h
//  TNF
//
//  Created by 李立 on 16/1/9.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecoderView.h"

@interface SbjectCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIScrollViewDelegate,RecordViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray  *_allMessagesFrame;
    UITextView *_messageField;
    UIView *view;
    UIButton *senderButton;
    RecoderView *recode;
}

@property(nonatomic,retain)NSArray *dataList;
@property(nonatomic,assign)BOOL isSelf;
@property(nonatomic,copy)NSString *ID;

@end

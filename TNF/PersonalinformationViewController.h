//
//  PersonalinformationViewController.h
//  TNF
//
//  Created by 李立 on 15/12/17.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "BaseViewController.h"

@interface PersonalinformationViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>


@property(nonatomic,strong)UITableView *personalinfTableView;
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong) UITextField *field;
@property(nonatomic,strong)UIButton *baocunbutton;
@property(nonatomic,strong)NSArray *datelist;
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)NSArray *proTimeList;
@property(nonatomic,strong)UILabel *pickLabel;
@property(nonatomic,strong)UIView *view1;
@property(nonatomic,strong)UITextField *iphoneLabel;
@property(nonatomic,strong)UITextField *nameLabel;
@property(nonatomic,strong)UITextField *weixinField;
@property(nonatomic,strong)UITextField *app_addressField;
@property(nonatomic,strong)UITextField *educationField;

@end

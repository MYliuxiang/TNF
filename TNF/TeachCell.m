//
//  TeachCell.m
//  TNF
//
//  Created by 李立 on 16/1/9.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "TeachCell.h"
#import "PlayView.h"
#import "BgView4.h"
#import "FuYuanViewController.h"

@implementation TeachCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //1.创建子视图
        [self initCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)initCell
{
    headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30 * ratioHeight, 30 * ratioHeight)];
    headerImage.layer.masksToBounds = YES;
    headerImage.layer.cornerRadius = 15 * ratioHeight;
    headerImage.backgroundColor = [UIColor clearColor];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:self.dic[@"headimgurl"]]];
    [self addSubview:headerImage];
    
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(headerImage.right + 10, headerImage.top, kScreenWidth - 200, headerImage.height)];
    titleLabel.font =  [UIFont fontWithName:@"Arial" size:15*ratioHeight];
    titleLabel.text = @"kiki mike";
    titleLabel.textColor = [UIColor blackColor];
    [self addSubview:titleLabel];

    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kScreenWidth - 60 - 20, 30, 60, 30);
    button.backgroundColor = UIColor3(金色);
    [button setTitle:@"打赏" forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 15;
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(buttonAC:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];

}



- (void)buttonAC:(UIButton *)sender
{
    [WXDataService requestAFWithURL:Url_getGaveTeacher params:nil httpMethod:@"POST" finishBlock:^(id result) {
        NSLog(@"result==:%@",result);
        if ([[result objectForKey:@"status"] integerValue] == 0) {
            
            NSDictionary *subDic = result[@"result"];
            NSArray *array = subDic[@"list"];
            
            NSMutableArray *muArray = [NSMutableArray new];
            for (int i = 0;i < array.count; i ++) {
                [muArray addObject:[NSString stringWithFormat:@"%@",array[i]]];
            }
            NSArray * array1 = muArray;
            
            LJHongbaoAlertView *liView = [[LJHongbaoAlertView alloc]initWithFrame:CGRectMake(20 * ratioWidth, (kScreenHeight - 195 * ratioHeight ) / 2.0, kScreenWidth  - 20 * ratioWidth * 2 , 195 * ratioHeight) monenyArray:array1 title:subDic[@"title"] text:subDic[@"text"] delegate:self];
            [[self ViewController].view addSubview:liView];
//            [[[UIApplication sharedApplication] keyWindow] addSubview:liView];
        }
        //请求失败
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
        }
        
        
    } errorBlock:^(NSError *error) {
        
    }];


}

#pragma mark -------LJDelegale ---------------------
- (void)selecetmoeny:(NSString *)moeny
{

    [WXDataService requestAFWithURL:Url_setGaveTeacherMP3 params:@{@"cost":moeny,@"teacher_id":self.teacher_member_id,@"id":self.ID,@"member_id":[UserDefaults objectForKey:Userid]} httpMethod:@"POST" finishBlock:^(id result) {
        NSLog(@"result==:%@",result);
        if ([[result objectForKey:@"status"] integerValue] == 0) {
            [MBProgressHUD showSuccess:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            self.ISDASHANG = YES;
            return ;
        }
        //请求失败
        if ([[result objectForKey:@"status"] integerValue] == 1) {
            
            BgView4 *view = [[BgView4 alloc]initWithFrame:CGRectMake(20 * ratioWidth, (kScreenHeight - 180 * ratioHeight ) / 2.0, kScreenWidth  - 20 * ratioWidth * 2 , 180 * ratioHeight) Title:@"您的福币不够了" Delegate:self Mycost:@"" Cost:[NSString stringWithFormat:@"你目前拥有%@个福币",result[@"result"][@"amount"]]];
            [[self ViewController].view addSubview:view];
            
//                        [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
            
        }
        
    } errorBlock:^(NSError *error) {
        
    }];
}

//------获取福币  BgView4delegate-----
- (void)selecetbtn
{
    FuYuanViewController * fuFuYuan = [[FuYuanViewController alloc]init];
    [[self ViewController].navigationController pushViewController:fuFuYuan animated:YES];
    
    
}

- (void)setIsDa:(BOOL)isDa
{
    _isDa = isDa;
    button.hidden = _isDa;

}

- (void)setISDASHANG:(BOOL)ISDASHANG
{
    _ISDASHANG = ISDASHANG;
    if(self.ISDASHANG){
        
    [button setTitle:@"已打赏" forState:UIControlStateNormal];
        button.backgroundColor = UIColor4(所有的灰色);
    button.enabled = NO;
        
    }else{
        [button setTitle:@"打赏" forState:UIControlStateNormal];
        button.backgroundColor = UIColor3(金色);
        button.enabled = YES;
        
    }


}


- (void)setMp3_list:(NSArray *)mp3_list
{
    _mp3_list = mp3_list;
    for (int i = 0; i < mp3_list.count; i++) {
        
       PlayView *playView = [[PlayView alloc] initWithFrame:CGRectMake(titleLabel.left, titleLabel.bottom + (10 + 25) * i, kScreenWidth / 2.0, 25)];
        playView.backgroundColor = [UIColor yellowColor];
        NSDictionary *dic = self.mp3_list[i];
        playView.contentURL = dic[@"mp3"];
        [self addSubview:playView];

    }

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [headerImage sd_setImageWithURL:[NSURL URLWithString:self.Url]];
    titleLabel.text = self.title;
    
    
    

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end



























//
//  TopCell.m
//  MyMovie
//
//  Created by zsm on 14-8-23.
//  Copyright (c) 2014年 zsm. All rights reserved.
//

#import "TopCell.h"

@implementation TopCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _initViews];
    }
    return self;
    
}

- (void)_initViews
{
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth / 2.0 - 12.5 , 65 * ratioHeight)];
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view];
    
    titleLabel  = [[UILabel alloc] initWithFrame:CGRectMake(0, 15 * ratioHeight, view.width, 17)];
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"人物类";
    [view addSubview:titleLabel];
    
    conentLabel  = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel.bottom + 10, view.width, 13)];
    conentLabel.font = [UIFont systemFontOfSize:13];
    conentLabel.textAlignment = NSTextAlignmentCenter;
    conentLabel.textColor = [MyColor colorWithHexString:@"#555555"];
    conentLabel.text = @"共13题/已练1";
    [view addSubview:conentLabel];
    
    
}

- (void)setIsFist:(BOOL)isFist
{
    _isFist = isFist;
    if (_isFist) {
        
        view.left = 10;

    }else{
    
        view.left = 2.5;

    }
    
    

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    titleLabel.text = self.list.title;
    conentLabel.text = [NSString stringWithFormat:@"共%@题/已练%@",self.list.count_total,self.list.count_finish];
    
}

@end

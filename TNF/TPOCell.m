//
//  TPOCell.m
//  TNF
//
//  Created by 刘翔 on 15/12/28.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "TPOCell.h"

@implementation TPOCell

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

    bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, (kScreenWidth - 25) / 2.0, 60 * ratioHeight)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15 * ratioHeight, bgView.width, 15 * ratioHeight)];
    titleLabel.textColor = [UIColor blackColor];;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:15 * ratioHeight];
    [self addSubview:titleLabel];
    
    label1 = [[UIImageView alloc] initWithFrame:CGRectMake((bgView.width) / 2.0 - 43 * ratioHeight, titleLabel.bottom + 10 * ratioHeight, 6 * ratioHeight, 6 * ratioHeight)];
    label1.backgroundColor = UIColor4(所有的灰色);
    label1.layer.masksToBounds = YES;
    label1.layer.cornerRadius = 3 * ratioHeight;
    [bgView addSubview:label1];
    
    label2 = [[UIImageView alloc] initWithFrame:CGRectMake(label1.right + 10 * ratioHeight, titleLabel.bottom + 10 * ratioHeight, 6 * ratioHeight, 6 * ratioHeight)];
    label2.backgroundColor = UIColor4(所有的灰色);
    label2.layer.masksToBounds = YES;
    label2.layer.cornerRadius = 3 * ratioHeight;
    [bgView addSubview:label2];
    
    label3 = [[UIImageView alloc] initWithFrame:CGRectMake(label2.right + 10 * ratioHeight, titleLabel.bottom + 10 * ratioHeight, 6 * ratioHeight, 6 * ratioHeight)];
    label3.backgroundColor = UIColor4(所有的灰色);
    label3.layer.masksToBounds = YES;
    label3.layer.cornerRadius = 3 * ratioHeight;
    [bgView addSubview:label3];
    
    label4 = [[UIImageView alloc] initWithFrame:CGRectMake(label3.right + 10 * ratioHeight, titleLabel.bottom + 10 * ratioHeight, 6 * ratioHeight, 6 * ratioHeight)];
    label4.backgroundColor = UIColor4(所有的灰色);
    label4.layer.masksToBounds = YES;
    label4.layer.cornerRadius = 3 * ratioHeight;
    [bgView addSubview:label4];
    
    
    label5 = [[UIImageView alloc] initWithFrame:CGRectMake(label4.right + 10 * ratioHeight, titleLabel.bottom + 10 * ratioHeight, 6 * ratioHeight, 6 * ratioHeight)];
    label5.backgroundColor = UIColor4(所有的灰色);
    label5.layer.masksToBounds = YES;
    label5.layer.cornerRadius = 3 * ratioHeight;
    [bgView addSubview:label5];
    
    label6 = [[UIImageView alloc] initWithFrame:CGRectMake(label5.right + 10 * ratioHeight, titleLabel.bottom + 10 * ratioHeight, 6 * ratioHeight, 6 * ratioHeight)];
    label6.backgroundColor = UIColor4(所有的灰色);
    label6.layer.masksToBounds = YES;
    label6.layer.cornerRadius = 3 * ratioHeight;
    [bgView addSubview:label6];
    

    
}


- (void)setModel:(TPOModel *)model
{

    _model = model;
    titleLabel.text = _model.title;
        if (self.type == 0) {
            bgView.left = 10;
            titleLabel.left = 10;
        }else{
    
            bgView.left = 2.5;
            titleLabel.left = 2.5;
    
        }

    for (int i = 0; i < model.lists.count; i++) {
        TPOList  *list = model.lists[i];
        if (i == 0) {
            
            if ([list.Is_practice boolValue]) {
                
                label1.backgroundColor = UIColor1(蓝);
            }else{
                
                label1.backgroundColor = UIColor4(所有的灰色);
                
            }
            
        }else if (i == 1){
            
            if ([list.Is_practice boolValue]) {
                label2.backgroundColor = UIColor1(蓝);
            }else{
                label2.backgroundColor = UIColor4(所有的灰色);
                
            }
            
            
        }else if (i == 2){
            
            if ([list.Is_practice boolValue]) {
                label3.backgroundColor = UIColor1(蓝);
            }else{
                label3.backgroundColor = UIColor4(所有的灰色);
                
            }
            
            
        }else if (i == 3){
            
            if ([list.Is_practice boolValue]) {
                label4.backgroundColor = UIColor1(蓝);
            }else{
                label4.backgroundColor = UIColor4(所有的灰色);
                
            }
            
            
        }else if (i == 4){
            
            if ([list.Is_practice boolValue]) {
                label5.backgroundColor = UIColor1(蓝);
            }else{
                label5.backgroundColor = UIColor4(所有的灰色);
                
            }
            
            
        }else if (i == 5){
            
            if ([list.Is_practice boolValue]) {
                label6.backgroundColor = UIColor1(蓝);
            }else{
                label6.backgroundColor = UIColor4(所有的灰色);
                
            }
            
            
        }
        
        
    }


}


@end

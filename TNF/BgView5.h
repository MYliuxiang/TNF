//
//  BgView5.h
//  TNF
//
//  Created by 李善 on 15/12/18.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BgView5delegate<NSObject>

//代理方法

@end

@interface BgView5 : UIView{
    
    
}

@property(nonatomic,weak)id<BgView5delegate>BgViewdelegate;

- (instancetype)initWithFrame:(CGRect)frame
                        Title:(NSString *)title
                      ImgNames:(NSArray *)imgNames
               bgviewdelegate:(id<BgView5delegate>)delegate
                         Text:(NSString *)text
                        Text1:(NSString*)text1;

@end

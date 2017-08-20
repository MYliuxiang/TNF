//
//  BgView3.h
//  TNF
//
//  Created by 李善 on 15/12/18.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BgView3delegate<NSObject>

- (void)lingquClik;
//代理方法

@end

@interface BgView3 : UIView{

 
}

@property(nonatomic,weak)id<BgView3delegate>BgViewdelegate;

- (instancetype)initWithFrame:(CGRect)frame
                        Title:(NSString *)title
                      ImgName:(NSString *)imgName
               bgviewdelegate:(id<BgView3delegate>)delegate
                         Text:(NSString *)text
                        Text1:(NSString*)text1;

@end

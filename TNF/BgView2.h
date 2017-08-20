//
//  BgView2.h
//  TNF
//
//  Created by 李善 on 15/12/18.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BgView2delegate<NSObject>

//代理方法

@end

@interface BgView2 : UIView

@property(nonatomic,weak)id<BgView2delegate>BgViewdelegate;

- (instancetype)initWithFrame:(CGRect)frame
                        Title:(NSString *)title
                         Text:(NSString *)text
                        Text1:(NSString*)text1;

@end

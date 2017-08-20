//
//  BgView4.h
//  TNF
//
//  Created by 李善 on 15/12/18.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BgView4delegate<NSObject>

//代理方法
- (void)selecetbtn;

@end

@interface BgView4 : UIView{
    
    UIView *_bgView;
    UIView *_whiteView;
    
}

@property(nonatomic,weak)id<BgView4delegate>BgViewdelegate;

- (instancetype)initWithFrame:(CGRect)frame
                        Title:(NSString *)title
                     Delegate:(id<BgView4delegate>)delegate
                       Mycost:(NSString *)mycost
                        Cost:(NSString*)cost;

@end

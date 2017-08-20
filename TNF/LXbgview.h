//
//  LXbgview.h
//  TNF
//
//  Created by 刘翔 on 16/1/4.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LXbgviewDelegate<NSObject>

//代理方法
- (void)clickOK;

@end

@interface LXbgview : UIView

@property(nonatomic,weak)id<LXbgviewDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame
                        Title:(NSString *)title
                         Text:(NSString *)text
                     delegate:(id<LXbgviewDelegate>)delegate;

@end

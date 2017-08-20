//
//  BgView1.h
//  TNF
//
//  Created by 李善 on 15/12/18.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BgView1delegate<NSObject>

- (void)amount1;

@end

@interface BgView1 : UIView

@property(nonatomic,weak)id<BgView1delegate>BgViewdelegate;
@property(nonatomic,copy)NSString *amount;

- (instancetype)initWithFrame:(CGRect)frame
                        TodayFubi:(NSString *)TodayFubi
                       TomorrowFubi:(NSString *)TomorrowFubi;

@end



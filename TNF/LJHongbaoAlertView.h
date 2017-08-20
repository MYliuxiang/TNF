//
//  LJHongbaoAlertView.h
//  TNF
//
//  Created by lijiang on 15/12/24.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LJDelegate <NSObject>


- (void)selecetmoeny:(NSString *)moeny;


@end
@interface LJHongbaoAlertView : UIView
{
    UIView *_bgView;
    UIView *_whiteView;
    NSArray *_dataArray;

}
@property(nonatomic,weak)id<LJDelegate>ljdelegate;

- (id)initWithFrame:(CGRect)frame
        monenyArray:(NSArray *)monenyArray
              title:(NSString *)title
               text:(NSString *)text
           delegate:(id)delegate;

@end

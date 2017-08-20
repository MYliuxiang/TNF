//
//  LXSgement.h
//  TNF
//
//  Created by 刘翔 on 15/12/22.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LXDelegate <NSObject>


- (void)clickindex:(int)index;


@end


@interface LXSgement : UIView
{
    UIImageView *seltedImageView;
    UIView *bgView;

}
@property(nonatomic,weak)id<LXDelegate> delegate;
@property(nonatomic,strong)NSArray *titlesArray;
@property(nonatomic,assign)int seltedIndex;
- (id)initWithFrame:(CGRect)frame
              titles:(NSArray *)titles
        normalColor:(UIColor *)normalColor
      selectedColor:(UIColor *)selectedColor
        bottomColor:(UIColor *)bottomColor
      divisionColor:(UIColor *)divisionColor;


@end

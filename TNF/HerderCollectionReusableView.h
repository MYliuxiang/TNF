//
//  HerderCollectionReusableView.h
//  XINRUE
//
//  Created by yunhe on 14/12/23.
//  Copyright (c) 2014年 yunhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopViewDelegate <NSObject>


- (void)clickindex:(int)index;


@end

@interface HerderCollectionReusableView : UICollectionReusableView<LXDelegate>
{
    UIImageView *_imageView;
    UILabel *label1;
    UILabel *label2;

    
}
@property(nonatomic,weak)id<TopViewDelegate> delegate;
@property(nonatomic,retain)NSArray *titles;
@property(nonatomic,copy)NSString *text1;
@property(nonatomic,copy)NSString *text2;
@property(nonatomic,copy)NSString *url;



@end

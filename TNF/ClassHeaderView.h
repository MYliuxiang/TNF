//
//  ClassHeaderView.h
//  TNF
//
//  Created by 刘翔 on 15/12/27.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassHeaderView : UICollectionReusableView
{
    UILabel *label1;
    UILabel *label2;

}
@property(nonatomic,copy)NSString *text1;
@property(nonatomic,copy)NSString *text2;

@end

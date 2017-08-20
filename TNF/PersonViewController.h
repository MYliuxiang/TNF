//
//  PersonViewController.h
//  TNF
//
//  Created by 李江 on 15/12/27.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "BaseViewController.h"
#import "LXSgement.h"
@interface PersonViewController : BaseViewController
{
    UIView *footerView;


}
- (id)initWithIsHaveSgemengt:(BOOL)isHaveSgemengt
              IshavePlayView:(BOOL)ishavePlayView
                         Url:(NSString *)url
                          ID:(NSString *)ID
                   texttitle:(NSString *)texttitle;

@property (nonatomic,assign)BOOL isHaveSgemengt;
@property (nonatomic,assign)BOOL ishavePlayView;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *url;
@property (nonatomic,assign)BOOL ishaveweilian;
@property (nonatomic,retain)UIImageView *imageView;
@property (nonatomic,strong)NSString *imageUrl;
@property (nonatomic,strong)NSString *VidioUrl;


@end

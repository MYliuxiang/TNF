//
//  FileContentViewController.h
//  TNF
//
//  Created by 李江 on 16/1/14.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "BaseViewController.h"

@interface FileContentViewController : BaseViewController<UIWebViewDelegate>

@property (nonatomic,strong)NSString *ID;

@property (nonatomic,strong)UIWebView *webView;

@end

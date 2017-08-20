//
//  WebViewController.h
//  TNF
//
//  Created by 李立 on 16/1/9.
//  Copyright © 2016年 刘翔. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController<UIWebViewDelegate>
{
    UIWebView *_webView;
    
    UIActivityIndicatorView *_actView;  //风火轮视图
    
}
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,assign)BOOL isZhibo;
@end

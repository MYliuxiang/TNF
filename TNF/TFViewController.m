//
//  HHViewController.m
//  TNF
//
//  Created by 刘翔 on 15/12/16.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#import "TFViewController.h"
#import "BgView.h"
#import "StarView.h"
#import "SetupViewController.h"
#import "TrainingrecordViewController.h"
#import "BgView2.h"
#import "TagViewController.h"
#import "OralController.h"
#import "BaseNavigationController.h"
#import "FuYuanViewController.h"
#import "CollectionView.h"
#import  "TiShengViewController.h"
#import "Bgmodel.h"
#import "TFYSmodel.h"
#import "BgView1.h"
#import "LDZMoviePlayerController.h"
#import "ProformainformationViewController.h"
#import "FXBlurView.h"
#import "UIImage+BoxBlur.h"

#define kImageHeight ratioHeight*472/2

@interface TFViewController ()<UITableViewDataSource,UITableViewDelegate,BgView1delegate,BgViewdelegate>
{

    UIView *_ViodeView;
    UILabel *_yuandian;
    UIButton *Daybutton;
    UILabel *prompt;
    UILabel *dayLabel;
}
@end


@implementation TFViewController
{

    UIImageView *imgView;
    UITableView *_tableview;
    NSString *_identify;
    UIImageView *clearimgView;
    UIView *_cell;
    UILabel *_FBlabel;
    NSArray *_dataArray;
    UIView *_allView;
    CGFloat _float_y;
}


- (void)dealloc{

    NSLog(@"该控制器被销毁了");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    iamgeView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
   self.navigationController.navigationBar.hidden = YES;
   
    UIImage *image = [UIImage imageNamed:@""];
    [self.navigationController.navigationBar setBackgroundImage:image
                                                  forBarMetrics:UIBarMetricsCompact];
    
    NSString *su= [UserDefaults objectForKey:subject];
    if([su intValue] == 1 || [su intValue] == 2)
    {
        self.service = 1;
        [self Mydataservice];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [MyColor colorWithHexString:@"0x000000"];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(VideoDonghua) name:Noti_VideoDonghua object:nil];
    //创建tabelew视图
    [self createTablewView];
    //创建口语练习button
    [self Speackbutton];
    [self CreateBjView];
    
    
    _ViodeView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth-70*ratioWidth/2, ratioHeight*472/2 + ratioHeight*50/2 , ratioWidth*40/2, ratioWidth*40/2)];
    _ViodeView.alpha = 0;
    _ViodeView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_ViodeView];

//    [self Mydataservice];
}

//通知动画
- (void)VideoDonghua
{

    [UIView animateWithDuration:.5 animations:^{
        
        _ViodeView.height = ratioWidth*40/2;
        _ViodeView.width = ratioWidth*40/2;
        _ViodeView.left = kScreenWidth-70*ratioWidth/2;
        _ViodeView.top = _float_y;
    } completion:^(BOOL finished) {
        _ViodeView.alpha = 0;
    }];



}


//签到
- (void)SignFubi{

    if ([_TFYFmodel.isSignIn integerValue]==0) {
        NSString *su= [UserDefaults objectForKey:subject];
        if([su intValue] != 0) {
            NSString *amountSignInTo= [NSString stringWithFormat:@"每日练题好礼相送 \n 明日奖励预告:+%@个福币",_TFYFmodel.amountSignInTo];
            BgView1 *bg1 = [[BgView1 alloc]initWithFrame:self.view.frame TodayFubi:_TFYFmodel.amountSignIn TomorrowFubi:amountSignInTo];
            bg1.BgViewdelegate =self;
            [self.view addSubview:bg1];
        }
    }
    
    
}



//判断是否第一次登陆
-(void)CreateBjView{
    //判断是否第一次登陆
    NSString *su= [UserDefaults objectForKey:subject];
    if([su intValue] != 1 && [su intValue] != 2 ){
        float hei = kScreenHeight > 480 ? 960/2  : 1080/2 ;
        bgView *Bjview = [[bgView alloc]initWithFrame:CGRectMake((kScreenWidth-(ratioWidth*540/2))/2.0,(kScreenHeight-ratioHeight*hei)/2.0, ratioWidth*540/2.0, ratioHeight* hei)];
        Bjview.BgViewdelegate = self;
        [self.view addSubview:Bjview];
    }
}

- (void)amount
{
    [self Mydataservice];
}
//创建口语练习button
- (void)Speackbutton{
    
    UIButton *Speackbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    Speackbutton.frame = CGRectMake(0, kScreenHeight-110*ratioHeight/2, kScreenWidth, ratioHeight*110/2);
    [Speackbutton setTitle:@"口语练习" forState:UIControlStateNormal];
    Speackbutton.titleLabel.font = [UIFont boldSystemFontOfSize:17 * ratioHeight];
    [Speackbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Speackbutton.backgroundColor = [MyColor colorWithHexString:@"0x0172fe"];
    [self.view addSubview:Speackbutton];
    [Speackbutton addTarget:self action:@selector(SpeackAction:) forControlEvents:UIControlEventTouchUpInside];

}



- (void)createTablewView{
    
    imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ratioHeight*472/2)];
    imgView.backgroundColor = [UIColor clearColor];
    //        [self.view insertSubview:imgView aboveSubview:_tableview];
    [self.view addSubview:imgView];
   
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _tableview.backgroundColor = [UIColor clearColor];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.delegate = self;
    _tableview.dataSource =self;
    _identify = @"HomePageCell";
    _tableview.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,  ratioHeight*472/2)];
    _tableview.tableFooterView = [[UIView alloc]init];
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:_identify];
    [self.view addSubview:_tableview];
//    _tableview.contentInset = UIEdgeInsetsMake(ratioHeight*472/2, 0, 0, 0);
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    

}

#pragma mark------------ 创建cell上面的视图-----
- (UIView *)createStartView{
    //创建星星视图
    
    UIView *vieSS = [[UIView alloc]initWithFrame:CGRectZero];
    _cell = vieSS;
    _cell.backgroundColor = [UIColor blackColor];
    NSArray *subjectCN = _TFYFmodel.subjectCN;
    [subjectCN enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSString *title = obj[@"title"];
        //label
        UILabel *delivery = [WXLabel UIlabelFrame:CGRectMake(ratioWidth*20/2,(ratioHeight*50/2+ratioHeight*30/2)*idx+ratioHeight*50/2, ratioWidth*130/2, ratioHeight*30/2) textColor:[MyColor colorWithHexString:@"0x555555"] textFont:[UIFont systemFontOfSize:13*ratioHeight] labelTag:30+idx];
        delivery.text = obj[@"title"];
        [_cell addSubview:delivery];
        [delivery sizeToFit];
        
      
        NSInteger gray = _TFYFmodel.Grayindex;
        //星星视图
        StarView *start = [[StarView alloc]initWithFrame:CGRectMake(delivery.right+ratioWidth*20/2,(ratioHeight*50/2+ratioHeight*30/2)*idx+ratioHeight*50/2 , ratioHeight*30/2*gray+((gray-1)*(ratioWidth*10/2)), ratioHeight*30/2) starmore:[obj[@"fen"] floatValue] Grayindex:_TFYFmodel.Grayindex];
        start.tag = 2000+idx;
        [_cell addSubview:start];
        
    }];
    
    
    CGFloat x =((ratioHeight*50/2+ratioHeight*30/2)*(subjectCN.count));
    
    //视频
    UIButton *videoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    videoButton.frame = CGRectMake(kScreenWidth-70*ratioWidth/2, ratioHeight*50/2, 22, 22);
    [videoButton setImage:[UIImage imageNamed:@"play_05"] forState:UIControlStateNormal];
    [_cell addSubview:videoButton];
    videoButton.selected =NO;
    [videoButton addTarget:self action:@selector(videoButton:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat width = ratioWidth*180/2;
    CGFloat height = ratioHeight*50/2;
    CGFloat jianju =(kScreenWidth -ratioWidth*180/2*3)/4;
    //弱点标签
    NSArray *nameAry = _TFYFmodel.com_list;

        //划线
        UILabel *deviey1 = [[UILabel alloc]initWithFrame:CGRectMake(ratioWidth*20/2, x+ratioHeight*65/2,ratioWidth*220/2, 1)];
        deviey1.backgroundColor = [MyColor colorWithHexString:@"0x555555"];
        [_cell addSubview:deviey1];
        
        //弱点标签
        UILabel *weaknesslabel = [WXLabel UIlabelFrame:CGRectMake(deviey1.right+ratioWidth*20/2, deviey1.top-ratioHeight*30/4, kScreenWidth-deviey1.width*2-ratioWidth*20*2, ratioHeight*30/2) textColor:[MyColor colorWithHexString:@"0x555555"] textFont:[UIFont systemFontOfSize:13] labelTag:50];
        weaknesslabel.text = @"弱点标签";
        weaknesslabel.textAlignment = NSTextAlignmentCenter;
        [_cell addSubview:weaknesslabel];
        
        
        //划线2
        UILabel *deviey2 = [[UILabel alloc]initWithFrame:CGRectMake(weaknesslabel.right+ratioWidth*20/2, deviey1.top,ratioWidth*220/2, 1)];
        deviey2.backgroundColor = [MyColor colorWithHexString:@"0x555555"];
        [_cell addSubview:deviey2];
        
        //弱点标签
//        NSArray *nameAry = _TFYFmodel.com_list;
//        NSArray *color = @[@"0x0172fe",@"0xffad01",@"0x0172fe",@"0xff1e6f"];
        if(nameAry.count != 0){
        [nameAry enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *bookitem = [[UIButton alloc]init];
            [bookitem.layer setMasksToBounds:YES];
            [bookitem.layer setCornerRadius:height / 2.0];
            [_cell addSubview:bookitem];
            bookitem.tag = ([obj[@"id"] intValue]+800);
            NSInteger Yindex = idx/3;
            NSInteger Xindex = idx%3;
            bookitem.frame  =CGRectMake((width+jianju)*Xindex+jianju, deviey1.bottom+ratioHeight*50/2+(height+25*ratioHeight/2)*Yindex , width, height);
             bookitem.titleLabel.font = [UIFont boldSystemFontOfSize:13];
            [bookitem setTitle:obj[@"title"] forState:UIControlStateNormal];
            [bookitem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
            [bookitem addTarget:self action:@selector(bookitemAction:) forControlEvents:UIControlEventTouchUpInside];
            [bookitem setBackgroundColor:[MyColor colorWithHexString:[NSString stringWithFormat:@"0x%@",obj[@"color"]]]];
          
        }];
        
        }else{
        
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, deviey1.bottom + 25*ratioHeight  , kScreenWidth, height)];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [MyColor colorWithHexString:@"0x555555"];
            label.font = [UIFont systemFontOfSize:13];
            label.text = @"只有练习才能显示弱点";
            [_cell addSubview:label];
        
        }

    
    
    CGFloat Y =0;
    //计算当有标签栏的时候Y坐标
    NSInteger Yindex = nameAry.count/3;
    if (Yindex==0) {
        if (nameAry.count == 0) {
            
            Y = ((x+65*ratioHeight/2)+ratioHeight*50 + height );
            
        }else{
            
            Y = ((x+65*ratioHeight/2)+ratioHeight*50 + height);
        }
    }else if(Yindex>0){
        
        if (nameAry.count%3 == 0) {
            Y = ((x+65*ratioHeight/2)+ratioHeight*50 + height*(Yindex) + 25*ratioHeight/2 *(Yindex - 1));
        } else {
           Y = ((x+65*ratioHeight/2)+ratioHeight*50 + height*(Yindex + 1) + 25*ratioHeight/2 *(Yindex - 1));
        
        }

    }
    
   
    //划线3
    UILabel *deviey3 = [[UILabel alloc]initWithFrame:CGRectMake(ratioWidth*20/2, Y,ratioWidth*220/2, 1)];
    deviey3.backgroundColor = [MyColor colorWithHexString:@"0x555555"];
    [_cell addSubview:deviey3];
    
    
    
    
    //提升课程
    UILabel *ClassLabel = [WXLabel UIlabelFrame:CGRectMake(deviey3.right+ratioWidth*20/2, deviey3.top-ratioHeight*30/4, kScreenWidth-deviey3.width*2-ratioWidth*20*2, ratioHeight*30/2) textColor:[MyColor colorWithHexString:@"0x555555"] textFont:[UIFont systemFontOfSize:13] labelTag:51];
    ClassLabel.text = @"提升课程";
    ClassLabel.textAlignment = NSTextAlignmentCenter;
    [_cell addSubview:ClassLabel];
    
    //划线4
    UILabel *deviey4 = [[UILabel alloc]initWithFrame:CGRectMake(ClassLabel.right+ratioWidth*20/2, deviey3.top,ratioWidth*220/2, 1)];
    deviey4.backgroundColor = [MyColor colorWithHexString:@"0x555555"];
    [_cell addSubview:deviey4];
    
    
    
    UIView *more = [[UIView alloc] initWithFrame:CGRectMake(ratioWidth*20/2, deviey4.top+ratioHeight*35/2, kScreenWidth - 20 * ratioHeight, ratioHeight*20)];

    [_cell addSubview:more];

    more.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(morelableAction)];
    [more addGestureRecognizer:tap];
    //为你推荐
    UILabel *recommendLabel = [WXLabel UIlabelFrame:CGRectMake(0, 0, ratioWidth*50*2, ratioHeight*25/2) textColor:[UIColor whiteColor] textFont:[UIFont systemFontOfSize:13*ratioHeight] labelTag:600];
    recommendLabel.text =@"为你推荐";
    recommendLabel.textAlignment = NSTextAlignmentLeft;
    [more addSubview:recommendLabel];
    
    
    //更多
    UIButton *MoreLabel = [[UIButton alloc]initWithFrame:CGRectMake(more.width-ratioWidth*50*2, 0, ratioWidth*50*2, ratioHeight*26/2)];
    [MoreLabel setTitle:@"更多" forState:UIControlStateNormal];
    MoreLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    MoreLabel.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    MoreLabel.titleLabel.font = [UIFont systemFontOfSize:13*ratioHeight];
    [MoreLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [MoreLabel addTarget:self action:@selector(morelableAction) forControlEvents:UIControlEventTouchUpInside];
    [more addSubview:MoreLabel];
    
    NSArray*recommendListAry = _TFYFmodel.recommendList;
   
    NSInteger aa;
   
    if(recommendListAry.count%2 == 0) {
        
        aa = recommendListAry.count/2;
    
    }else {
        aa = recommendListAry.count/2 + 1;
    }
    
    if (recommendListAry.count !=0) {
        CollectionView *coView = [[CollectionView alloc]initWithFrame:CGRectMake(0, more.bottom+ 12.5,kScreenWidth, (250/2) * ratioHeight *aa) recommendLisrAry:recommendListAry];
        coView.tag = 607;
        self.Collectionbottom = coView.bottom;
        [_cell addSubview:coView];
    }
    _cell.frame =CGRectMake(0, 0, kScreenWidth, self.Collectionbottom);
    
    return _cell;
}


//创建头部视图
- (void)cereateImgview{
    if (clearimgView == nil) {
        
        //图片背景视图
        [imgView sd_setImageWithURL:[NSURL URLWithString:_TFYFmodel.backgroupImg] placeholderImage:nil];
       
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:_TFYFmodel.backgroupImg] options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            
            if (finished) {
                
                UIImage *image = [[UIImage alloc] initWithData:data];
                imgView.image = [image drn_boxblurImageWithBlur:0.5 withTintColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.3]];
                ;
            }else{
                
                
            }
            
        }];

        
        //图层视图
        clearimgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, ratioHeight*472/2)];
        clearimgView.backgroundColor = [UIColor clearColor];

        clearimgView.userInteractionEnabled = YES;
//        [self.view insertSubview:clearimgView aboveSubview:imgView];
        
        _tableview.tableHeaderView = clearimgView;
        
//        FXBlurView *blurView = [[FXBlurView alloc] initWithFrame:clearimgView.bounds];
//        blurView.blurRadius = 10;
//        blurView.tintColor = [UIColor blackColor];
//        [imgView addSubview:blurView];

        
        //ios8 创建需要的毛玻璃特效类型
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        //  毛玻璃view 视图
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//        effectView.backgroundColor = [UIColor blackColor];
        //添加到要有毛玻璃特效的控件中
        effectView.frame = CGRectMake(0, clearimgView.height - ratioHeight*75, kScreenWidth, ratioHeight*75);
        [clearimgView addSubview:effectView];
        //设置模糊透明度
        effectView.alpha = .5f;
        
       
        
        //设置按钮
        UIView *SetupVeiw = [[UIView alloc]initWithFrame:CGRectMake(40*ratioWidth/2, ratioHeight*30/2, ratioWidth*70/2, ratioWidth*80/2)];
        SetupVeiw.backgroundColor = [UIColor clearColor];
        [clearimgView addSubview:SetupVeiw];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SetupAction)];
        [SetupVeiw addGestureRecognizer:tap];
       
        UIButton *Setup = [UIButton buttonWithType:UIButtonTypeCustom];
        Setup.frame = CGRectMake(10, 20 + 11, 44/2, 44/2);
        [Setup setImage:[UIImage imageNamed:@"set_01"] forState:UIControlStateNormal];
        
        [clearimgView addSubview:Setup];
        [Setup addTarget:self action:@selector(SetupAction) forControlEvents:UIControlEventTouchUpInside];
        
       
        
        //输入天数的按钮键
         Daybutton =[[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth-150*ratioHeight/2)/2, 99 * ratioHeight / 2.0 - 10, 150*ratioHeight/2, 90/2*ratioHeight)];
//        NSString *apptime = [NSString stringWithFormat:@"%@",_TFYFmodel.apptime];
        

        NSLog(@"%@",_TFYFmodel.apptime);
        Daybutton.backgroundColor = [UIColor clearColor];
        Daybutton.titleLabel.font = [UIFont fontWithName:@"Arial" size:45*ratioHeight];
        [UIFont fontNamesForFamilyName:@"Arial"];
        [Daybutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [Daybutton addTarget:self action:@selector(DaybuttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [clearimgView addSubview:Daybutton];
        
        
    
        dayLabel = [WXLabel UIlabelFrame:CGRectMake(Daybutton.right,Daybutton.bottom - 26*ratioHeight  , 20, 26*ratioHeight / 2.0)
                                         textColor:[UIColor whiteColor]
                                         textFont:[UIFont systemFontOfSize:13]
                                         labelTag:31];
    
        dayLabel.text = @"天";
//        dayLabel.backgroundColor = [UIColor greenColor];
        [clearimgView addSubview:dayLabel];

        
        
        prompt = [WXLabel UIlabelFrame:CGRectMake(ratioWidth*100/2, Daybutton.bottom, kScreenWidth-ratioWidth*200/2, ratioHeight*40/2) textColor:[UIColor whiteColor] textFont:[UIFont systemFontOfSize:13*ratioHeight] labelTag:32];
        
        prompt.textAlignment = NSTextAlignmentCenter;
        [clearimgView addSubview:prompt];
        
        
        //福币视图
        UIView *fubiView =[[UIView alloc]initWithFrame:CGRectMake(kScreenWidth-(ratioWidth*130/2)-10, 253 / 2.0 * ratioHeight, ratioWidth*130/2, ratioHeight*50/2)];
        fubiView.backgroundColor = [UIColor colorWithRed:161/255.0 green:116/255.0 blue:58/255.0 alpha:1];
        [fubiView.layer setMasksToBounds:YES];
        UITapGestureRecognizer *tapGesture= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fubiAction:)];
        tapGesture.numberOfTapsRequired = 1;
        [fubiView addGestureRecognizer:tapGesture];
        [fubiView.layer setCornerRadius:ratioHeight*50/4];
        [clearimgView addSubview:fubiView];
       
        
        //福币按钮
        UIButton *fubi = [UIButton buttonWithType:UIButtonTypeCustom];
        fubi.frame = CGRectMake(8 * ratioWidth, (fubiView.height - 15) / 2.0, 22, 15);
        fubi.contentMode = UIViewContentModeScaleAspectFit;
        fubi.userInteractionEnabled =NO;
        [fubi setBackgroundImage:[UIImage imageNamed:@"photo_01"] forState:UIControlStateNormal];
        [fubiView addSubview:fubi];
        
        
        //福币值
        _FBlabel = [[UILabel alloc]init];
        _FBlabel.frame = CGRectMake(fubi.right, fubi.top, fubiView.width - fubi.right, fubi.height);
        _FBlabel.font = [UIFont boldSystemFontOfSize:12*ratioWidth];
        _FBlabel.textColor = [UIColor whiteColor];
        _FBlabel.textAlignment = NSTextAlignmentCenter;
        [fubiView addSubview:_FBlabel];
        
        
        CGFloat Width_W = 60 * ratioWidth / 2.0;
        CGFloat buWidth = (kScreenWidth- Width_W * 4)/3.0;
   
        NSArray *Labelarray = @[@"练习录音",@"预估分数",@"目标分数"];
        for (int i = 0; i< Labelarray.count; i++) {
            UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake((buWidth+Width_W)*i+Width_W,ratioHeight*350/2, buWidth, ratioHeight*70/2)];
//            button.backgroundColor = [UIColor redColor];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:40/2*ratioHeight];
//            [button setTitle:@"0" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(ButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [clearimgView addSubview:button];
            button.tag = 100+i;
           
            //圆点
            if (i == 0 ) {
                _yuandian = [[UILabel alloc]init];
                _yuandian.frame = CGRectMake(button.right - buWidth / 2.0 + 15  , button.top, ratioHeight*20/2,ratioHeight*20/2);
                _yuandian.backgroundColor =[UIColor redColor];
                [_yuandian.layer setMasksToBounds:YES];
                [_yuandian.layer setCornerRadius:ratioHeight*20/4];
                [clearimgView addSubview:_yuandian];
            }
        
            
            
            NSString *labelName = Labelarray[i];
            UILabel *ModelLabel= [WXLabel UIlabelFrame:CGRectMake((buWidth+Width_W)*i+Width_W, button.bottom, buWidth, ratioHeight*30/2) textColor:[UIColor whiteColor] textFont:[UIFont systemFontOfSize:ratioHeight*26/2] labelTag:33];
            ModelLabel.textAlignment = NSTextAlignmentCenter;
            ModelLabel.text = labelName;
            [clearimgView addSubview:ModelLabel];
            ModelLabel.tag = i+130;
        }
    
}
    
    [Daybutton setTitle:[NSString stringWithFormat:@"%@",_TFYFmodel.apptime] forState:UIControlStateNormal];
    [Daybutton sizeToFit];
    Daybutton.left = (kScreenWidth - Daybutton.width) / 2.0;
    dayLabel.top  =  Daybutton.bottom - 26*ratioHeight;
    dayLabel.left = Daybutton.right;
    prompt.top = Daybutton.bottom - 10;
    prompt.text = _TFYFmodel.app_ex_timeCN;
}


#pragma mark-- tabelView滑动--------------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    NSLog(@"===%f",scrollView.contentOffset.y);
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY<-300) {
        _tableview.contentOffset = CGPointMake(0,-300 );
    }
    
    //判断向上滑动、还是向下滑动
    if (offsetY < 0) {  //向下
        //1.向下滑动，图片放大之后的高度
        CGFloat height = ABS(offsetY) + (ratioHeight*472/2);
        //2.计算放大的倍数
        CGFloat scale = height/(ratioHeight*472/2);
        //3.修改transfrom放大、缩小
        
        imgView.transform = CGAffineTransformMakeScale(scale, scale);
       
        imgView.top=0;
        
        CGFloat gfg=(ratioHeight*472/2)*scale-kImageHeight;
        
//        clearimgView.transform = CGAffineTransformMakeTranslation(0,gfg);
  
    } else {  //向上
        imgView.transform = CGAffineTransformMakeTranslation(0,-offsetY);
//        clearimgView.transform = CGAffineTransformMakeTranslation(0,-offsetY);
    }
    
    _float_y = ratioHeight*472/2 + ratioHeight*50/2 -offsetY;
    _ViodeView.top =  _float_y;

}


- (void)morelableAction{

    NSLog(@"更多点击事件");
    TiShengViewController *tishengVC = [[TiShengViewController alloc]init];
    [self.navigationController pushViewController:tishengVC animated:YES];
    

}
#pragma mark -- 了解托福口语--------------
- (void)RecommendAction:(UIButton *)button{

    NSLog(@"了解托福口语");

}



#pragma mark-- 更多点击事件--------------
- (void)MoreAction:(UIButton *)button{

    NSLog(@"口语评分标准");

}



#pragma mark -- 弱点标签点击事件--------------
- (void)bookitemAction:(UIButton*)button{

    TagViewController *tagVC = [[TagViewController alloc]init];
    tagVC.ID = [NSString stringWithFormat:@"%d",button.tag  - 800];
    [self.navigationController pushViewController:tagVC animated:YES];
    
    NSLog(@"弱点标签点击事件");
    
}


#pragma mark -- 口语练习点击事件--------------
- (void)SpeackAction:(UIButton *)button{

    NSLog(@"口语练习点击事件");
    
    OralController *VC = [[OralController alloc] init];
    
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:VC];
    [self presentViewController:nav animated:YES completion:nil];
    

}




#pragma mark -- 视频点击事件--------------
- (void)videoButton:(UIButton *)button{
    
    
    [UIView animateWithDuration:.5 animations:^{
      
        _ViodeView.width = kScreenWidth;
        _ViodeView.height = kScreenHeight;
        _ViodeView.center = CGPointMake(kScreenWidth / 2.0, (kScreenHeight ) / 2.0);
        _ViodeView.alpha = 1;

    } completion:^(BOOL finished) {
        
        

        LDZMoviePlayerController *moviewPlayerVC = [[LDZMoviePlayerController alloc] init];
    
        /*
         //  播放本地
         moviewPlayerVC.movieURL = [NSURL fileURLWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"5540385469401b10912f7a24-6.mp4"]];
         */
    
        //  播放网络
        //        NSString *urlString = @"http://mw2.dwstatic.com/2/8/1528/133366-99-1436362095.mp4";
    
        NSURL *URL = [NSURL URLWithString: _TFYFmodel.mp4Url];
        moviewPlayerVC.movieURL = URL;
        [self presentViewController:moviewPlayerVC animated:NO completion:nil];
    
        NSLog(@"视频点击事件");
    }];
    



}



#pragma mark --- 设置点击事件--------------
//设置按钮点击事件
- (void)SetupAction{

    NSLog(@"设置点击事件");
    SetupViewController *setVC = [[SetupViewController alloc]init];
    [self.navigationController pushViewController:setVC animated:YES];

}


#pragma mark --练习录音,预估分数点击事件--------------
- (void)ButtonAction:(UIButton *)button{
    
    //练习录音
    if (button.tag == 100){
       
        TrainingrecordViewController *tra = [[TrainingrecordViewController alloc]init];
        [self.navigationController pushViewController:tra animated:YES];
        
    }
    
    //预估分数
    if (button.tag == 101) {
        NSString *comment =@"预估的评分是动态的,通过对你近日的练习 \n 结果进行评估.练习越多,评估越准!";
        BgView2 *bjview = [[BgView2 alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight) Title:_TFYFmodel.scoreP Text:comment Text1:nil];
        [self.view addSubview:bjview];
        
}
    
    //目标分数
    if (button.tag == 102) {
        
        NSLog(@"点击了");
        
        ProformainformationViewController *porforVC = [[ProformainformationViewController alloc]init];
        [self.navigationController pushViewController:porforVC animated:YES];
        
    }
}


#pragma mark --充值福币点击事件点击事件--------------
- (void)fubiAction:(UIButton *)button{
    
    FuYuanViewController *fuyuan = [[FuYuanViewController alloc]init];
    [self.navigationController pushViewController:fuyuan animated:YES];
    
    NSLog(@"充值福币点击事件");
    
}


#pragma mark --天数点击事件------
- (void)DaybuttonAction:(UIButton *)button{

    NSLog(@"天数点击事件");

    //跳转到备考信息
    ProformainformationViewController *proformainVC = [[ProformainformationViewController alloc]init];
    [self.navigationController pushViewController:proformainVC animated:YES];
    
}


#pragma mark -- 网络请求---------
- (void)Mydataservice{
    NSString *useid = [UserDefaults objectForKey:Userid];
    NSDictionary *params = @{@"member_id":useid};
    [WXDataService requestAFWithURL:Url_getStudentHome params:params httpMethod:@"POST" finishBlock:^(id result) {
        if([result[@"states"] intValue]== 0){
            NSLog(@"ggggg%@",result);
            NSDictionary *re = result[@"result"];
            _TFYFmodel = [[TFYSmodel alloc]initWithDataDic:re];
            _TFYFmodel.apptime =re[@"app_ex_time"];
            _TFYFmodel.subjectCN = re[@"subjectCN"];
            _TFYFmodel.recommendList = re[@"recommendList"];
            _TFYFmodel.com_list = re[@"com_list"];
            _TFYFmodel.sub = re[@"subject"];
            _TFYFmodel.appscore = re[@"app_t_score"];
            _TFYFmodel.mp4Url = re[@"mp4Url"];
            NSInteger sub = [re[@"subject"] integerValue];
            if (sub == 1) {
                _TFYFmodel.Grayindex = 4;
            }else if(sub ==2){
                _TFYFmodel.Grayindex =9;
            }
            
           
            _dataArray = @[@""];
            [self cereateImgview];
            [self SignFubi];
            
            _FBlabel.text = [NSString stringWithFormat:@"%d",[_TFYFmodel.amount intValue]];
            //是否有联习
            if([re[@"isNewRecord"] integerValue] == 0 )
            {
                _yuandian.hidden = YES;
                
            } else {
                 _yuandian.hidden = NO;
            }
            
            UIButton *aa = (UIButton *)[clearimgView viewWithTag:100];
            [aa setTitle:_TFYFmodel.recordCount forState:UIControlStateNormal];
            
            UIButton *aa1 = (UIButton *)[clearimgView viewWithTag:101];
            [aa1 setTitle:_TFYFmodel.scoreP forState:UIControlStateNormal];
            
            UIButton *aa2 = (UIButton *)[clearimgView viewWithTag:102];
            [aa2 setTitle:_TFYFmodel.appscore forState:UIControlStateNormal];
            
            _allView = [self createStartView];
            [_tableview reloadData];
        }
        if([result[@"states"] intValue]== 1){
            [MBProgressHUD showError:result[@"msg"] toView:[UIApplication sharedApplication].keyWindow];
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    }

#pragma mark --- bgView1delegate---------
- (void)amount1
{
   [self Mydataservice];
}

#pragma mark -- tablewView delegate----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

   
    return _dataArray.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_identify forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_identify];
        
    }
    cell.backgroundColor = [MyColor colorWithHexString:@"0x000000"];
    //取消单元格的选择状态
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    [cell.contentView addSubview:_allView];
    
    return cell;

}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellheight =_allView.bottom+ ratioHeight*120/2+ratioHeight*20/2;
//    NSLog(@"cellheight:%f",self.Collectionbottom);
    return cellheight;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end

//
//  HADirect.m
//  Test
//
//  Created by mac on 15/9/19.
//  Copyright (c) 2015年 HA. All rights reserved.
//

#import "HADirect.h"
@interface HADirect()<UIScrollViewDelegate>
//轮播图片名字的数组
@property(strong,nonatomic) NSArray *imageArr;
//自定义视图的数组
@property(strong,nonatomic) NSArray *viewArr;

//定时器
@property(strong,nonatomic) NSTimer *timer;

@end

@implementation HADirect

#define contentOffSet_x self.direct.contentOffset.x
#define frame_width self.direct.frame.size.width
#define contentSize_x self.direct.contentSize.width

#pragma mark -========================初始化==============================

#pragma mark 静态初始化方法
+(instancetype)direcWithtFrame:(CGRect)frame ImageArr:(NSArray *)imageNameArray AndImageClickBlock:(imageClickBlock)clickBlock;
{
    return [[HADirect alloc]initWithtFrame:frame ImageArr:imageNameArray AndImageClickBlock:clickBlock];
}

#pragma mark 静态初始化自定义视图方法
+(instancetype)direcWithtFrame:(CGRect)frame ViewArr:(NSArray *)customViewArr
{
    return [[HADirect alloc]initWithtFrame:frame ViewArr:customViewArr];
}


-(instancetype)initWithtFrame:(CGRect)frame ViewArr:(NSArray *)customViewArr
{
    if(self=[self initWithFrame:frame])
    {
        //设置ScrollView的contentSize
        self.direct.contentSize=CGSizeMake((customViewArr.count+1)*frame_width,0);
        
        self.pageVC.numberOfPages=customViewArr.count;
        
        self.viewArr=customViewArr;
        
        //设置图片点击的Block

    }
    return self;
}

-(instancetype)initWithtFrame:(CGRect)frame ImageArr:(NSArray *)imageNameArray AndImageClickBlock:(imageClickBlock)clickBlock;
{
    if(self=[self initWithFrame:frame])
    {
        //设置ScrollView的contentSize
        self.direct.contentSize=CGSizeMake((imageNameArray.count+2)*frame_width,0);
        
        self.pageVC.numberOfPages=imageNameArray.count;
        
        //设置滚动图片数组
        self.imageArr=imageNameArray;
        
        //设置图片点击的Block
        self.clickBlock=clickBlock;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        //初始化轮播ScrollView
        self.direct=[[UIScrollView alloc]init];
        self.direct.delegate=self;
        self.direct.pagingEnabled=YES;
        self.direct.frame=self.bounds;
        self.direct.contentOffset=CGPointMake(frame_width, 0);
        self.direct.showsHorizontalScrollIndicator=NO;
        [self addSubview:self.direct];
        
        //初始化轮播页码控件
        self.pageVC=[[UIPageControl alloc]init];
        //设置轮播页码的位置
        self.pageVC.frame=CGRectMake(0,self.frame.size.height-30, self.frame.size.width, 30);
        [self addSubview:self.pageVC];
        
        self.time=1.5;
    }
    return self;
}

#pragma mark-===========================定时器===============================
#pragma mark 初始化定时器
-(void)beginTimer
{
    if(self.timer==nil)
    {
        self.timer =[NSTimer scheduledTimerWithTimeInterval:self.time target:self selector:@selector(timerSel) userInfo:nil repeats:YES];
    }
}
#pragma mark 摧毁定时器
-(void)stopTimer
{
    [self.timer invalidate];
    self.timer=nil;
}

#pragma mark 定时器调用的方法
-(void)timerSel
{
    //获取并且计算当前页码
    CGPoint currentConOffSet=self.direct.contentOffset;
    currentConOffSet.x+=frame_width;
    
    //动画改变当前页码
    [UIView animateWithDuration:0.5 animations:^{
        self.direct.contentOffset=currentConOffSet;
    }completion:^(BOOL finished) {
        [self updataWhenFirstOrLast];
    }];
}

#pragma mark-========================UIScrollViewDelegate=====================
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self beginTimer];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //当最后或者最前一张图片时改变坐标
    [self updataWhenFirstOrLast];
}

#pragma mark-=====================轮播页码改变=====================
-(void)updataPageControl
{
    NSInteger index=(contentOffSet_x-frame_width)/frame_width;
    self.pageVC.currentPage=index;
}

#pragma mark -=====================其他一些方法===================
//轮播定时器时间
-(void)setTime:(CGFloat)time
{
    if(time>0)
    {
        _time=time;
        [self stopTimer];
        [self beginTimer];
    }
}

#pragma mark 重写图片名字的数组
-(void)setImageArr:(NSArray *)imageArr
{
    _imageArr=imageArr;
    
    [self addImageToScrollView];
    
    [self beginTimer];
}

#pragma mark 重写自定义视图的数组
-(void)setViewArr:(NSArray *)viewArr
{
    _viewArr=viewArr;
    
    [self addCustomViewToScrollView];
    
    [self beginTimer];
}

#pragma mark 图片点击事件
-(void)imageClick:(UITapGestureRecognizer *)tap
{
    UIView *view=tap.view;
    NSInteger a = view.tag;
   if(self.clickBlock)
   {
        self.clickBlock(a);
   }
}

#pragma mark 根据自定义视图添加到ScrollView
-(void)addCustomViewToScrollView
{
    NSMutableArray *imgMArr=[NSMutableArray arrayWithArray:self.viewArr];
    
    UIView *lastView=[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:[self.viewArr lastObject]]];
    [imgMArr insertObject:lastView atIndex:0];
    
    UIView *firstView=[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:[self.viewArr firstObject]]];
    [imgMArr addObject:firstView];

    NSInteger tag=-1;
    for (UIView *customView in imgMArr) {
        customView.frame=CGRectMake(self.frame.size.width*(tag+1), 0, self.frame.size.width, self.frame.size.height);
        NSLog(@"%f",customView.frame.origin.x);
        //设置tag
        customView.tag=tag;
        tag++;
        
        //添加手势
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick:)];
        [customView addGestureRecognizer:tap];
        customView.userInteractionEnabled=YES;
        [self.direct addSubview:customView];
    }
}

#pragma mark 根据图片名添加图片到ScrollView
-(void)addImageToScrollView
{
    NSMutableArray *imgMArr=[NSMutableArray arrayWithArray:self.imageArr];
    [imgMArr insertObject:[self.imageArr lastObject] atIndex:0];
    [imgMArr addObject:[self.imageArr firstObject]];
    
    NSInteger tag=-1;
    for (NSString *name in imgMArr) {
        UIImageView *imgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:name]];
        imgView.frame=CGRectMake(self.frame.size.width*(tag+1), 0, self.frame.size.width, self.frame.size.height);
        //设置tag
        imgView.tag=tag;
        tag++;
        
        //添加手势
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick:)];
        [imgView addGestureRecognizer:tap];
        imgView.userInteractionEnabled=YES;
        [self.direct addSubview:imgView];
    }
    self.pageVC.numberOfPages=self.imageArr.count;
}

#pragma mark 判断是否第一或者最后一个图片,改变坐标
-(void)updataWhenFirstOrLast
{
    if(contentOffSet_x >= contentSize_x-frame_width)
    {
        self.direct.contentOffset=CGPointMake(frame_width, 0);
    }
    else if (contentOffSet_x <= 0)
    {
        self.direct.contentOffset=CGPointMake(contentSize_x - 1 *frame_width, 0);
    }
    
    //更新PageControl
    [self updataPageControl];
}
@end

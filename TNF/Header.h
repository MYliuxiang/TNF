
//
//  Header.h
//  TNF
//
//  Created by 李立 on 15/12/17.
//  Copyright © 2015年 刘翔. All rights reserved.
//

#ifndef Header_h
#define Header_h

/*
 
 友盟
 http://www.umeng.com/apps
 邮箱： tech@tuoninfu.com     新密码：    tech@5tuonindefu
 
 微信 开放平台 https://open.weixin.qq.com
 邮箱：   tech@tuoninfu.com
 新密码： tech@5tuonindefu
 
 
 Apple开发者帐号
 https://developer.apple.com/
 帐号：nate7chan@163.com
 密码：5kissUapple
 
 学生帐号test1 密码123456
 老师帐号test2 密码123456
 
 Bundle ID：com.products.TNF
 
 sina 开放平台-老师
 http://open.weibo.com/
 邮箱：nate7chan@163.com     新密码： 5kissU
 
 */

//常用属性
#define UserDefaults  [NSUserDefaults standardUserDefaults]
#define Color(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define ColorRGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


//-----------------------屏幕尺寸------------------
#define  kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define  kScreenWidth [[UIScreen mainScreen] bounds].size.width

//---------------------当前系统版本------------------
#define  kVersion [[[UIDevice currentDevice] systemVersion] floatValue]


//参考的屏幕宽度和高度 - 适配尺寸
#define referenceBoundsHeight 568.0
#define referenceBoundsWight 320.0
#define ratioHeight kScreenHeight/referenceBoundsHeight
#define ratioWidth kScreenWidth/referenceBoundsWight

//色值
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]


//所有全局颜色
#define UIColor(深色背景) UIColorFromRGB(0x1c1c1c)
#define UIColor1(蓝) UIColorFromRGB(0x0172fe)
#define UIColor2(灰色背景) UIColorFromRGB(0xf0f0f0)
#define UIColor3(金色) UIColorFromRGB(0xb28752)
#define UIColor4(所有的灰色) UIColorFromRGB(0x555555)
#define UIColor5(标题大字) UIColorFromRGB(0x000000)
#define UIColor6(正文小字) UIColorFromRGB(0x555555)
#define UIColor7(粉红) UIColorFromRGB(0xff1e6f)
#define UIColor8(橘黄) UIColorFromRGB(0xffad01)
#define UIColor9(白色) UIColorFromRGB(0xFFFFFF)
#define UIColorBtn(灰色) Color(142, 143, 144)


// 图片名字
#define imageNamed(name) [UIImage imageNamed:name]





#endif /* Header_h */

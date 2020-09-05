//
// Created by 杨浪 on 2020/9/1.
// Copyright (c) 2020 杨浪. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const KEY_REC_WAY = @"rec_way";


//定义系统属性高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define mc_Is_iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define mc_Is_iphoneX SCREEN_WIDTH >=375.0f && SCREEN_HEIGHT >=812.0f&& mc_Is_iphone

/*状态栏高度*/
#define mcStatusBarHeight (CGFloat)(mc_Is_iphoneX?(44.0):(20.0))
/*导航栏高度*/
#define mcNavBarHeight (44)
/*状态栏和导航栏总高度*/
#define mcNavBarAndStatusBarHeight (CGFloat)(mc_Is_iphoneX?(88.0):(64.0))
/*TabBar高度*/
#define mcTabBarHeight (CGFloat)(mc_Is_iphoneX?(49.0 + 34.0):(49.0))
/*顶部安全区域远离高度*/
#define mcTopBarSafeHeight (CGFloat)(mc_Is_iphoneX?(44.0):(0))
/*底部安全区域远离高度*/
#define mcBottomSafeHeight (CGFloat)(mc_Is_iphoneX?(34.0):(0))
/*iPhoneX的状态栏高度差值*/
#define mcTopBarDifHeight (CGFloat)(mc_Is_iphoneX?(24.0):(0))
/*导航条和Tabbar总高度*/
#define mcNavAndTabHeight (mcNavBarAndStatusBarHeight + mcTabBarHeight)

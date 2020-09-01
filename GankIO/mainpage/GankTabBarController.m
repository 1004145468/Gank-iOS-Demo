//
//  GankTabBarController.m
//  GankIO
//
//  Created by 杨浪 on 2020/8/25.
//  Copyright © 2020 杨浪. All rights reserved.
//

#import "GankTabBarController.h"
#import "tabs/rec/GankRecTabController.h"
#import "tabs/tec/GankTecTabController.h"
#import "tabs/mm/GankMMTabController.h"
#import "tabs/my/GankMyTabController.h"

@interface GankTabBarController ()

@end

@implementation GankTabBarController

- (instancetype)init {
    self = [super init];
    if (self) {
        UIViewController *recVc = [GankRecTabController new]; //推荐
        //技术
        UINavigationController *tecVc = [[UINavigationController alloc] initWithRootViewController:[GankTecTabController new]];
        tecVc.navigationBar.barTintColor = [UIColor whiteColor];
        UIViewController *mmVc = [GankMMTabController new];  //福利
        UIViewController *myVc = [[UINavigationController alloc] initWithRootViewController:[GankMyTabController new]]; //个人中心
        self.viewControllers = @[recVc, tecVc, mmVc, myVc];
    }
    return self;
}

@end

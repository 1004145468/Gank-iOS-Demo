//
//  AppDelegate.m
//  GankIO
//
//  Created by 杨浪 on 2020/8/24.
//  Copyright © 2020 杨浪. All rights reserved.
//

#import "AppDelegate.h"
#import "GankTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


#pragma mark "-----应用生命周期函数------"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"应用启动");
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [GankTabBarController new];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"应用处在前台，获取到焦点");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"应用失去焦点");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"应用进入后台");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"应用重新回到前台");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"应用被退出");
}

@end

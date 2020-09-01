//
// Created by 杨浪 on 2020/8/28.
// Copyright (c) 2020 杨浪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface GankDetailViewController : UIViewController

@property(nonatomic, copy) NSString *linkUrl;

+ (UIViewController *)controllerInNavigationController:(NSString *)title WithLink:(NSString *)link;

@end
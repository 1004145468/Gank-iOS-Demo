//
// Created by 杨浪 on 2020/8/30.
// Copyright (c) 2020 杨浪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"


@interface GankTecCategoryController : UITableViewController

- (instancetype)initWithKeyWord:(NSString *)keyWord;

+ (instancetype)controllerWithKeyWord:(NSString *)keyWord;

@end
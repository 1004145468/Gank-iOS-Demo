//
// Created by 杨浪 on 2020/8/31.
// Copyright (c) 2020 杨浪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GankPicDetailController : UIViewController <UIScrollViewDelegate>

+ (instancetype)openImageWithData:(NSURL *)data AndRect:(CGRect)rect;

@end
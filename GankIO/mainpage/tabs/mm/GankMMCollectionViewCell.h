//
// Created by 杨浪 on 2020/8/31.
// Copyright (c) 2020 杨浪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import "GankMMData.h"

@interface GankMMCollectionViewCell : UICollectionViewCell

@property(nonatomic, weak) UIImageView *picView;

- (void)updateData:(GankMMData *)data WithIndex:(int)index;

@end
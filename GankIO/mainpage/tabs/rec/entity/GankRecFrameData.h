//
// Created by 杨浪 on 2020/8/28.
// Copyright (c) 2020 杨浪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GankRecData.h"

@interface GankRecFrameData : NSObject

@property(nonatomic, strong) GankRecData *data;
@property(nonatomic, assign, readonly) CGFloat rowHeight;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (instancetype)recFrameWithDictionary:(NSDictionary *)dictionary;

+ (CGFloat)getTitleFontSize;

+ (CGFloat)getDetailFontSize;

+ (int)getCellTopPadding;

+ (int)getCellBottomPadding;

+ (int)getImageWithTitleGap;

+ (int)getTitleWithDetailGap;

+ (int)getImageHeight;

@end
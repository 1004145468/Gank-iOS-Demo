//
// Created by 杨浪 on 2020/8/30.
// Copyright (c) 2020 杨浪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GankTecData.h"
#import "CoreGraphics/CoreGraphics.h"


@interface GankTecFrameData : NSObject

@property(nonatomic, strong) GankTecData *data;

@property(nonatomic, assign) CGFloat rowHeight;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (instancetype)frameDataWithDictionary:(NSDictionary *)dictionary;

@end
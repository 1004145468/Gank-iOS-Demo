//
// Created by 杨浪 on 2020/8/31.
// Copyright (c) 2020 杨浪. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GankMMData : NSObject

@property(nonatomic, copy) NSArray *images;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (instancetype)dataWithDictionary:(NSDictionary *)dictionary;

@end
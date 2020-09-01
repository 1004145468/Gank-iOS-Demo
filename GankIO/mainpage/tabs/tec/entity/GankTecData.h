//
// Created by 杨浪 on 2020/8/30.
// Copyright (c) 2020 杨浪. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GankTecData : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *desc;
@property(nonatomic, copy) NSString *url;
@property(nonatomic, strong) NSArray *image;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (instancetype)tecDataWithDictionary:(NSDictionary *)dictionary;

@end
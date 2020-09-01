//
// Created by 杨浪 on 2020/8/31.
// Copyright (c) 2020 杨浪. All rights reserved.
//

#import "GankMMData.h"


@implementation GankMMData

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.images = dictionary[@"images"];
    }
    return self;
}

+ (instancetype)dataWithDictionary:(NSDictionary *)dictionary {
    return [[GankMMData alloc] initWithDictionary:dictionary];
}

@end
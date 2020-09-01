//
// Created by 杨浪 on 2020/8/27.
// Copyright (c) 2020 杨浪. All rights reserved.
//

#import "GankRecData.h"

@implementation GankRecData

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self != nil) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key {
    //in case of other field
}


+ (instancetype)recDataWithDictionary:(NSDictionary *)dictionary {
    return [[GankRecData alloc] initWithDictionary:dictionary];
}

@end
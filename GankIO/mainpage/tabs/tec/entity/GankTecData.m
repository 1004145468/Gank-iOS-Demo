//
// Created by 杨浪 on 2020/8/30.
// Copyright (c) 2020 杨浪. All rights reserved.
//

#import "GankTecData.h"


@implementation GankTecData

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key {
    //in case of other field
}

+ (instancetype)tecDataWithDictionary:(NSDictionary *)dictionary {
    return [[GankTecData alloc] initWithDictionary:dictionary];
}

@end
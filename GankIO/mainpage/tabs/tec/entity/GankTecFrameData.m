//
// Created by 杨浪 on 2020/8/30.
// Copyright (c) 2020 杨浪. All rights reserved.
//

#import "GankTecFrameData.h"
#import "UIKit/UIKit.h"


@interface GankTecFrameData ()


- (CGFloat)computeRowHeight;

@end

@implementation GankTecFrameData

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.data = [GankTecData tecDataWithDictionary:dictionary];
        self.rowHeight = [self computeRowHeight];
    }
    return self;
}

- (CGFloat)computeRowHeight {
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat textWidth = screenWidth - 190;

    NSMutableDictionary *titleAttributes = [NSMutableDictionary dictionary];
    titleAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    CGRect titleSize = [self.data.title boundingRectWithSize:CGSizeMake(textWidth, 40)
                                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                  attributes:titleAttributes
                                                     context:nil];
    CGFloat titleLineHeight = titleSize.size.height;

    NSMutableDictionary *desAttributes = [NSMutableDictionary dictionary];
    desAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    CGRect desSize = [self.data.desc boundingRectWithSize:CGSizeMake(textWidth, 35)
                                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                               attributes:desAttributes
                                                  context:nil];
    CGFloat desLineHeight = desSize.size.height;
    CGFloat contentHeight = MAX(titleLineHeight + 10 + desLineHeight, 90);

    return contentHeight + 30;
}


+ (instancetype)frameDataWithDictionary:(NSDictionary *)dictionary {
    return [[GankTecFrameData alloc] initWithDictionary:dictionary];
}

@end
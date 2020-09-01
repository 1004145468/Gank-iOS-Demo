//
// Created by 杨浪 on 2020/8/28.
// Copyright (c) 2020 杨浪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GankRecFrameData.h"

@implementation GankRecFrameData

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self != nil) {
        self.data = [GankRecData recDataWithDictionary:dictionary];
        self->_rowHeight = [self computeRowHeight];
    }
    return self;
}

+ (instancetype)recFrameWithDictionary:(NSDictionary *)dictionary {
    return [[GankRecFrameData alloc] initWithDictionary:dictionary];
}

- (CGFloat)computeRowHeight {

    CGSize textSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, 0);
    CGFloat titleHeight = 0;
    NSString *title = self.data.title;
    if (title != nil) {
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        attributes[NSFontAttributeName] = [UIFont boldSystemFontOfSize:[GankRecFrameData getTitleFontSize]];
        CGSize titleSize = [title boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
        titleHeight = titleSize.height;
    }
    CGFloat detailHeight = 0;
    NSString *detail = self.data.desc;
    if (detail != nil) {
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        attributes[NSFontAttributeName] = [UIFont systemFontOfSize:[GankRecFrameData getDetailFontSize]];
        CGSize detailSize = [detail boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
        detailHeight = detailSize.height;
    }
    //添加1point偏差
    return ceil(
            [GankRecFrameData getCellTopPadding]
                    + [GankRecFrameData getImageHeight]
                    + [GankRecFrameData getImageWithTitleGap]
                    + titleHeight
                    + [GankRecFrameData getTitleWithDetailGap]
                    + detailHeight
                    + [GankRecFrameData getCellBottomPadding]
    ) + 1;
}

+ (int)getImageHeight {
    return 180;
}

+ (CGFloat)getTitleFontSize {
    return 20;
}

+ (CGFloat)getDetailFontSize {
    return 18;
}

+ (int)getCellTopPadding {
    return 10;
}

+ (int)getCellBottomPadding {
    return 30;
}

+ (int)getImageWithTitleGap {
    return 20;
}

+ (int)getTitleWithDetailGap {
    return 5;
}

@end

//
// Created by 杨浪 on 2020/8/31.
// Copyright (c) 2020 杨浪. All rights reserved.
//

#import "GankMMCollectionViewCell.h"
#import "Headers/Public/Masonry/View+MASAdditions.h"
#import "Headers/Public/SDWebImage/UIImageView+WebCache.h"

@implementation GankMMCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        [imageView setClipsToBounds:YES];
        [self.contentView addSubview:imageView];
        self.picView = imageView;
    }
    return self;
}

- (void)updateData:(GankMMData *)data WithIndex:(int)index {
    NSURL *requestUrl = nil;
    if (data.images != nil && data.images.count > 0) {
        NSString *picStr = data.images[0];
        requestUrl = [NSURL URLWithString:picStr];
    }
    [self.picView sd_setImageWithURL:requestUrl placeholderImage:[UIImage imageNamed:@"place_hold"]];
    BOOL isLeftCell = index % 2 == 0;
    [self.picView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(isLeftCell ? UIEdgeInsetsMake(0, 5, 0, 2) : UIEdgeInsetsMake(0, 2, 0, 5));
    }];
}

@end
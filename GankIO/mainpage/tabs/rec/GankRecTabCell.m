//
// Created by 杨浪 on 2020/8/27.
// Copyright (c) 2020 杨浪. All rights reserved.
//

#import "GankRecTabCell.h"
#import "View+MASAdditions.h"
#import "Headers/Public/SDWebImage/UIImageView+WebCache.h"

@interface GankRecTabCell ()

@property(nonatomic, weak) UIImageView *coverView;
@property(nonatomic, weak) UILabel *titleView;
@property(nonatomic, weak) UILabel *detailView;

@end

@implementation GankRecTabCell

+ (GankRecTabCell *)cellWithTableView:(UITableView *)tableView AndReuseIdentifier:(NSString *)identifier {
    GankRecTabCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[GankRecTabCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        self.selectedBackgroundView = [UIView new];
        //append imageView
        UIImageView *imageView = [UIImageView new];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 5;
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        [imageView setClipsToBounds:YES];
        [self.contentView addSubview:imageView];
        self.coverView = imageView;
        //append titleView
        UILabel *titleView = [UILabel new];
        [titleView setNumberOfLines:0];
        titleView.font = [UIFont boldSystemFontOfSize:[GankRecFrameData getTitleFontSize]];
        [self.contentView addSubview:titleView];
        self.titleView = titleView;
        //append detailView
        UILabel *detailView = [UILabel new];
        [detailView setTextAlignment:NSTextAlignmentLeft];
        [detailView setNumberOfLines:0];
        detailView.font = [UIFont systemFontOfSize:[GankRecFrameData getDetailFontSize]];
        [self.contentView addSubview:detailView];
        self.detailView = detailView;
        //add UIView constraints
        [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
            make.top.mas_equalTo(self.contentView.mas_top).mas_offset([GankRecFrameData getCellTopPadding]);
            make.height.mas_equalTo([GankRecFrameData getImageHeight]);
        }];
        [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.coverView.mas_bottom).mas_offset([GankRecFrameData getImageWithTitleGap]);
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
        }];
        [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleView.mas_bottom).mas_offset([GankRecFrameData getTitleWithDetailGap]);
            make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-[GankRecFrameData getCellBottomPadding]).priorityHigh;
        }];
    }
    return self;
}

- (void)setData:(GankRecFrameData *)frameData {
    GankRecData *data = frameData.data;
    NSArray *images = data.images;
    NSString *picUrl = nil;
    if (images != nil && images.count > 0) {
        picUrl = images[0];
    }
    [self.coverView sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"place_hold"]];
    self.titleView.hidden = data.title == nil;
    self.titleView.text = data.title;
    self.detailView.hidden = data.desc == nil;
    self.detailView.text = data.desc;
}
@end

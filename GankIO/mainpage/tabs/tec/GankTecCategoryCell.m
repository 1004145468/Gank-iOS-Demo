//
// Created by 杨浪 on 2020/8/30.
// Copyright (c) 2020 杨浪. All rights reserved.
//

#import "GankTecCategoryCell.h"
#import "Headers/Public/Masonry/View+MASAdditions.h"
#import "Headers/Public/SDWebImage/UIImageView+WebCache.h"

@interface GankTecCategoryCell ()

@property(nonatomic, weak) UIImageView *coverView;
@property(nonatomic, weak) UILabel *titleView;
@property(nonatomic, weak) UILabel *desView;

@end

@implementation GankTecCategoryCell

+ (instancetype)cellWithTableView:(UITableView *)tableView AndReuseIdentifier:(NSString *)reuseIdentifier {
    GankTecCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[GankTecCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectedBackgroundView = [UIView new];
    UIImageView *coverImageView = [UIImageView new];
    coverImageView.contentMode = UIViewContentModeCenter;
    coverImageView.clipsToBounds = YES;
    [self.contentView addSubview:coverImageView];
    self.coverView = coverImageView;
    UILabel *titleView = [UILabel new];
    titleView.font = [UIFont systemFontOfSize:18];
    [titleView setNumberOfLines:2];
    titleView.textColor = [UIColor blackColor];
    [self.contentView addSubview:titleView];
    self.titleView = titleView;
    UILabel *desView = [UILabel new];
    desView.font = [UIFont systemFontOfSize:16];
    [desView setNumberOfLines:2];
    desView.textColor = [UIColor grayColor];
    [self.contentView addSubview:desView];
    self.desView = desView;
    //set layout constraint
    [coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(10);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 90));
        make.bottom.mas_lessThanOrEqualTo(self.contentView.mas_bottom).mas_offset(-20);
    }];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(coverImageView.mas_right).mas_offset(20);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
        make.top.mas_equalTo(self.contentView.mas_top).mas_offset(10);
    }];
    [desView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(coverImageView.mas_right).mas_offset(20);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-10);
        make.top.mas_equalTo(self.titleView.mas_bottom).mas_offset(10);
        make.bottom.mas_lessThanOrEqualTo(self.contentView.mas_bottom).offset(-20);
    }];
    return self;
}

- (void)setData:(GankTecData *)data {
    NSURL *picUrl = nil;
    if (data.image != nil && data.image.count > 0) {
        NSString *picString = data.image[0];
        picUrl = [NSURL URLWithString:picString];
    }
    [self.coverView sd_setImageWithURL:picUrl placeholderImage:[UIImage imageNamed:@"place_hold"]];
    self.titleView.text = data.title;
    self.desView.text = data.desc;
}


@end
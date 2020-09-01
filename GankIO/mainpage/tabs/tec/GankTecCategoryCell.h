//
// Created by 杨浪 on 2020/8/30.
// Copyright (c) 2020 杨浪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import "GankTecData.h"


@interface GankTecCategoryCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView AndReuseIdentifier:(NSString *)reuseIdentifier;

@property(nonatomic, strong, setter=setData:) GankTecData *data;

@end
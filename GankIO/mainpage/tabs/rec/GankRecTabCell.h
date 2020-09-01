//
// Created by 杨浪 on 2020/8/27.
// Copyright (c) 2020 杨浪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import "GankRecFrameData.h"


@interface GankRecTabCell : UITableViewCell

+ (GankRecTabCell *)cellWithTableView:(UITableView *)tableView AndReuseIdentifier:(NSString *)identifier;

- (void)setData:(GankRecFrameData *)frameData;

@end
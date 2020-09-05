//
//  GankMyTabController.m
//  GankIO
//
//  Created by 杨浪 on 2020/8/25.
//  Copyright © 2020 杨浪. All rights reserved.
//

#import "GankMyTabController.h"
#import "Headers/Public/Masonry/View+MASAdditions.h"
#import "Headers/Public/SDWebImage/UIImageView+WebCache.h"
#import "GankSelectRecStrategyController.h"
#import "GankConstant.h"

@interface GankMyTabController ()

@property(nonatomic) NSMutableArray *dataList;

@end

@implementation GankMyTabController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"个人中心";
        self.tabBarItem.title = @"我的";
        self.tabBarItem.image = [UIImage imageNamed:@"my_normal"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"my_press"];
    }
    //mock data
    self.dataList = [NSMutableArray array];
    [self.dataList addObject:@[@"推荐策略"]];
    [self.dataList addObject:@[@"Mock", @"Mock", @"Mock"]];
    [self.dataList addObject:@[@"Mock", @"Mock", @"Mock", @"Mock"]];

    return self;
}

#pragma mark "-----ViewController生命周期"

- (void)loadView {
    [super loadView];
    NSLog(@"loadView");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    UIView *headView = [[UIView alloc] init];
    [headView setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top).mas_offset(mcNavBarAndStatusBarHeight);
        make.height.mas_equalTo(200);
    }];
    UIImageView *coverImgView = [UIImageView new];
    coverImgView.layer.masksToBounds = YES;
    coverImgView.layer.cornerRadius = 50;
    coverImgView.layer.borderColor = [[UIColor whiteColor] CGColor];
    coverImgView.layer.borderWidth = 3;
    [coverImgView setContentMode:UIViewContentModeScaleAspectFill];
    NSURL *requestUrl = [NSURL URLWithString:@"http://gank.io/images/d6bba8cf5b8c40f9ad229844475e9149"];
    [coverImgView sd_setImageWithURL:requestUrl placeholderImage:[UIImage imageNamed:@"place_hold"]];
    [headView addSubview:coverImgView];
    [coverImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headView.mas_left).mas_offset(20);
        make.centerY.mas_equalTo(headView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    UILabel *nickLabel = [UILabel new];
    nickLabel.text = @"涯上月灬指香";
    nickLabel.font = [UIFont boldSystemFontOfSize:20];
    nickLabel.textColor = [UIColor whiteColor];
    [nickLabel sizeToFit];
    [headView addSubview:nickLabel];
    [nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(coverImgView.mas_right).mas_offset(20);
        make.right.mas_lessThanOrEqualTo(headView.mas_right).mas_offset(-30);
        make.top.mas_equalTo(headView.mas_top).mas_offset(70);
    }];
    UILabel *detailView = [UILabel new];
    detailView.text = @"这个人很懒，什么也没有留下";
    detailView.font = [UIFont systemFontOfSize:18];
    detailView.textColor = [UIColor whiteColor];
    [detailView sizeToFit];
    [headView addSubview:detailView];
    [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nickLabel.mas_left);
        make.right.mas_lessThanOrEqualTo(headView.mas_right).mas_offset(-30);
        make.top.mas_equalTo(nickLabel.mas_bottom).mas_offset(10);
    }];
    //创建静态UITableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
//    tableView.scrollEnabled = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.top.mas_equalTo(headView.mas_bottom).mas_offset(10);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataList[(NSUInteger) section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reUsedIdentifier = @"my_item";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reUsedIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reUsedIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectedBackgroundView = [UIView new];
    }
    NSString *title = self.dataList[(NSUInteger) indexPath.section][(NSUInteger) indexPath.row];
    cell.textLabel.text = title;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = self.dataList[(NSUInteger) indexPath.section][(NSUInteger) indexPath.row];
    if ([title isEqualToString:@"推荐策略"]) {
        GankSelectRecStrategyController *controller = [[GankSelectRecStrategyController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear");
}

@end

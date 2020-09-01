//
//  GankRecTabController.m
//  GankIO
//
//  Created by 杨浪 on 202®0/8/25.
//  Copyright © 2020 杨浪. All rights reserved.
//

#import "GankRecTabController.h"
#import "GankNetworkManager.h"
#import "GankRecTabCell.h"
#import "GankDetailViewController.h"
#import "MJRefresh/MJRefresh.h"
#import "GankConstant.h"

@interface GankRecTabController ()

@property(nonatomic, copy) NSString *recWay;
@property(nonatomic, strong) NSMutableArray *data;

- (void)requestData;

@end

@implementation GankRecTabController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"推荐";
        self.tabBarItem.image = [UIImage imageNamed:@"rec_normal"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"rec_press"];
        //配置数据
        self.data = [NSMutableArray array];
        NSString *recWay = [[NSUserDefaults standardUserDefaults] stringForKey:KEY_REC_WAY];
        if (recWay == nil) {
            recWay = @"views";
        }
        self.recWay = recWay;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = [UIColor grayColor];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    //设置下拉刷新
    MJRefreshNormalHeader *refreshStateHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestData];
    }];
    refreshStateHeader.lastUpdatedTimeLabel.hidden = YES;
    [refreshStateHeader setAutomaticallyChangeAlpha:YES];
    [refreshStateHeader setTitle:@"下拉刷新数据" forState:MJRefreshStateIdle];
    [refreshStateHeader setTitle:@"释放更新数据" forState:MJRefreshStatePulling];
    [refreshStateHeader setTitle:@"正在加载数据" forState:MJRefreshStateRefreshing];
    self.tableView.mj_header = refreshStateHeader;
    //请求推荐数据
    [self requestData];
}

- (void)requestData {
    GankNetworkManager *httpManager = [GankNetworkManager shareManager];
    [httpManager requestHotDataWithType:@"views" AndCategory:@"Article" AndCount:20 AndSuccessCall:^(NSDictionary *_Nullable dictionary) {
        [self.tableView.mj_header endRefreshing];
        if (dictionary == nil) return;
        NSArray *data = dictionary[@"data"];
        if (data == nil || data.count < 1) return;
        //子线程处理数据，回主线程更新ui
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, DISPATCH_QUEUE_PRIORITY_HIGH), ^{
            NSMutableArray *newData = [NSMutableArray arrayWithCapacity:data.count];
            for (NSDictionary *dic in data) {
                GankRecFrameData *frameData = [GankRecFrameData recFrameWithDictionary:dic];
                [newData addObject:frameData];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.data removeAllObjects];
                [self.data addObjectsFromArray:newData];
                [self.tableView reloadData];
            });
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GankRecFrameData *frameData = self.data[(NSUInteger) indexPath.row];
    GankRecTabCell *cell = [GankRecTabCell cellWithTableView:tableView AndReuseIdentifier:@"rec_common"];
    [cell setData:frameData];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger selectRow = indexPath.row;
    GankRecFrameData *selectData = self.data[(NSUInteger) selectRow];
    NSString *title = selectData.data.title;
    NSString *linkUrl = selectData.data.url;
    //present detail viewController
    UIViewController *detailController = [GankDetailViewController controllerInNavigationController:title WithLink:linkUrl];
    [self presentViewController:detailController animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    GankRecFrameData *frameData = self.data[(NSUInteger) indexPath.row];
    return frameData.rowHeight;
}

@end

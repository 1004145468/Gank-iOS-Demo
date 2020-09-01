//
// Created by 杨浪 on 2020/8/30.
// Copyright (c) 2020 杨浪. All rights reserved.
//

#import "GankTecCategoryController.h"
#import "GankTecCategoryCell.h"
#import "GankTecFrameData.h"
#import "MJRefresh/MJRefresh.h"
#import "GankNetworkManager.h"
#import "GankDetailViewController.h"

@interface GankTecCategoryController ()

@property(nonatomic, assign) int currentPage;

@property(nonatomic, copy) NSString *keyWord;
@property(nonatomic, strong) NSMutableArray *dataList;

- (void)requestData;

@end

@implementation GankTecCategoryController

- (instancetype)initWithKeyWord:(NSString *)keyWord {
    self = [super init];
    if (self) {
        self.keyWord = keyWord;
        self.dataList = [NSMutableArray array];
    }
    return self;
}

+ (instancetype)controllerWithKeyWord:(NSString *)keyWord {
    return [[GankTecCategoryController alloc] initWithKeyWord:keyWord];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置tableView
    self.tableView.separatorColor = [UIColor grayColor];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    //设置下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.currentPage = 0;
        [self requestData];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setAutomaticallyChangeAlpha:YES];
    [header setTitle:@"下拉重新加载数据" forState:MJRefreshStateIdle];
    [header setTitle:@"松手加载数据" forState:MJRefreshStatePulling];
    [header setTitle:@"正在请求最新数据" forState:MJRefreshStateRefreshing];
    self.tableView.mj_header = header;
    //加载更多数据
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self requestData];
    }];
    [footer setTitle:@"点击或者上拉加载更多数据" forState:MJRefreshStateIdle];
    [footer setTitle:@"松手加载更多数据" forState:MJRefreshStatePulling];
    [footer setTitle:@"正在加载更多数据" forState:MJRefreshStateRefreshing];
    [footer setHidden:YES];
    self.tableView.mj_footer = footer;
    [self requestData];
}

- (void)requestData {
    GankNetworkManager *httpManager = [GankNetworkManager shareManager];
    int page = self.currentPage + 1;
    [httpManager requestCategory:@"Article" AndType:self.keyWord AndPage:page AndCount:10 AndSuccess:^(NSDictionary *dictionary) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (dictionary == nil)
            return;
        int pageCount = [dictionary[@"page_count"] intValue];
        self.tableView.mj_footer.hidden = (page >= pageCount);
        NSArray *dicArray = dictionary[@"data"];
        if (dicArray == nil || dicArray.count < 1) return;
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, DISPATCH_QUEUE_PRIORITY_HIGH), ^{
            NSMutableArray *newDataList = [NSMutableArray arrayWithCapacity:dicArray.count];
            for (NSDictionary *dic in dicArray) {
                GankTecFrameData *frameData = [GankTecFrameData frameDataWithDictionary:dic];
                [newDataList addObject:frameData];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                self.currentPage = self.currentPage + 1;
                if (page == 1) {
                    [self.dataList removeAllObjects];
                }
                [self.dataList addObjectsFromArray:newDataList];
                [self.tableView reloadData];
            });
        });
    }];
}


#pragma mark "tableview datasource"

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GankTecFrameData *frameData = self.dataList[(NSUInteger) indexPath.row];
    GankTecCategoryCell *cell = [GankTecCategoryCell cellWithTableView:tableView AndReuseIdentifier:@"common_tec"];
    [cell setData:frameData.data];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    GankTecFrameData *frameData = self.dataList[(NSUInteger) indexPath.row];
    return frameData.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GankTecFrameData *frameData = self.dataList[(NSUInteger) indexPath.row];
    NSString *title = frameData.data.title;
    NSString *link = frameData.data.url;
    UIViewController *detailController = [GankDetailViewController controllerInNavigationController:title WithLink:link];
    [self presentViewController:detailController animated:YES completion:nil];
}

@end
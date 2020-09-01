//
//  GankMMTabController.m
//  GankIO
//
//  Created by 杨浪 on 2020/8/25.
//  Copyright © 2020 杨浪. All rights reserved.
//

#import "GankMMTabController.h"
#import "GankMMCollectionViewCell.h"
#import "GankNetworkManager.h"
#import "MJRefresh.h"
#import "GankPicDetailController.h"

@interface GankMMTabController ()

@property(nonatomic, assign) int currentPage;
@property(nonatomic, strong) NSMutableArray *dataList;

- (void)requestData;

@end

@implementation GankMMTabController

- (instancetype)init {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGFloat itemWidth = [[UIScreen mainScreen] bounds].size.width / 2;
    flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth * 1.2f);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 5;
    self = [super initWithCollectionViewLayout:flowLayout];
    if (self) {
        self.tabBarItem.title = @"福利";
        self.tabBarItem.image = [UIImage imageNamed:@"mm_normal"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"mm_press"];
        self.dataList = [NSMutableArray array];
        [self.collectionView setBackgroundColor:[UIColor whiteColor]];
        [self.collectionView registerClass:[GankMMCollectionViewCell class] forCellWithReuseIdentifier:@"common_mm"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //config refresh header
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.currentPage = 0;
        [self requestData];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setAutomaticallyChangeAlpha:YES];
    [header setTitle:@"下拉换一批" forState:MJRefreshStateIdle];
    [header setTitle:@"释放刷新数据" forState:MJRefreshStatePulling];
    [header setTitle:@"正在更新数据" forState:MJRefreshStateRefreshing];
    self.collectionView.mj_header = header;
    //config footer header
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self requestData];
    }];
    footer.hidden = YES;
    [footer setTitle:@"上拉或者点击加载更多数据" forState:MJRefreshStateIdle];
    [footer setTitle:@"上拉或者点击加载更多数据" forState:MJRefreshStatePulling];
    [footer setTitle:@"上拉或者点击加载更多数据" forState:MJRefreshStateRefreshing];
    self.collectionView.mj_footer = footer;
    [self requestData];
}

- (void)requestData {
    GankNetworkManager *httpManager = [GankNetworkManager shareManager];
    int page = self.currentPage + 1;
    [httpManager requestCategory:@"Girl" AndType:@"Girl" AndPage:page AndCount:page AndSuccess:^(NSDictionary *dictionary) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        if (dictionary == nil) return;
        self.currentPage = self.currentPage + 1; //next page
        self.collectionView.mj_footer.hidden = NO;
        int pageCount = [dictionary[@"page_count"] intValue];
        if (page >= pageCount) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        NSArray *dicArray = dictionary[@"data"];
        if (dicArray == nil || dicArray.count < 1) return;
        NSMutableArray *newData = [NSMutableArray arrayWithCapacity:dicArray.count];
        for (NSDictionary *dic in dicArray) {
            GankMMData *mmData = [GankMMData dataWithDictionary:dic];
            [newData addObject:mmData];
        }
        if (page == 1) {
            [self.dataList removeAllObjects];
        }
        [self.dataList addObjectsFromArray:newData];
        [self.collectionView reloadData];
    }];
}

#pragma mark - collection view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GankMMCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"common_mm" forIndexPath:indexPath];
    GankMMData *data = self.dataList[(NSUInteger) indexPath.item];
    [cell updateData:data WithIndex:(int) indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GankMMCollectionViewCell *cell = (GankMMCollectionViewCell *) [collectionView cellForItemAtIndexPath:indexPath];
    CGRect rect = cell.picView.frame;
    CGRect itemRect = [self.view convertRect:rect fromView:cell.contentView];
    GankMMData *data = self.dataList[(NSUInteger) indexPath.item];
    NSURL *requestUrl = nil;
    if (data.images != nil && data.images.count > 0) {
        NSString *picStr = data.images[0];
        requestUrl = [NSURL URLWithString:picStr];
    }
    UIViewController *detailController = [GankPicDetailController openImageWithData:requestUrl AndRect:itemRect];
    [self presentViewController:detailController animated:NO completion:nil];
}

@end

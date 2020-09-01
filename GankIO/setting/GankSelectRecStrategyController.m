//
// Created by 杨浪 on 2020/8/31.
// Copyright (c) 2020 杨浪. All rights reserved.
//

#import "GankSelectRecStrategyController.h"
#import "Headers/Public/Masonry/View+MASAdditions.h"
#import "GankConstant.h"

@interface GankSelectRecStrategyController ()

@property(nonatomic, strong) NSMutableDictionary *titleMaps;

@end

@implementation GankSelectRecStrategyController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.titleMaps = [NSMutableDictionary dictionary];
        [self.titleMaps setValue:@"观看数" forKey:@"views"];
        [self.titleMaps setValue:@"点赞数" forKey:@"likes"];
        [self.titleMaps setValue:@"评论数" forKey:@"comments"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"选择推荐策略";
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [self.view addSubview:pickerView];
    [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(300);
        make.centerY.mas_equalTo(self.view.mas_centerY).mas_offset(-50);
    }];
    //查询上一次的记录
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *select_rec_way = [userDefaults stringForKey:KEY_REC_WAY];
    if (select_rec_way != nil) {
        NSUInteger indexOfObject = [self.titleMaps.allKeys indexOfObject:select_rec_way];
        if (indexOfObject != NSNotFound) {
            [pickerView selectRow:indexOfObject inComponent:0 animated:NO];
        }
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.titleMaps.allValues[(NSUInteger) row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    /**
     * 在ios下存储分为如下几类：
     * 1.用于存储应用配置 NSUserDefault
     * 2.用于存储加密数据 KeyChain
     * 3.文件存储：
     *  Plist 存储 NSSearchPathForDirectoriesInDomains
     *  Archiver 打包存储  NSKeyedArchiver
     *  Stream 大文件存储
     * 4.Sqlite数据库存储
     *
     * 在ios主要目录结构
     * 1.Application
     * 2.Library/Preference
     * 3.Library/Cache
     * 4.Document
     * 5.Temp
     */
    NSString *selectTitle = self.titleMaps.allKeys[(NSUInteger) row];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:selectTitle forKey:KEY_REC_WAY];
    [userDefaults synchronize];
}

@end
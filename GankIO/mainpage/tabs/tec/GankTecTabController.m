//
//  GankTecTabController.m
//  GankIO
//
//  Created by 杨浪 on 2020/8/25.
//  Copyright © 2020 杨浪. All rights reserved.
//

#import "GankTecTabController.h"
#import "GankTecCategoryController.h"

@interface GankTecTabController ()

@property(nonatomic, strong, getter=getCategories) NSArray *Categories;

@end

@implementation GankTecTabController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"技术";
        self.tabBarItem.image = [UIImage imageNamed:@"tec_normal"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"tec_press"];
        //设置PageController中menu
        [self setShowOnNavigationBar:YES];
        [self setMenuViewLayoutMode:WMMenuViewLayoutModeCenter];
        [self setMenuViewStyle:WMMenuViewStyleLine];
        [self setMenuBGColor:[UIColor whiteColor]];
        [self setMenuHeight:80];
        [self setMenuItemWidth:100];
        [self setTitleSizeNormal:18];
        [self setTitleSizeSelected:20];
    }
    return self;
}

- (NSArray *)getCategories {
    static NSArray *_titles = nil;
    if (_titles == nil) {
        _titles = @[@"Android", @"iOS", @"Flutter"];
    }
    return _titles;
}

#pragma mark - wmpageview data source

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.Categories.count;
}

- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    NSString *keyWord = self.Categories[(NSUInteger) index];
    return [GankTecCategoryController controllerWithKeyWord:keyWord];
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.Categories[(NSUInteger) index];
}

@end

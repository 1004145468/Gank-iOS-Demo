//
//  GankNetworkManager.h
//  GankIO
//
//  Created by 杨浪 on 2020/8/25.
//  Copyright © 2020 杨浪. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GankNetworkManager : NSObject

//获取单例对象
+ (instancetype)shareManager;

/**
 本周最热 API
 https://gank.io/api/v2/hot/<hot_type>/category/<category>/count/<count>
 请求方式: GET
 注:

 hot_type 可接受参数 views（浏览数） | likes（点赞数） | comments（评论数）
 category 可接受参数 Article | GanHuo | Girl
 count: [1, 20]
 */
- (void)requestHotDataWithType:(NSString *)type AndCategory:(NSString *)category AndCount:(int)count AndSuccessCall:(void (^)(NSDictionary *_Nullable dictionary))callback;

/**
 https://gank.io/api/v2/data/category/<category>/type/<type>/page/<page>/count/<count>
 请求方式: GET
 注:

 category 可接受参数 All(所有分类) | Article | GanHuo | Girl
 type 可接受参数 All(全部类型) | Android | iOS | Flutter | Girl ...，即分类API返回的类型数据
 count: [10, 50]
 page: >=1
 示例:

 获取妹子列表
 https://gank.io/api/v2/data/category/Girl/type/Girl/page/1/count/10
 获取Android干货列表
 https://gank.io/api/v2/data/category/GanHuo/type/Android/page/1/count/10
 */
- (void)requestCategory:(NSString *)category
                AndType:(NSString *)type
                AndPage:(int)page
               AndCount:(int)count
             AndSuccess:(void (^)(NSDictionary *_Nullable dictionary))success;

@end


NS_ASSUME_NONNULL_END

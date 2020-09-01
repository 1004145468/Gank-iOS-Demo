//
//  GankNetworkManager.m
//  GankIO
//
//  Created by 杨浪 on 2020/8/25.
//  Copyright © 2020 杨浪. All rights reserved.
//

#import "GankNetworkManager.h"
#import "AFNetworking.h"

static NSString *REQ_HOST = @"https://gank.io/api/v2";

@interface GankNetworkManager ()

+ (AFHTTPSessionManager *)getHttpSessionManager;

@end


@implementation GankNetworkManager

+ (instancetype)shareManager {
    static GankNetworkManager *shareManager = nil;
    if (shareManager == nil) {
        shareManager = [[GankNetworkManager alloc] init];
    }
    return shareManager;
}

+ (AFHTTPSessionManager *)getHttpSessionManager {
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    return sessionManager;
}

- (void)requestCategory:(NSString *)category
                AndType:(NSString *)type
                AndPage:(int)page
               AndCount:(int)count
             AndSuccess:(void (^)(NSDictionary *_Nullable dictionary))success {
    AFHTTPSessionManager *sessionManager = [GankNetworkManager getHttpSessionManager];
    NSString *requestUrl = [NSString stringWithFormat:@"%@/data/category/%@/type/%@/page/%d/count/%d", REQ_HOST, category, type, page, count];
    [sessionManager GET:requestUrl parameters:nil headers:nil progress:^(NSProgress *downloadProgress) {
                //do nothings
            }
                success:^(NSURLSessionDataTask *task, id responseObject) {
                    success(responseObject);
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"请求分类数据失败，error = %@", error);
            }];
}


- (void)requestHotDataWithType:(NSString *)type
                   AndCategory:(NSString *)category
                      AndCount:(int)count
                AndSuccessCall:(void (^)(NSDictionary *_Nullable dictionary))callback {
    AFHTTPSessionManager *sessionManager = [GankNetworkManager getHttpSessionManager];
    NSString *requestUrl = [NSString stringWithFormat:@"%@/hot/%@/category/%@/count/%d", REQ_HOST, type, category, count];
    [sessionManager GET:requestUrl parameters:nil headers:nil progress:^(NSProgress *_Nonnull downloadProgress) {
        //do nothings
    }           success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        callback(responseObject);
    }           failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        NSLog(@"请求热门数据失败，error = %@", error);
    }];
}

@end

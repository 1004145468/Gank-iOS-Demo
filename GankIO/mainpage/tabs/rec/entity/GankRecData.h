//
// Created by 杨浪 on 2020/8/27.
// Copyright (c) 2020 杨浪. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GankRecData : NSObject <NSCoding>

//"_id": "5e78b2f65d7c47fe610b0029",
//"author": "\u6254\u7269\u7ebf",
//"category": "Article",
//"createdAt": "2020-03-23 20:59:40",
//"desc": "\u6211\u4ece\u53bb\u5e74\u5f00\u59cb\u4f7f\u7528 RxJava \uff0c\u5230\u73b0\u5728\u4e00\u5e74\u591a\u4e86\u3002\u4eca\u5e74\u52a0\u5165\u4e86 Flipboard \u540e\uff0c\u770b\u5230 Flipboard \u7684 Android \u9879\u76ee\u4e5f\u5728\u4f7f\u7528 RxJava \uff0c\u5e76\u4e14\u4f7f\u7528\u7684\u573a\u666f\u8d8a\u6765\u8d8a\u591a \u3002\u800c\u6700\u8fd1\u8fd9\u51e0\u4e2a\u6708\uff0c\u6211\u4e5f\u53d1\u73b0\u56fd\u5185\u8d8a\u6765\u8d8a\u591a\u7684\u4eba\u5f00\u59cb\u63d0\u53ca RxJava \u3002\u6709\u4eba\u8bf4\u300eRxJava \u771f\u662f\u592a\u597d\u7528\u4e86\u300f\uff0c\u6709\u4eba\u8bf4\u300eRxJava \u771f\u662f\u592a\u96be\u7528\u4e86\u300f\uff0c\u53e6\u5916\u66f4\u591a\u7684\u4eba\u8868\u793a\uff1a\u6211\u771f\u7684\u767e\u5ea6\u4e86\u4e5f\u8c37\u6b4c\u4e86\uff0c\u4f46\u6211\u8fd8\u662f\u60f3\u95ee\uff1a RxJava \u5230\u5e95\u662f\u4ec0\u4e48\uff1f",
//"images": [
//"http://gank.io/images/9a91a5f16f9749638c0ba6ab2e1a3127",
//""
//],▸
//"likeCounts": 3,
//"publishedAt": "2015-10-02 12:59:40",
//"stars": 4,
//"title": "\u7ed9 Android \u5f00\u53d1\u8005\u7684 RxJava \u8be6\u89e3",
//"type": "Android",
//"url": "https://www.baidu.com",
//"views": 5254
@property(nonatomic, copy) NSString *author;
@property(nonatomic, copy) NSString *category;
@property(nonatomic, copy) NSString *createdAt;
@property(nonatomic, copy) NSString *desc;
@property(nonatomic, strong) NSArray *images;
@property(nonatomic, copy) NSString *publishedAt;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *url;

@property(nonatomic, assign) int likeCounts;
@property(nonatomic, assign) int views;
@property(nonatomic, assign) int stars;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (instancetype)initWithCoder:(NSCoder *)coder;

- (void)encodeWithCoder:(NSCoder *)coder;

+ (instancetype)recDataWithDictionary:(NSDictionary *)dictionary;


@end
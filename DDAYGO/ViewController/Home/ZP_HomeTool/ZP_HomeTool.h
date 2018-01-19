//
//  ZP_HomeTool.h
//  DDAYGO
//
//  Created by Summer on 2017/11/10.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZP_HomeTool : NSObject

// 获取国家列表
+ (void)requesPosition:(NSDictionary *)Position success:(void(^)(id obj))success failure:(void (^)(NSError *error))failure;

// 74) 查询广告列表
+ (void)requestGetadvertlist:(NSDictionary *)Getadvertlist success:(void(^)(id obj))success failure:(void (^)(NSError *error))failure;

//  获取首页八大分类
+ (void)requesFirst:(NSDictionary *)First success:(void (^)(id))success failure:(void (^)(NSError *))failure ;

// 获取热销商品
+(void)requestSellLikeHotCakes:(NSDictionary *)sd success:(void(^)(id obj))success failure:(void (^)(NSError *error))failure;

// 获取精选商品
+(void)requSelectLikeHotCakes:(NSDictionary *)jx success:(void(^)(id obj))success failure:(void (^)(NSError * reeor))failure;
@end

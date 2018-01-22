//
//  ZP_ClassViewTool.h
//  DDAYGO
//
//  Created by Summer on 2017/10/26.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZP_ClassViewTool : NSObject

// 获取分类类目，大分类
+ (void)requClassIfication:(NSDictionary *)dfl success:(void(^)(id obj))success failure:(void(^)(NSError * error))failure;


// 获取分类类目，（二级）
+ (void)requClassIficationrj:(NSDictionary *)dflrj success:(void(^)(id obj))success failure:(void(^)(NSError * error))failure;

//  商品分类
+ (void)requMerchandise:(NSDictionary *)spfl WithIndex:(NSUInteger)index success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//  商品详情
+ (void)requDetails:(NSDictionary *)spxq success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//  商品评价
+ (void)requEvaluates:(NSDictionary *)sppj success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure;

/**
 *获取确认订单信息
 */
+ (void)requPay:(NSDictionary *)spxq success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 *根据颜色尺码ID查询库存
 */
+ (void)requColorOrSize:(NSDictionary *)dic success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 *加入购物车
 */
+ (void)requAddToCart:(NSDictionary *)dic success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure;

/**
 * 收藏
 */
+ (void)requshoucang:(NSDictionary *)dic success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure;

/**
 * 取消收藏
 */
+ (void)requCancelshoucang:(NSDictionary *)dic success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure;

//获取图片
//+ (void)requImage:(NSString *)url success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure;

//75) 获取店铺信息
+ (void)requestGetshopinfos: (NSDictionary *)Getshopinfos success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure;

//76) 获取店铺评论
+ (void)requestGetshopreviews:(NSDictionary *)Getshopreviews success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure;
// 店铺简介
+ (void)requestShopintroduction: (NSDictionary *)Shopintroduction success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure;

//77) 根据大分类和子分类，获取该分类下产品，默认销量排序，支持排序最新，好评，价格
+ (void)requestGetproductfilter:(NSDictionary *)Getproductfilter success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure;
@end

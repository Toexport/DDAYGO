//
//  ZP_shoopingTool.h
//  DDAYGO
//
//  Created by Summer on 2017/11/10.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZP_shoopingTool : NSObject
//  获取地址
+ (void)requGetAddress:(NSDictionary *)Address success:(void (^)(id))success failure:(void (^)(NSError *))failure;
// 获取确认订单信息
+ (void)requesMakeSureOrder:(NSDictionary *)MakeSureOrder success:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 79) 修改購物車商品數量
+ (void)requestSetcartproductcount:(NSDictionary *)Setcartproductcount success:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 选择支付方式
+ (void)requetMethodpay:(NSDictionary *)Methodpay success:(void (^)(id))success failure:(void (^)(NSError *))failure;
// 添加订单并付款
+ (void)requesAddOrdersPay:(NSDictionary *)AddOrdersPay success:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 获取确认订单界面数据
+ (void)requesOrders:(NSDictionary *)Oredrs success:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 获取确认订单界面支付数据
+ (void)requesOrdersPay:(NSDictionary *)OrdersPay success:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 获取购物车信息
+ (void)requesshoppingData:(NSString *)token success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure;

// 添加订单并付款
+ (void)requessaddorderpay:(NSDictionary *)dic noEdit:(BOOL)noEdit success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure;

//  删除购物车
+ (void)requesscartitemdelte:(NSDictionary *)dic success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure;
@end


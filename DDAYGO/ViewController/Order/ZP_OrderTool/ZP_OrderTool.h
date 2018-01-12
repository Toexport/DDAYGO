//
//  ZP_OrderTool.h
//  DDAYGO
//
//  Created by Summer on 2017/11/17.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZP_OrderTool : NSObject

//  商品评价，商家评价
+ (void)requestAppraise:(NSDictionary *)Appraise success:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 订单协议
+ (void)requestGetorders:(NSDictionary *)Appraise success:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 获取退换货原因列表
+ (void)requestSelect:(NSDictionary *)Select success:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 获取退换货申请页面信息
+ (void)requestRequestRefund: (NSDictionary *)RequestRefund success:(void (^)(id))success failure:(void (^)(NSError *))failure;
@end



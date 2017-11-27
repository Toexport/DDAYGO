//
//  ZP_shoopingTool.m
//  DDAYGO
//
//  Created by Summer on 2017/11/10.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_shoopingTool.h"
#import "PrefixHeader.pch"
#import "ZP_NetorkingTools.h"
@implementation ZP_shoopingTool

//+ (void)requsetShopping:(NSDictionary *)Shopping success:(void (^)(id))success failure:(void (^)(NSError *))failure {
//    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@%@",URLAPI, ShoppingAPI] parameters:nil success:^(NSDictionary *responseObject) {
//        success(responseObject);
//        ZPLog(@"%@",responseObject);
//    } failure:^(NSError *error) {
//        failure(error);
//        ZPLog(@"%@",error);
//    }];
//}

//  获取地址
+ (void)requGetAddress:(NSDictionary *)Address success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@%@",URLAPI,RequestAddress] parameters:Address success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
// 获取确认订单信息
+ (void)requesMakeSureOrder:(NSDictionary *)MakeSureOrder success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@%@",URLAPI, MakeSureOrderAPI] parameters:MakeSureOrder success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
// 选择支付方式
+(void)requetMethodpay:(NSDictionary *)Methodpay success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@%@", URLAPI,RequetMethodpay] parameters:Methodpay success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
// 添加订单并付款
+ (void)requesAddOrdersPay:(NSDictionary *)AddOrdersPay success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"http://localhost:39499/api/Test/addorder?token=%@&stockids=%@&adsid=%@&logistic=%@&payway=%@&leavemsg=%@&icuetoken=%@",AddOrdersPay[@"token"],AddOrdersPay[@"stockids"],AddOrdersPay[@"adsid"],AddOrdersPay[@"logistic"],AddOrdersPay[@"payway"],AddOrdersPay[@"leavemsg"],AddOrdersPay[@"icuetoken"]] parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 获取购物车信息
+ (void)requesshoppingData:(NSString *)token success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure {
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@cart?token=%@",URLAPI,token] parameters:nil success:^(id responseObject) {
        success(responseObject);
//        ZPLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
// 支付
+ (void)requessaddorderpay:(NSDictionary *)dic noEdit:(BOOL)noEdit success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure{

    NSString *url;
    if (noEdit) {
        url = [NSString stringWithFormat:@"%@updateorderpay?token=%@&orderno=%@&adsid=%@&logistic=1&payway=%@&leavemsg=%@&icuetoken=%@",URLAPI,dic[@"token"],dic[@"ordersnumber"],dic[@"adsid"],dic[@"payway"],dic[@"leavemsg"],dic[@"icuetoken"]];
    } else {
        url = [NSString stringWithFormat:@"%@addorderpay?token=%@&stockids=%@&adsid=%@&logistic=1&payway=%@&leavemsg=%@&icuetoken=%@",URLAPI,dic[@"token"],dic[@"stockids"],dic[@"adsid"],dic[@"payway"],dic[@"leavemsg"],dic[@"icuetoken"]];
    }
    [ZP_NetorkingTools POST:url parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
    
}

@end


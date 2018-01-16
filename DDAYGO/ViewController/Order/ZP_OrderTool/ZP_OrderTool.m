//
//  ZP_OrderTool.m
//  DDAYGO
//
//  Created by Summer on 2017/11/17.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_OrderTool.h"
#import "ZP_NetorkingTools.h"
#import "PrefixHeader.pch"
@implementation ZP_OrderTool

//  商品评价，商家评价
+ (void)requestAppraise:(NSDictionary *)Appraise success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@addreviews?oid=%@&preview=%@&sreview=%@&token=%@&supscore=%@",URLAPI,Appraise[@"oid"],Appraise[@"preview"],Appraise[@"sreview"],Appraise[@"token"],Appraise[@"supscore"]] parameters:nil success:^(NSDictionary *responseObject) {
        
        success(responseObject);
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

// 订单协议
+ (void)requestGetorders:(NSDictionary *)Appraise success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@getorders?",URLAPI] parameters:Appraise success:^(id responseObject) {
        
        success(responseObject);
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}

// 删除订单
+ (void)requestDeleteOrder:(NSDictionary *)DeleteOrder success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@deletecustomerorder?ordernumber=%@&token=%@",URLAPI,DeleteOrder[@"ordernumber"],DeleteOrder[@"token"]] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 67) 获取退换货申请页面商品信息
+ (void)requestRequestRefund: (NSDictionary *)RequestRefund success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@getrefundproductinfo?token=%@&rty=%@&oid=%@",URLAPI,RequestRefund[@"token"],RequestRefund[@"rty"],RequestRefund[@"oid"]] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError * error) {
        failure(error);
    }];
}

// 获取退换货原因列表
+ (void)requestSelect:(NSDictionary *)Select success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString * strurl = [NSString stringWithFormat:@"%@getrefundreasonlist?token=%@&countrycode=%@",URLAPI,Select[@"token"],Select[@"countrycode"]];
    NSString * str = [strurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ZP_NetorkingTools GET:str parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError * error) {
        failure(error);
    }];
}
// 69) 添加退换货记录
+ (void)requestAddRefund:(NSDictionary *)AddRefund  success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString * strUrl = [NSString stringWithFormat:@"%@addrefund?token=%@&rty=%@&oid=%@&reason=%@&reasondetail=%@&imgs=%@",URLAPI,AddRefund[@"token"],AddRefund[@"rty"],AddRefund[@"oid"],AddRefund[@"reason"],AddRefund[@"reasondetail"],AddRefund[@"imgs"]];
    NSString * str = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ZP_NetorkingTools POST:str parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 上传退换货相关图片
+ (void)requestUploadrefundimgs:(NSDictionary *)Uploadrefundimgs success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString * strUrl = [NSString stringWithFormat:@"%@uploadrefundimgs",URLAPI];
    NSString * str = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ZP_NetorkingTools POST:str parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end


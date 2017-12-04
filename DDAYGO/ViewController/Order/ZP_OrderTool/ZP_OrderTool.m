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
    http://www.ddaygo.com/api/Test/addreviews?preview=21,7,5,薄荷清新爽口&oid=117102618112236642&supscore=5.0&sreview=sdfadfa&token=
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@addreviews?preview=%@&oid=%@&supscore=%@&sreview=%@&token=%@",URLAPI,Appraise[@"preview"],Appraise[@"oid"],Appraise[@"supscore"],Appraise[@"sreview"],Appraise[@"token"]] parameters:nil success:^(NSDictionary *responseObject) {
        
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
@end


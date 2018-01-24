//
//  ZP_ClassViewTool.m
//  DDAYGO
//
//  Created by Summer on 2017/10/26.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_ClassViewTool.h"
#import "ZP_NetorkingTools.h"
#import "PrefixHeader.pch"
@implementation ZP_ClassViewTool

// 获取分类类目，大分类
+ (void)requClassIfication:(NSArray *)dfl success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@%@", URLAPI, HotAPI] parameters:dfl success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

// 获取分类类目，（二级）
+(void)requClassIficationrj:(NSDictionary *)dflrj success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@%@", URLAPI, AdvertisingAPI] parameters:dflrj success:^(NSDictionary *responseObject) {
        success(responseObject);
        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//  商品分类
+ (void)requMerchandise:(NSDictionary *)spfl WithIndex:(NSUInteger)index success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSArray * arr = @[@"default",@"sale",@"price",@"time"];

    
//    http://192.168.0.117:7000/api/Test/productfilter?fatherid=&sort=&seq=&word=&countrycode=&page=&pagesize=
//    http://192.168.0.117:7000/api/Test/productfilter?seq=&countrycode=&word=&fatherid=&sort=&page=&pagesize=

    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@productfilter?seq=%@&countrycode=%@&word=%@&fatherid=%@&sort=%@&page=%@&pagesize=%@",URLAPI,spfl[@"seq"],spfl[@"countrycode"],spfl[@"word"],spfl[@"fatherid"],arr[index],spfl[@"page"],spfl[@"pagesize"]] parameters:nil success:^(NSDictionary *responseObject) {
        //        ZPLog(@"%@",responseObject);
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
        //        ZPLog(@"%@",error);
    }];
}

//  商品详情
+ (void)requDetails:(NSDictionary *)spxq success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@%@?productid=%@&token=%@", URLAPI,Details,spxq[@"productid"],spxq[@"token"]] parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
        //        ZPLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        failure(error);
        
    }];
}

//  商品评价
+ (void)requEvaluates:(NSDictionary *)sppj success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@getproductreview?productid=%@&page=%@&pagesize=%@", URLAPI,sppj[@"productid"],sppj[@"page"],sppj[@"pagesize"]] parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//  立即购买
+ (void)requPay:(NSDictionary *)spxq success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@ordersaddinfo", URLAPI] parameters:spxq success:^(NSDictionary *responseObject) {
        success(responseObject);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}
//  根据颜色尺码ID查询库存
+ (void)requColorOrSize:(NSDictionary *)dic success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@getcolornormstockid", URLAPI] parameters:dic success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 *加入购物车
 */
+ (void)requAddToCart:(NSDictionary *)dic success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure {
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@addcart?amount=%@&stockid=%@&token=%@", URLAPI,dic[@"amount"],dic[@"stockid"],dic[@"token"]] parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 * 收藏
 */
+ (void)requshoucang:(NSDictionary *)dic success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure{
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@addcollections?productid=%@&token=%@", URLAPI,dic[@"productid"],dic[@"token"]] parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 * 取消收藏
 */
+ (void)requCancelshoucang:(NSDictionary *)dic success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure{
    [ZP_NetorkingTools POST:[NSString stringWithFormat:@"%@deletecollection?productid=%@&token=%@", URLAPI,dic[@"productid"],dic[@"token"]] parameters:nil success:^(NSDictionary *responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//+ (void)requImage:(NSString *)url success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure {
//    [ZP_NetorkingTools GET:url parameters:nil success:^(NSDictionary *responseObject) {
//        success([UIImage imageWithData:responseObject]);
//    } failure:^(NSError *error) {
//        NSDictionary *dic = error;
//        failure(error);
//    }];
//}

//75) 获取店铺信息
+ (void)requestGetshopinfos: (NSDictionary *)Getshopinfos success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@getshopinfos?supplierid=%@",URLAPI,Getshopinfos[@"supplierid"]] parameters:nil success:^(id responseObject) {
        success(responseObject);
        
    } failure:^(NSError * error) {
        failure(error);
    }];
}

//76) 获取店铺评论
+ (void)requestGetshopreviews:(NSDictionary *)Getshopreviews success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure{

//    NSString * strUrl = [NSString stringWithFormat:[NSString stringWithFormat:@"%@getshopreviews?sid=%@&page=%@&pagesize=%@",URLAPI,Getshopreviews[@"sid"],Getshopreviews[@"page"],Getshopreviews[@"pagesize"]];
    NSString * strUrl = [NSString stringWithFormat:@"%@getshopreviews?sid=%@&page=%@&pagesize=%@",URLAPI,Getshopreviews[@"sid"],Getshopreviews[@"page"],Getshopreviews[@"pagesize"]];
     NSString * urlString = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ZP_NetorkingTools GET:urlString parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError * error) {
        failure(error);
    }];
}
// 店铺简介
+ (void)requestShopintroduction: (NSDictionary *)Shopintroduction success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure {
    [ZP_NetorkingTools GET:[NSString stringWithFormat:@"%@shopintroduction?supplierid=%@",URLAPI,Shopintroduction[@"supplierid"]] parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError * error) {
        failure(error);
        ZPLog(@"%@",error);
    }];
}

//77) 根据大分类和子分类，获取该分类下产品，默认销量排序，支持排序最新，好评，价格
+ (void)requestGetproductfilter:(NSDictionary *)Getproductfilter success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure {
//    NSString * strUrl = [NSString stringWithFormat:@"%@getproductfilter?fathid=%@&sort=%@&seq=%@&word=%@&countrycode=%@&page=%@&pagesize=%@",URLAPI,Getproductfilter[@"fathid"],Getproductfilter[@"sort"],Getproductfilter[@"seq"],Getproductfilter[@"word"],Getproductfilter[@"countrycode"],Getproductfilter[@"page"],Getproductfilter[@"pagesize"]];
    NSString * strUrl = [NSString stringWithFormat:@"%@getproductfilter?token=%@&sid=%@&fathid=%@&sort=%@&seq=%@&word=%@&countrycode=%@&page=%@&pagesize=%@",URLAPI,Getproductfilter[@"token"],Getproductfilter[@"sid"],Getproductfilter[@"fathid"],Getproductfilter[@"sort"],Getproductfilter[@"seq"],Getproductfilter[@"word"],Getproductfilter[@"countrycode"],Getproductfilter[@"page"],Getproductfilter[@"pagesize"]];
    NSString * str = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [ZP_NetorkingTools GET:str parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError * error) {
        failure(error);
    }];
}
@end


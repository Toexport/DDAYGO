//
//  ZP_ShoppingModel.m
//  DDAYGO
//
//  Created by Summer on 2017/11/10.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_ShoppingModel.h"
#import "PrefixHeader.pch"
@implementation ZP_ShoppingModel
//  今天新增商品详情的判断是否为没有登录状态
+ (instancetype)CreateWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    };
    return self;
}
- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key
{
    
}

//http://www.ddaygo.com/api/Test/addorderpay?icuetoken=nil&leavemsg=nihaoya&stockids=3_1&logistic=1&token=6a82c076d36524b8e7b8c2b8e3db37b1&payway=allpay_balance&adsid=44

@end


@implementation ZP_CartsModel

+ (NSMutableArray *)arrayWithArray:(NSArray *)array{
    NSMutableArray *arr =[NSMutableArray array];
    for (NSDictionary *dic in array) {
        ZP_CartsModel *model = [[ZP_CartsModel alloc]init];
        model.defaultimg = [NSString stringWithFormat:@"%@%@",ImgAPI, dic[@"defaultimg"]];
        model.createtime = dic[@"createtime"];
        model.productname = dic[@"productname"];
        model.productremark = dic[@"productremark"];
        model.suppliername = dic[@"suppliername"];
        model.colorname = dic[@"colorname"];
        model.normname = dic[@"normname"];
        model.priceamount = dic[@"priceamount"];
        model.productprice = dic[@"productprice"];
        model.amount = dic[@"amount"];
        model.cp = dic[@"cp"];
        model.stockid = dic[@"stockid"];
        [arr addObject:model];
    }
    return arr;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"Carts" : [ZP_CartsModel class]};
}

@end


@implementation ZP_CartsShopModel
+ (NSMutableArray *)arrayWithArray:(NSArray *)array{
    NSMutableArray *arr =[NSMutableArray array];
    for (NSDictionary *dic in array) {
        ZP_CartsShopModel *model = [[ZP_CartsShopModel alloc]init];
        model.shopname = dic[@"shopname"];
//        model.symbol = dic[@"symbol"];
        model.supplierid = dic[@"supplierid"];
        NSArray * arrays = dic[@"cart"];
        if (arrays.count>0) {
            model.array = [ZP_CartsModel arrayWithArray:arrays];
        }
        [arr addObject:model];
    }
    return arr;
}

@end


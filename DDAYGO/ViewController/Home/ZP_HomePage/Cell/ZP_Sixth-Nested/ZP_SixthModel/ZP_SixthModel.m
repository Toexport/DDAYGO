//
//  ZP_SixthModel.m
//  DDAYGO
//
//  Created by Summer on 2017/10/26.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_SixthModel.h"
#import "PrefixHeader.pch"
@implementation ZP_SixthModel
+ (instancetype) GetSixthData:(NSDictionary *)dic {
    return [[self alloc]initWithSixthData:dic];
}

- (instancetype)initWithSixthData:(NSDictionary *) Dic {
    if (self == [super init]) {
        self.defaultimg = Dic[@"defaultimg"];
        self.productname = Dic[@"productname"];
    }
    return self;
}
+ (id)cheakNull:(id)dic {
    if ([dic isEqual:[NSNull null]]) {
        return @"";
    }
    return dic;
}

+ (NSMutableArray *)arrayWithArray:(NSArray *)array {
//    NSMutableArray * arr = [[NSMutableArray alloc]init];
//    for (NSDictionary * dic in array) {
//        ZP_SixthModel * model = [[ZP_SixthModel alloc]init];
//        model.defaultimg = [NSString stringWithFormat:@"%@%@",ImgAPI,dic[@"defaultimg"]];
//        model.productname = dic[@"productname"];
//        model.productid = dic[@"productid"];
//        model.PreferentialLabel = [NSString stringWithFormat:@"%@", dic[@"productprice"]];
//        model.TrademarkLabel = [NSString stringWithFormat:@"%@", dic[@"cp"]];
//        [arr addObject:model];
//    }
//    return arr;
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (NSDictionary * dic in array) {
        ZP_SixthModel * model = [[ZP_SixthModel alloc]init];
        model.defaultimg = [NSString stringWithFormat:@"%@%@",ImgAPI,dic[@"defaultimg"]];
        model.productname = dic[@"productname"];
        model.productid = dic[@"productid"];
        model.PreferentialLabel = [NSString stringWithFormat:@"%@", dic[@"productprice"]];
        model.TrademarkLabel = [NSString stringWithFormat:@"%@", dic[@"cp"]];
        [arr addObject:model];
    }
    return arr;
}
@end

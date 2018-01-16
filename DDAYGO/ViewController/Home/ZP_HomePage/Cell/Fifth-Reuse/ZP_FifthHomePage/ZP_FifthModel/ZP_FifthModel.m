//
//  ZP_FifthModel.m
//  DDAYGO
//
//  Created by Summer on 2017/10/25.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_FifthModel.h"
#import "PrefixHeader.pch"
@implementation ZP_FifthModel
+ (instancetype)GetFifthData:(NSDictionary *)dic {
    return [[self alloc]initWithFifthData:dic];
}

- (instancetype)initWithFifthData:(NSDictionary *)Dic {
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
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (NSDictionary * dic in array) {
        ZP_FifthModel * model = [[ZP_FifthModel alloc]init];
        model.defaultimg = [NSString stringWithFormat:@"%@%@",ImgAPI,dic[@"defaultimg"]];
        model.productname = dic[@"productname"];
        model.producid = dic[@"productid"];
        model.PreferentialLabel = [NSString stringWithFormat:@"%@",dic[@"productprice"]];
        model.TrademarkLabel = [NSString stringWithFormat:@"%@",dic[@"cp"]];
        [arr addObject:model];
    }
    return arr;
}

@end

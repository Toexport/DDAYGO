//
//  ZP_InformationModel.m
//  DDAYGO
//
//  Created by Summer on 2017/11/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_InformationModel.h"
#import "PrefixHeader.pch"
@implementation ZP_InformationModel
+ (instancetype)GetInformationData:(NSDictionary *)dic {
    return [[self alloc]initWithInformationData:dic];
}

- (instancetype)initWithInformationData:(NSDictionary *)Dic {
    if (self == [super init]) {
        self.defaultimg = [NSString stringWithFormat:@"%@%@",ImgAPI,Dic[@"defaultimg"]];
        self.productname = Dic[@"productname"];
        self.productprice = [NSString stringWithFormat:@"%@",Dic[@"productprice"]];
        self.amount = [NSString stringWithFormat:@"%@",Dic[@"amount"]];
        self.cp = [NSString stringWithFormat:@"%@",Dic[@"cp"]];
        self.shopname = Dic[@"shopname"];
        self.productid = Dic[@"productid"];
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
        ZP_InformationModel * model = [[ZP_InformationModel alloc]init];
        model.defaultimg = [NSString stringWithFormat:@"%@%@",ImgAPI,dic[@"defaultimg"]];
        model.productname = dic[@"productname"];
        model.suppliername = dic[@"suppliername"];
        model.allamount = dic[@"allamount"];
        model.amount = [NSString stringWithFormat:@"%@",dic[@"amount"]];
        model.productprice = [NSString stringWithFormat:@"%@",dic[@"productprice"]];
        model.cp = [NSString stringWithFormat:@"%@",dic[@"cp"]];
        model.shopname = dic[@"shopname"];
        model.productid = dic[@"productid"];
        [arr addObject:model];
    }
    return arr;
}
@end

//
//  ZP_InformationModel.m
//  DDAYGO
//
//  Created by Summer on 2017/11/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_InformationModel.h"

@implementation ZP_InformationModel
+ (instancetype)GetInformationData:(NSDictionary *)dic {
    return [[self alloc]initWithInformationData:dic];
}

- (instancetype)initWithInformationData:(NSDictionary *)Dic {
    if (self == [super init]) {
        self.defaultimg = [NSString stringWithFormat:@"http://www.ddaygo.com%@",Dic[@"defaultimg"]];
        self.productname = Dic[@"productname"];
        self.productprice = [NSString stringWithFormat:@"%@",Dic[@"productprice"]];
        self.amount = [NSString stringWithFormat:@"%@",Dic[@"amount"]];
        self.cp = [NSString stringWithFormat:@"%@",Dic[@"cp"]];
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
        model.defaultimg = [NSString stringWithFormat:@"http://www.ddaygo.com%@",dic[@"defaultimg"]];
        model.productname = dic[@"productname"];
        model.suppliername = dic[@"suppliername"];
        model.amount = [NSString stringWithFormat:@"%@",dic[@"amount"]];
        model.productprice = [NSString stringWithFormat:@"%@",dic[@"productprice"]];
        model.cp = [NSString stringWithFormat:@"%@",dic[@"cp"]];
        [arr addObject:model];
    }
    return arr;
}
@end

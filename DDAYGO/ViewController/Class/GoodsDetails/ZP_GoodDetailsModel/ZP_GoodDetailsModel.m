//
//  ZP_GoodDetailsModel.m
//  DDAYGO
//
//  Created by Summer on 2017/11/2.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_GoodDetailsModel.h"

@implementation ZP_GoodDetailsModel
+ (instancetype) getGoodDetailsData:(NSDictionary *)Dic {
    return [[self alloc]initWithGoodDetailsData:Dic];
}

- (instancetype)initWithGoodDetailsData:(NSDictionary *)dic {
    if (self == [super init]) {
        self.defaultimg = [NSString stringWithFormat:@"http://www.ddaygo.com%@", dic[@"defaultimg"]];
        self.productname = dic[@"productname"];
        self.productprice = [NSString stringWithFormat:@"%@",dic[@"productprice"]];
        self.TrademarkLabel = [NSString stringWithFormat:@"%@", dic[@"cp"]];
        self.quantity = [NSString stringWithFormat:@"%@",dic[@"per"]];
        self.peramount = [NSString stringWithFormat:@"%@",dic[@"peramount"]];
        self.productid = [NSString stringWithFormat:@"%@",dic[@"productid"]];
        self.productamount = [NSString stringWithFormat:@"%@",dic[@"productamount"]];
        self.state = dic[@"state"];
    }
    return self;
}

+ (id)cheakNull:(id)dic {
    if ([dic isEqual:[NSNull null]]) {
        return @"";
    }
    return dic;
}

+ (NSMutableArray *)arrayWithArray:(NSDictionary *)array {
    
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (NSDictionary * dic in array) {
        ZP_GoodDetailsModel * model = [[ZP_GoodDetailsModel alloc]init];
        model.cnimg = [NSString stringWithFormat:@"http://www.ddaygo.com%@", dic[@"cnimg"]];
        model.cnname = dic[@"cnname"];
        model.cntype = dic[@"cntype"];
        model.productid = [NSString stringWithFormat:@"%@", dic[@"productid"]];
        model.sort = [NSString stringWithFormat:@"%@",dic[@"sort"]];
        model.cnid = dic[@"cnid"];
        if ([model.cntype isEqualToNumber:@1]) {
            [arr addObject:model];
        }
    }
    return arr;
}

+ (NSMutableArray *)arrayWithTypeArray:(NSDictionary *)array {
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (NSDictionary * dic in array) {
        ZP_GoodDetailsModel * model = [[ZP_GoodDetailsModel alloc]init];
        model.cnimg = [NSString stringWithFormat:@"http://www.ddaygo.com%@", dic[@"cnimg"]];
        model.cnname = dic[@"cnname"];
        model.cntype = dic[@"cntype"];
        model.productid = [NSString stringWithFormat:@"%@", dic[@"productid"]];
        model.sort = [NSString stringWithFormat:@"%@",dic[@"sort"]];
        model.cnid = dic[@"cnid"];
        if ([model.cntype isEqualToNumber:@2]) {
            [arr addObject:model];
        }
    }
    return arr;
}
@end


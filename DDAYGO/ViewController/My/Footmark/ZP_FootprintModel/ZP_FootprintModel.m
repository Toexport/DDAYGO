//
//  ZP_FootprintModel.m
//  DDAYGO
//
//  Created by Summer on 2017/11/24.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_FootprintModel.h"
#import "PrefixHeader.pch"
@implementation ZP_FootprintModel

+ (NSMutableArray *)arrayWithArray:(NSArray *)array {
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    if (array.count > 0) {
        for (NSDictionary * dic in array) {
            ZP_FootprintModel * model = [[ZP_FootprintModel alloc]init];
            model.createdate = dic[@"createdate"];
            model.historyArray = [ZP_FootprintModel1 arrayWithArray1:dic[@"historylist"]];
            [arr addObject:model];
        }
        
    }
    return arr;
}
@end


@implementation ZP_FootprintModel1

+ (instancetype)gEtFootprint1:(NSDictionary *)Dic {
    return [[self alloc]initWithFootprintData:Dic];
}

- (instancetype)initWithFootprintData:(NSDictionary *)dic {
    if (self == [super init]) {
        self.defaultimg = [NSString stringWithFormat:@"%@%@",ImgAPI,dic[@"defaultimg"]];
        self.productname = dic[@"productname"];
        self.productprice = [NSString stringWithFormat:@"%@",dic[@"productprice"]];
        self.cp = [NSString stringWithFormat:@"%@",dic[@"cp"]];
        self.state = dic[@"state"];
        self.productid = dic[@"productid"];
    }
    return self;
}

+ (NSMutableArray *)arrayWithArray1:(NSArray *)array {
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    if (array.count > 0) {
        
        for (NSDictionary * dic in array) {
            ZP_FootprintModel1 * model = [[ZP_FootprintModel1 alloc]init];
            model.defaultimg = [NSString stringWithFormat:@"%@%@",ImgAPI,dic[@"defaultimg"]];
            model.productname = dic[@"productname"];
            model.productprice = [NSString stringWithFormat:@"%@",dic[@"productprice"]];
            model.cp = [NSString stringWithFormat:@"%@",dic[@"cp"]];
            model.historyid = dic[@"historyid"];
            model.productid = dic[@"productid"];
            model.state = dic[@"state"];
            [arr addObject:model];
        }
        
    }
    return arr;
}
@end


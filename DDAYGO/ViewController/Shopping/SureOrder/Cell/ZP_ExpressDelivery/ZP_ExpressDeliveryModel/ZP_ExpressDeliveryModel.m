//
//  ZP_ExpressDeliveryModel.m
//  DDAYGO
//
//  Created by Summer on 2017/11/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_ExpressDeliveryModel.h"

@implementation ZP_ExpressDeliveryModel

+ (instancetype)GetExpressDeliveryData:(NSDictionary *)dic {
    return [[self alloc]initWithInformationData:dic];
}

- (instancetype)initWithInformationData:(NSDictionary *)Dic {
    if (self == [super init]) {
        self.freightamount = [NSString stringWithFormat:@"%@",Dic[@"freightamount"]];
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
        ZP_ExpressDeliveryModel * model = [[ZP_ExpressDeliveryModel alloc]init];
        model.freightamount = [NSString stringWithFormat:@"%@",dic[@"freightamount"]];
        
        [arr addObject:model];
    }
    return arr;
}
@end

//
//  ZP_FrontPageReceivingAddressModel.m
//  DDAYGO
//
//  Created by Summer on 2017/11/13.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_FrontPageReceivingAddressModel.h"

@implementation ZP_FrontPageReceivingAddressModel

+ (instancetype)GetFrontPageReceivingAddress:(NSDictionary *)dic {
    return [[self alloc]initWithFrontPageReceivingAddressData:dic];
}

- (instancetype)initWithFrontPageReceivingAddressData:(NSDictionary *)Dic {
    if (self == [super init]) {
        self.eeceiptname = Dic[@"receiptname"];
        self.eeceiptphone = Dic[@"receiptphone"];
        self.addressid = Dic[@"addressid"];
        self.addressdetail = Dic[@"addressdetail"];
        self.isdefault = Dic[@"isdefault"];
        self.zipcode = Dic[@"zipcode"];
    }
    return self;
}

+(id)cheakNull:(id)dic {
    if ([dic isEqual:[NSNull null]]) {
        return @"";
    }
    return dic;
}

+ (NSMutableArray *)arrayWithArray:(NSArray *)array {
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (NSDictionary * dic in array) {
        ZP_FrontPageReceivingAddressModel * model = [[ZP_FrontPageReceivingAddressModel alloc]init];
        model.eeceiptname = dic[@"receiptname"];
        model.eeceiptphone = dic[@"receiptphone"];
        model.addressdetail = dic[@"addressdetail"];
        model.addressid = dic[@"addressid"];
        model.isdefault = dic[@"isdefault"];
        model.zipcode = dic[@"zipcode"];
        [arr addObject:model];
    }
    return arr;
}
@end


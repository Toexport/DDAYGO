//
//  ZP_ComfirmModel.m
//  DDAYGO
//
//  Created by Summer on 2017/11/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_ComfirmModel.h"

@implementation ZP_ComfirmModel

+ (instancetype)GetComfirmData:(NSDictionary *)dic {
    return [[self alloc]initWithInformationData:dic];
}

- (instancetype)initWithInformationData:(NSDictionary *)Dic {
    if (self == [super init]) {
        self.receiptname = Dic[@"receiptname"];
        self.receiptphone = [NSString stringWithFormat:@"%@",Dic[@"receiptphone"]];
        self.addressdetail = Dic[@"addressdetail"];
        self.isdefault = Dic[@"isdefault"];
        self.addressid = Dic[@"addressid"];
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
        ZP_ComfirmModel * model = [[ZP_ComfirmModel alloc]init];
        model.receiptname = dic[@"receiptname"];
        model.receiptphone = [NSString stringWithFormat:@"%@",dic[@"receiptphone"]];
        model.addressdetail = dic[@"addressdetail"];
        model.isdefault = dic[@"isdefault"];
        model.addressid = dic[@"addressid"];
        [arr addObject:model];
    }
    return arr;
}
@end


//
//  ZP_PayModel.m
//  DDAYGO
//
//  Created by Summer on 2018/1/31.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "ZP_PayModel.h"

@implementation ZP_PayModel

+ (instancetype)GetConfirmPayData:(NSDictionary *)dic {
    return [[self alloc]initWithConfirmPayData:dic];
}
- (instancetype)initWithConfirmPayData:(NSDictionary *)Dic {
    if (self == [super init]) {
        self.payname = Dic[@"payname"];
        self.logourl = Dic[@"logourl"];
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
        ZP_PayModel * model = [[ZP_PayModel alloc]init];
        model.logourl = dic[@"logourl"];
        //        [NSString stringWithFormat:@"http://www.ddaygo.com%@", dic[@"logourl"]];;
        model.payid = dic[@"payid"];
        model.payname = dic[@"payname"];
        [arr addObject:model];
    }
    return arr;
}
@end

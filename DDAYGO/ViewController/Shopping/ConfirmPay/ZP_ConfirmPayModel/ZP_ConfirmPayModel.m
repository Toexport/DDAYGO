//
//  ZP_ConfirmPayModel.m
//  DDAYGO
//
//  Created by Summer on 2017/11/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_ConfirmPayModel.h"

@implementation ZP_ConfirmPayModel

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
        ZP_ConfirmPayModel * model = [[ZP_ConfirmPayModel alloc]init];
        model.logourl = dic[@"logourl"];
        //        [NSString stringWithFormat:@"http://www.ddaygo.com%@", dic[@"logourl"]];;
        model.payid = dic[@"payid"];
        model.payname = dic[@"payname"];
        [arr addObject:model];
    }
    return arr;
}
@end


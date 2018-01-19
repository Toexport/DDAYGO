//
//  ZP_ZeroModel.m
//  DDAYGO
//
//  Created by Summer on 2017/10/25.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_ZeroModel.h"

@implementation ZP_ZeroModel
+ (instancetype)getHeadlineData:(NSDictionary *)dic {
    return [[self alloc]initWitheadlineData:dic];
}

- (instancetype)initWitheadlineData:(NSDictionary *)dic {
    if (self == [super init]) {
        self.advertimg = dic[@"advertimg"];
    }
    return self;
}
+(id)cheakUull:(id)dic {
    if ([dic isEqual:[NSNull null]]) {
        return @"";
    }
    return dic;
}
@end

//
//  ZP_LeftModel.m
//  DDAYGO
//
//  Created by Summer on 2017/10/26.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_LeftModel.h"

@implementation ZP_LeftModel
+ (instancetype)GetLeftData:(NSDictionary *)dic {
    return [[self alloc]initWithLeftData:dic];
}

- (instancetype)initWithLeftData:(NSDictionary *)Dic {
    if (self == [super init]) {
        self.contentLabel = Dic[@"producttypename"];
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
        
        ZP_LeftModel * model = [[ZP_LeftModel alloc]init];
        
        model.contentLabel = dic[@"producttypename"];
        
        [arr addObject:model];
    }
    return arr;
}
@end

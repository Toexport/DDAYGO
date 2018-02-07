//
//  ZP_RightModel.m
//  DDAYGO
//
//  Created by Summer on 2017/10/26.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_RightModel.h"

@implementation ZP_RightModel
+ (instancetype) GetRightData:(NSDictionary *)dic {
    return [[self alloc]initWithRightData:dic];
}
- (instancetype)initWithRightData:(NSDictionary *)Dic {
    if (self == [super init]) {
        self.contentLabel = Dic[@"producttypename"];
        self.fatherid = Dic[@"fatherid"];
        self.producttypeid = Dic[@"producttypeid"];
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
        ZP_RightModel * model = [[ZP_RightModel alloc]init];
        model.contentLabel = dic[@"producttypename"];
        model.fatherid = dic[@"fatherid"];
        model.producttypeid = dic[@"producttypeid"];
    [arr addObject:model];
        
    }
    
    return arr;
}
@end

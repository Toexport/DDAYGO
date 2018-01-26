//
//  ZP_OrderModel.m
//  DDAYGO
//
//  Created by Summer on 2017/11/24.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_OrderModel.h"
@implementation OrderModel1
+ (NSMutableArray *)arrayWithOrderArray:(NSArray *)array {
    NSMutableArray * arr = [NSMutableArray array];
    for (NSDictionary * dict in array) {
        OrderModel1 * model1 = [[OrderModel1 alloc]init];
        [model1 setValuesForKeysWithDictionary:dict];
        [arr addObject:model1];
    }
    return arr;
}
@end


@implementation OrderModel
+ (NSMutableArray *)arrayWithArray:(NSArray *)array {
    NSMutableArray *arr =[NSMutableArray array];
    for (NSDictionary *dic in array) {
        OrderModel *model = [[OrderModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [arr addObject:model];
    }
    return arr;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
}
@end



@implementation OrdersdetailModel
+ (instancetype)CreateWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    };
    return self;
}
- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key {
    
}

@end


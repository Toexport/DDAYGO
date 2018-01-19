//
//  ShoplntroducedModel.m
//  DDAYGO
//
//  Created by Summer on 2018/1/19.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "ShoplntroducedModel.h"

@implementation ShoplntroducedModel

+ (NSMutableArray *)arrayWithArray:(NSArray *)array {
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    if (array.count > 0) {
//    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    for (NSDictionary * dic in array) {
        ShoplntroducedModel * model = [[ShoplntroducedModel alloc]init];
        model.suppliername = dic[@"suppliername"];
        model.phone = dic[@"phone"];
        model.updatetime = dic[@"updatetime"];
        model.countrycodes = dic[@"countrycodes"];
        [arr addObject:model];
    }
  }
    return arr;
}

@end

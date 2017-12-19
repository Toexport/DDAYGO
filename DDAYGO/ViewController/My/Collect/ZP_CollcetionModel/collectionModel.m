//
//  collectionModel.m
//  DDAYGO
//
//  Created by 小树普惠 on 2017/11/24.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "collectionModel.h"

@implementation collectionModel

+ (NSMutableArray *)arrayWithArray:(NSArray *)array{
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (NSDictionary * dic in array) {
        collectionModel * model = [[collectionModel alloc]init];
        model.defaultimg = [NSString stringWithFormat:@"http://www.ddaygo.com%@", dic[@"defaultimg"]];
        model.productname = dic[@"productname"];
        model.productprice = dic[@"productprice"];
        model.CurrencySymbolLabel = @"RMB:";
        model.productid =  dic[@"productid"];
        model.cp = dic[@"cp"];
        [arr addObject:model];
    }
    return arr;
}

@end


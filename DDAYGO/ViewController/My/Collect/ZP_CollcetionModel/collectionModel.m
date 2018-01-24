//
//  collectionModel.m
//  DDAYGO
//
//  Created by 小树普惠 on 2017/11/24.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "collectionModel.h"
#import "PrefixHeader.pch"
@implementation collectionModel

+ (NSMutableArray *)arrayWithArray:(NSArray *)array{
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (NSDictionary * dic in array) {
        collectionModel * model = [[collectionModel alloc]init];
        model.defaultimg = [NSString stringWithFormat:@"%@%@",ImgAPI, dic[@"defaultimg"]];
        model.productname = dic[@"productname"];
        model.productprice = dic[@"productprice"];
        model.productid =  dic[@"productid"]; // 商品ID
        model.cp = dic[@"cp"];
        model.state = dic[@"state"];
        [arr addObject:model];
    }
    return arr;
}

@end


//
//  EvaluateModel.m
//  DDAYGO
//
//  Created by Summer on 2018/2/1.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "EvaluateModel.h"
#import "PrefixHeader.pch"
@implementation EvaluateModel

+ (NSMutableArray *)EvaluateArray:(NSArray *)array {
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (NSDictionary * dict in array) {
        EvaluateModel * model = [[EvaluateModel alloc]init];
            model.avatar = [NSString stringWithFormat:@"%@%@",ImgAPI,dict[@"avatar"]];
            model.realname = dict[@"realname"];
            model.createtime = dict[@"createtime"];
            model.reviewscontent = dict[@"reviewscontent"];
            model.fraction = dict[@"fraction"];
            [arr addObject:model];
    }
    return arr;
}
@end

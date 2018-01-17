//
//  ZP_ExtractModel.m
//  DDAYGO
//
//  Created by Summer on 2017/12/11.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_ExtractModel.h"

@implementation ZP_ExtractModel

+ (NSMutableArray *)arrayWithArray:(NSArray *)array {
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (NSDictionary * dic in array) {
        ZP_ExtractModel * model = [[ZP_ExtractModel alloc]init];
        model.takeid = dic[@"takeid"];
        model.supplierid = dic[@"supplierid"];
        model.takeamount = dic[@"takeamount"];
        model.bankname = dic[@"bankname"];
        model.bankcardno = dic[@"bankcardno"];
        model.bankcardname = dic[@"bankcardname"];
        model.phone = dic[@"phone"];
        model.email = dic[@"email"];
        model.state = dic[@"state"];
        model.remark = dic[@"remark"];
        model.createtime = dic[@"createtime"];
        model.updatetime = dic[@"updatetime"];
        
        [arr addObject:model];
    }
    return arr;
}
@end

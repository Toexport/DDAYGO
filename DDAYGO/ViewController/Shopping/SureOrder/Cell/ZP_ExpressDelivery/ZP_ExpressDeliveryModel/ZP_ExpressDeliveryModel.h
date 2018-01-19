//
//  ZP_ExpressDeliveryModel.h
//  DDAYGO
//
//  Created by Summer on 2017/11/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZP_ExpressDeliveryModel : NSObject
@property (nonatomic, strong) NSNumber * freightamount; // 快递费
@property (nonatomic, copy) NSString * chooselogistic; // 配送方式
@property (nonatomic, strong) NSNumber * allamount; // 金额
@property (nonatomic, strong) NSNumber * amount; // 数量

+ (instancetype)GetExpressDeliveryData:(NSDictionary *)dic;

+ (NSMutableArray *)arrayWithArray:(NSArray *)array;
@end

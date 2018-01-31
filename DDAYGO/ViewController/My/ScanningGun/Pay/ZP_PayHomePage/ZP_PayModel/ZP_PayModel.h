//
//  ZP_PayModel.h
//  DDAYGO
//
//  Created by Summer on 2018/1/31.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZP_PayModel : NSObject
/**支付方式ID*/
@property (nonatomic, strong) NSString * payid;
/**支付方式名称*/
@property (nonatomic, strong) NSString * payname;
/**logo路径*/
@property (nonatomic, strong) NSString * logourl; //

+ (instancetype)GetConfirmPayData:(NSDictionary *)dic;

+ (NSMutableArray *)arrayWithArray:(NSArray *)array;
@end

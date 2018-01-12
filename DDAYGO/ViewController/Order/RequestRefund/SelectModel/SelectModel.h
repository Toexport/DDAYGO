//
//  SelectModel.h
//  DDAYGO
//
//  Created by Summer on 2018/1/12.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectModel : NSObject
@property (nonatomic, strong) NSNumber * reasonid; // ID
@property (nonatomic, strong) NSString * reasonstr; // 状态
+ (NSMutableArray *)arrayWithArray:(NSArray *)array;
@end

@interface SelectModel1 : NSObject
@property (nonatomic, strong) NSString * refundinfo; // 字典
@property (nonatomic, strong) NSString * productname; // 商品名字
@property (nonatomic, strong) NSNumber * ordersnumber; // 订单号
@property (nonatomic, strong) NSNumber * ordersamount; // 订单金额
@property (nonatomic, strong) NSNumber * productamount; // 商品金额
@property (nonatomic, strong) NSNumber * freight;  // 运费金额
@property (nonatomic, strong) NSNumber * state;  // 订单状态
@property (nonatomic, strong) NSString * defaultimg; // 图片
@end

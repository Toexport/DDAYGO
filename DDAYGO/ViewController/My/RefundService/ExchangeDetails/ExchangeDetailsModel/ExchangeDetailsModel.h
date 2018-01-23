//
//  ExchangeDetailsModel.h
//  DDAYGO
//
//  Created by Summer on 2018/1/15.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExchangeDetailsModel : NSObject

@property (nonatomic, strong)NSNumber * aid; // 用户ID
@property (nonatomic, strong) NSNumber * ordersnumber; // 订单号
@property (nonatomic, strong) NSNumber * returntype; // 申请类型
@property (nonatomic, strong) NSNumber * ordersamount; // 退款总额
@property (nonatomic, strong) NSNumber * returnamount; // 退款金额
@property (nonatomic, strong) NSString * createtime; // 申请时间
@property (nonatomic, strong) NSString * refundreason; 
@property (nonatomic, strong) NSString * prestatestr; // 原因
@property (nonatomic, strong) NSString * refunddetail; // 详细说明
//@property (nonatomic, strong) NSNumber * state; // 当前状态
@property (nonatomic, strong) NSString * logisticname; // 物流信息
@property (nonatomic, strong)NSNumber * refundid;  // 退换记录ID
@property (nonatomic, strong) NSString * returntypestr; // 商品名字
@property (nonatomic, strong) NSString * statestr; // 当前状态
//*************************//
@property (nonatomic, strong) NSString * defaultimg; // 主图
@property (nonatomic, strong) NSString * logisticimg; // 上传的图片
@property (nonatomic, strong) NSString * productname; // 商品名字
@property (nonatomic, strong) NSString * colorname; // 颜色
@property (nonatomic, strong) NSString * normname; // 尺码
@property (nonatomic, strong) NSNumber * amount; // 数量


@end



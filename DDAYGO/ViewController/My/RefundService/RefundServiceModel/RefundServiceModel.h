//
//  RefundServiceModel.h
//  DDAYGO
//
//  Created by Summer on 2018/1/15.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RefundServiceModel : NSObject
@property (nonatomic, strong) NSNumber * aid; //ID
@property (nonatomic, strong) NSString * createtime; //时间
@property (nonatomic, strong) NSString * defaultimg; // 图片
@property (nonatomic, strong) NSString * shopname; // 商店名字
@property (nonatomic, strong) NSString * productname; // 商品名字
@property (nonatomic, strong) NSString * statestr; // 审核状态
@property (nonatomic, strong) NSNumber * ordersnumber; // 订单编号
@property (nonatomic, strong)NSNumber * refundid; //退换货记录ID

@end

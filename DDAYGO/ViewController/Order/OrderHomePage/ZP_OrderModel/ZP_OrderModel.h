//
//  ZP_OrderModel.h
//  DDAYGO
//
//  Created by Summer on 2017/11/24.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OrderModel;
@class OrdersdetailModel;
@interface OrderModel1 : NSObject
//总订单数
@property (nonatomic, strong) NSNumber * datacount;
@property (nonatomic, strong) NSArray<OrderModel *> * datalist;
+ (NSMutableArray *)arrayWithOrderArray:(NSArray *)array;
@end


@interface OrderModel : NSObject
//收货地址ID
@property (nonatomic, strong) NSNumber * addressid;
//收货人姓名
@property (nonatomic, strong) NSString * receiptname;
//收货人手机号码
@property (nonatomic, strong) NSNumber * receiptphone;
//用户ID
@property (nonatomic, strong) NSNumber * aid;
//所在国家代号
@property (nonatomic, strong) NSNumber * countrycode;
@property (nonatomic, strong) NSNumber * countrystr;
//创建时间
@property (nonatomic, strong) NSString * createtime;
//更新时间
@property (nonatomic, strong) NSString * updatetime;
// 交易状态
@property (nonatomic, strong) NSString * state;
//商品ID
@property (nonatomic, strong) NSNumber * productid;
/**商品默认图片*/
@property (nonatomic, strong) NSString * defaultimg;

//店铺名称
@property (nonatomic, strong) NSString * shopname;
//供货商名称
@property (nonatomic, strong) NSString * suppliername;
//供货商ID
@property (nonatomic, strong) NSNumber * supplierid;

//邮箱
@property (nonatomic, strong) NSString * email;
//运费
@property (nonatomic, strong) NSNumber * freight;
//买家留言
@property (nonatomic, strong) NSString * leavemsg;
//配送方式
@property (nonatomic, strong) NSNumber * logistic;
//物流公司名称
@property (nonatomic, strong) NSString * logisticname;
//物流单号
@property (nonatomic, strong) NSNumber * logisticnumber;
//订单编号
@property (nonatomic, strong) NSNumber * ordersnumber;
//订单成本
@property (nonatomic, strong) NSNumber * orderscost;
//订单总cp
@property (nonatomic, strong) NSNumber * orderscp;
//订单总额
@property (nonatomic, strong) NSNumber * ordersamount;
//订单类型

@property (nonatomic, strong) NSArray<OrdersdetailModel *> * ordersdetail;

+ (NSMutableArray *)arrayWithArray:(NSArray *)array;

//+ (instancetype)CreateWithDict:(NSDictionary *)dict;

@end

/*---------------------OrdersdetailModel--------------------------*/

@interface OrdersdetailModel : NSObject

//订单状态
@property (nonatomic, strong) NSNumber * state;
//订单编号
@property (nonatomic, strong) NSNumber * ordersnumber;
//购买时库存价格
@property (nonatomic, strong) NSNumber * price;
//购买数量
@property (nonatomic, strong) NSNumber * amount;
//商品名称
@property (nonatomic, strong) NSString * productname;
/**商品默认图片*/
@property (nonatomic, strong) NSString * defaultimg;
//颜色ID
@property (nonatomic, strong) NSNumber * colorid;
//尺码ID
@property (nonatomic, strong) NSNumber * normid;
//颜色
@property (nonatomic, strong) NSString * colorname;
//尺码
@property (nonatomic, strong) NSString * normname;
//商品ID
@property (nonatomic, strong) NSNumber * productid;
//供货商ID
@property (nonatomic, strong) NSNumber * supplierid;
// 订单详情ID
@property (nonatomic, strong) NSNumber * detailid;
// 库存ID
@property (nonatomic, strong) NSNumber * stockid;
// 商品cp
@property (nonatomic, strong) NSNumber * cp;
//成本价格
@property (nonatomic, strong) NSNumber * cost;
// 产地
@property (nonatomic, strong) NSNumber * produced;
//供货商名称
@property (nonatomic, strong) NSString * suppliername;
//商品规格
@property (nonatomic, strong) NSNumber * norm;
// 总计金额
@property (nonatomic, strong) NSNumber * ordersamount;
// 运费
@property (nonatomic, strong) NSNumber * freight;
// 评论次数
@property (nonatomic, strong) NSNumber * reviewscount;

+ (instancetype)CreateWithDict:(NSDictionary *)dict;

@end


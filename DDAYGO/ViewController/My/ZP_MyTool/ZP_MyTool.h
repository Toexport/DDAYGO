//
//  ZP_MyTool.h
//  DDAYGO
//
//  Created by Summer on 2017/10/30.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZP_MyTool : NSObject

// 个人资料
+ (void)requestSetHomePage:(NSDictionary *)SetHomePage success:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 修改资料（目前只支持修改性别，昵称）
+ (void)requesModifydata:(NSDictionary *)Modifydata uccess:(void (^)(id))success failure:(void (^)(NSError *))failure;

//  新增地址
+ (void)requesnewAaddress:(NSDictionary *)newAaddress success:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 收货地址
+ (void)requesAddress:(NSDictionary *)Address success:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 设定默认地址
+ (void) requestDefaultAddress:(NSDictionary *)DefaultAddress success:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 删除地址
+ (void)requesDeleteAddress:(NSDictionary *)DeleteAddress success:(void (^)(id))success failure:(void (^)(NSError *))failure;
//  绑定IUCE
+ (void)requestBindingICUE:(NSDictionary *)Binding success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//  绑定介绍人
+ (void)requesIntroduce:(NSDictionary *)Introduce success:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 获取用户收藏商品列表

+ (void)requestgetcollections:(NSDictionary *)Binding success:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 获取浏览记录
+ (void)requtsFootprint:(NSDictionary *)Footprint success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//  删除浏览记录
+ (void)requtsDeleFootprint:(NSDictionary *)Footprint success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//  获取生成二维码所需要的商家ID
+ (void)requesQrCode:(NSDictionary *)QrCoed success:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 用户扫码后请求付款链接
+ (void)requesQrCodePay:(NSDictionary *)QrCoed success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//  获取用户供货商ID
+ (void)requesSupplier:(NSDictionary *)Supplier success:(void (^)(id))success failure:(void (^)(NSError *))failure;
// 获取商家余额
+ (void)requesMerchantsBalance:(NSDictionary *)MerchantsBalance success:(void (^)(id))success failure:(void (^)(NSError *))failure;

//添加提现申请  addsuppliertakeout
+ (void)requesAddSupplierTakeOut:(NSDictionary *)QrCoed success:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 获取用户提现记录列表
+ (void)requesWithdrawalRecord:(NSDictionary *)WithdrawalRecord uccess:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 获取订单支付结果
+ (void)requesOrdPay:(NSDictionary *)OrdPay uccess:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 获取浏览记录、收藏的数量
+ (void)requesBrowseCollection:(NSDictionary *)BrowseCollection uccess:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 获取上一期开奖号码及奖金分配信息
+ (void)getPrizeInfo:(void (^)(id obj))success failure:(void (^)(NSError *error))failure;
// 获取历史开奖
+ (void)requestHistoryPrize:(NSDictionary *)HistoryPrize uccess:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 获取某期开奖信息
+ (void)requestLotterypoolwininfo:(NSDictionary *)HistoryPrize uccess:(void (^)(id obj))success failure:(void (^)(NSError *error))failure;

// 获取本期促销彩信息
+ (void)requestLotterynow:(NSString *)token uccess:(void (^)(id obj))success failure:(void (^)(NSError *error))failure;

// 获取本期下注查看更多
+ (void)requseMoreMore:(NSDictionary *)MoreMore uccess:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 获取历史下注号码
+ (void)requestHistoricalBet:(NSDictionary *)HistoricalBet uccess:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 促销彩下注
+ (void)requestBte:(NSDictionary *)Bte uccess:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 获取下注页面奖金彩券数量开奖时间
+ (void)requestAcquisitionTime:(NSDictionary *)AcquisitionTime uccess:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 邮箱验证
+ (void)requesEmail:(NSDictionary *)Email uccess:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 验证码
+ (void)requestRestPassword:(NSDictionary *)RestPassword success:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 申请成为供货商状态
+ (void)requestSupplier:(NSDictionary *)Suppliers success:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 获取组织形状
+ (void)requestCompanyType:(NSDictionary *)CompanyType success:(void (^)(id))success failure:(void (^)(NSError *))failure;

// 添加供货商申请
+ (void)requestSupplierRequest:(NSDictionary *)SupplierRequest success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure;

// 获取退换货记录列表
+ (void)requestGetrefundlist:(NSDictionary *)Getrefundlist success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure;

// 获取退换货详情
+ (void)requestGetrefundinfo:(NSDictionary *)Getrefundinfo success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure;

//72) 更改退换货状态
+ (void)RequestRefundStatus:(NSDictionary *)RefundStatus success:(void (^)(id obj))success failure:(void (^)(NSError *error))failure;
@end


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
@end


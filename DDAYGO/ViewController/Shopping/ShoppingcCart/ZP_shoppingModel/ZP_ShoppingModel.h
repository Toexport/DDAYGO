//
//  ZP_ShoppingModel.h
//  DDAYGO
//
//  Created by Summer on 2017/11/10.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZP_CartsModel;
@class ZP_CartsShopModel;

@interface ZP_ShoppingModel : NSObject


/**运费总金额*/
@property (nonatomic, strong) NSNumber * freightamount;
/**订单总金额*/
@property (nonatomic, strong) NSNumber * allamount;

@property (nonatomic, strong) NSNumber *chooseadsid;
/**
 *商品库存数量
 */
@property (nonatomic, strong) NSNumber *productamount;

@property (nonatomic, strong) NSArray<ZP_CartsModel *> *carts;
@property (nonatomic, strong) NSArray<ZP_CartsShopModel *> *cartshop;

+ (instancetype)CreateWithDict:(NSDictionary *)dict;

@end

@interface ZP_CartsModel : NSObject
@property (nonatomic, strong) NSNumber *cartid;
@property (nonatomic, strong) NSNumber *aid;
@property (nonatomic, strong) NSNumber * stockid;
@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, strong) NSNumber *productid;
@property (nonatomic, strong) NSNumber *colorid;
@property (nonatomic, strong) NSNumber *normid;
@property (nonatomic, strong) NSNumber *productprice;
@property (nonatomic, strong) NSNumber *cp;
@property (nonatomic, strong) NSNumber * supplierid;
@property (nonatomic, strong) NSNumber * weight;
@property (nonatomic, strong) NSNumber * priceamount;
@property (nonatomic, strong) NSNumber *productcost;

@property (nonatomic, strong) NSString *createtime;
@property (nonatomic, strong) NSString *productname;
@property (nonatomic, strong) NSString *defaultimg;
@property (nonatomic, strong) NSString *productremark;
@property (nonatomic, strong) NSString *colorname;
@property (nonatomic, strong) NSString *normname;
@property (nonatomic, strong) NSString *suppliername;

+ (NSMutableArray *)arrayWithArray:(NSArray *)array;

@end


@interface ZP_CartsShopModel : NSObject
@property (nonatomic, strong) NSNumber *supplierid;
@property (nonatomic, strong) NSString *shopname;
@property (nonatomic, strong) NSString * symbol;
@property (nonatomic, strong) NSMutableArray * array;
+ (NSMutableArray *)arrayWithArray:(NSArray *)array;
@end


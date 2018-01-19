//
//  ZP_GoodDetailsModel.h
//  DDAYGO
//
//  Created by Summer on 2017/11/2.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZP_GoodDetailsModel : NSObject
@property (nonatomic, strong) NSString * productname; // 标题
@property (nonatomic, strong) NSString * productprice; // 价格
@property (nonatomic, strong) NSString * defaultimg; //图片
@property (nonatomic, strong) NSString * TrademarkLabel; // 商标编号
@property (nonatomic, strong) NSString * peramount;  // 销量
@property (nonatomic, strong) NSString * productid; // 货号ID
@property (nonatomic, strong) NSNumber * supplierid; // 供货商ID
@property (nonatomic, strong) NSNumber * state;  //状态
/**库存*/
@property (nonatomic, strong) NSString * productamount;

// 评价数据
@property (nonatomic, strong) NSNumber * reviewscount;
@property (nonatomic, strong) NSString * bad_percent;
@property (nonatomic, strong) NSString * good_percent;
@property (nonatomic, strong) NSString * mid_percent;
@property (nonatomic, strong) NSNumber * page;
@property (nonatomic, strong) NSNumber * pagesize;
@property (nonatomic, strong) NSNumber * pagestr;

/***************/
@property (nonatomic, strong) NSNumber * cnid; // 货号ID
@property (nonatomic, strong) NSString * cnimg; // 货号ID
@property (nonatomic, strong) NSString * cnname; // 货号ID
/**类型*/
@property (nonatomic, strong) NSNumber * cntype; // 货号ID
@property (nonatomic, strong) NSString * sort; // 货号ID

+ (instancetype)getGoodDetailsData:(NSDictionary *)Dic;

+ (NSMutableArray *)arrayWithArray:(NSArray *)array;

+ (NSMutableArray *)arrayWithTypeArray:(NSDictionary *)array;

@end


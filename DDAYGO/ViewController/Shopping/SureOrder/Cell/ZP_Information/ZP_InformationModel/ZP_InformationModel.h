//
//  ZP_InformationModel.h
//  DDAYGO
//
//  Created by Summer on 2017/11/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZP_InformationModel : NSObject
@property (nonatomic, strong) NSString * shopname; // 商店名字
@property (nonatomic, strong) NSString * productname;         // 商品名称
@property (nonatomic, strong) NSString * defaultimg;         // 商品默认图片
@property (nonatomic, strong) NSString * productprice;      // 商品价格
@property (nonatomic, strong) NSString * cp;               // 商品CP
@property (nonatomic, strong) NSString * colorid;         // 颜色
@property (nonatomic, strong) NSString * normid;         // 尺码
@property (nonatomic, strong) NSString * supplierid;    // 供货商ID
@property (nonatomic, strong) NSString * suppliername; // 供货商名
@property (nonatomic, strong) NSString * stockid;     // 库存ID
@property (nonatomic, strong) NSString * amount;     // 购买数量
@property (nonatomic, strong) NSString * allamount; // 总数量

+ (instancetype)GetInformationData:(NSDictionary *)dic;

+ (NSMutableArray *)arrayWithArray:(NSArray *)array;
@end

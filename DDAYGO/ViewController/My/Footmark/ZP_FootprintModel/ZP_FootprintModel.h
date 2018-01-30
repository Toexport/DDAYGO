//
//  ZP_FootprintModel.h
//  DDAYGO
//
//  Created by Summer on 2017/11/24.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZP_FootprintModel : NSObject
@property (strong, nonatomic) NSString * createdate;
@property (nonatomic, strong) NSMutableArray * historyArray;

+ (NSMutableArray *)arrayWithArray:(NSArray *)array;
@end

@interface ZP_FootprintModel1 : NSObject
@property (strong, nonatomic) NSString * defaultimg; // 图片
@property (strong, nonatomic) NSString * productname;  // 标题
@property (strong, nonatomic) NSString * productprice; // 商品价格
@property (strong, nonatomic) NSString * cp; // 商品cp
@property (nonatomic, strong) NSNumber * state;  // 商品状态
@property (nonatomic, strong) NSNumber * historyid;
@property (nonatomic, strong) NSNumber * productid;  //商品ID

+ (instancetype)gEtFootprint1:(NSDictionary *)Dic;

+ (NSMutableArray *)arrayWithArray1:(NSArray *)array;
@end



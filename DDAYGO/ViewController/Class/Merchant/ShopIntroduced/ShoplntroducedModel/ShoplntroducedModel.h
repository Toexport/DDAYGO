//
//  ShoplntroducedModel.h
//  DDAYGO
//
//  Created by Summer on 2018/1/19.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoplntroducedModel : NSObject
@property (nonatomic, strong) NSString * countrycodes ; // 地区
@property (nonatomic, strong) NSNumber * phone; // 电话
@property (nonatomic, strong) NSString * updatetime; // 时间
@property (nonatomic, strong) NSString * suppliername; // 店铺名字
//introduction =     {
//    countrycode = 886;
//    countrycodes = "\U81fa\U7063";
//    createtime = "0001-01-01 00:00:00";
//    "good_percent" = "<null>";
//    phone = 123456;
//    reviewscount = 0;
//    suppliername = "<null>";
//    updatetime = "0001-01-01 00:00:00";
//};

@property (nonatomic, strong) NSString * good_percent; // 好评度
//reviewgood =     {
//    ReviewsData = "<null>";
//    "bad_percent" = "<null>";
//    "good_percent" = "0.00%";
//    "mid_percent" = "<null>";
//    page = 0;
//    pagesize = 0;
//    pagestr = "<null>";
//    reviewscount = 0;
//};

+ (NSMutableArray *)arrayWithArray:(NSArray *)array;
@end

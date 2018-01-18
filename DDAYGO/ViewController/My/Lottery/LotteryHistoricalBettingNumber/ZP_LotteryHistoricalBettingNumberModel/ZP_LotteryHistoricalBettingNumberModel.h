//
//  ZP_LotteryHistoricalBettingNumberModel.h
//  DDAYGO
//
//  Created by Summer on 2017/12/30.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>


@class ZP_LotteryHistoricalBettingNumberModel2;

@class ZP_LotteryHistoricalBettingNumberModel3;

@interface ZP_LotteryHistoricalBettingNumberModel : NSObject
@property (nonatomic, strong) NSNumber * pollid;
@property (nonatomic, strong) NSNumber * countrycode;
@property (nonatomic, strong) NSNumber * yyyy;
@property (nonatomic, strong) NSNumber * mm;
@property (nonatomic, strong) NSString * createtime;
@property (nonatomic, strong) NSNumber * periods;
//@property (nonatomic, strong) NSNumber * white1;
//@property (nonatomic, strong) NSNumber * white2;
//@property (nonatomic, strong) NSNumber * white3;
//@property (nonatomic, strong) NSNumber * white4;
//@property (nonatomic, strong) NSNumber * white5;
@property (nonatomic, strong) NSNumber * powerball;
@property (nonatomic, strong) NSMutableArray * winorders;
/*********************/
@end

@interface ZP_LotteryHistoricalBettingNumberModel2 : NSObject

@property (nonatomic, strong) NSString * lotteryoid;
@property (nonatomic, strong) NSNumber * pollid;
@property (nonatomic, strong) NSNumber * aid;
@property (nonatomic, strong) NSNumber * winamount;
@property (nonatomic, strong) NSNumber * rstate;
@property (nonatomic, strong) NSString * createtime;
@property (nonatomic, strong) NSString * updatetime;
@property (nonatomic, strong) NSArray * winordersdetail;

@end
/*********************/

@interface ZP_LotteryHistoricalBettingNumberModel3 : NSObject

@property (nonatomic, strong) NSNumber * pollid;
//@property (nonatomic, strong) NSNumber * aid;
@property (nonatomic, strong) NSString * lotteryoid;
@property (nonatomic, strong) NSNumber * state;
@property (nonatomic, strong) NSNumber * rstate;
@property (nonatomic, strong) NSNumber * white1;
@property (nonatomic, strong) NSNumber * white2;
@property (nonatomic, strong) NSNumber * white3;
@property (nonatomic, strong) NSNumber * white4;
@property (nonatomic, strong) NSNumber * white5;
@property (nonatomic, strong) NSNumber * powerball;
@property (nonatomic, strong) NSNumber * buycount;
@property (nonatomic, strong) NSNumber * detailwinamount;

//@interface ZP_LotteryHistoricalBettingNumberModel2 : NSObject
//
//@property (nonatomic, strong) NSNumber * lotteryoid;
//@property (nonatomic, strong) NSNumber * pollid;
//@property (nonatomic, strong) NSNumber * aid;
//@property (nonatomic, strong) NSNumber * winamount;
//@property (nonatomic, strong) NSNumber * rstate;
//@property (nonatomic, strong) NSNumber * createtime;
//@property (nonatomic, strong) NSNumber * updatetime;
//@property (nonatomic, strong) NSNumber * winordersdetail;
//
//@end
///*********************/
//
//@interface ZP_LotteryHistoricalBettingNumberModel3 : NSObject
//
//@property (nonatomic, strong) NSNumber * pollid;
//@property (nonatomic, strong) NSNumber * aid;
//@property (nonatomic, strong) NSNumber * lotteryoid;
//@property (nonatomic, strong) NSNumber * state;
//@property (nonatomic, strong) NSNumber * rstate;
//@property (nonatomic, strong) NSNumber * white1;
//@property (nonatomic, strong) NSNumber * white2;
//@property (nonatomic, strong) NSNumber * white3;
//@property (nonatomic, strong) NSNumber * white4;
//@property (nonatomic, strong) NSNumber * white5;
//@property (nonatomic, strong) NSNumber * powerball;
//@property (nonatomic, strong) NSNumber * buycount;

@end


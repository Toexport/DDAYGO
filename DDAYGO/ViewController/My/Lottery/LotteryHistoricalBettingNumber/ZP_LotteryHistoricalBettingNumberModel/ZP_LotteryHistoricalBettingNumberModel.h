//
//  ZP_LotteryHistoricalBettingNumberModel.h
//  DDAYGO
//
//  Created by Summer on 2017/12/30.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZP_LotteryHistoricalBettingNumberModel : NSObject
@property (nonatomic, strong) NSNumber * pollid;
@property (nonatomic, strong) NSNumber * countrycode;
@property (nonatomic, strong) NSNumber * yyyy;
@property (nonatomic, strong) NSNumber * mm;
@property (nonatomic, strong) NSNumber * createtime;
@property (nonatomic, strong) NSNumber * periods;
//@property (nonatomic, strong) NSNumber * white1;
//@property (nonatomic, strong) NSNumber * white2;
//@property (nonatomic, strong) NSNumber * white3;
//@property (nonatomic, strong) NSNumber * white4;
//@property (nonatomic, strong) NSNumber * white5;
@property (nonatomic, strong) NSNumber * powerball;
@property (nonatomic, strong) NSNumber * winorders;
@property (nonatomic, strong) NSMutableArray * array;
/*********************/
@end

@interface ZP_LotteryHistoricalBettingNumberModel2 : NSObject

@property (nonatomic, strong) NSString * lotteryoid;
@property (nonatomic, strong) NSNumber * pollid;
@property (nonatomic, strong) NSNumber * aid;
@property (nonatomic, strong) NSNumber * winamount;
@property (nonatomic, strong) NSNumber * rstate;
@property (nonatomic, strong) NSNumber * createtime;
@property (nonatomic, strong) NSNumber * updatetime;
@property (nonatomic, strong) NSArray * winordersdetail;
@property (nonatomic, strong) NSMutableArray * arr;
@end
/*********************/

@interface ZP_LotteryHistoricalBettingNumberModel3 : NSObject

@property (nonatomic, strong) NSNumber * pollid;
@property (nonatomic, strong) NSNumber * aid;
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


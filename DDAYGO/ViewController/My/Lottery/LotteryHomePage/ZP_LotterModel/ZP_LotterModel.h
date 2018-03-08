//
//  ZP_LotterModel.h
//  DDAYGO
//
//  Created by Summer on 2017/12/15.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>
@class lotteryModel;
@class lotterywinModel;
@class lotteryorderModel;

@interface ZP_LotterModel : NSObject

@property (nonatomic, strong) NSDictionary * lottery;

/*彩金點數*/
@property (nonatomic, strong) NSNumber * lbalance;

@property (nonatomic, strong) NSArray<lotterywinModel *> *lotterywin;

@property (nonatomic, strong) NSArray<lotteryorderModel *> *lotteryorder;

@end


@interface lotteryModel : NSObject

/*奖池ID*/
@property (nonatomic, strong) NSNumber *pollid;
/*国家id*/
@property (nonatomic, strong) NSNumber *countrycode;
/*奖池金额*/
@property (nonatomic, strong) NSNumber * poolamount;
/**年份*/
@property (nonatomic, strong) NSNumber *yyyy;
/**月份*/
@property (nonatomic, strong) NSNumber *mm;
/**期数**/
@property (nonatomic, strong) NSNumber *periods;
/**奖池生成时间*/
@property (nonatomic, strong) NSString *createtime;
/**奖池开奖时间*/
@property (nonatomic, strong) NSString *recordtime;
/*开奖白球1*/
@property (nonatomic, strong) NSNumber * white1;
/*开奖白球2*/
@property (nonatomic, strong) NSNumber *white2;
/*开奖白球3*/
@property (nonatomic, strong) NSNumber *white3;
/*开奖白球4*/
@property (nonatomic, strong) NSNumber *white4;
/*开奖白球5*/
@property (nonatomic, strong) NSNumber *white5;
/*开奖红球*/
@property (nonatomic, strong) NSNumber * powerball;

@end

@interface lotterywinModel : NSObject
/*一等奖*/
@property (nonatomic, strong) NSNumber *state;
/*奖项总额*/
@property (nonatomic, strong) NSNumber *winamount;
/*中奖人数*/
@property (nonatomic, strong) NSNumber *wincount;
/*单注奖金*/
@property (nonatomic, strong) NSNumber *winunit;

@end

@interface lotteryorderModel : NSObject
/*订单号*/
@property (nonatomic, strong) NSString * lotteryoid;
/*奖池ID*/
@property (nonatomic, strong) NSNumber * pollid;
@property (nonatomic, strong) NSNumber * yyyy;
@property (nonatomic, strong) NSNumber * mm;
@property (nonatomic, strong) NSNumber * periods;
@property (nonatomic, strong) NSNumber * createtime;
@property (nonatomic, strong) NSNumber * white1;
@property (nonatomic, strong) NSNumber * white2;
@property (nonatomic, strong) NSNumber * white3;
@property (nonatomic, strong) NSNumber * white4;
@property (nonatomic, strong) NSNumber * white5;
@property (nonatomic, strong) NSNumber * powerball;
@property (nonatomic, strong) NSNumber * buycount;
//"lotteryoid": "LT17121609252109754", 购彩单号
//"pollid": 1,        奖池ID
//"yyyy": 0,
//"mm": 0,
//"periods": 0,
//"createtime": "0001-01-01T00:00:00",
//"white1": 6,        //白球1
//"white2": 16,        白球2
//"white3": 26,        白球3
//"white4": 36,        白球4
//"white5": 46,        白球5
//"powerball": 16,        红球
//"buycount": 0

@end

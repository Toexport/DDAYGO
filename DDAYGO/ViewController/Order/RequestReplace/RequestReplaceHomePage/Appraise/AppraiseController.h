//
//  AppraiseController.h
//  DDAYGO
//
//  Created by Login on 2017/9/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZP_OrderModel.h"
@interface AppraiseController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
    NSArray * dataArray;
}

@property (nonatomic, strong) OrderModel * model;
@property (nonatomic, strong) OrdersdetailModel * model2;
@property (nonatomic, strong) NSNumber * ordersnumber; // 订单号
@property (nonatomic, strong) NSNumber * productid; //商品ID
@property (nonatomic, strong) NSNumber * detailid; // 商品详情ID
@property (nonatomic, assign) NSInteger  num; // 商品详情ID
@property (nonatomic, strong) NSString * defaultimg; // 商品图片


@end

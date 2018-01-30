//
//  OrdeTailViewCell.h
//  DDAYGO
//
//  Created by Summer on 2018/1/28.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZP_OrderModel.h"
@interface OrdeTailViewCell : UITableViewCell
@property (nonatomic, strong) UIButton * AppraiseBut;      // 评价
//@property (nonatomic, strong) UIButton * LogisticsBut;    // 物流
@property (nonatomic, strong) UIButton * OnceagainBut;   // 再次购买

@property (nonatomic, strong) OrdersdetailModel * model;   // 再次购买

@property (nonatomic, strong) OrderModel * model2;   // 再次购买


- (void)InformationWithDic:(OrdersdetailModel *)dic WithModel:(OrderModel *)model;

typedef void (^FinishBlock)(id response);
@property (nonatomic , copy) FinishBlock finishBlock;

typedef void (^AppraiseBlock)(id response);
@property (nonatomic , copy) AppraiseBlock appraiseBlock;

typedef void (^OnceagainBlock)(id response);
@property (nonatomic , copy) OnceagainBlock onceagainBlock;
@end

//
//  OrderViewCell.h
//  DDAYGO
//
//  Created by Login on 2017/9/21.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZP_OrderModel.h"
@interface OrderViewCell : UITableViewCell
@property (nonatomic ,strong) UILabel * OrderLabel;            //  订单Name
@property (nonatomic, strong) UILabel * IDLabel;              //  ID号
@property (nonatomic, strong) UILabel * DateLabel;           //  日期
@property (nonatomic, strong) UILabel * TradingLabel;      //  交易状态
@property (nonatomic, strong) UIButton * DeleteBut;       // 删除按钮
@property (nonatomic, strong) UIView * Backgroundview;    //  背景view
/*********************************************************/
/********************************************************/
@property (nonatomic, strong) UIImageView * FigureImage;               //主图
@property (nonatomic, strong) UILabel * merchantsLabel;               //商家名字
@property (nonatomic, strong) UILabel * titleLabel;                  //商品文字
@property (nonatomic, strong) UILabel * descLabel;                  // 颜色分类
@property (nonatomic, strong) UILabel * SizeLabel;                 // 尺寸
@property (nonatomic, strong) UILabel * PreferentialLabel;        //优惠价格
@property (nonatomic, strong) UILabel * CurrencySymbolLabel;     // 货币符号
@property (nonatomic, strong) UILabel * priceLabel;             // 价格
@property (nonatomic, strong) UILabel * SharacterLabel;        // X 符号
@property (nonatomic, strong) UIImageView * TrademarkImage;   // 商标
@property (nonatomic, strong) UILabel * TrademarkLabel;      // 商标编号
@property (nonatomic, strong) UILabel * QuantityLabel;      //  数量
/**********************************************************/
/*********************************************************/
@property (nonatomic, strong) UILabel * CountLabel;         // 合计
@property (nonatomic, strong) UILabel * AmountLabel;       // 金额
@property (nonatomic, strong) UILabel * FreightLabel;     // 快递
@property (nonatomic, strong) UILabel * ExpressFeeLabel; // 快递费
/********************************************************/
/*******************************************************/
@property (nonatomic, strong) UIButton * AppraiseBut;      // 评价
//@property (nonatomic, strong) UIButton * LogisticsBut;    // 物流
@property (nonatomic, strong) UIButton * OnceagainBut;   // 再次购买

@property (nonatomic, strong) OrdersdetailModel * model;   // 再次购买


- (void)InformationWithDic:(OrdersdetailModel *)dic WithModel:(OrderModel *)model;

typedef void (^FinishBlock)(id response);

@property (nonatomic , copy) FinishBlock finishBlock;

typedef void (^AppraiseBlock)(id response);

@property (nonatomic , copy) AppraiseBlock appraiseBlock;

@end


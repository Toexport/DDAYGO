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
@property (nonatomic, strong) UIView * Backgroundview;    //  背景view
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

- (void)InformationWithDic:(OrdersdetailModel *)dic WithModel:(OrderModel *)model;


@end


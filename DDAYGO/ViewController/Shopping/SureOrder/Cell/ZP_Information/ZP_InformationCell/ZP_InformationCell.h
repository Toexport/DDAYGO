//
//  InformationCell.h
//  DDAYGO
//
//  Created by Login on 2017/9/20.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZP_InformationModel.h"

@interface ZP_InformationCell : UITableViewCell
//@property (nonatomic, strong) UIImageView * merchantsImage;                 // 商家图片
//@property (nonatomic, strong) UILabel * merchantsLabel;                    // 商家店铺名
@property (nonatomic, strong) UIImageView * FigureImage;                    // 主图
@property (nonatomic, strong) UILabel * titleLabel;                        // 商品文字
@property (nonatomic, strong) UILabel * descLabel;                        // 250ml升级装
@property (nonatomic, strong) UILabel * PreferentialLabel;               // 优惠价格
@property (nonatomic, strong) UIImageView * TrademarkImage;             // 商标
@property (nonatomic, strong) UILabel * TrademarkLabel;                // 商标编号
@property (nonatomic, strong) UILabel * QuantityLabel;                // 数量
@property (nonatomic, strong) UILabel * DistributionLabel;           // 配送方式
@property (nonatomic, strong) UILabel * CourierLabel;               // 快递
@property (nonatomic, strong) UILabel * CostLabel;                 // 费用
@property (nonatomic, strong) UITextField * TextField;            // 文本输入框
@property (nonatomic, strong) UILabel * TotalLabel;              // 总计
@property (nonatomic, strong) UILabel * SmallLabel;             // 小计
@property (nonatomic, strong) UILabel * ComputationsLabel;     // 价格
@property (nonatomic, strong) UILabel * CurrencySymbolLabel;  // 货币符号
@property (nonatomic, strong) UILabel * MessageLabel;        // 卖家留言
@property (nonatomic, strong) UILabel * SharacterLabel;     // X 符号
- (void)InformationWithDic:(ZP_InformationModel *)model;
@end

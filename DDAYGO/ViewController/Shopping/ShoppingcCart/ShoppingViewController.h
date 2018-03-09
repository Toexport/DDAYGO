//
//  ShoppingViewController.h
//  DDAYGO
//
//  Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PromptBoxView.h"
@interface ShoppingViewController : PromptBoxView

@property (nonatomic, strong) UILabel * merchantsLabel; // 店铺名称
@property (nonatomic, strong) UIButton * AllButton;  // 全选按钮
@property (nonatomic, strong) UIButton * Shopchoosebuttom; // 选择按钮
@property (nonatomic, strong) UILabel * AllLabel;  // 全选文字
@property (nonatomic, strong) UILabel * StatisticsLabel;  // 合计
@property (nonatomic, strong) UILabel * CurrencySymbolLabel; // 货币符号
@property (nonatomic, strong) UILabel * PriceLabel; // 总金额
@property (nonatomic, strong) UILabel * FreightLabel; // 运费
@property (nonatomic, strong) UIButton * ClearingButt; // 结算按钮
//- (void)cellWithDic:(NSDictionary *)dic;  // 获取总金额
@property (nonatomic, strong) UILabel * RemindLabel;

@end


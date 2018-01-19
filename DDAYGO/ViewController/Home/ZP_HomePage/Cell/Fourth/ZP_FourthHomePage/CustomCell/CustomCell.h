//
//  CustomCell.h
//  DDAYGO
//
//  Created by Summer on 2017/10/25.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZP_FourthModel.h"
@interface CustomCell : UITableViewCell
@property (nonatomic, strong) UIImageView * imageView1; // 图片
@property (nonatomic, strong) UILabel * introduceLabel; // 详情
@property (nonatomic, strong) UILabel * CurrencySymbolLabel; // 货币符号
@property (nonatomic, strong) UILabel * PreferentialLabel; // 优惠
@property (nonatomic, strong) UILabel * PriceLabel; // 价格
@property (nonatomic, strong) UIImageView * TrademarkImage; // 商标图片
@property (nonatomic, strong) UILabel * TrademarkLabel; // 商标编号
- (void)cellWithdic:(ZP_FourthModel *)model;
@end

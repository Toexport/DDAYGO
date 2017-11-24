//
//  NestedCollectionViewCell.h
//  DDAYGO
//
//  Created by Login on 2017/10/13.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZP_SixthModel.h"
@interface NestedCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView * imageView; // 主图
@property (nonatomic, strong) UILabel * introduceLabel; // 文字介绍
@property (nonatomic, strong) UILabel * PreferentialLabel; // 优惠价格
@property (nonatomic, strong) UILabel * priceLabel; // 价格
@property (nonatomic, strong) UIImageView * TrademarkImage; //商标
@property (nonatomic, strong) UILabel * TrademarkLabel; // 商标编号

- (void)cellWithdic:(ZP_SixthModel *)dic;

@end

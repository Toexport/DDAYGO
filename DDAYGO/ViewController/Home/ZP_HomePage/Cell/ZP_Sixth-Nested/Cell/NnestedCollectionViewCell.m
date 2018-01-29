//
//  NnestedCollectionViewCell.m
//  DDAYGO
//
//  Created by Summer on 2018/1/29.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "NnestedCollectionViewCell.h"
#import "PrefixHeader.pch"
#import "ZP_SixthModel.h"
@implementation NnestedCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)cellWithdic:(ZP_SixthModel *)model {
    [_ImageView sd_setImageWithURL:[NSURL URLWithString:model.defaultimg] placeholderImage:[UIImage imageNamed:@""]];
    _titleLabel.text = model.productname;
    _priceLabel.text = [NSString stringWithFormat:@"NT%@", model.PreferentialLabel];
    _TrademarkLabel.text = model.TrademarkLabel;
}

@end

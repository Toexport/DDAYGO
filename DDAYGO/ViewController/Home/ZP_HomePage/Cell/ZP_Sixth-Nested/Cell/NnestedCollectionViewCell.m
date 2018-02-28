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
}

- (void)cellWithdic:(ZP_SixthModel *)model {
    [self.ImageView sd_setImageWithURL:[NSURL URLWithString:model.defaultimg] placeholderImage:[UIImage imageNamed:@""]];
    self.titleLabel.text = model.productname;
//    self.priceLabel.text = [NSString stringWithFormat:@"NT %@", model.PreferentialLabel];
//    self.priceLabel.text = [NSString stringWithFormat:[NSString stringWithFormat:@"%@", DD_MonetarySymbol], model.PreferentialLabel];
    self.priceLabel.text = [NSString stringWithFormat:@"%@ %@", DD_MonetarySymbol, model.PreferentialLabel];
//    self.TrademarkLabel.text = model.TrademarkLabel;
}

@end

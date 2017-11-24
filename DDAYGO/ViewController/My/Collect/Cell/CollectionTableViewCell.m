//
//  CollectionTableViewCell.m
//  DDAYGO
//
//  Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//


#import "CollectionTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation CollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)setModel:(collectionModel *)model {
    [_ShopimageView sd_setImageWithURL:[NSURL URLWithString:model.defaultimg] placeholderImage:nil];
    _priceLabel.text = [NSString stringWithFormat:@"%@",model.productprice];
    _shopTextLabel.text = model.productname;
}

@end


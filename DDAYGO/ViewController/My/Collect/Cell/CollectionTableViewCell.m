//
//  CollectionTableViewCell.m
//  DDAYGO
//
//  Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//


#import "CollectionTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "PrefixHeader.pch"
@implementation CollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)setModel:(collectionModel *)model {
    
     [_ShopimageView sd_setImageWithURL:[NSURL URLWithString:model.defaultimg] placeholderImage:[UIImage imageNamed:@""]];
    if ([model.state intValue] == 4) {
        _showYImageVIew.hidden = NO;
        _showYImageVIew.image = [UIImage imageNamed:@"bg_footprint_frame"];
        _showYImageVIew.backgroundColor = [UIColor clearColor];
        _zhuangtaiLabel.center = _ShopimageView.center;
        _zhuangtaiLabel.text = NSLocalizedString(@"已失效", nil);
        [_zhuangtaiLabel setTextColor:[UIColor whiteColor]];
        _zhuangtaiLabel.textAlignment = NSTextAlignmentCenter;
        //       __defaltLabel.font = [UIFont systemFontOfSize:14];
        [_zhuangtaiLabel addSubview:_showYImageVIew];
    }else{
        
    [_ShopimageView sd_setImageWithURL:[NSURL URLWithString:model.defaultimg] placeholderImage:[UIImage imageNamed:@""]];
        [_ShopimageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
        _ShopimageView.contentMode =  UIViewContentModeScaleAspectFill;
        _ShopimageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _ShopimageView.clipsToBounds  = YES;
    }
    _priceLabel.text = [NSString stringWithFormat:@"%@",model.productprice];
     NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"symbol"];
   _CurrencySymbolLabel.text = [NSString stringWithFormat:@"%@",str];
    _Cp.text = [NSString stringWithFormat:@"%@",model.cp];
    _shopTextLabel.text = model.productname;
}

@end


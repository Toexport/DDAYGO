//
//  FootprintCollectionViewCell.m
//  DDAYGO
//
//   Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "FootprintCollectionViewCell.h"
#import "PrefixHeader.pch"
@implementation FootprintCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)FootprintCollection:(ZP_FootprintModel1 *)model {
    [_defaultimg sd_setImageWithURL:[NSURL URLWithString:model.defaultimg] placeholderImage:[UIImage imageNamed:@""]];
    if ([model.state intValue] == 4) {
        _defaultimgImageVIew.hidden = NO;
        _defaultimgImageVIew.backgroundColor = [UIColor clearColor];
        _defaultimgImageVIew.image = [UIImage imageNamed:@"bg_footprint_frame"];
        _defaltLabel.center = _defaultimgImageVIew.center;
        _defaltLabel.text = NSLocalizedString(@"已失效", nil);
        [_defaltLabel setTextColor:[UIColor whiteColor]];
        _defaltLabel.textAlignment = NSTextAlignmentCenter;
        [_defaultimgImageVIew addSubview:_defaltLabel];
    }else{
        
    [_defaultimg sd_setImageWithURL:[NSURL URLWithString:model.defaultimg] placeholderImage:[UIImage imageNamed:@""]];
//        [_defaultimg setContentScaleFactor:[[UIScreen mainScreen] scale]];
//        _defaultimg.contentMode =  UIViewContentModeScaleAspectFill;
//        _defaultimg.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//        _defaultimg.clipsToBounds  = YES;
    }
    _productname.text = model.productname;
    _productprice.text = [NSString stringWithFormat:@"%@",model.productprice];
    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"symbol"];
    _CurrencySymbolLabel.text = [NSString stringWithFormat:@"%@",str];
    _cp.text = [NSString stringWithFormat:@"%@",model.cp];
    
}
@end

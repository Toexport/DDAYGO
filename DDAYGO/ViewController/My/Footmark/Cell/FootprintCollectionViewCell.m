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
        _defaltLabel.text = MyLocal(@"invalid");
        [_defaltLabel setTextColor:[UIColor whiteColor]];
        _defaltLabel.textAlignment = NSTextAlignmentCenter;
        [_defaultimgImageVIew setContentScaleFactor:[[UIScreen mainScreen] scale]];
        _defaultimgImageVIew.contentMode =  UIViewContentModeScaleAspectFill;
        _defaultimgImageVIew.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [_defaultimgImageVIew addSubview:_defaltLabel];
    }else{
    [_defaultimg sd_setImageWithURL:[NSURL URLWithString:model.defaultimg] placeholderImage:[UIImage imageNamed:@""]];
        _defaultimg.frame = CGRectMake(_defaultimg.frame.origin.x, _defaultimg.frame.origin.y, _defaultimg.frame.size.width, _defaultimg.frame.size.height);
    [_defaultimg setContentScaleFactor:[[UIScreen mainScreen] scale]];
    _defaultimg.contentMode =  UIViewContentModeScaleAspectFill;
    _defaultimg.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    }
    _productname.text = model.productname;
    _productprice.text = [NSString stringWithFormat:@"%@",model.productprice];
    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"symbol"];
    _CurrencySymbolLabel.text = [NSString stringWithFormat:@"%@",str];
    _cp.text = [NSString stringWithFormat:@"%@",model.cp];
    
}

@end

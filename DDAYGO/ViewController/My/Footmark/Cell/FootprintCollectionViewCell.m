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

- (void)FootprintCollection:(ZP_FootprintModel *)model {
    [_defaultimg sd_setImageWithURL:[NSURL URLWithString:model.defaultimg] placeholderImage:[UIImage imageNamed:@""]];
    if ([model.state intValue] == 4) {
        __defaultimgImageVIew.hidden = NO;
        __defaultimgImageVIew.backgroundColor = [UIColor clearColor];
        __defaultimgImageVIew.image = [UIImage imageNamed:@"bg_footprint_frame"];
        
//        _defaultimg.alpha = 0.5;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, __defaultimgImageVIew.frame.size.width / 2, __defaultimgImageVIew.frame.size.width / 2, 15)];
        label.center = __defaultimgImageVIew.center;
        label.text = NSLocalizedString(@"已失效", nil);
        [label setTextColor:[UIColor whiteColor]];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        [__defaultimgImageVIew addSubview:label];
    }else{
        
    [_defaultimg sd_setImageWithURL:[NSURL URLWithString:model.defaultimg] placeholderImage:[UIImage imageNamed:@""]];

    }
    _productname.text = model.productname;
    _productprice.text = [NSString stringWithFormat:@"%@",model.productprice];
    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"symbol"];
    _CurrencySymbolLabel.text = [NSString stringWithFormat:@"%@:",str];
    _cp.text = [NSString stringWithFormat:@"%@",model.cp];
    
}
@end

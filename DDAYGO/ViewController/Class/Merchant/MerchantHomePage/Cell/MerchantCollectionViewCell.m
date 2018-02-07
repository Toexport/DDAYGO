//
//  MerchantCollectionViewCell.m
//  DDAYGO
//
//  Created by Summer on 2018/1/22.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "MerchantCollectionViewCell.h"
#import "PrefixHeader.pch"
@implementation MerchantCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI {
    //            图片
    self.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, CGRectGetWidth(self.frame)- 10, CGRectGetWidth(self.frame)-10)];
    self.imageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _imageView.contentMode =  UIViewContentModeScaleAspectFill;
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _imageView.clipsToBounds  = YES;
    [self addSubview:self.imageView];
    
    //            标题
    self.headerlabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetWidth(self.frame)- 10, CGRectGetWidth(self.frame)-10, 20)];
    //    [self.headerlabel setBackgroundColor:[UIColor yellowColor]];
    self.headerlabel.textColor = ZP_TypefaceColor;
    self.headerlabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.headerlabel.numberOfLines = 0;
    self.headerlabel.font = ZP_titleFont;
    self.headerlabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.headerlabel];
    
    //            价格
    self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetWidth(self.frame)+ 25, CGRectGetWidth(self.frame) - 90, 15)];
    self.priceLabel.textColor = ZP_HomePreferentialpriceTypefaceCorlor;
    self.priceLabel.font = [UIFont systemFontOfSize:10];
    //    [self.priceLabel setBackgroundColor:ZP_Graybackground];
    self.priceLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.priceLabel];
    
    //    商标
    UIImageView * TrademarkImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)- 55, CGRectGetWidth(self.frame)+ 25, 22*0.66, 20-5)];
    TrademarkImage.image = [UIImage imageNamed:@"ic_cp"];
    [self.contentView addSubview:TrademarkImage];
    
    //    商标编号
    UILabel * TrademarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 40, CGRectGetWidth(self.frame)+ 25,CGRectGetWidth(self.frame)- 125, 15)];
    TrademarkLabel.textAlignment = NSTextAlignmentLeft;
    //    [TrademarkLabel setBackgroundColor:ZP_Graybackground];
    TrademarkLabel.textColor = ZP_textblack;
    TrademarkLabel.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:TrademarkLabel];
    _TrademarkLabel = TrademarkLabel;
    
}

- (void)merchant:(MerchantModel *)model {
     [_imageView sd_setImageWithURL:[NSURL URLWithString:model.defaultimg] placeholderImage:[UIImage imageNamed:@""]];
    self.headerlabel.text = model.productname;
    self.priceLabel.text = [NSString stringWithFormat:@"NT%@",[model.productprice stringValue]];
    self.TrademarkLabel.text = [model.cp stringValue];
}
@end

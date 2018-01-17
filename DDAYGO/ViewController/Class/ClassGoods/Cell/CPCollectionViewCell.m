//
//  CPCollectionViewCell.m
//  DDAYGO
//
//  Created by Login on 2017/9/14.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "CPCollectionViewCell.h"
#import "PrefixHeader.pch"
#import "ZP_ClassGoodsModel.h"
@implementation CPCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI {
//    图片
    self.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, CGRectGetWidth(self.frame)- 10, CGRectGetWidth(self.frame)-10)];
    self.imageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:self.imageView];
    
//    标题
    UILabel * headerlabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetWidth(self.frame)- 7.5, CGRectGetWidth(self.frame) - 50, 15)];
    headerlabel.textColor = ZP_TypefaceColor;
    headerlabel.lineBreakMode = NSLineBreakByWordWrapping;
    headerlabel.numberOfLines = 0;
    headerlabel.font = ZP_titleFont;
    headerlabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:headerlabel];
    _headerlabel = headerlabel;
    
//    地区
    UILabel * AreaLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 40, CGRectGetWidth(self.frame) - 7.5,35, 15)];
    AreaLabel.textColor = ZP_TypefaceColor;
    AreaLabel.font = ZP_titleFont;
    AreaLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:AreaLabel];
    _AreaLabel = AreaLabel;
    
//    商品介绍
    UILabel * MerchandiseIntroducedLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetWidth(self.frame) + 10, CGRectGetWidth(self.frame) - 10, 15)];
    MerchandiseIntroducedLabel.textColor = ZP_TypefaceColor;
    MerchandiseIntroducedLabel.numberOfLines = 0;
    MerchandiseIntroducedLabel.font = ZP_introduceFont;
    MerchandiseIntroducedLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:MerchandiseIntroducedLabel];
    _MerchandiseIntroducedLabel = MerchandiseIntroducedLabel;
    
//    优惠价格
    UILabel * preferentialLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetWidth(self.frame)+ 35, CGRectGetWidth(self.frame) - 90, 15)];
    preferentialLabel.textColor = ZP_HomePreferentialpriceTypefaceCorlor;
    preferentialLabel.font = ZP_introduceFont;
    preferentialLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:preferentialLabel];
    _preferentialLabel = preferentialLabel;
    
////    价格
//    UILabel * priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetWidth(self.frame)+ 35, CGRectGetWidth(self.frame) - 100, 15)];
//    priceLabel.textColor = ZP_HomePreferentialpriceTypefaceCorlor;
//    priceLabel.font = ZP_TrademarkFont;
//    priceLabel.textAlignment = NSTextAlignmentLeft;
////    [self.contentView addSubview:priceLabel];
//    _priceLabel = priceLabel;
    
    
//   横线
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(5, CGRectGetWidth(self.frame)+ 37.5, _priceLabel.height, 1.5)];
    backView.backgroundColor = ZP_TypefaceColor;
//    [self.contentView addSubview:backView];
    
//   商标
    UIImageView * TrademarkImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)- 55, CGRectGetWidth(self.frame)+ 35, 22*0.66, 20-5)];
    [self.contentView addSubview:TrademarkImage];
    _TrademarkImage = TrademarkImage;
    
//   商标编号
    UILabel * TrademarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 35, CGRectGetWidth(self.frame)+ 35,CGRectGetWidth(self.frame) - 125 , 15)];
    TrademarkLabel.textAlignment = NSTextAlignmentLeft;
    TrademarkLabel.textColor = ZP_textblack;
    TrademarkLabel.font = [UIFont systemFontOfSize:9];
    [self.contentView addSubview:TrademarkLabel];
    _TrademarkLabel = TrademarkLabel;
    
}

- (void)cellWithdic:(ZP_ClassGoodsModel *)model {
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.defaultimg] placeholderImage:[UIImage imageNamed:@""]]; // 图片
    _headerlabel.text = model.productname;  // 标题
    _MerchandiseIntroducedLabel.text = model.productremark; // 商品介绍
    _preferentialLabel.text = model.productprice; // 优惠价格
//    _priceLabel.text = model.productprice;
    _TrademarkImage.image = [UIImage imageNamed:@"ic_cp"];
    _TrademarkLabel.text = model.TrademarkLabel; // CP编号
    _AreaLabel.text = model.produced; // 地区
    
}

@end

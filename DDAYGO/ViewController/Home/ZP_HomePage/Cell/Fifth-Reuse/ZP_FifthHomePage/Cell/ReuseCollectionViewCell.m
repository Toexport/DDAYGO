//
//  ReuseCollectionViewCell.m
//  DDAYGO
//
//  Created by Login on 2017/9/13.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ReuseCollectionViewCell.h"
#import "PrefixHeader.pch"
#import "ZP_ZeroModel.h"
@implementation ReuseCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
//    主图
    UIImageView * imageView = [UIImageView new];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(1);
        make.top.equalTo(self).offset(-1);
        make.right.equalTo(self).offset(-1);
        make.bottom.equalTo(self).offset(-60);
        make.width.mas_offset(ZP_Width/4-1);
    }];
    _imageView = imageView;
    
//    标题
    ZP_GeneralLabel * TitleLabel = [ZP_GeneralLabel initWithtextLabel:_titleLabel.text textColor:ZP_HomeTitleTypefaceCorlor font:ZP_TrademarkFont textAlignment:NSTextAlignmentCenter bakcgroundColor:ZP_WhiteColor];
//    TitleLabel.textColor = ZP_HomeTitleTypefaceCorlor;
//    TitleLabel.textAlignment = NSTextAlignmentCenter;
//    TitleLabel.lineBreakMode = UILineBreakModeWordWrap; //文字分行
//    TitleLabel.numberOfLines = 0;
//    TitleLabel.font = ZP_TrademarkFont;
    [self addSubview:TitleLabel];
    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(2);
        make.right.equalTo(self).offset(-2);
        make.bottom.equalTo(imageView).offset(10);
    }];
    _titleLabel = TitleLabel;
    
//    优惠价格
    ZP_GeneralLabel * PreferentialLabel = [ZP_GeneralLabel initWithtextLabel:_PreferentialLabel.text textColor:ZP_HomePreferentialpriceTypefaceCorlor font:ZP_introduceFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
//    PreferentialLabel.textColor = ZP_HomePreferentialpriceTypefaceCorlor;
//    PreferentialLabel.textAlignment = NSTextAlignmentLeft;
//    PreferentialLabel.font = ZP_introduceFont;
    [self addSubview:PreferentialLabel];
    [PreferentialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.bottom.equalTo(TitleLabel).offset(15);
    }];
    _PreferentialLabel = PreferentialLabel;
    
//    价格
    ZP_GeneralLabel * priceLabel = [ZP_GeneralLabel initWithtextLabel:_priceLabel.text textColor:ZP_HomeTitlepriceTypefaceColor font:ZP_introduceFont textAlignment:NSTextAlignmentCenter bakcgroundColor:ZP_WhiteColor];
//    priceLabel.textColor = ZP_HomeTitlepriceTypefaceColor;
//    priceLabel.textAlignment = NSTextAlignmentCenter;
//    priceLabel.font = ZP_introduceFont;
    [self addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.bottom.equalTo(PreferentialLabel).offset(10);
    }];
    _priceLabel = priceLabel;
    
//    横线
    UIView * Crossview = [UIView new];
    Crossview.backgroundColor = ZP_HomeTitlepriceTypefaceColor;
    [self addSubview: Crossview];
    [Crossview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.bottom.equalTo(PreferentialLabel).offset(4.5);
        make.width.mas_equalTo(priceLabel);
        make.height.mas_equalTo(1);
    }];
    
//    商标
    UIImageView * TrademarkImage = [UIImageView new];
    [self.contentView addSubview:TrademarkImage];
    [TrademarkImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.bottom.equalTo(priceLabel).offset(10);
        make.width.mas_offset(10);
        make.height.mas_offset(10);
    }];
    _TrademarkImage = TrademarkImage;
    
//    商标编号
    ZP_GeneralLabel * TrademarkLabel = [ZP_GeneralLabel initWithtextLabel:_TrademarkLabel.text textColor:ZP_HomeTitlepriceTypefaceColor font:ZP_TrademarkFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
//    TrademarkLabel.textAlignment = NSTextAlignmentLeft;
//    TrademarkLabel.textColor = ZP_HomeTitlepriceTypefaceColor;
//    TrademarkLabel.font = ZP_TrademarkFont;
    [self.contentView addSubview:TrademarkLabel];
    [TrademarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.bottom.equalTo(priceLabel).offset(10);
        make.width.mas_offset(20); //宽
        make.height.mas_offset(10); // 高
        
    }];
    _TrademarkLabel = TrademarkLabel;
    
//    分割线
    UIView * view1 = [UIView new];
    view1.backgroundColor = ZP_Graybackground;
    [self.contentView addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(0);
        make.left.equalTo(self).offset(0);
        make.width.mas_equalTo(ZP_Width);
        make.height.mas_equalTo(1);
    }];
}

- (void)cellWithdic:(ZP_FifthModel *)model {
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.defaultimg] placeholderImage:[UIImage imageNamed:@""]];
    _titleLabel.text = model.productname;
    _PreferentialLabel.text = [NSString stringWithFormat:@"RMB:%@",model.PreferentialLabel]; // 优惠价格
    _priceLabel.text = [NSString stringWithFormat:@"RMB:"];
    _TrademarkImage.image = [UIImage imageNamed:@"ic_cp"];
    _TrademarkLabel.text = model.TrademarkLabel;
    
}

@end

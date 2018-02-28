//
//  CustomCell.m
//  DDAYGO
//
//  Created by Summer on 2017/10/25.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "CustomCell.h"
#import "PrefixHeader.pch"
#import "ZP_FourthModel.h"
@implementation CustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:@"customCell"];
    if (self) {
        [self initUI];
        self.userInteractionEnabled = YES;
    }
    return self;
}
- (void)initUI {
    //    图片
    UIImageView * imageView1 = [UIImageView new];
    [self addSubview:imageView1];
    [imageView1 setContentScaleFactor:[[UIScreen mainScreen] scale]];
    imageView1.contentMode =  UIViewContentModeScaleAspectFill;
    imageView1.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    imageView1.clipsToBounds  = YES;
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(2.5);
        make.right.equalTo(self).offset(-5);
        make.bottom.equalTo(self).offset(-2.5);
        make.width.mas_offset(70);
        make.height.mas_offset(70);
    }];
    self.imageView1 = imageView1;
    
    //  文字介绍
    ZP_GeneralLabel * introduceLabel = [ZP_GeneralLabel initWithtextLabel:self.introduceLabel.text textColor:ZP_HomeTitleTypefaceCorlor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    introduceLabel.lineBreakMode = NSLineBreakByWordWrapping; //文字分行
    introduceLabel.numberOfLines = 2;
    [self addSubview:introduceLabel];
    [introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.left.equalTo(self).offset(5);
        make.right.equalTo(imageView1).offset(-75);
    }];
    self.introduceLabel = introduceLabel;
//     货币符号
    ZP_GeneralLabel * CurrencySymbolLabel = [ZP_GeneralLabel initWithtextLabel:self.CurrencySymbolLabel.text textColor:ZP_HomePreferentialpriceTypefaceCorlor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self addSubview:CurrencySymbolLabel];
    [CurrencySymbolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(introduceLabel).offset(5);
        make.left.equalTo(self).offset(5);
//        make.right.equalTo(self).offset(5);
    }];
    self.CurrencySymbolLabel = CurrencySymbolLabel;
    //    优惠价格
    ZP_GeneralLabel * PreferentialLabel = [ZP_GeneralLabel initWithtextLabel:self.PreferentialLabel.text textColor:ZP_HomePreferentialpriceTypefaceCorlor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self addSubview:PreferentialLabel];
    [PreferentialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CurrencySymbolLabel).offset(0);
        make.left.equalTo(CurrencySymbolLabel).offset(18.5);
    }];
    self.PreferentialLabel = PreferentialLabel;
    
//    //    价格
//    ZP_GeneralLabel * PriceLabel = [ZP_GeneralLabel initWithtextLabel:_PriceLabel.text textColor:ZP_HomeTitlepriceTypefaceColor font:ZP_introduceFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
//    [self addSubview:PriceLabel];
//    [PriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).offset(60);
//        make.left.equalTo(self).offset(5);
//    }];
//    self.PriceLabel = PriceLabel;
//
//    //    横线
//    UIView * Crossview = [UIView new];
//    Crossview.backgroundColor = ZP_HomeTitlepriceTypefaceColor;
////    [self addSubview: Crossview];
//    [Crossview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).offset(67.f);
//        make.left.equalTo(self).offset(5);
//        make.width.mas_offset(70);
//        make.height.mas_offset(1);
//    }];
    
    //    商标
    UIImageView * TrademarkImage = [UIImageView new];
    [self.contentView addSubview:TrademarkImage];
    [TrademarkImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(PreferentialLabel).offset(65);
        make.top.equalTo(CurrencySymbolLabel).offset(0);
        make.width.mas_offset(15);
        make.height.mas_offset(15);
        
    }];
    self.TrademarkImage = TrademarkImage;
    
//    商标编号
    ZP_GeneralLabel * TrademarkLabel = [ZP_GeneralLabel initWithtextLabel:_TrademarkLabel.text textColor:ZP_HomeTitlepriceTypefaceColor font:ZP_introduceFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self.contentView addSubview:TrademarkLabel];
    [TrademarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TrademarkImage).offset(20);
        make.top.equalTo(TrademarkImage).offset(2.5);
//        make.width.mas_offset(40);
    }];
    self.TrademarkLabel = TrademarkLabel;
    
    //    分割线
    UIView * view1 = [UIView new];
    view1.backgroundColor = ZP_Graybackground;
    [self.contentView addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(0);
        make.left.equalTo(self).offset(0);
        make.width.mas_equalTo(ZP_Width-100);
        make.height.mas_equalTo(1);
    }];
}

- (void)cellWithdic:(ZP_FourthModel *)model {
    [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:model.defaultimg] placeholderImage:[UIImage imageNamed:@""]];
    self.introduceLabel.text = model.productname;
//    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"symbol"];
//    self.CurrencySymbolLabel.text = [NSString stringWithFormat:@"%@",str];
    self.PreferentialLabel.text = [NSString stringWithFormat:@"%@ %@", DD_MonetarySymbol,model.PreferentialLabel]; // 优惠价格
    self.TrademarkImage.image = [UIImage imageNamed:@"ic_cp"];
    self.TrademarkLabel.text = model.TrademarkLabel;
}


@end

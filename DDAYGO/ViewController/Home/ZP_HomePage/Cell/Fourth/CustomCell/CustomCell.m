//
//  CustomCell.m
//  DDAYGO
//
//  Created by Summer on 2017/10/25.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "CustomCell.h"
#import "PrefixHeader.pch"
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
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(2.5);
        make.right.equalTo(self).offset(-3);
        make.bottom.equalTo(self).offset(-2.5);
        make.width.mas_offset(70);
        make.height.mas_offset(70);
    }];
    _imageView1 = imageView1;
    
    //  文字介绍
    ZP_GeneralLabel * introduceLabel = [ZP_GeneralLabel initWithtextLabel:_introduceLabel.text textColor:ZP_HomeTitleTypefaceCorlor font:ZP_introduceFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
//    introduceLabel.textColor = ZP_HomeTitleTypefaceCorlor;
    introduceLabel.lineBreakMode = NSLineBreakByWordWrapping; //文字分行
    introduceLabel.numberOfLines = 0;
//    introduceLabel.font = ZP_introduceFont;
    [self addSubview:introduceLabel];
    [introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-80);
    }];
    _introduceLabel = introduceLabel;
    
    //    优惠价格
    ZP_GeneralLabel * PreferentialLabel = [ZP_GeneralLabel initWithtextLabel:_PreferentialLabel.text textColor:ZP_HomePreferentialpriceTypefaceCorlor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
//    PreferentialLabel.textColor = ZP_HomePreferentialpriceTypefaceCorlor;
//    PreferentialLabel.textAlignment = NSTextAlignmentLeft;
//    PreferentialLabel.font = ZP_titleFont;
    [self addSubview:PreferentialLabel];
    [PreferentialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(45);
        make.left.equalTo(self).offset(5);
    }];
    _PreferentialLabel = PreferentialLabel;
    
    //    价格
    ZP_GeneralLabel * PriceLabel = [ZP_GeneralLabel initWithtextLabel:_PriceLabel.text textColor:ZP_HomeTitlepriceTypefaceColor font:ZP_introduceFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
//    PriceLabel.textColor = ZP_HomeTitlepriceTypefaceColor;
//    PriceLabel.textAlignment = NSTextAlignmentLeft;
//    PriceLabel.font = ZP_introduceFont;
    [self addSubview:PriceLabel];
    [PriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(60);
        make.left.equalTo(self).offset(5);
    }];
    _PriceLabel = PriceLabel;
    
    //    横线
    UIView * Crossview = [UIView new];
    Crossview.backgroundColor = ZP_HomeTitlepriceTypefaceColor;
    [self addSubview: Crossview];
    [Crossview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(67.f);
        make.left.equalTo(self).offset(5);
        make.width.mas_offset(70);
        make.height.mas_offset(1);
    }];
    
    //    商标
    UIImageView * TrademarkImage = [UIImageView new];
    [self.contentView addSubview:TrademarkImage];
    [TrademarkImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-120);
        make.top.equalTo(self).offset(50);
        make.width.mas_offset(15);
        make.height.mas_offset(15);
        
    }];
    _TrademarkImage = TrademarkImage;
    
    //    商标编号
    ZP_GeneralLabel * TrademarkLabel = [ZP_GeneralLabel initWithtextLabel:_TrademarkLabel.text textColor:ZP_HomeTitlepriceTypefaceColor font:ZP_TrademarkFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
//    TrademarkLabel.textAlignment = NSTextAlignmentLeft;
//    TrademarkLabel.textColor = ZP_HomeTitlepriceTypefaceColor;
//    TrademarkLabel.font = ZP_TrademarkFont;
    [self.contentView addSubview:TrademarkLabel];
    [TrademarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-90);
        make.top.equalTo(self).offset(52.5);
//        make.width.mas_offset(40);
    }];
    _TrademarkLabel = TrademarkLabel;
    
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

- (void)InformationWithDic:(NSDictionary *)dic {
    
    _imageView1.image = [UIImage imageNamed:@"Shopping2"];
    _introduceLabel.text = dic[@"Titlelabel"];
    _PreferentialLabel.text = dic[@"Preferentia"];
    _PriceLabel.text = dic[@"Price"];
    _TrademarkImage.image = [UIImage imageNamed:@"ic_cp"];
    _TrademarkLabel.text = dic[@"Trademark"];
}

@end

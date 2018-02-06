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
    [imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
    imageView.contentMode =  UIViewContentModeScaleAspectFill;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    imageView.clipsToBounds  = YES;
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(1);
        make.top.equalTo(self).offset(1);
        make.right.equalTo(self).offset(-1);
//        make.bottom.equalTo(self).offset(-30);
        make.height.mas_offset(ZP_Width/4);
        make.width.mas_offset(ZP_Width/4-1);
//        make.height.mas_equalTo(35);
    }];
    self.imageView = imageView;
    
//    标题
    ZP_GeneralLabel * TitleLabel = [ZP_GeneralLabel initWithtextLabel:_titleLabel.text textColor:ZP_HomeTitleTypefaceCorlor font:ZP_introduceFont textAlignment:NSTextAlignmentCenter bakcgroundColor:ZP_WhiteColor];
    [self addSubview:TitleLabel];
    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(1);
        make.right.equalTo(imageView).offset(0);
        make.top.equalTo(imageView).offset(ZP_Width/4);
        make.height.mas_offset(15);
    }];
    self.titleLabel = TitleLabel;

//    优惠价格
    ZP_GeneralLabel * PreferentialLabel = [ZP_GeneralLabel initWithtextLabel:_PreferentialLabel.text textColor:ZP_HomePreferentialpriceTypefaceCorlor font:ZP_introduceFont textAlignment:NSTextAlignmentCenter bakcgroundColor:ZP_WhiteColor];
    [self addSubview:PreferentialLabel];
    [PreferentialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.right.equalTo(imageView).offset(5);
        make.bottom.equalTo(TitleLabel).offset(15);
        make.height.mas_offset(15);
    }];
    self.PreferentialLabel = PreferentialLabel;
    
////    商标
//    UIImageView * TrademarkImage = [UIImageView new];
//    [self.contentView addSubview:TrademarkImage];
//    [TrademarkImage mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.left.equalTo(PreferentialLabel).offset(5);
//        make.top.equalTo(PreferentialLabel).offset(2.5);
//        make.right.equalTo(PreferentialLabel).offset(20);
//        make.width.mas_offset(10);
//        make.height.mas_offset(10);
//    }];
//    self.TrademarkImage = TrademarkImage;
//
////    商标编号
//    ZP_GeneralLabel * TrademarkLabel = [ZP_GeneralLabel initWithtextLabel:_TrademarkLabel.text textColor:ZP_HomeTitlepriceTypefaceColor font:ZP_TrademarkFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
//    [self.contentView addSubview:TrademarkLabel];
//    [TrademarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(TrademarkImage).offset(12.5);
////        make.right.equalTo(TrademarkImage).offset(10);
//        make.top.equalTo(PreferentialLabel).offset(0);
//        make.height.mas_offset(15); // 高
//    }];
//    self.TrademarkLabel = TrademarkLabel;
    
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
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.defaultimg] placeholderImage:[UIImage imageNamed:@""]];
    self.titleLabel.text = model.productname;
    self.PreferentialLabel.text = [NSString stringWithFormat:@"NT%@",model.PreferentialLabel]; // 优惠价格
//    self.TrademarkImage.image = [UIImage imageNamed:@"ic_cp"];
//    self.TrademarkLabel.text = model.TrademarkLabel;
    
}

@end

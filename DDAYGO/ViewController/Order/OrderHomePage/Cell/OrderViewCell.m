//
//  OrderViewCell.m
//  DDAYGO
//
//  Created by Login on 2017/9/21.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "OrderViewCell.h"
#import "PrefixHeader.pch"
#import "ZP_OrderModel.h"
#import "ConfirmViewController.h"
#import "ZP_OrderTool.h"
@implementation OrderViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:@"orderViewCell"];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void) initUI {
//    背景view
    UIView * Backgroundview = [UIView new];
    Backgroundview.layer.borderWidth = 1;
    Backgroundview.backgroundColor = ZP_Graybackground;
    Backgroundview.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [self.contentView addSubview:Backgroundview];
    [Backgroundview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.height.mas_equalTo(110);
        make.width.mas_equalTo(ZP_Width);
    }];
    _Backgroundview = Backgroundview;
    
/******************************************************/
//  主图
    UIImageView * FigureImage = [UIImageView new];
    [FigureImage setContentScaleFactor:[[UIScreen mainScreen] scale]];
    FigureImage.contentMode =  UIViewContentModeScaleAspectFill;
    FigureImage.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    FigureImage.clipsToBounds  = YES;
    [self.Backgroundview addSubview:FigureImage];
    [FigureImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(Backgroundview).offset(3);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(100 - 5);
    }];
    _FigureImage = FigureImage;
    
//  商家名字
    ZP_GeneralLabel * merchantsLabel = [ZP_GeneralLabel  initWithtextLabel:_merchantsLabel.text textColor:ZP_textblack font:ZP_stockFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    [self.Backgroundview addSubview:merchantsLabel];
    [merchantsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(FigureImage).offset(95);
        make.top.equalTo(Backgroundview).offset(3);
        make.height.mas_offset(15);
    }];
    _merchantsLabel = merchantsLabel;
    
//  商品文字
    ZP_GeneralLabel * titleLabel = [ZP_GeneralLabel initWithtextLabel:_titleLabel.text textColor:ZP_textblack font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    titleLabel.textColor = ZP_textblack;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping; //文字分行
    titleLabel.numberOfLines = 0;
    titleLabel.font = ZP_titleFont;
    [self.Backgroundview addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(FigureImage).offset(95);
        make.right.equalTo(self.Backgroundview).offset(-10);
//        make.right.equalTo(Backgroundview).offset(-10);
        make.top.equalTo(merchantsLabel).offset(15);
    }];
    _titleLabel = titleLabel;
    
//  颜色分类
    ZP_GeneralLabel * descLabel = [ZP_GeneralLabel initWithtextLabel:_descLabel.text textColor:ZP_TypefaceColor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    [self.Backgroundview addSubview:descLabel];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(FigureImage).offset(95);
        make.bottom.equalTo(titleLabel).offset(15);
    }];
    _descLabel = descLabel;
    
//  尺码
    ZP_GeneralLabel * SizeLabel = [ZP_GeneralLabel initWithtextLabel:_SizeLabel.text textColor:ZP_TypefaceColor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    [self.Backgroundview addSubview:SizeLabel];
    [SizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(descLabel).offset(35);
        make.top.equalTo(descLabel).offset(0);
    }];
    _SizeLabel = SizeLabel;
    
//  货币符号
    ZP_GeneralLabel * CurrencySymbolLabel = [ZP_GeneralLabel initWithtextLabel:_CurrencySymbolLabel.text textColor:ZP_HomePreferentialpriceTypefaceCorlor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    [self.Backgroundview addSubview:CurrencySymbolLabel];
    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"symbol"];
    CurrencySymbolLabel.text = [NSString stringWithFormat:@"%@",str];
    [CurrencySymbolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(FigureImage).offset(95);
        make.bottom.equalTo(SizeLabel).offset(15);
        make.height.mas_offset(15);
    }];
    
//  优惠价格
    ZP_GeneralLabel * PreferentialLabel = [ZP_GeneralLabel initWithtextLabel:_PreferentialLabel.text textColor:ZP_HomePreferentialpriceTypefaceCorlor font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    [self.Backgroundview addSubview:PreferentialLabel];
    [PreferentialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CurrencySymbolLabel).offset(20);
        make.top.equalTo(CurrencySymbolLabel).offset(0);
        make.height.mas_offset(15);
    }];
    _PreferentialLabel = PreferentialLabel;

//  商标
    UIImageView * TrademarkImage = [UIImageView new];
    [self.Backgroundview addSubview:TrademarkImage];
    [TrademarkImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(PreferentialLabel).offset(60);
        make.top.equalTo(PreferentialLabel).offset(0);
        make.width.mas_offset(15);
        make.height.mas_offset(15);
    }];
    _TrademarkImage = TrademarkImage;
    
//  商标编号
    ZP_GeneralLabel * TrademarkLabel = [ZP_GeneralLabel initWithtextLabel:_TrademarkLabel.text textColor:ZP_textblack font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    [self.Backgroundview addSubview:TrademarkLabel];
    [TrademarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TrademarkImage).offset(18);
        make.bottom.equalTo(PreferentialLabel).offset(0);
    }];
    _TrademarkLabel = TrademarkLabel;
    
//  竖线
    UIView * VerticalView = [UIView new];
    VerticalView.layer.borderWidth = 1;
    VerticalView.backgroundColor = ZP_TypefaceColor;
    [self.Backgroundview addSubview:VerticalView];
    [VerticalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-55);
        make.bottom.equalTo(PreferentialLabel).offset(0);
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(1);
    }];
    
//  符号X
    ZP_GeneralLabel * SharacterLabel = [ZP_GeneralLabel initWithtextLabel:_SharacterLabel.text textColor:ZP_TypefaceColor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    [self.Backgroundview addSubview:SharacterLabel];
    SharacterLabel.text = @"X";
    _SharacterLabel = SharacterLabel;
    [SharacterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(VerticalView).offset(5);
        make.bottom.equalTo(VerticalView).offset(+2);
    }];
    
//  数量
    ZP_GeneralLabel * QuantityLabel = [ZP_GeneralLabel initWithtextLabel:_QuantityLabel.text textColor:ZP_TypefaceColor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    [self.Backgroundview addSubview:QuantityLabel];
    [QuantityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SharacterLabel).offset(10);
        make.bottom.equalTo(SharacterLabel).offset(0);
    }];
    _QuantityLabel = QuantityLabel;
}

- (void)InformationWithDic:(OrdersdetailModel *)dic WithModel:(OrderModel *)model {
    [_FigureImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImgAPI,dic.defaultimg]] placeholderImage:[UIImage imageNamed:@""]];
    NSLog(@"%@",dic.defaultimg);
    _merchantsLabel.text = [NSString stringWithFormat:@"%@",model.shopname];
    _titleLabel.text = dic.productname;
    if (dic.colorname.length < 1) {
        _descLabel.hidden = YES;
    }else {
       _descLabel.text = [NSString stringWithFormat:@"顏色:%@,",dic.colorname];
    }
    if (dic.normname.length < 1) {
        _SizeLabel.hidden = YES;
    }else {
        _SizeLabel.text = [NSString stringWithFormat:@"尺碼:%@",dic.normname];
    }
    _PreferentialLabel.text = [NSString stringWithFormat:@"%@",dic.price];
//    _priceLabel.text = [NSString stringWithFormat:@"NT%@",dic.cost];
    _TrademarkImage.image = [UIImage imageNamed:@"ic_cp"];
    _TrademarkLabel.text = [NSString stringWithFormat:@"%@",dic.cp];
    _QuantityLabel.text = [NSString stringWithFormat:@"%@",dic.amount];

}

@end


//
//  ShoppingCell.m
//  DDAYGO
//
//  Created by Login on 2017/9/12.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ShoppingCell.h"
#import "PrefixHeader.pch"
@implementation ShoppingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    static NSString * ShoppingID = @"shoppingCell";
    self = [super initWithStyle:style reuseIdentifier:ShoppingID];
    if (self) {
        [self initUI];
//        [self ininViewUI];
    }
    return self;
}

- (void)initUI {
//  商品选择按钮
    UIButton * buttom = [UIButton new];
    [buttom setImage:[UIImage imageNamed:@"ic_Shopping_Choice_normal"] forState:UIControlStateNormal];
    [buttom setImage:[UIImage imageNamed:@"ic_Shopping_Choice_pressed"] forState:UIControlStateSelected];
    buttom.layer.masksToBounds = YES;
    buttom.layer.cornerRadius = buttom.frame.size.height/2;
    buttom.layer.borderColor = [UIColor clearColor].CGColor;
    buttom.layer.borderWidth = 1;
    [buttom setTitleColor:ZP_TypefaceColor forState:UIControlStateNormal];
    [self.contentView addSubview:buttom];
    [buttom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(self).offset(45);
        
    }];
    _buttom = buttom;
    
//  图片
    UIImageView * imageView = [UIImageView new];
    [imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
    imageView.contentMode =  UIViewContentModeScaleAspectFill;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    imageView.clipsToBounds  = YES;
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5); // 上
        make.left.equalTo(self).offset(30);  // 左
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(90);
    }];
    _leftImageView = imageView;
    
//  标题
    ZP_GeneralLabel * titleLabel = [ZP_GeneralLabel initWithtextLabel:_titleLabel.text textColor:ZP_TypefaceColor font:ZP_stockFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self.contentView addSubview:titleLabel];
     _titleLabel = titleLabel;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView).offset(3);
        make.left.equalTo(imageView).offset(95);
        make.right.equalTo(imageView).offset(ZP_Width - 35 -95);
    }];
    
//     商品介绍
    ZP_GeneralLabel * MerchandiseIntroducedLabel = [ZP_GeneralLabel initWithtextLabel:_MerchandiseIntroducedLabel.text textColor:ZP_TypefaceColor font:ZP_stockFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    MerchandiseIntroducedLabel.lineBreakMode = NSLineBreakByWordWrapping; //文字分行
    MerchandiseIntroducedLabel.numberOfLines = 0;
    [self.contentView addSubview:MerchandiseIntroducedLabel];
    _MerchandiseIntroducedLabel = MerchandiseIntroducedLabel;
    _MerchandiseIntroducedLabel.height = YES;
    [MerchandiseIntroducedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel).offset(17);
        make.left.equalTo(imageView).offset(95);
        make.right.equalTo(imageView).offset(ZP_Width - 35 - 95);
    }];
    
//  商品颜色
    ZP_GeneralLabel * descLabel = [ZP_GeneralLabel initWithtextLabel:_descLabel.text textColor:ZP_TypefaceColor font:ZP_stockFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self.contentView addSubview:descLabel];
    _descLabel = descLabel;
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView).offset(95);
        make.bottom.equalTo(MerchandiseIntroducedLabel).offset(15); //
    }];

 
    
//  商品尺码
    ZP_GeneralLabel * SizeLabel = [ZP_GeneralLabel initWithtextLabel:_SizeLabel.text textColor:ZP_TypefaceColor font:ZP_stockFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self.contentView addSubview:SizeLabel];
    _SizeLabel = SizeLabel;
    [SizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(descLabel).offset(40);
        make.top.equalTo(descLabel).offset(0);
//        make.width.mas_offset(25);
    }];
    
// 货币符号
    ZP_GeneralLabel * CurrencySymbolLabel = [ZP_GeneralLabel initWithtextLabel:_CurrencySymbolLabel.text textColor:ZP_HomePreferentialpriceTypefaceCorlor font:ZP_stockFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self.contentView addSubview:CurrencySymbolLabel];
    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"symbol"];
    CurrencySymbolLabel.text = [NSString stringWithFormat:@"%@",str];
    [CurrencySymbolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView).offset(95);
        make.bottom.equalTo(SizeLabel).offset(15);
        make.height.mas_offset(15);
    }];
    
//  优惠价格
    ZP_GeneralLabel * PreferentialLabel = [ZP_GeneralLabel initWithtextLabel:_PreferentialLabel.text textColor:ZP_HomePreferentialpriceTypefaceCorlor font:ZP_addBtnTextdetaFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self.contentView addSubview:PreferentialLabel];
    _PreferentialLabel = PreferentialLabel;
    [PreferentialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CurrencySymbolLabel).offset(25); //左边
        make.bottom.equalTo(SizeLabel).offset(15);
        make.height.mas_offset(15);
//        make.width.mas_offset(100);
    }];

//  商标
    UIImageView * TrademarkImage = [UIImageView new];
    [self.contentView addSubview:TrademarkImage];
    [TrademarkImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-85);
        make.top.equalTo(PreferentialLabel).offset(0);
        make.width.mas_offset(15);
        make.height.mas_offset(15);
    }];
    _TrademarkImage = TrademarkImage;
    
//  商标编号
    ZP_GeneralLabel * TrademarkLabel = [ZP_GeneralLabel initWithtextLabel:_TrademarkLabel.text textColor:ZP_textblack font:ZP_TrademarkFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self.contentView addSubview:TrademarkLabel];
    [TrademarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TrademarkImage).offset(18);
        make.top.equalTo(TrademarkImage).offset(2.5);
    }];
    _TrademarkLabel = TrademarkLabel;
    
//  竖线
    UIView * VerticalView = [UIView new];
    VerticalView.layer.borderWidth = 1;
    VerticalView.layer.borderColor = [UIColor blackColor].CGColor;
    [self.contentView addSubview:VerticalView];
    [VerticalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TrademarkLabel).offset(40);
        make.bottom.equalTo(PreferentialLabel).offset(0); // 下
        make.height.mas_equalTo(13); // 高
        make.width.mas_equalTo(1); // 宽
    }];
    
//  符号X
    ZP_GeneralLabel * SharacterLabel = [ZP_GeneralLabel initWithtextLabel:_SharacterLabel.text textColor:ZP_TypefaceColor font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self.contentView addSubview:SharacterLabel];
    SharacterLabel.text = @"X";
    [SharacterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(VerticalView).offset(8);
        make.bottom.equalTo(VerticalView).offset(+2.5);
    }];
    _SharacterLabel = SharacterLabel;
    
//  数量
    ZP_GeneralLabel * QuantityLabel = [ZP_GeneralLabel initWithtextLabel:_QuantityLabel.text textColor:ZP_TypefaceColor font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self.contentView addSubview:QuantityLabel];
    [QuantityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SharacterLabel).offset(10);
        make.bottom.equalTo(SharacterLabel).offset(0);
    }];
    _QuantityLabel = QuantityLabel;
    
//  分割线
    UIView * view1 = [UIView new];
    view1.backgroundColor = ZP_Graybackground;
    [self.contentView addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(100);
        make.right.equalTo(self).offset(ZP_Width - 100); //长
        make.bottom.equalTo(self).offset(0.5);
        make.height.mas_equalTo(1); // 高
    }];
}

//  数据
- (void)cellWithModel:(ZP_CartsModel *)model andIndexObject:(NSString *)str {
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:model.defaultimg] placeholderImage:nil];;
    _titleLabel.text = model.productname;
    _MerchandiseIntroducedLabel.text = model.productremark;
    NSLog(@"%@",model.colorname);  //看到没有· 并不是空 可能是@”“ 可能是null 可能是nil  ·你说你的判断该怎么写
//    length这个是什么意思 长度的· ·字符的长度 // 用点心吧
    if (model.colorname.length < 1) {
        _descLabel.hidden = YES;//你自己看 model 。colorename 是不是等于nil、
    }else {
        _descLabel.text = [NSString stringWithFormat:@"顏色:%@,",model.colorname];
    }
    if (model.normname.length < 1) {
        _SizeLabel.hidden = YES;
    }else {
        _SizeLabel.text = [NSString stringWithFormat:@"尺碼:%@",model.normname];
    }
    _PreferentialLabel.text = [NSString stringWithFormat:@"%@",model.productprice];
    _TrademarkImage.image = [UIImage imageNamed:@"ic_cp"];
    _TrademarkLabel.text = [NSString stringWithFormat:@"%@",model.cp];
    _QuantityLabel.text = [NSString stringWithFormat:@"%@",str];
    
}

///**
// 编辑模式下的View
// */
//- (void)ininViewUI {
//    UIView * EditorView = [UIView new];
//    EditorView.backgroundColor = [UIColor orangeColor];
//    [self.contentView addSubview:EditorView];
//    [EditorView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(90);
//        make.top.equalTo(self).offset(5);
//        make.width.mas_offset(120);
//    }];
    //  筛选按钮
//    UIButton * ScreeningBut = [UIButton new];
//    [ScreeningBut setImage:[UIImage imageNamed:@"ic_shop_down"] forState:UIControlStateNormal];
//    ScreeningBut.layer.borderColor = [UIColor clearColor].CGColor;
//    ScreeningBut.layer.borderWidth = 1;
//    [ScreeningBut addTarget:self action:@selector(ScreeningBut:) forControlEvents:UIControlEventTouchUpInside];
//    [EditorView addSubview:ScreeningBut];
//    [ScreeningBut mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(EditorView).offset(95);
//        make.top.equalTo(EditorView).offset(55);
//        make.width.mas_equalTo(15);
//        make.height.mas_equalTo(15);
//    }];
//    //  背景
//    UIView * backgroundView = [UIView new];
//    backgroundView.layer.borderWidth = 1;
//    backgroundView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
////    backgroundView.backgroundColor = [UIColor orangeColor];
//    [EditorView addSubview:backgroundView];
//    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(EditorView).offset(95);
//        make.bottom.equalTo(self).offset(-23.5);
//        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(100);
//    }];
//
//    //  减少
//    UIButton * Reducebutton = [UIButton buttonWithType:UIButtonTypeCustom];
//    Reducebutton.frame = CGRectMake(0, 0, 20, 20);
//    [Reducebutton setImage:[UIImage imageNamed:@"ic_shopping_less"] forState:UIControlStateNormal];
//    Reducebutton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
//    Reducebutton.layer.borderWidth = 1;
//    [Reducebutton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [backgroundView addSubview:Reducebutton];
//    _Reducebutton = Reducebutton;
//
//    //  个数
//    UILabel * numLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 20)];
//    numLabel.textAlignment = NSTextAlignmentCenter;
//    numLabel.textColor = [UIColor blackColor];
//    numLabel.text = @"0";
//    numLabel.font = [UIFont systemFontOfSize:14];
//    [backgroundView addSubview:numLabel];
//    _numLabel = numLabel;
//
//    //  添加
//    UIButton * addButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    addButton.frame = CGRectMake(80, 0, 20, 20);
//    [addButton setImage:[UIImage imageNamed:@"ic_shopping_add"] forState:UIControlStateNormal];
//    addButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
//    addButton.layer.borderWidth = 1;
//    [addButton addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
//    [backgroundView addSubview:addButton];
//    _addButton = addButton;
//
//    //  分割线
//    UIView * view1 = [UIView new];
//    view1.backgroundColor = ZP_Graybackground;
//    [self.contentView addSubview:view1];
//    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(100);
//        make.right.equalTo(self).offset(ZP_Width); //长
//        make.bottom.equalTo(self).offset(0); // 高
//        make.height.mas_equalTo(1); // 高
//    }];

//}

- (void)buttonClick:(UIButton *)sender {
    if ([_numLabel.text integerValue]<=0) {
        _numLabel.text = @"0";
    }else {
        _numLabel.text = [NSString stringWithFormat:@"%ld",[_numLabel.text integerValue]-1];
        self.btnClickBlock(_numLabel.text);
    }
}

- (void)addClick:(UIButton *)sender {
    
    _numLabel.text = [NSString stringWithFormat:@"%ld",[_numLabel.text integerValue]+1];
    self.btnClickBlock(_numLabel.text);
}

//  筛选
- (void)ScreeningBut:(UIButton *)sender {
    NSLog(@"筛选");
}
@end


//
//  OrderViewCell.m
//  DDAYGO
//
//  Created by Login on 2017/9/21.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "OrderViewCell.h"
#import "PrefixHeader.pch"
#import "LogistcsController.h"
#import "AppraiseController.h"
@implementation OrderViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:@"orderViewCell"];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void) initUI {
    //  订单Name
    ZP_GeneralLabel * OrderLabel = [ZP_GeneralLabel initWithtextLabel:_OrderLabel.text textColor:ZP_textblack font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
    //    OrderLabel.textAlignment = NSTextAlignmentLeft;
    //    OrderLabel.textColor = ZP_textblack;
    OrderLabel.text = NSLocalizedString(@"订单号:", nil);
    //    OrderLabel.font = ZP_titleFont;
    [self.contentView addSubview:OrderLabel];
    [OrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(self).offset(5);
    }];
    _OrderLabel = OrderLabel;
    
    //  ID号
    ZP_GeneralLabel * IDLabel = [ZP_GeneralLabel initWithtextLabel:_IDLabel.text textColor:ZP_textblack font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    //    IDLabel.textAlignment = NSTextAlignmentLeft;
    //    IDLabel.textColor = ZP_textblack;
    //    IDLabel.font = ZP_titleFont;
    [self.contentView addSubview:IDLabel];
    [IDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(55);
        make.top.equalTo(self).offset(5);
    }];
    _IDLabel = IDLabel;
    
    //  日期
    ZP_GeneralLabel * DateLabel = [ZP_GeneralLabel initWithtextLabel:_DateLabel.text textColor:ZP_textblack font:ZP_introduceFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    //    DateLabel.textAlignment = NSTextAlignmentLeft;
    //    DateLabel.textColor = ZP_textblack;
    //    DateLabel.font = ZP_introduceFont;
    [self.contentView addSubview:DateLabel];
    [DateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(self).offset(20);
    }];
    _DateLabel = DateLabel;
    
    
    //  交易成功
    ZP_GeneralLabel * TradingLabel = [ZP_GeneralLabel initWithtextLabel:_TradingLabel.text textColor:ZP_typefaceOrangeColor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
    //    TradingLabel.textAlignment = NSTextAlignmentLeft;
    //    TradingLabel.textColor = ZP_typefaceOrangeColor;
    TradingLabel.text = NSLocalizedString(@"交易成功", nil);
    //    TradingLabel.font = ZP_titleFont;
    [self.contentView addSubview:TradingLabel];
    [TradingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-15);
    }];
    _TradingLabel = TradingLabel;
    
    //    背景view
    UIView * Backgroundview = [UIView new];
    Backgroundview.layer.borderWidth = 1;
    Backgroundview.backgroundColor = ZP_Graybackground;
    Backgroundview.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [self.contentView addSubview:Backgroundview];
    [Backgroundview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(35);
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.height.mas_equalTo(110);
        make.width.mas_equalTo(ZP_Width);
    }];
    _Backgroundview = Backgroundview;
    
    /******************************************************/
    //  主图
    UIImageView * FigureImage = [UIImageView new];
    [self.Backgroundview addSubview:FigureImage];
    [FigureImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(self).offset(40);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(100 - 5);
    }];
    _FigureImage = FigureImage;
    
    //  商家名字
    ZP_GeneralLabel * merchantsLabel = [ZP_GeneralLabel  initWithtextLabel:_merchantsLabel.text textColor:ZP_Graybackground font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
    //    merchantsLabel.textAlignment = NSTextAlignmentLeft;
    //    [merchantsLabel setTextColor:ZP_Graybackground];
    //    merchantsLabel.textColor = [UIColor blackColor];
    //    merchantsLabel.font = ZP_titleFont;
    [self.Backgroundview addSubview:merchantsLabel];
    [merchantsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(FigureImage).offset(80);
        make.top.equalTo(self).offset(40);
    }];
    _merchantsLabel = merchantsLabel;
    
    //  商品文字
    ZP_GeneralLabel * titleLabel = [ZP_GeneralLabel initWithtextLabel:_titleLabel.text textColor:ZP_textblack font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
    titleLabel.textColor = ZP_textblack;
    titleLabel.lineBreakMode = UILineBreakModeWordWrap; //文字分行
    titleLabel.numberOfLines = 0;
    titleLabel.font = ZP_titleFont;
    [self.Backgroundview addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(80);
        make.top.equalTo(self).offset(55);
        make.right.equalTo(self).offset(-20);
    }];
    _titleLabel = titleLabel;
    
    //  250ml升级装
    UILabel * descLabel = [UILabel new];;
    descLabel.textColor = ZP_TypefaceColor;
    descLabel.font = ZP_introduceFont;
    [self.Backgroundview addSubview:descLabel];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(80);
        make.top.equalTo(self).offset(85);
    }];
    _descLabel = descLabel;
    
    //  优惠价格
    UILabel * PreferentialLabel = [UILabel new];
    PreferentialLabel.textAlignment = NSTextAlignmentLeft;
    PreferentialLabel.textColor = ZP_pricebackground;
    PreferentialLabel.font = ZP_titleFont;
    [self.Backgroundview addSubview:PreferentialLabel];
    [PreferentialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(80);
        make.top.equalTo(self).offset(100);
    }];
    _PreferentialLabel = PreferentialLabel;
    
    //  价格
    UILabel * priceLabel = [UILabel new];
    priceLabel.textAlignment = NSTextAlignmentLeft;
    priceLabel.textColor = ZP_TabBarTextColor;
    priceLabel.font = ZP_titleFont;
    [self.Backgroundview addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(80);
        make.top.equalTo(self).offset(115);
    }];
    _priceLabel = priceLabel;
    
    //  横线
    UIView * Crossview = [UIView new];
    Crossview.layer.borderWidth = 1;
    Crossview.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    Crossview.backgroundColor = ZP_TabBarTextColor;
    [self.Backgroundview addSubview: Crossview];
    [Crossview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(80);
        make.top.equalTo(self).offset(122);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(priceLabel);
    }];
    
    //  商标
    UIImageView * TrademarkImage = [UIImageView new];
    [self.Backgroundview addSubview:TrademarkImage];
    [TrademarkImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-120);
        make.top.equalTo(self).offset(110);
    }];
    _TrademarkImage = TrademarkImage;
    
    //  商标编号
    UILabel * TrademarkLabel = [UILabel new];
    TrademarkLabel.textAlignment = NSTextAlignmentLeft;
    TrademarkLabel.textColor = ZP_textblack;
    TrademarkLabel.font = ZP_titleFont;
    [self.Backgroundview addSubview:TrademarkLabel];
    [TrademarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-90);
        make.top.equalTo(self).offset(110);
    }];
    _TrademarkLabel = TrademarkLabel;
    
    //  竖线
    UIView * VerticalView = [UIView new];
    VerticalView.layer.borderWidth = 1;
    VerticalView.backgroundColor = ZP_TabBarTextColor;
    [self.Backgroundview addSubview:VerticalView];
    [VerticalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-55);
        make.top.equalTo(self).offset(120);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(1);
    }];
    
    //  符号X
    UILabel * SharacterLabel = [UILabel new];
    SharacterLabel.textAlignment = NSTextAlignmentLeft;
    SharacterLabel.textColor = ZP_TypefaceColor;
    SharacterLabel.font = ZP_titleFont;
    [self.Backgroundview addSubview:SharacterLabel];
    SharacterLabel.text = @"X";
    [SharacterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-35);
        make.top.equalTo(self).offset(125);
    }];
    
    //  数量
    UILabel * QuantityLabel = [UILabel new];
    QuantityLabel.textAlignment = NSTextAlignmentLeft;
    QuantityLabel.textColor = ZP_TypefaceColor;
    QuantityLabel.font = ZP_titleFont;
    [self.Backgroundview addSubview:QuantityLabel];
    [QuantityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self).offset(125);
    }];
    _QuantityLabel = QuantityLabel;
    
    //  合计
    UILabel * CountLabel = [UILabel new];
    CountLabel.textAlignment = NSTextAlignmentLeft;
    CountLabel.textColor = ZP_textblack;
    CountLabel.text = NSLocalizedString(@"合计:", nil);
    CountLabel.font = ZP_introduceFont;
    [self.contentView addSubview:CountLabel];
    [CountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-120);
        make.bottom.equalTo(self).offset(-60);
    }];
    _CountLabel = CountLabel;
    
    //  金额
    UILabel * AmountLabel = [UILabel new];
    AmountLabel.textAlignment = NSTextAlignmentLeft;
    AmountLabel.textColor = ZP_textblack;
    AmountLabel.font = ZP_introduceFont;
    [self.contentView addSubview:AmountLabel];
    [AmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-95);
        make.bottom.equalTo(self).offset(-60);
    }];
    _AmountLabel = AmountLabel;
    
    //  运费
    UILabel * FreightLabel = [UILabel new];
    FreightLabel.textAlignment = NSTextAlignmentLeft;
    FreightLabel.textColor = ZP_textblack;
    FreightLabel.font = ZP_introduceFont;
    FreightLabel.text = NSLocalizedString(@"(RMB30.00)", nil);
    [self.contentView addSubview:FreightLabel];
    [FreightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-5);
        make.bottom.equalTo(self).offset(-60);
    }];
    _FreightLabel = FreightLabel;
    
    //  评价
    UIButton * AppraiseBut = [UIButton buttonWithType:UIButtonTypeSystem];
    AppraiseBut.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [AppraiseBut setTitle:NSLocalizedString(@"评价", nil) forState:UIControlStateNormal];
    [AppraiseBut setTitleColor:ZP_TypefaceColor forState:UIControlStateNormal];
    AppraiseBut.titleLabel.font = ZP_introduceFont;
    AppraiseBut.layer.borderWidth = 1;
    [AppraiseBut addTarget:self action:@selector(AppraiseBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:AppraiseBut];
    [AppraiseBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-140);
        make.bottom.equalTo(self).offset(-15);
        make.width.mas_equalTo(60);
    }];
    _AppraiseBut = AppraiseBut;
    
    //  物流
    UIButton * LogisticsBut = [UIButton buttonWithType:UIButtonTypeSystem];
    LogisticsBut.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [LogisticsBut setTitle:NSLocalizedString(@"查看物流", nil) forState:UIControlStateNormal];
    [LogisticsBut setTitleColor:ZP_TypefaceColor forState:UIControlStateNormal];
    LogisticsBut.titleLabel.font = ZP_introduceFont;
    LogisticsBut.layer.borderWidth = 1;
    [LogisticsBut addTarget:self action:@selector(LogisticsBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:LogisticsBut];
    [LogisticsBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-75);
        make.bottom.equalTo(self).offset(-15);
        make.width.mas_equalTo(60);
    }];
    _LogisticsBut = LogisticsBut;
    
    //  再次购买
    UIButton * OnceagainBut = [UIButton buttonWithType:UIButtonTypeSystem];
    OnceagainBut.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    OnceagainBut.backgroundColor = ZP_OnceagainColor;
    [OnceagainBut setTitle:NSLocalizedString(@"再次购买", nil) forState:UIControlStateNormal];
    [OnceagainBut setTitleColor:ZP_textWite forState:UIControlStateNormal];
    OnceagainBut.titleLabel.font = ZP_introduceFont;
    OnceagainBut.layer.borderWidth = 1;
    //    [OnceagainBut addTarget:self action:@selector(OnceagainBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:OnceagainBut];
    [OnceagainBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self).offset(-15);
        make.width.mas_equalTo(60);
    }];
    _OnceagainBut = OnceagainBut;
    
}

//  评价
- (void)AppraiseBut:(UIButton *)AppraiseBut {
    AppraiseController * appistcs = [[AppraiseController alloc]init];
    if (self.appraiseBlock) {
        self.appraiseBlock(appistcs);
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"appraise" object:nil];
    
}

//  物流
- (void)LogisticsBut:(UIButton *) LogisticsBut {
    LogistcsController * logistcs = [[LogistcsController alloc]init];
    if (self.finishBlock) {
        self.finishBlock(logistcs);
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"logistcs" object:nil];
    NSLog(@"物流");
}
////  再次购买
//- (void)OnceagainBut:(UIButton *)OnceagainBut {
//    NSLog(@"再次购买");
//}

- (void)InformationWithDic:(OrdersdetailModel *)dic WithModel:(OrderModel *)model{
    int a = [dic.state intValue];
    switch (a) {
        case -1:
            
            break;
        case 1:
            _TradingLabel.text = @"待付款";
            [_OnceagainBut setTitle:@"付款" forState:UIControlStateNormal];
            [_LogisticsBut setTitle:@"取消订单" forState:UIControlStateNormal];
            _AppraiseBut.hidden = YES;
            break;
        case 2:
            _TradingLabel.text = @"待发货";
            [_OnceagainBut setTitle:@"提醒发货" forState:UIControlStateNormal];
            _LogisticsBut.hidden = YES;
            _AppraiseBut.hidden = YES;
            break;
        case 3:
            _TradingLabel.text = @"待收货";
            [_OnceagainBut setTitle:@"确认收货" forState:UIControlStateNormal];
            _AppraiseBut.hidden = YES;
            break;
        case 4:
            _TradingLabel.text = @"交易成功";
            [_OnceagainBut setTitle:@"再次购买" forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    _IDLabel.text = [NSString stringWithFormat:@"%@",dic.ordersnumber];
    _DateLabel.text = model.createtime;
    //    _TimeLabel.text = dic[@"Time"];
    [_FigureImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.ddaygo.com%@", dic.defaultimg]]];
    _titleLabel.text = dic.productname;
    //    _descLabel.text = dic[@"desc"];
    _PreferentialLabel.text = [NSString stringWithFormat:@"%@",dic.cost];
    _priceLabel.text = [NSString stringWithFormat:@"%@",dic.price];
    _TrademarkImage.image = [UIImage imageNamed:@"ic_cp"];
    _TrademarkLabel.text = [NSString stringWithFormat:@"%@",dic.cp];
    _QuantityLabel.text = [NSString stringWithFormat:@"%@",dic.amount];
    _merchantsLabel.text = [NSString stringWithFormat:@"%@",dic.suppliername];
    _AmountLabel.text = @"123";
}

@end


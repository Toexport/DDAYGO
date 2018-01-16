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
#import "RequestReplaceController.h"
#import "RequestRefundController.h"
#import "ZP_OrderModel.h"
@implementation OrderViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:@"orderViewCell"];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void) initUI {
    //  订单号
    ZP_GeneralLabel * OrderLabel = [ZP_GeneralLabel initWithtextLabel:_OrderLabel.text textColor:ZP_textblack font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
    OrderLabel.text = NSLocalizedString(@"訂單號:", nil);
    [self.contentView addSubview:OrderLabel];
    [OrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(self).offset(5);
    }];
    _OrderLabel = OrderLabel;
    
    //  ID号
    ZP_GeneralLabel * IDLabel = [ZP_GeneralLabel initWithtextLabel:_IDLabel.text textColor:ZP_textblack font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self.contentView addSubview:IDLabel];
    [IDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(55);
        make.top.equalTo(self).offset(5);
    }];
    _IDLabel = IDLabel;
    
    //  日期
    ZP_GeneralLabel * DateLabel = [ZP_GeneralLabel initWithtextLabel:_DateLabel.text textColor:ZP_textblack font:ZP_introduceFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self.contentView addSubview:DateLabel];
    [DateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(self).offset(20);
    }];
    _DateLabel = DateLabel;
    
    
//     删除订单按钮
    UIButton * DeleteBut = [UIButton buttonWithType:UIButtonTypeSystem];
    [DeleteBut setBackgroundImage:[UIImage imageNamed:@"ic_dianpu_delete_normal"] forState:UIControlStateNormal];
    [DeleteBut addTarget:self action:@selector(DeleteBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:DeleteBut];
    [DeleteBut mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.top.equalTo(self).offset(10);
        }];
    _DeleteBut = DeleteBut;
    
    
//  交易状态
    ZP_GeneralLabel * TradingLabel = [ZP_GeneralLabel initWithtextLabel:_TradingLabel.text textColor:ZP_typefaceOrangeColor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
    [self.contentView addSubview:TradingLabel];
    [TradingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(DeleteBut).offset(2.5);
        make.right.equalTo(DeleteBut).offset(-25);
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
    ZP_GeneralLabel * merchantsLabel = [ZP_GeneralLabel  initWithtextLabel:_merchantsLabel.text textColor:ZP_textblack font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    [self.Backgroundview addSubview:merchantsLabel];
//    merchantsLabel.text = @"你好吗";
    [merchantsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(FigureImage).offset(80);
        make.top.equalTo(DateLabel).offset(20);
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
        make.left.equalTo(FigureImage).offset(80);
        make.right.equalTo(self.Backgroundview).offset(-10);
        make.top.equalTo(merchantsLabel).offset(20);
    }];
    _titleLabel = titleLabel;
    
//  颜色分类
    ZP_GeneralLabel * descLabel = [ZP_GeneralLabel initWithtextLabel:_descLabel.text textColor:ZP_TypefaceColor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    [self.Backgroundview addSubview:descLabel];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(FigureImage).offset(80);
        make.top.equalTo(merchantsLabel).offset(50);
    }];
    _descLabel = descLabel;
    
//  尺码
    ZP_GeneralLabel * SizeLabel = [ZP_GeneralLabel initWithtextLabel:_SizeLabel.text textColor:ZP_TypefaceColor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    SizeLabel.text = @"XXL";
    [self.Backgroundview addSubview:SizeLabel];
    [SizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(descLabel).offset(10);
        make.top.equalTo(descLabel).offset(0);
    }];
    _SizeLabel = SizeLabel;
//  货币符号
    ZP_GeneralLabel * CurrencySymbolLabel = [ZP_GeneralLabel initWithtextLabel:_CurrencySymbolLabel.text textColor:ZP_TypefaceColor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    [self.Backgroundview addSubview:CurrencySymbolLabel];
    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:@"symbol"];
    CurrencySymbolLabel.text = [NSString stringWithFormat:@"%@",str];
    [CurrencySymbolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(FigureImage).offset(80);
        make.top.equalTo(SizeLabel).offset(20);
    }];
//  优惠价格
    ZP_GeneralLabel * PreferentialLabel = [ZP_GeneralLabel initWithtextLabel:_PreferentialLabel.text textColor:ZP_TypefaceColor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    [self.Backgroundview addSubview:PreferentialLabel];
    [PreferentialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CurrencySymbolLabel).offset(20);
        make.top.equalTo(SizeLabel).offset(20);
    }];
    _PreferentialLabel = PreferentialLabel;
//
////  价格
//    ZP_GeneralLabel * priceLabel = [ZP_GeneralLabel initWithtextLabel:_priceLabel.text textColor:ZP_TabBarTextColor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
////    [self.Backgroundview addSubview:priceLabel];
//    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(FigureImage).offset(80);
//        make.top.equalTo(PreferentialLabel).offset(15);
//    }];
//    _priceLabel = priceLabel;
    
////  横线
//    UIView * Crossview = [UIView new];
//    Crossview.layer.borderWidth = 1;
//    Crossview.backgroundColor = ZP_TabBarTextColor;
////    [self.Backgroundview addSubview: Crossview];
//    [Crossview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(FigureImage).offset(80);
//        make.top.equalTo(priceLabel).offset(7.5);
//        make.height.mas_equalTo(1);
//        make.width.mas_equalTo(priceLabel);
//    }];
    
//  商标
    UIImageView * TrademarkImage = [UIImageView new];
    [self.Backgroundview addSubview:TrademarkImage];
    [TrademarkImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-90);
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
        make.top.equalTo(TrademarkImage).offset(0);
    }];
    _TrademarkLabel = TrademarkLabel;
    
//  竖线
    UIView * VerticalView = [UIView new];
    VerticalView.layer.borderWidth = 1;
    VerticalView.backgroundColor = ZP_TabBarTextColor;
    [self.Backgroundview addSubview:VerticalView];
    [VerticalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-55);
        make.top.equalTo(TrademarkLabel).offset(0);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(1);
    }];
    
//  符号X
    ZP_GeneralLabel * SharacterLabel = [ZP_GeneralLabel initWithtextLabel:_SharacterLabel.text textColor:ZP_TypefaceColor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    [self.Backgroundview addSubview:SharacterLabel];
    SharacterLabel.text = @"X";
    _SharacterLabel = SharacterLabel;
    [SharacterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(VerticalView).offset(5);
        make.top.equalTo(VerticalView).offset(0);
    }];
    
//  数量
    ZP_GeneralLabel * QuantityLabel = [ZP_GeneralLabel initWithtextLabel:_QuantityLabel.text textColor:ZP_TypefaceColor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    [self.Backgroundview addSubview:QuantityLabel];
    [QuantityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(SharacterLabel).offset(10);
        make.top.equalTo(SharacterLabel).offset(0);
    }];
    _QuantityLabel = QuantityLabel;
    
//  合计
    ZP_GeneralLabel * CountLabel = [ZP_GeneralLabel initWithtextLabel:_CountLabel.text textColor:ZP_textblack font:ZP_introduceFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    CountLabel.text = NSLocalizedString(@"合計", nil);
    [self.contentView addSubview:CountLabel];
    [CountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TrademarkImage).offset(-20);
        make.top.equalTo(VerticalView).offset(40);
    }];
    _CountLabel = CountLabel;
    
//  金额
    ZP_GeneralLabel * AmountLabel = [ZP_GeneralLabel initWithtextLabel:_AmountLabel.text textColor:ZP_textblack font:ZP_introduceFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self.contentView addSubview:AmountLabel];
    [AmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CountLabel).offset(25);
        make.top.equalTo(VerticalView).offset(40);
    }];
    _AmountLabel = AmountLabel;
    
//  运费
    ZP_GeneralLabel * FreightLabel = [ZP_GeneralLabel initWithtextLabel:_FreightLabel.text textColor:ZP_textblack font:ZP_introduceFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    FreightLabel.text = NSLocalizedString(@"運費", nil);
    [self.contentView addSubview:FreightLabel];
    [FreightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(AmountLabel).offset(40);
        make.top.equalTo(VerticalView).offset(40);
    }];
    _FreightLabel = FreightLabel;
    
    
//  快递费
    ZP_GeneralLabel * ExpressFeeLabel = [ZP_GeneralLabel initWithtextLabel:_ExpressFeeLabel.text textColor:ZP_textblack font:ZP_introduceFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
//    ExpressFeeLabel.text = @"0.00";
    [self.contentView addSubview:ExpressFeeLabel];
    _ExpressFeeLabel = ExpressFeeLabel;
    [ExpressFeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(FreightLabel).offset(25);
        make.top.equalTo(FreightLabel).offset(0);
    }];
    
//  评价
    UIButton * AppraiseBut = [UIButton buttonWithType:UIButtonTypeSystem];
    AppraiseBut.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [AppraiseBut setTitle:NSLocalizedString(@"評價", nil) forState:UIControlStateNormal];
    [AppraiseBut setTitleColor:ZP_TypefaceColor forState:UIControlStateNormal];
    AppraiseBut.titleLabel.font = ZP_introduceFont;
    AppraiseBut.layer.borderWidth = 1;
    [AppraiseBut addTarget:self action:@selector(AppraiseBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:AppraiseBut];
    [AppraiseBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-75);
        make.bottom.equalTo(self).offset(-15);
        make.width.mas_equalTo(60);
    }];
    _AppraiseBut = AppraiseBut;
    
////  物流
//    UIButton * LogisticsBut = [UIButton buttonWithType:UIButtonTypeSystem];
//    LogisticsBut.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
//    [LogisticsBut setTitle:NSLocalizedString(@"查看物流", nil) forState:UIControlStateNormal];
//    [LogisticsBut setTitleColor:ZP_TypefaceColor forState:UIControlStateNormal];
//    LogisticsBut.titleLabel.font = ZP_introduceFont;
//    LogisticsBut.layer.borderWidth = 1;
//    [LogisticsBut addTarget:self action:@selector(LogisticsBut:) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:LogisticsBut];
//    [LogisticsBut mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self).offset(-75);
//        make.bottom.equalTo(self).offset(-15);
//        make.width.mas_equalTo(60);
//    }];
//    _LogisticsBut = LogisticsBut;

//  再次购买
    UIButton * OnceagainBut = [UIButton buttonWithType:UIButtonTypeSystem];
    OnceagainBut.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    OnceagainBut.backgroundColor = ZP_OnceagainColor;
    [OnceagainBut setTitle:NSLocalizedString(@"再次購買", nil) forState:UIControlStateNormal];
    [OnceagainBut setTitleColor:ZP_textWite forState:UIControlStateNormal];
    OnceagainBut.titleLabel.font = ZP_introduceFont;
    OnceagainBut.layer.borderWidth = 1;
    //    [OnceagainBut addTarget:self action:@selector(OnceagainBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:OnceagainBut];
    [OnceagainBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(AppraiseBut).offset(0);
        make.width.mas_equalTo(60);
    }];
    _OnceagainBut = OnceagainBut;
}

//  评价
- (void)AppraiseBut:(UIButton *)AppraiseBut {
    NSLog(@"state =  %@",_model.state);
    switch (_model.state.longValue) {
        case 3:{
            RequestReplaceController * RequestReplace = [[RequestReplaceController alloc]init];
            
            if (self.appraiseBlock) {
                self.appraiseBlock(RequestReplace);
            }
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ExchangeDetails" object:nil];
        }
            break;
            
        case 2:{
            RequestRefundController * RequestRefund = [[RequestRefundController alloc]init];
            RequestRefund.ord = _model.ordersnumber;
            if (self.appraiseBlock) {
                self.appraiseBlock(RequestRefund);
            }
            [[NSNotificationCenter defaultCenter]postNotificationName:@"RequestRefund" object:nil];
        }
            break;
            
        case 4:{
            AppraiseController * appistcs = [[AppraiseController alloc]init];
            if (self.appraiseBlock) {
                self.appraiseBlock(appistcs);
            }
            [[NSNotificationCenter defaultCenter]postNotificationName:@"appraise" object:nil];
        }
            break;
        default:
            break;
    }
}

// 上传按钮
- (void)DeleteBut:(UIButton *)sendel {
    ZPLog(@"----");
}
////  物流
//- (void)LogisticsBut:(UIButton *) LogisticsBut {
//    LogistcsController * logistcs = [[LogistcsController alloc]init];
//    if (self.finishBlock) {
//        self.finishBlock(logistcs);
//    }
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"logistcs" object:nil];
//    NSLog(@"物流");
//}
//  再次购买
//- (void)OnceagainBut:(UIButton *)OnceagainBut {
//    NSLog(@"再次购买");
//}

- (void)InformationWithDic:(OrdersdetailModel *)dic WithModel:(OrderModel *)model {
    int a = [dic.state intValue];
    NSLog(@"Stata = %D",a);
    switch (a) {
        case 0:
            //不让评价点击
            _AppraiseBut.userInteractionEnabled = NO;
            //不让购买点击
            _OnceagainBut.userInteractionEnabled = NO;
            break;
        case 1:
            _TradingLabel.text = @"待付款";
            [_OnceagainBut setTitle:@"付款" forState:UIControlStateNormal];
            [_AppraiseBut setTitle:@"取消訂單" forState:UIControlStateNormal];
//            _AppraiseBut.hidden = YES;
            //例如 --点击第一个看能不能点击
            _AppraiseBut.userInteractionEnabled = NO;
            break;
        case 2:
            _TradingLabel.text = @"待發貨";
            [_OnceagainBut setTitle:@"提醒發貨" forState:UIControlStateNormal];
            [_AppraiseBut setTitle:@"退款" forState:UIControlStateNormal];
            _OnceagainBut.userInteractionEnabled = NO;
//            _AppraiseBut.hidden = YES;
            break;
        case 3:
            _TradingLabel.text = @"待收貨";
            [_OnceagainBut setTitle:@"確認收貨" forState:UIControlStateNormal];
            [_AppraiseBut setTitle:@"退换货" forState:UIControlStateNormal];
            _OnceagainBut.userInteractionEnabled = NO;
//            _AppraiseBut.hidden = YES;
            break;
        case 4:
            _TradingLabel.text = @"交易成功";
            [_OnceagainBut setTitle:@"再次購買" forState:UIControlStateNormal];
            [_AppraiseBut setTitle:@"评价" forState:UIControlStateNormal];
            
            break;
        default:
            break;
    }
    
    _IDLabel.text = [NSString stringWithFormat:@"%@",dic.ordersnumber];
    _DateLabel.text = model.createtime;
    [_FigureImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImgAPI,dic.defaultimg]] placeholderImage:[UIImage imageNamed:@""]];
    _merchantsLabel.text = [NSString stringWithFormat:@"%@",model.shopname];
    _titleLabel.text = dic.productname;
//    _titleLabel.text = model.shopname;
    _descLabel.text = dic.colorname;
    _SizeLabel.text = dic.normname;
    _AmountLabel.text = [NSString stringWithFormat:@"%@",model.ordersamount];
    _ExpressFeeLabel.text = [NSString stringWithFormat:@"%@",model.freight]; // 运费
    _PreferentialLabel.text = [NSString stringWithFormat:@"%@",dic.price];
//    _priceLabel.text = [NSString stringWithFormat:@"NT%@",dic.cost];
    _TrademarkImage.image = [UIImage imageNamed:@"ic_cp"];
    _TrademarkLabel.text = [NSString stringWithFormat:@"%@",dic.cp];
    _QuantityLabel.text = [NSString stringWithFormat:@"%@",dic.amount];
    _model = dic;
}

@end


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
#import "ExchangeDetailsController.h"
#import "ZP_OrderModel.h"
#import "ConfirmViewController.h"
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
        make.left.equalTo(self).offset(50);
        make.top.equalTo(OrderLabel).offset(0);
    }];
    _IDLabel = IDLabel;
    
    //  日期
    ZP_GeneralLabel * DateLabel = [ZP_GeneralLabel initWithtextLabel:_DateLabel.text textColor:ZP_textblack font:ZP_introduceFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self.contentView addSubview:DateLabel];
    [DateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(IDLabel).offset(20);
    }];
    _DateLabel = DateLabel;
    
//     删除订单按钮
    UIButton * DeleteBut = [UIButton buttonWithType:UIButtonTypeSystem];
    [DeleteBut setBackgroundImage:[UIImage imageNamed:@"ic_footprint_delete_normal"] forState:UIControlStateNormal];
    [DeleteBut addTarget:self action:@selector(DeleteBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:DeleteBut];
    [DeleteBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self).offset(10);
        make.width.mas_offset(15);
        make.height.mas_offset(15);
        }];
    _DeleteBut = DeleteBut;
    
//  交易状态
    ZP_GeneralLabel * TradingLabel = [ZP_GeneralLabel initWithtextLabel:_TradingLabel.text textColor:ZP_typefaceOrangeColor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:nil];
    [self.contentView addSubview:TradingLabel];
    [TradingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(DeleteBut).offset(0);
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
        make.top.equalTo(self).offset(40);
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
        make.top.equalTo(self).offset(45);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(100 - 5);
    }];
    _FigureImage = FigureImage;
    
//  商家名字
    ZP_GeneralLabel * merchantsLabel = [ZP_GeneralLabel  initWithtextLabel:_merchantsLabel.text textColor:ZP_textblack font:ZP_stockFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    [self.Backgroundview addSubview:merchantsLabel];
//    merchantsLabel.text = @"你好吗";
    [merchantsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(FigureImage).offset(95);
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
        make.left.equalTo(FigureImage).offset(95);
        make.right.equalTo(self.Backgroundview).offset(-10);
        make.top.equalTo(merchantsLabel).offset(20);
    }];
    _titleLabel = titleLabel;
    
//  颜色分类
    ZP_GeneralLabel * descLabel = [ZP_GeneralLabel initWithtextLabel:_descLabel.text textColor:ZP_TypefaceColor font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    [self.Backgroundview addSubview:descLabel];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(FigureImage).offset(95);
        make.top.equalTo(merchantsLabel).offset(50);
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
        make.top.equalTo(SizeLabel).offset(20);
        make.height.mas_offset(15);
    }];
    
//  优惠价格
    ZP_GeneralLabel * PreferentialLabel = [ZP_GeneralLabel initWithtextLabel:_PreferentialLabel.text textColor:ZP_HomePreferentialpriceTypefaceCorlor font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    [self.Backgroundview addSubview:PreferentialLabel];
    [PreferentialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CurrencySymbolLabel).offset(20);
        make.top.equalTo(SizeLabel).offset(20);
        make.height.mas_offset(15);
    }];
    _PreferentialLabel = PreferentialLabel;

//  商标
    UIImageView * TrademarkImage = [UIImageView new];
    [self.Backgroundview addSubview:TrademarkImage];
    [TrademarkImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(SizeLabel).offset(-10);
        make.top.equalTo(PreferentialLabel).offset(+2);
        make.width.mas_offset(15);
        make.height.mas_offset(15);
    }];
    _TrademarkImage = TrademarkImage;
    
//  商标编号
    ZP_GeneralLabel * TrademarkLabel = [ZP_GeneralLabel initWithtextLabel:_TrademarkLabel.text textColor:ZP_textblack font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_Graybackground];
    [self.Backgroundview addSubview:TrademarkLabel];
    [TrademarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TrademarkImage).offset(18);
        make.bottom.equalTo(PreferentialLabel).offset(+2);
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
    
//  合计
    ZP_GeneralLabel * CountLabel = [ZP_GeneralLabel initWithtextLabel:_CountLabel.text textColor:ZP_textblack font:ZP_addBtnTextdetaFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    CountLabel.text = NSLocalizedString(@"合計:", nil);
    [self.contentView addSubview:CountLabel];
    [CountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TrademarkImage).offset(-20);
        make.top.equalTo(VerticalView).offset(40);
    }];
    _CountLabel = CountLabel;
    
//  金额
    ZP_GeneralLabel * AmountLabel = [ZP_GeneralLabel initWithtextLabel:_AmountLabel.text textColor:ZP_textblack font:ZP_addBtnTextdetaFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self.contentView addSubview:AmountLabel];
    [AmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CountLabel).offset(38);
        make.top.equalTo(VerticalView).offset(40);
    }];
    _AmountLabel = AmountLabel;
    
//  运费
    ZP_GeneralLabel * FreightLabel = [ZP_GeneralLabel initWithtextLabel:_FreightLabel.text textColor:ZP_textblack font:ZP_stockFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    FreightLabel.text = NSLocalizedString(@"(運費", nil);
    [self.contentView addSubview:FreightLabel];
    [FreightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(AmountLabel).offset(70);
        make.top.equalTo(AmountLabel).offset(+2.5);
    }];
    _FreightLabel = FreightLabel;
    
//  快递费
    ZP_GeneralLabel * ExpressFeeLabel = [ZP_GeneralLabel initWithtextLabel:_ExpressFeeLabel.text textColor:ZP_textblack font:ZP_stockFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
//    ExpressFeeLabel.text = @"0.00";
    [self.contentView addSubview:ExpressFeeLabel];
    _ExpressFeeLabel = ExpressFeeLabel;
    [ExpressFeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(FreightLabel).offset(35);
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
        [OnceagainBut addTarget:self action:@selector(OnceagainBut:) forControlEvents:UIControlEventTouchUpInside];
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
            RequestReplace.Oid = self.model.ordersnumber; // 传过去的数据(订单号)
            if (self.appraiseBlock) {
                self.appraiseBlock(RequestReplace);
            }
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ExchangeDetails" object:nil];
        }
            break;
            
//        case 2:{
//            RequestRefundController * RequestRefund = [[RequestRefundController alloc]init];
//            RequestRefund.ord = self.model.ordersnumber;
//            if (self.appraiseBlock) {
//                self.appraiseBlock(RequestRefund);
//            }
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"RequestRefund" object:nil];
//        }
//            break;
//
//        case 4:{
//            AppraiseController * appistcs = [[AppraiseController alloc]init];
//            appistcs.ordersnumber = self.model.ordersnumber; // 传过去的数据(订单号)
//            appistcs.productid = self.model.productid; // 传过去的数据(商品ID)
//            appistcs.detailid = self.model.detailid; // 传过去的数据(商品详情ID)
//            appistcs.model2 = self.model;
//            if (self.appraiseBlock) {
//                self.appraiseBlock(appistcs);
//            }
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"appraise" object:nil];
//        }
//            break;
//
        default:
            break;
    }
}

//  再次购买
- (void)OnceagainBut:(UIButton *)OnceagainBut {
    NSLog(@"state =  %@",_model.state);
    switch (_model.state.longValue) {
        case 6:{
            // 退款详情
            ExchangeDetailsController * ExchangeDetails = [[ExchangeDetailsController alloc]init];
            ExchangeDetails.Oid = _model.ordersnumber;// 传过去的数据(订单号)
            ExchangeDetails.type = 666;
            if (self.onceagainBlock) {
                self.onceagainBlock(ExchangeDetails);
            }
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ExchangeDetails" object:nil];
        }
            break;
            
        case 4:{
            if ([_model.reviewscount integerValue] == 0) {
                AppraiseController * appistcs = [[AppraiseController alloc]init];
                appistcs.ordersnumber = self.model.ordersnumber; // 传过去的数据(订单号)
                appistcs.productid = self.model.productid; // 传过去的数据(商品ID)
                appistcs.detailid = self.model.detailid; // 传过去的数据(商品详情ID)
                appistcs.model2 = self.model;
                if (self.appraiseBlock) {
                    self.appraiseBlock(appistcs);
                }
                [[NSNotificationCenter defaultCenter]postNotificationName:@"appraise" object:nil];
                _OnceagainBut.hidden = NO;
            }else {
                RequestReplaceController * RequestReplace = [[RequestReplaceController alloc]init];
                if (self.appraiseBlock) {
                    self.appraiseBlock(RequestReplace);
                }
                [[NSNotificationCenter defaultCenter]postNotificationName:@"RequestReplace" object:nil];
                _OnceagainBut.hidden = YES;
            }
        }
            break;
    // 付款
        case 1:{
            ConfirmViewController * confirm = [[ConfirmViewController alloc]init];
            confirm.stockidsString = [NSString stringWithFormat:@"%@_%@",_model.stockid,_model.amount];
            confirm.noEdit = YES;
            confirm.ordersnumber = _model2.ordersnumber;
            confirm.type = 666;
            
            if (self.onceagainBlock) {
                self.onceagainBlock(confirm);
            }
            [[NSNotificationCenter defaultCenter]postNotificationName:@"confirm" object:nil];
        }
            break;
    // 退款
        case 2:{
            RequestRefundController * RequestRefund = [[RequestRefundController alloc]init];
            RequestRefund.oid = self.model.ordersnumber;

            
            if (self.onceagainBlock) {
                self.onceagainBlock(RequestRefund);
            }
            [[NSNotificationCenter defaultCenter]postNotificationName:@"RequestRefund" object:nil];
        }
            break;
            
        default:
            break;
    }
}

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
            _DeleteBut.hidden = NO;
//            [_AppraiseBut setTitle:@"取消訂單" forState:UIControlStateNormal];
            _AppraiseBut.hidden = YES;
            //例如 --点击第一个看能不能点击
            NSLog(@"Stata = %D",a);
            _AppraiseBut.userInteractionEnabled = NO;
            break;
//          退款
        case 2:
            _TradingLabel.text = @"待發貨";
            _DeleteBut.hidden = YES;
            [_OnceagainBut setTitle:@"退款" forState:UIControlStateNormal];
            _OnceagainBut.backgroundColor = nil;
            [self.OnceagainBut setTitleColor:ZP_TypefaceColor forState:UIControlStateNormal];
//            [_AppraiseBut setTitle:@"退款" forState:UIControlStateNormal];
            NSLog(@"Stata = %D",a);
//            _OnceagainBut.userInteractionEnabled = YES;
            _AppraiseBut.hidden = YES;
            break;
            
        case 3:
            _TradingLabel.text = @"待收貨";
            _DeleteBut.hidden = YES;
            [_OnceagainBut setTitle:@"確認收貨" forState:UIControlStateNormal];
            [_AppraiseBut setTitle:@"退换货" forState:UIControlStateNormal];
            NSLog(@"Stata = %D",a);

            _OnceagainBut.userInteractionEnabled = YES;
            break;
            
        case 4:
            _TradingLabel.text = @"交易成功";
            _DeleteBut.hidden = NO;
            [_OnceagainBut setTitle:@"评价" forState:UIControlStateNormal];
            _OnceagainBut.backgroundColor = nil;
            [self.OnceagainBut setTitleColor:ZP_TypefaceColor forState:UIControlStateNormal];
//            [_AppraiseBut setTitle:@"评价" forState:UIControlStateNormal];
            if ([_model.reviewscount integerValue] == 0) {
                _OnceagainBut.hidden = NO;
            }else {
                _OnceagainBut.hidden = YES;
            }
            
            NSLog(@"Stata = %D",a);
            _AppraiseBut.hidden = YES;
//            _OnceagainBut.hidden = YES;
            NSLog(@"Stata = %D",a);
            break;
        case 5:
            _TradingLabel.text = @"交易成功";
            _DeleteBut.hidden = NO;
//            [_OnceagainBut setTitle:@"再次購買" forState:UIControlStateNormal];
//            [_OnceagainBut setTitle:@"评价" forState:UIControlStateNormal];
//            _AppraiseBut.hidden = YES;
//            _OnceagainBut.hidden = YES;
            break;
        case 6:
            _TradingLabel.text = @"退款/售后";
            _DeleteBut.hidden = YES;
            [_OnceagainBut setTitle:@"查看详情" forState:UIControlStateNormal];
            _AppraiseBut.hidden = YES;
            break;
        default:
            break;
    }
    
    _IDLabel.text = [NSString stringWithFormat:@"%@",dic.ordersnumber];
    _DateLabel.text = model.createtime;
    [_FigureImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ImgAPI,dic.defaultimg]] placeholderImage:[UIImage imageNamed:@""]];
    _merchantsLabel.text = [NSString stringWithFormat:@"%@",model.shopname];
    _titleLabel.text = dic.productname;
    _descLabel.text = [NSString stringWithFormat:@"顏色:%@,",dic.colorname];
    _SizeLabel.text = [NSString stringWithFormat:@"尺碼:%@",dic.normname];
    _AmountLabel.text = [NSString stringWithFormat:@"NT%@",model.ordersamount];
    _ExpressFeeLabel.text = [NSString stringWithFormat:@"NT%@)",model.freight]; // 运费
    _PreferentialLabel.text = [NSString stringWithFormat:@"%@",dic.price];
//    _priceLabel.text = [NSString stringWithFormat:@"NT%@",dic.cost];
    _TrademarkImage.image = [UIImage imageNamed:@"ic_cp"];
    _TrademarkLabel.text = [NSString stringWithFormat:@"%@",dic.cp];
    _QuantityLabel.text = [NSString stringWithFormat:@"%@",dic.amount];
    _model = dic;
    _model2 = model;
}

@end


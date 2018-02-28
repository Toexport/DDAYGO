//
//  OrdeTailViewCell.m
//  DDAYGO
//
//  Created by Summer on 2018/1/28.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "OrdeTailViewCell.h"
#import "PrefixHeader.pch"
#import "LogistcsController.h"
#import "AppraiseController.h"
#import "RequestReplaceController.h"
#import "RequestRefundController.h"
#import "ExchangeDetailsController.h"
#import "ZP_OrderModel.h"
#import "ConfirmViewController.h"
#import "ZP_OrderTool.h"
@implementation OrdeTailViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:@"OrdeTailViewCell"];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    //  合计
    ZP_GeneralLabel * CountLabel = [ZP_GeneralLabel initWithtextLabel:_CountLabel.text textColor:ZP_textblack font:ZP_addBtnTextdetaFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    CountLabel.text = [NSString stringWithFormat:@"%@:",MyLocal(@"Total")];
    [self.contentView addSubview:CountLabel];
    [CountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-165);
        make.top.equalTo(self).offset(8);
    }];
    _CountLabel = CountLabel;
    
    //  金额
    ZP_GeneralLabel * AmountLabel = [ZP_GeneralLabel initWithtextLabel:_AmountLabel.text textColor:ZP_textblack font:ZP_addBtnTextdetaFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self.contentView addSubview:AmountLabel];
    [AmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(CountLabel).offset(38);
        make.top.equalTo(CountLabel).offset(0);
    }];
    _AmountLabel = AmountLabel;
    
    //  运费
    ZP_GeneralLabel * FreightLabel = [ZP_GeneralLabel initWithtextLabel:_FreightLabel.text textColor:ZP_textblack font:ZP_stockFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    FreightLabel.text = NSLocalizedString(@"(freight", nil);
    [self.contentView addSubview:FreightLabel];
    [FreightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(AmountLabel).offset(75);
        make.top.equalTo(AmountLabel).offset(+2);
    }];
    _FreightLabel = FreightLabel;
    
    //  快递费
    ZP_GeneralLabel * ExpressFeeLabel = [ZP_GeneralLabel initWithtextLabel:_ExpressFeeLabel.text textColor:ZP_textblack font:ZP_stockFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self.contentView addSubview:ExpressFeeLabel];
    _ExpressFeeLabel = ExpressFeeLabel;
    [ExpressFeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(FreightLabel).offset(35);
        make.top.equalTo(FreightLabel).offset(0);
    }];
    
    //  左边按钮
    UIButton * AppraiseBut = [UIButton buttonWithType:UIButtonTypeSystem];
    AppraiseBut.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [AppraiseBut setTitle:MyLocal(@"evaluation") forState:UIControlStateNormal];
    [AppraiseBut setTitleColor:ZP_TypefaceColor forState:UIControlStateNormal];
    AppraiseBut.titleLabel.font = ZP_introduceFont;
//    AppraiseBut.layer.borderWidth = 1;
    [AppraiseBut addTarget:self action:@selector(AppraiseBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:AppraiseBut];
    [AppraiseBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-75);
        make.bottom.equalTo(self).offset(-10);
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
    
    //  右边按钮
    UIButton * OnceagainBut = [UIButton buttonWithType:UIButtonTypeSystem];
    OnceagainBut.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    OnceagainBut.backgroundColor = ZP_OnceagainColor;
    [OnceagainBut setTitle:MyLocal(@"Buy again") forState:UIControlStateNormal];
    [OnceagainBut setTitleColor:ZP_textWite forState:UIControlStateNormal];
    OnceagainBut.titleLabel.font = ZP_introduceFont;
//    OnceagainBut.layer.borderWidth = 1;
    [OnceagainBut addTarget:self action:@selector(OnceagainBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:OnceagainBut];
    [OnceagainBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(AppraiseBut).offset(0);
        make.width.mas_equalTo(60);
    }];
    _OnceagainBut = OnceagainBut;
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
            [_OnceagainBut setTitle:MyLocal(@"payment") forState:UIControlStateNormal];
            //            _DeleteBut.hidden = NO;
            //            [_AppraiseBut setTitle:@"取消訂單" forState:UIControlStateNormal];
            _AppraiseBut.hidden = YES;
            //例如 --点击第一个看能不能点击
            //            NSLog(@"Stata = %D",a);
            _AppraiseBut.userInteractionEnabled = NO;
            //            ZPLog(@"Stata = %D",a);
            break;
            //          退款
        case 2:
            [_OnceagainBut setTitle:MyLocal(@"refund") forState:UIControlStateNormal];
            _OnceagainBut.backgroundColor = nil;
            [self.OnceagainBut setTitleColor:ZP_TypefaceColor forState:UIControlStateNormal];
            //            [_AppraiseBut setTitle:@"退款" forState:UIControlStateNormal];
            //            ZPLog(@"Stata = %D",a);
            _OnceagainBut.hidden = NO;
            _AppraiseBut.hidden = YES;
            break;
            
        case 3:
            [_OnceagainBut setTitle:MyLocal(@"Confirmation of receipt") forState:UIControlStateNormal];
            [_AppraiseBut setTitle:MyLocal(@"Exchange of goods") forState:UIControlStateNormal];
            //            NSLog(@"Stata = %D",a);
            _OnceagainBut.userInteractionEnabled = YES;
            //            ZPLog(@"Stata = %D",a);
            break;
        case 4:
            [_OnceagainBut setTitle:MyLocal(@"evaluation") forState:UIControlStateNormal];
            _OnceagainBut.backgroundColor = nil;
            [self.OnceagainBut setTitleColor:ZP_TypefaceColor forState:UIControlStateNormal];
            //            [_AppraiseBut setTitle:@"评价" forState:UIControlStateNormal];
            //        你是根据这个有判断是否隐藏 不是根据4，不是更具4的
            if ([_model.reviewscount integerValue] == 0) {
                _OnceagainBut.hidden = NO;
            }else {
                _OnceagainBut.hidden = YES;
            }
            _AppraiseBut.hidden = YES;
            //            ZPLog(@"Stata = %D",a);
            break;
        case 5:
            //            [_OnceagainBut setTitle:@"再次購買" forState:UIControlStateNormal];
            //            [_OnceagainBut setTitle:@"评价" forState:UIControlStateNormal];
            _AppraiseBut.hidden = YES;
            _OnceagainBut.hidden = YES;
            //            ZPLog(@"Stata = %D",a);
            break;
        case 6:
            [_OnceagainBut setTitle:MyLocal(@"Check details") forState:UIControlStateNormal];
            _OnceagainBut.hidden = NO;
            _AppraiseBut.hidden = YES;
            //            ZPLog(@"Stata = %D",a);
            break;
        case 7:
            _OnceagainBut.backgroundColor = nil;
            [self.OnceagainBut setTitleColor:ZP_TypefaceColor forState:UIControlStateNormal];
            [_OnceagainBut setTitle:MyLocal(@"Check details") forState:UIControlStateNormal];
            _OnceagainBut.hidden = NO;
            _AppraiseBut.hidden = YES;
            ZPLog(@"Stata = %D",a);
            break;
        default:
            break;
    }
    _AmountLabel.text = [NSString stringWithFormat:@"%@ %@",DD_MonetarySymbol,model.ordersamount];
    _ExpressFeeLabel.text = [NSString stringWithFormat:@"%@ %@)",DD_MonetarySymbol,model.freight]; // 运费
    _model = dic;
    _model2 = model;
}

//  左边按钮
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
        default:
            break;
    }
}

//  右边按钮
- (void)OnceagainBut:(UIButton *)OnceagainBut {
    NSLog(@"state =  %@",_model.state);
    switch (_model.state.longValue) {
        case 7:{
            // 退款详情
            ExchangeDetailsController * ExchangeDetails = [[ExchangeDetailsController alloc]init];
            ExchangeDetails.Oid = _model.ordersnumber;// 传过去的数据(订单号)
            ExchangeDetails.type = 777;
            if (self.onceagainBlock) {
                self.onceagainBlock(ExchangeDetails);
            }
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ExchangeDetails" object:nil];
        }
            break;
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
            // 评价
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
            confirm.shopname = _model2.shopname;
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
        case 3:{
            //       确认收货
            
            [self requestConfirmreceipt];
        }
            break;
        default:
            break;
    }
}

// 确认收货
- (void)requestConfirmreceipt {
    //    確認收貨
    NSMutableDictionary * dicc = [NSMutableDictionary dictionary];
    dicc[@"token"] = Token;
    dicc[@"oid"] = self.model.ordersnumber;
    [ZP_OrderTool requestConfirmreceipt:dicc success:^(id obj) {
        if ([obj[@"result"] isEqualToString:@"ok"]) {
            [SVProgressHUD showSuccessWithStatus:MyLocal(@"Confirm the success of the receipt")];
            AppraiseController * appistcss = [[AppraiseController alloc]init];
            appistcss.ordersnumber = self.model.ordersnumber; // 传过去的数据(订单号)
            appistcss.productid = self.model.productid; // 传过去的数据(商品ID)
            appistcss.detailid = self.model.detailid; // 传过去的数据(商品详情ID)
            appistcss.model2 = self.model;
            if (self.appraiseBlock) {
                self.appraiseBlock(appistcss);
            }
            [[NSNotificationCenter defaultCenter]postNotificationName:@"appraises" object:nil];
        }
        if ([obj[@"result"] isEqualToString:@"failure"]) {
            [SVProgressHUD showInfoWithStatus:MyLocal(@"Confirm the failed of the receipt")];
        }
        ZPLog(@"%@",obj);
    } failure:^(NSError * error) {
        ZPLog(@"%@",error);
    }];
}

@end


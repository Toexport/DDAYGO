//
//  LogistcsCell.m
//  DDAYGO
//
//  Created by Login on 2017/9/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "LogistcsCell.h"
#import "PrefixHeader.pch"
@implementation LogistcsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:@"logistcsCell"];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI {
    //     主图
    UIImageView * FigureImage = [UIImageView new];
    [self.contentView addSubview:FigureImage];
    [FigureImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(self).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(100);
    }];
    _FigureImage = FigureImage;
    
    //    商品数量
    UILabel * QuantityLabel = [UILabel new];
    QuantityLabel.textAlignment = NSTextAlignmentCenter;
    [QuantityLabel setBackgroundColor:ZP_LabelColor];
    QuantityLabel.textColor = ZP_textWite;
    QuantityLabel.font  = ZP_addBtnTextdetaFont;
    [self.contentView addSubview:QuantityLabel];
    [QuantityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(self).offset(100);
        make.width.mas_equalTo(80);
    }];
    _QuantityLabel = QuantityLabel;
    
    //        物流状态
    UILabel * OrderLabel = [UILabel new];
    OrderLabel.textAlignment = NSTextAlignmentLeft;
    OrderLabel.textColor = ZP_textblack;
    OrderLabel.text = MyLocal(@"Logistics state");
    OrderLabel.font = ZP_addBtnTextdetaFont;
    [self.contentView addSubview:OrderLabel];
    [OrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(95);
        make.top.equalTo(self).offset(20);
    }];
    _OrderLabel = OrderLabel;
    
    //    状态
    UILabel * StateLabel = [UILabel new];
    StateLabel.textAlignment = NSTextAlignmentLeft;
    StateLabel.textColor = ZP_TabbarNormalColor;
    StateLabel.font = ZP_addBtnTextdetaFont;
    [self.contentView addSubview:StateLabel];
    [StateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(180);
        make.top.equalTo(self).offset(20);
    }];
    _StateLabel = StateLabel;
    
    //    运送公司
    UILabel * TransportLabel = [UILabel new];
    TransportLabel.textAlignment = NSTextAlignmentLeft;
    TransportLabel.textColor = ZP_textblack;
    TransportLabel.text = NSLocalizedString(@"Courier company:", nil) ;
    TransportLabel.font = ZP_TooBarFont;
    [self.contentView addSubview:TransportLabel];
    [TransportLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(95);
        make.top.equalTo(self).offset(60);
    }];
    _TransportLabel = TransportLabel;
    
    //     快运公司
    UILabel * CompanyLabel = [UILabel new];
    CompanyLabel.textAlignment = NSTextAlignmentLeft;
    CompanyLabel.font = ZP_TooBarFont;
    [self.contentView addSubview:CompanyLabel];
    [CompanyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(180);
        make.top.equalTo(self).offset(60);
    }];
    _CompanyLabel = CompanyLabel;
    
    //    运单编号
    UILabel * TransportIDLabel = [UILabel new];
    TransportIDLabel.textAlignment = NSTextAlignmentLeft;
    TransportIDLabel.textColor = ZP_textblack;
    TransportIDLabel.text = MyLocal(@"waybill number");
    TransportIDLabel.font = ZP_TooBarFont;
    [self.contentView addSubview:TransportIDLabel];
    [TransportIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(95);
        make.top.equalTo(self).offset(90);
    }];
    _TransportIDLabel = TransportIDLabel;
    
    //     单号
    UILabel * IDnumberLabel = [UILabel new];
    IDnumberLabel.textAlignment = NSTextAlignmentLeft;
    IDnumberLabel.font = ZP_TooBarFont;
    [self.contentView addSubview:IDnumberLabel];
    [IDnumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(180);
        make.top.equalTo(self).offset(90);
    }];
    _IDnumberLabel = IDnumberLabel;
}

- (void)Logistce:(NSDictionary *)dic {
    _FigureImage.image = [UIImage imageNamed:@"Shopping"];
    _StateLabel.text = dic[@"State"];
    _QuantityLabel.text = dic[@"Quantity"];
    _CompanyLabel.text = dic[@"Company"];
    _IDnumberLabel.text = dic[@"IDnumber"];
}



@end

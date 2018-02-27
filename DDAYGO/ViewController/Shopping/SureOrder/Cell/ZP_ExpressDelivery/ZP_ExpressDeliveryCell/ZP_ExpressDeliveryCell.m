//
//  ExpressDeliveryCell.m
//  DDAYGO
//
//  Created by Summer on 2017/10/31.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_ExpressDeliveryCell.h"
#import "PrefixHeader.pch"
@implementation ZP_ExpressDeliveryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    static NSString * ExpressDeliveryID = @"expressDeliveryCell";
    self = [super initWithStyle:style reuseIdentifier:ExpressDeliveryID];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
//  配送方式
    UILabel * DistributionLabel = [UILabel new];
    DistributionLabel.textAlignment = NSTextAlignmentLeft;
    DistributionLabel.textColor = ZP_textblack;
    DistributionLabel.font = ZP_titleFont;
    DistributionLabel.text = MyLocal(@"Distribution mode:");
    [self.contentView addSubview:DistributionLabel];
    [DistributionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-15);
        
    }];
    _DistributionLabel = DistributionLabel;
    
//  快递
    UILabel * CourierLabel = [UILabel new];
    CourierLabel.textAlignment = NSTextAlignmentLeft;
    CourierLabel.textColor = ZP_textblack;
    CourierLabel.font = ZP_titleFont;
    CourierLabel.text = MyLocal(@"Courier:");
    [self.contentView addSubview:CourierLabel];
    [CourierLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-55);
        make.bottom.equalTo(self).offset(-15);
    }];
    _CourierLabel = CourierLabel;
    
//  费用
    UILabel * CostLabel = [UILabel new];
    CostLabel.textAlignment = NSTextAlignmentLeft;
    CostLabel.textColor = ZP_TypefaceColor;
    CostLabel.font = ZP_titleFont;
    [self.contentView addSubview:CostLabel];
    [CostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self).offset(-15);
    }];
    _CostLabel = CostLabel;
    
//  下划线
    UIView * Underline1 = [UIView new];
    Underline1.layer.borderWidth = 1;
    Underline1.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [self.contentView addSubview:Underline1];
    [Underline1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(0);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(ZP_Width - 5);
    }];

}

- (void)ExpressDevliveryDic:(ZP_ExpressDeliveryModel *)model {
    
    _CostLabel.text = [NSString stringWithFormat:@"NT %@",model.freightamount]; // 优惠价格
//    _DistributionLabel.text = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"Distribution mode: ", nil),model.chooselogistic];
}

@end

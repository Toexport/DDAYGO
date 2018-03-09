//
//  ConfirmViewCell.m
//  
//
//  Created by Login on 2017/9/20.
//
//

#import "ZP_ConfirmViewCell.h"
#import "PrefixHeader.pch"

@implementation ZP_ConfirmViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    static NSString * ConfirmViewID = @"confirmViewCell";
    self = [super initWithStyle:style reuseIdentifier:ConfirmViewID];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI {
    
    //  收货人（固定）
    ZP_GeneralLabel* ConsigneeLabel = [ZP_GeneralLabel initWithtextLabel:_ConsigneeLabel.text textColor:ZP_textblack font:ZP_stockFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    ConsigneeLabel.text = MyLocal(@"Consignee:");
    [self addSubview:ConsigneeLabel];
    [ConsigneeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30); // 左
        make.bottom.equalTo(self).offset(-60);
    }];
    _ConsigneeLabel = ConsigneeLabel;
    
    //  名字
    ZP_GeneralLabel * NameLabel = [ZP_GeneralLabel initWithtextLabel:_NameLabel.text textColor:ZP_textblack font:ZP_stockFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self.contentView addSubview:NameLabel];
    [NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(85);
        make.bottom.equalTo(self).offset(-60);
    }];
    _NameLabel = NameLabel;
    
    //  手机号码
    ZP_GeneralLabel * PhotoLabel = [ZP_GeneralLabel initWithtextLabel:_PhotoLabel.text textColor:ZP_textblack font:ZP_stockFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self.contentView addSubview:PhotoLabel];
    [PhotoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20); // 右
        make.bottom.equalTo(self).offset(-60); //下
    }];
    
    _PhotoLabel = PhotoLabel;
    
    //  定位图标（固定）
    UIImageView * addressImage = [UIImageView new];
    [self.contentView addSubview:addressImage];
    addressImage.image = [UIImage imageNamed:@"ic_order_address"];
    [addressImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-35);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(20);
        
    }];
    _addressImage = addressImage;
    
    //  收货地址(固定)
    ZP_GeneralLabel * AddressLabel = [ZP_GeneralLabel initWithtextLabel:_AddressLabel.text textColor:ZP_textblack font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    AddressLabel.text = MyLocal(@"Shipping address:");
    [self.contentView addSubview:AddressLabel];
    [AddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.top.equalTo(ConsigneeLabel).offset(20);
    }];
    _AddressLabel = AddressLabel;
    
    //  地址
    ZP_GeneralLabel * AddressdetailsLabel = [ZP_GeneralLabel initWithtextLabel:_AddressdetailsLabel.text textColor:ZP_textblack font:ZP_titleFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    AddressdetailsLabel.lineBreakMode = NSLineBreakByWordWrapping; //文字分行
    AddressdetailsLabel.numberOfLines = 0;
    [self.contentView addSubview:AddressdetailsLabel];
    [AddressdetailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(85);
        make.top.equalTo(ConsigneeLabel).offset(20);
        make.right.equalTo(self).offset(-30);
    }];
    _AddressdetailsLabel = AddressdetailsLabel;
    
    //  箭头
    UIImageView * ArrowImage = [UIImageView new];
    [self.contentView addSubview:ArrowImage];
    ArrowImage.image = [UIImage imageNamed:@"ic_forward"];
    [ArrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self).offset(-35);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(15);
    }];
    _ArrowImage = ArrowImage;
    
    //  横线彩条
    UIImageView * CrossImage = [UIImageView new];
    [self.contentView addSubview:CrossImage];
    CrossImage.image = [UIImage imageNamed:@"img_order_stripe"];
    [CrossImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.height.mas_equalTo(3);
        make.width.mas_equalTo(ZP_Width);
    }];
    _CrossImage = CrossImage;
}

- (void)cellWithDic:(ZP_ComfirmModel *)model {
    _NameLabel.text = model.receiptname;
    _PhotoLabel.text = model.receiptphone;
    _AddressdetailsLabel.text = model.addressdetail;
}
@end


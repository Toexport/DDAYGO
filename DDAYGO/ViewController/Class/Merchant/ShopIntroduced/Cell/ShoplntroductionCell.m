//
//  ShoplntroductionCell.m
//  DDAYGO
//
//  Created by Login on 2017/10/9.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ShoplntroductionCell.h"
#import "PrefixHeader.pch"
#import "ShoplntroducedModel.h"
@implementation ShoplntroductionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:@"Shoplntroduction"];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI {
//     店铺名字
    UILabel * StorenameLabel = [UILabel new];
    StorenameLabel.textAlignment = NSTextAlignmentLeft;
    StorenameLabel.textColor = ZP_textblack;
    StorenameLabel.font = ZP_NavTextdetaFont;
    [self.contentView addSubview:StorenameLabel];
    
    [StorenameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(15);
    }];
    _StorenameLabel = StorenameLabel;
    
//     下划线
    UIView * Underlineview = [UIView new];
    Underlineview.layer.borderWidth = 1;
    Underlineview.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [self.contentView addSubview:Underlineview];
    [Underlineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(self).offset(40);
        make.height.mas_offset(1);
        make.width.mas_offset(ZP_Width);
    }];
    
//     所在地
    UILabel * RegionLabel = [UILabel new];
    RegionLabel.textAlignment = NSTextAlignmentLeft;
    RegionLabel.textColor = ZP_TypefaceColor;
    RegionLabel.font = ZP_TooBarFont;
    RegionLabel.text = NSLocalizedString(@"所在地:", nil);
    [self.contentView addSubview:RegionLabel];
    [RegionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(50);
    }];
    
//     地址
    UILabel * AddressLabel = [UILabel new];
    AddressLabel.textAlignment = NSTextAlignmentLeft;
    AddressLabel.textColor = ZP_textblack;
    AddressLabel.font = ZP_titleFont;
    [self.contentView addSubview:AddressLabel];
    [AddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(100);
        make.top.equalTo(self).offset(50);
    }];
    _AddressLabel = AddressLabel;
    
//     服务电话
    UILabel * ServicetelephoneLabel = [UILabel new];
    ServicetelephoneLabel.textAlignment = NSTextAlignmentLeft;
    ServicetelephoneLabel.textColor = ZP_TypefaceColor;
    ServicetelephoneLabel.font = ZP_TooBarFont;
    ServicetelephoneLabel.text = NSLocalizedString(@"服务电话:", nil);
    [self.contentView addSubview:ServicetelephoneLabel];
    [ServicetelephoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(70);
    }];
    
//     电话号码
    UILabel * PhoneLabel = [UILabel new];
    PhoneLabel.textAlignment = NSTextAlignmentLeft;
    PhoneLabel.textColor = ZP_textblack;
    PhoneLabel.font = ZP_titleFont;
    [self.contentView addSubview:PhoneLabel];
    [PhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(100);
        make.top.equalTo(self).offset(70);
    }];
    _PhoneLabel = PhoneLabel;
    
//     好评度
    UILabel * EvaluationtitleLabel = [UILabel new];
    EvaluationtitleLabel.textAlignment = NSTextAlignmentLeft;
    EvaluationtitleLabel.textColor = ZP_TypefaceColor;
    EvaluationtitleLabel.font = ZP_TooBarFont;
    EvaluationtitleLabel.text = NSLocalizedString(@"好评度:", nil);
    [self.contentView addSubview:EvaluationtitleLabel];
    [EvaluationtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(90);
    }];
    
//     评价百分比
    UILabel * ratingLabel = [UILabel new];
    ratingLabel.textAlignment = NSTextAlignmentLeft;
    ratingLabel.textColor = ZP_textblack;
    ratingLabel.font = ZP_titleFont;
    [self.contentView addSubview:ratingLabel];
    [ratingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(100);
        make.top.equalTo(self).offset(90);
    }];
    _ratingLabel = ratingLabel;
    
//     服务标题
    UILabel * ServicetimetitleLabel = [UILabel new];
    ServicetimetitleLabel.textAlignment = NSTextAlignmentLeft;
    ServicetimetitleLabel.textColor = ZP_TypefaceColor;
    ServicetimetitleLabel.font = ZP_TooBarFont;
    ServicetimetitleLabel.text = NSLocalizedString(@"服务时间:", nil);
    [self.contentView addSubview:ServicetimetitleLabel];
    [ServicetimetitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(110);
    }];
    
//     服务时间
    UILabel * ServicetimeLabel = [UILabel new];
    ServicetimeLabel.textAlignment = NSTextAlignmentLeft;
    ServicetimeLabel.textColor = ZP_textblack;
    ServicetimeLabel.font = ZP_titleFont;
    [self.contentView addSubview:ServicetimeLabel];
    [ServicetimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(100);
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self).offset(110);
    }];
    _ServicetimeLabel = ServicetimeLabel;
    
//     营业登记
    UILabel * BusinessregistrationLabel = [UILabel new];
    BusinessregistrationLabel.textAlignment = NSTextAlignmentLeft;
    BusinessregistrationLabel.textColor = ZP_TypefaceColor;
    BusinessregistrationLabel.font = [UIFont systemFontOfSize:14];
    BusinessregistrationLabel.text = NSLocalizedString(@"营业登记:", nil);
    [self.contentView addSubview:BusinessregistrationLabel];
    [BusinessregistrationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.bottom.equalTo(self).offset(-10);
    }];
    
//     营业登记号
    UILabel * BusinessregistrationIDLabel = [UILabel new];
    BusinessregistrationIDLabel.textAlignment = NSTextAlignmentLeft;
    BusinessregistrationIDLabel.textColor = ZP_textblack;
    BusinessregistrationIDLabel.font = ZP_titleFont;
    [self.contentView addSubview:BusinessregistrationIDLabel];
    [BusinessregistrationIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(100);
        make.bottom.equalTo(self).offset(-10);
    }];
    _BusinessregistrationIDLabel = BusinessregistrationIDLabel;
}

//  解析数据
- (void)ShoplntroducedCollection:(NSDictionary *)dic andDic:(NSDictionary *)dict{
    _ratingLabel.text = [NSString stringWithFormat:@"%@",dict[@"good_percent"]];
    _PhoneLabel.text = dic[@"phone"];
//    if ([NSString stringWithFormat:@"%@",dic[@"suppliername"]].length < 1) {
//        _StorenameLabel.hidden = YES;
//    }else {
//        _StorenameLabel.text = [NSString stringWithFormat:@"%@",dic[@"suppliername"]];
//    }
    _ServicetimeLabel.text = [NSString stringWithFormat:@"%@",dic[@"updatetime"]];
    _AddressLabel.text = [NSString stringWithFormat:@"%@",dic[@"countrycode"]];
    switch ([[[NSUserDefaults standardUserDefaults] objectForKey:@"countrycode"] integerValue]) {
        case 886:
            self.AddressLabel.text = @"臺灣";
            break;
            
        case 86:
            self.AddressLabel.text = @"中国";
            break;
            
        case 852:
            self.AddressLabel.text = @"香港";
            break;
        default:
            break;
    }
}

@end

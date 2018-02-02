//
//  MessageViewCell.m
//  DDAYGO
//
//  Created by Summer on 2017/10/31.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_MessageViewCell.h"
#import "PrefixHeader.pch"
#import "ZP_ExpressDeliveryCell.h"
#import "ZP_InformationCell.h"
#import "ZP_InformationModel.h"
@implementation ZP_MessageViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    static NSString * MessageID = @"messageViewCell";
    self = [super initWithStyle:style reuseIdentifier:MessageID];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    //  卖家留言
    UILabel * MessageLabel = [UILabel new];
    MessageLabel.textAlignment = NSTextAlignmentLeft;
    MessageLabel.textColor = ZP_textblack;
    MessageLabel.font = ZP_titleFont;
    MessageLabel.text = NSLocalizedString(@"買家留言:", nil);
    [self.contentView addSubview:MessageLabel];
    [MessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(self).offset(15);
    }];
    _MessageLabel = MessageLabel;
    
    //  文本输入框
    UITextField * MessagetextField = [UITextField new];
    MessagetextField.textAlignment = NSTextAlignmentLeft;
    MessagetextField.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    MessagetextField.textColor = ZP_TabBarTextColor;
    MessagetextField.font = ZP_titleFont;
    MessagetextField.placeholder = NSLocalizedString(@"對其事項說明...", nil);
    [self.contentView addSubview:MessagetextField];
    [MessagetextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(70);
        make.top.equalTo(self).offset(15);
        make.width.mas_offset(ZP_Width - 70 - 15);
    }];
    _MessagetextField = MessagetextField;
    
    //  下划线
    UIView * Underline2 = [UIView new];
    Underline2.layer.borderWidth = 1;
    Underline2.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [self.contentView addSubview:Underline2];
    [Underline2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-45);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(ZP_Width - 5);
    }];
    
    //  总计
    UILabel * TotalLabel = [UILabel new];
    TotalLabel.textAlignment = NSTextAlignmentLeft;
    TotalLabel.textColor = ZP_textblack;
    TotalLabel.font = ZP_titleFont;
//    TotalLabel.text = NSLocalizedString(@"共计36件商品", nil);
    [self.contentView addSubview:TotalLabel];
    [TotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(- 120);
        make.bottom.equalTo(self).offset(-15);
    }];
    _TotalLabel = TotalLabel;
    //  小计
    UILabel * SmallLabel = [UILabel new];
    SmallLabel.textAlignment = NSTextAlignmentLeft;
    SmallLabel.textColor = ZP_textblack;
    SmallLabel.font = ZP_titleFont;
    SmallLabel.text = NSLocalizedString(@"小計:", nil);
    [self.contentView addSubview:SmallLabel];
    [SmallLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TotalLabel).offset(80);
        make.bottom.equalTo(self).offset(-15);
    }];
    _SmallLabel = SmallLabel;
    
    
//      价格
    UILabel * ComputationsLabel = [UILabel new];
    ComputationsLabel.textAlignment = NSTextAlignmentLeft;
    ComputationsLabel.textColor = ZP_HomePreferentialpriceTypefaceCorlor;
    ComputationsLabel.font = ZP_titleFont;
    [self.contentView addSubview:ComputationsLabel];
    [ComputationsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(SmallLabel).offset(30);
        make.bottom.equalTo(self).offset(-15);
    }];
    _ComputationsLabel = ComputationsLabel;
    
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

- (void)MessageDic:(ZP_InformationModel *)model {

    _TotalLabel.text = [NSString stringWithFormat:@"共计%@件商品",_allCount];
    _ComputationsLabel.text = [NSString stringWithFormat:@"NT%@", _allMoney];
}
@end


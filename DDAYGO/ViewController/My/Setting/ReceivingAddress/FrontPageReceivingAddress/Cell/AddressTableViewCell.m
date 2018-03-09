//
//  AddressTableViewCell.m
//  DDAYGO
//
//  Created by Login on 2017/9/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "AddressTableViewCell.h"
#import "ZP_FrontPageReceivingAddressModel.h"
#import "ZP_MyTool.h"
#import "PrefixHeader.pch"
@implementation AddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//  编辑
- (IBAction)editAction:(id)sender {
    if (self.finishBlock) {
        self.finishBlock(nil);

    }
}

- (void)cellWithdic:(ZP_FrontPageReceivingAddressModel *)model {
    _NameLabel.text = model.eeceiptname;
    _PhoneLabel.text = model.eeceiptphone;
    _AddressLabel.text = model.addressdetail;
    _defBtn.selected = [model.isdefault boolValue];
}


@end


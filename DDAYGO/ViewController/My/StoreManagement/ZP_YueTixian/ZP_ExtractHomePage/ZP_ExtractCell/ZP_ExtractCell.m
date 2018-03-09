//
//  ZP_ExtractCell.m
//  DDAYGO
//
//  Created by Summer on 2017/12/5.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_ExtractCell.h"
#import "ZP_ExtractModel.h"
#import "PrefixHeader.pch"
@implementation ZP_ExtractCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //    [self initUI];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

// 数据
- (void)setModel:(ZP_ExtractModel *)model {
    _MmountLabel.text =  [model.takeamount stringValue]; // 金额
    _BanksLabel.text = model.bankname;  // 银行
    NSLog(@"----%@",[model.bankname stringByReplacingPercentEscapesUsingEncoding:kCFStringEncodingUTF8]);
    
    if ([model.bankcardname isEqualToString:@"(null)"]) { // 判断数据为nill
        self.NameLabel.hidden = YES;
    }else {
        _NameLabel.text = model.bankcardname; // 名字
    }
    _BankAccountLabel.text = [model.bankcardno stringValue]; // 账户
    _PhoneLabel.text = [model.phone stringValue];  // 电话
    _EmailLabel.text = model.email;  // 邮箱
    _ApplyTimeLabel.text = model.createtime;  // 申请时间
    //    _AuditTimeLabel.text = model.updatetime;  // 审核时间
    //    _ReviewStatusLabel.text = [model.state stringValue];  // 审核状态
    
    int a = [model.state intValue];
    NSLog(@"STate = %d",a);
    switch (a) {
        case 2:
            _ReviewStatusLabel.text =MyLocal(@"Not audit");
            _CancelBut.hidden = NO;
            break;
            
        case 3:
            _ReviewStatusLabel.text = MyLocal(@"Withdrawals complete");
            _ViewLayoutConstraint.constant = CGFLOAT_MIN;
            _CancelBut.hidden = YES;
            break;
            
        case 7:
            _ReviewStatusLabel.text = MyLocal(@"product");
            _ViewLayoutConstraint.constant = CGFLOAT_MIN;
            _CancelBut.hidden = YES;
            break;
            
        case 6:
            _ReviewStatusLabel.text = MyLocal(@"Cancel withdrawals");
            _ViewLayoutConstraint.constant = CGFLOAT_MIN;
            _CancelBut.hidden = YES;
            break;
            
        default:
            break;
    }
}
@end

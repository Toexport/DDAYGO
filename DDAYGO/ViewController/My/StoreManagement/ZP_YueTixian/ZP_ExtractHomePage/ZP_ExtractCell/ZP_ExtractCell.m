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
    [self initUI];
}

- (void)initUI {
    _DatesTimeLabel.layer.cornerRadius = 5;
    _DatesTimeLabel.clipsToBounds = YES;
}

- (IBAction)CancelBut:(UIButton *)sender {
    ZPLog(@"取消按钮");
    
}

// 数据
-(void)Extract:(ZP_ExtractModel *)model {
    
    _MmountLabel.text = [NSString stringWithFormat:@"NT%@",model.takeamount]; // 金额
    _BanksLabel.text = [NSString stringWithFormat:@"%@",model.bankname];  // 银行
    _NameLabel.text = [NSString stringWithFormat:@"%@",model.bankcardname]; // 名字
    _BankAccountLabel.text = [NSString stringWithFormat:@"%@",model.bankcardno]; // 账户
    _PhoneLabel.text = [NSString stringWithFormat:@"%@",model.phone];  // 电话
    _EmailLabel.text = [NSString stringWithFormat:@"%@",model.email];  // 邮箱
    _ApplyTimeLabel.text = [NSString stringWithFormat:@"%@",model.createtime];  // 申请时间
    _AuditTimeLabel.text = [NSString stringWithFormat:@"%@",model.updatetime];  // 审核时间
    _ReviewStatusLabel.text = [NSString stringWithFormat:@"%@",model.state];  // 审核状态
    
    
}


@end

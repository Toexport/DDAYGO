//
//  ZP_ExtractCell.h
//  DDAYGO
//
//  Created by Summer on 2017/12/5.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZP_ExtractModel.h"
@interface ZP_ExtractCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel * DatesTimeLabel; // 日期时间
@property (strong, nonatomic) IBOutlet UILabel * MmountLabel;  // 金额
@property (strong, nonatomic) IBOutlet UILabel * BanksLabel;  // 银行
@property (strong, nonatomic) IBOutlet UILabel * NameLabel;  // 名字
@property (strong, nonatomic) IBOutlet UILabel * BankAccountLabel; // 账号
@property (strong, nonatomic) IBOutlet UILabel * PhoneLabel;  // 电话
@property (strong, nonatomic) IBOutlet UILabel * EmailLabel;  // 邮箱
@property (strong, nonatomic) IBOutlet UILabel * ApplyTimeLabel; // 申请时间
@property (strong, nonatomic) IBOutlet UILabel * AuditTimeLabel;  // 审核时间
@property (strong, nonatomic) IBOutlet UILabel * ReviewStatusLabel;  // 审核状态
@property (strong, nonatomic) IBOutlet UILabel * TextIntroduceLabel;  // 文字介绍
@property (weak, nonatomic) IBOutlet UIButton * CancelBut; // 取消按鈕
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ViewLayoutConstraint;
@property (nonatomic, strong) ZP_ExtractModel * model;
//- (void)Extract:(ZP_ExtractModel *)model;

@end

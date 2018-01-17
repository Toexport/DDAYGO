//
//  ZP_ExtractModel.h
//  DDAYGO
//
//  Created by Summer on 2017/12/11.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZP_ExtractModel : NSObject
@property (nonatomic, strong) NSNumber * takeid; // 提现记录ID
@property (nonatomic, strong) NSNumber * supplierid; // 供货商ID
@property (nonatomic, strong) NSNumber * takeamount; // 提现金额
@property (nonatomic, strong) NSString * bankname; // 提现银行名称
@property (nonatomic, strong) NSNumber * bankcardno; // 提现银行卡号
@property (nonatomic, strong) NSString * bankcardname; // 银行卡账户姓名
@property (nonatomic, strong) NSNumber * phone; // 手机号码
@property (nonatomic, strong) NSString * email; // 电子邮箱
@property (nonatomic, strong) NSNumber * state; // 状态 2提交申请  3提现完成  7退件 6取消提现
@property (nonatomic, strong) NSString * remark; // 提现备注
@property (nonatomic, strong) NSString * createtime; // 申请时间
@property (nonatomic, strong) NSString * updatetime; // 更新时间

+ (NSMutableArray *)arrayWithArray:(NSArray *)array;

@end

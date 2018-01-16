//
//  ConfirmPayView.h
//  DDAYGO
//
//  Created by Login on 2017/10/20.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZP_ConfirmPayModel.h"
@interface ConfirmPayView : UIView

//  支付成功
typedef void (^ConfirmPayBlock)(id response);
//  支付失败
typedef void (^PayFailBlock)(id response);

typedef void (^ConfirmPayMoneyBlock)(id response);

@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic , copy) ConfirmPayBlock confirmPayBlock;

@property (nonatomic , copy) PayFailBlock PayFailBlock;

@property (nonatomic , copy) ConfirmPayMoneyBlock ConfirmPayMoneyBlock;

//  总计金额
@property (nonatomic, strong) UILabel * AmountLabel;

//  ICUE支付方式
@property (nonatomic, strong) UILabel * ICUELabel;
// ICUE 图片
@property (nonatomic, strong) UIImageView * ICUEimageview;
//  信用卡支付
@property (nonatomic, strong) UILabel * CreditcardLabel;
// 信用卡图片
@property (nonatomic, strong) UIImageView * Creditcardimageview;

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UILabel * CurrencySymbolLabel; // 货币符号

/**
 *  显示属性选择视图
 *
 *  @param view 要在哪个视图中显示
 */
- (void)showInView:(UIView *)view;

/**
 *  属性视图的消失
 */
- (void)removeView;

@end


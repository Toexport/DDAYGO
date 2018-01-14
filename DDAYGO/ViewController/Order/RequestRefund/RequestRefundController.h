//
//  RequestRefundController.h
//  DDAYGO
//
//  Created by Summer on 2018/1/10.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestRefundController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *ReuqestRefundScrollView; // 滚动视图
@property (nonatomic, strong) NSString * OrderStr;
/** 第1个View */
@property (weak, nonatomic) IBOutlet UIView * view1;
@property (weak, nonatomic) IBOutlet UIImageView * MainImageView; // 商品图片
@property (weak, nonatomic) IBOutlet UILabel * TitleLabel; // 商品文字
@property (weak, nonatomic) IBOutlet UILabel * DetailedLabel; // 商品详情
@property (weak, nonatomic) IBOutlet UILabel * NumberLabel; // 商品数量

/** 第2个View */
@property (weak, nonatomic) IBOutlet UIView * view2;
@property (weak, nonatomic) IBOutlet UITextView * MessageLabel; // 留言

/** 第3个View */
@property (weak, nonatomic) IBOutlet UIView * view3;
@property (weak, nonatomic) IBOutlet UILabel * CurrencyLabel; // 货币符号
@property (weak, nonatomic) IBOutlet UILabel * PriceLabel;  // 金额

/** 第4个View */
@property (weak, nonatomic) IBOutlet UIView * view4;

/** 第5个View */
@property (weak, nonatomic) IBOutlet UIView * view5;

@end

//
//  ExchangeDetailsController.h
//  DDAYGO
//
//  Created by Summer on 2018/1/10.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExchangeDetailsController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView * ExchangeDetailsScrollView; // 滚动视图
@property (nonatomic, strong) NSNumber * Oid;
@property (nonatomic, assign) NSInteger type; //
@property (nonatomic, strong) NSNumber * leeLabel;
@property (nonatomic, strong) NSString * STrtltle;
/** 第1个View */
@property (weak, nonatomic) IBOutlet UIView * view1;  // view1
@property (weak, nonatomic) IBOutlet UILabel * OrderNumberLabel; // 订单号

/** 第2个View */
@property (weak, nonatomic) IBOutlet UIView *view2; // view2
@property (weak, nonatomic) IBOutlet UIView * BackgroundView; // 背景view
@property (weak, nonatomic) IBOutlet UIImageView * Mainimageview;  // 商品图片
@property (weak, nonatomic) IBOutlet UILabel * TitleLabel;  // 商品名字
@property (weak, nonatomic) IBOutlet UILabel * DetailsLabel; // 商品详情
@property (weak, nonatomic) IBOutlet UILabel * NumberLabel; // 数量
@property (weak, nonatomic) IBOutlet UILabel * YanseLable; // 颜色
@property (weak, nonatomic) IBOutlet UILabel * ChimaLabel; // 尺码

/**********************************************************/
@property (weak, nonatomic) IBOutlet UILabel * RequestTypeLabel; // 申请类型
@property (weak, nonatomic) IBOutlet UILabel * CurrencyLabel;  // 货币符号
@property (weak, nonatomic) IBOutlet UILabel * PriceLabel;  // 价格
@property (weak, nonatomic) IBOutlet UILabel * RequestTimeLabel;  // 申请时间
@property (weak, nonatomic) IBOutlet UILabel * RequestYuanyin;  // 原因
@property (weak, nonatomic) IBOutlet UILabel * NowStateLabel;  // 当前状态
@property (weak, nonatomic) IBOutlet UILabel * LogisticsLabel;  // 物流信息

/** 第3个View */
@property (weak, nonatomic) IBOutlet UIView *view3;


/**第4个View */
@property (weak, nonatomic) IBOutlet UIView *view4;

@property (weak, nonatomic) IBOutlet UILabel *View4titleLabel;
@property (weak, nonatomic) IBOutlet UIButton * CancelBut; // 取消按钮
@property (weak, nonatomic) IBOutlet UIButton * RequestServiceBut; // 请求客服

/**第5个View */
@property (weak, nonatomic) IBOutlet UIView *View5;
@property (weak, nonatomic) IBOutlet UIImageView *imageview1;



@end

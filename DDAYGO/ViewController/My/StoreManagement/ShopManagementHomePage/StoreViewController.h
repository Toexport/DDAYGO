//
//  StoreViewController.h
//  DDAYGO
//
//  Created by Login on 2017/9/26.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PromptBoxView.h"
@interface StoreViewController : PromptBoxView
@property (strong, nonatomic) IBOutlet UIScrollView * merchantscrollView;
@property (strong, nonatomic) IBOutlet UIButton * MerchantBut; // 头像
@property (strong, nonatomic) IBOutlet UILabel * TitleLabel; // 店铺名字
@property (strong, nonatomic) IBOutlet UILabel * ContractTimeLabel; // 合同时间
@property (strong, nonatomic) IBOutlet UILabel * MerchandiseNumberLabel;  // 商品数量
@property (strong, nonatomic) IBOutlet UILabel * MerchandiseStateLabel;  // 商品状态
/******************************/

@property (strong, nonatomic) IBOutlet UILabel * TotalAmountLabel;  // 总额度
@property (strong, nonatomic) IBOutlet UILabel * ActivitiesAssetsLabel;  // 活动资产
@property (strong, nonatomic) IBOutlet UILabel * FrozenAssets;  // 冻结资产






@end

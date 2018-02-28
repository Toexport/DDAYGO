//
//  BuyTopView.h
//  DDAYGO
//
//  Created by Login on 2017/9/14.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "ZP_GoodDetailsModel.h"
@interface BuyTopView : UIView
@property (weak, nonatomic) IBOutlet UILabel *CurrencyLabel;

+ (instancetype)view;
- (void)updateInfoWithModel:(ZP_GoodDetailsModel *)model;
@end

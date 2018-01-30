//
//  BuyTopView.h
//  testLogin
//
//  Created by huangzhibiao on 15/12/21.
//  Copyright © 2015年 haiwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "ZP_GoodDetailsModel.h"
@interface BuyTopView : UIView

+ (instancetype)view;
- (void)updateInfoWithModel:(ZP_GoodDetailsModel *)model;
@end

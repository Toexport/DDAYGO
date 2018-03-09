//
//  ZP_LotteryHistoricalBettingNumberController.h
//  DDAYGO
//
//  Created by Summer on 2017/12/18.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PromptBoxView.h"
@interface ZP_LotteryHistoricalBettingNumberController : PromptBoxView
@property (nonatomic, strong) UILabel * TitleLabel1;
@property (nonatomic, strong) UILabel * TitleLabel2;
@property (nonatomic, strong) UILabel * TitleLabel3;

@property (nonatomic, strong) UILabel * OrderLabel;
@property (nonatomic, strong) UILabel * OrderNumberLabel;
@property (strong ,nonatomic) NSNumber * pollid;
@end

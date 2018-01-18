//
//  ZP_LotteryHistoricalBettingNumberCell.h
//  DDAYGO
//
//  Created by Summer on 2017/12/18.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZP_LotteryHistoricalBettingNumberModel.h"

@interface ZP_LotteryHistoricalBettingNumberCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
@property (weak, nonatomic) IBOutlet UIButton * button1;
@property (weak, nonatomic) IBOutlet UIButton * button2;
@property (weak, nonatomic) IBOutlet UIButton * button3;
@property (weak, nonatomic) IBOutlet UIButton * button4;
@property (weak, nonatomic) IBOutlet UIButton * button5;
@property (weak, nonatomic) IBOutlet UIButton * button6;
@property (weak, nonatomic) IBOutlet UILabel * NumLabel; // 


@property (strong, nonatomic) ZP_LotteryHistoricalBettingNumberModel3 *model3;



- (void)fillIntoData:(ZP_LotteryHistoricalBettingNumberModel3 *)model3;

@end

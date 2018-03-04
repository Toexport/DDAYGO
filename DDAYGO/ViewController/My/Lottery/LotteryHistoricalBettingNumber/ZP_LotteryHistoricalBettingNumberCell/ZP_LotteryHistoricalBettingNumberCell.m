//
//  ZP_LotteryHistoricalBettingNumberCell.m
//  DDAYGO
//
//  Created by Summer on 2017/12/18.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_LotteryHistoricalBettingNumberCell.h"

@implementation ZP_LotteryHistoricalBettingNumberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)fillIntoData:(ZP_LotteryHistoricalBettingNumberModel3 *)model3 {
    NSLog(@"%@",model3.white5);
    self.orderNumber.text = model3.lotteryoid;
    [self.button1 setTitle:[NSString stringWithFormat:@"%02d",model3.white1.intValue] forState:UIControlStateNormal];
    [self.button2 setTitle:[NSString stringWithFormat:@"%02d",model3.white2.intValue] forState:UIControlStateNormal];
    [self.button3 setTitle:[NSString stringWithFormat:@"%02d",model3.white3.intValue] forState:UIControlStateNormal];
    [self.button4 setTitle:[NSString stringWithFormat:@"%02d",model3.white4.intValue] forState:UIControlStateNormal];
    [self.button5 setTitle:[NSString stringWithFormat:@"%02d",model3.white5.intValue] forState:UIControlStateNormal];
    [self.button6 setTitle:[NSString stringWithFormat:@"%02d",model3.powerball.intValue] forState:UIControlStateNormal];
}


@end

//
//  ZP_DetailsSistoryAwardTableViewCell.m
//  DDAYGO
//
//  Created by Summer on 2017/12/1.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_DetailsSistoryAwardTableViewCell.h"
@implementation ZP_DetailsSistoryAwardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)HistoryBet:(lotteryorderModel *)model {
    //    ZP_HistoryModel * model = [ZP_HistoryModel mj_objectWithKeyValues:model.pollid];
    [_butt1 setTitle:[NSString stringWithFormat:@"%02d",model.white1.intValue] forState:UIControlStateNormal];
    [_butt2 setTitle:[NSString stringWithFormat:@"%02d",model.white2.intValue] forState:UIControlStateNormal];
    [_butt3 setTitle:[NSString stringWithFormat:@"%02d",model.white3.intValue] forState:UIControlStateNormal];
    [_butt4 setTitle:[NSString stringWithFormat:@"%02d",model.white4.intValue] forState:UIControlStateNormal];
    [_butt5 setTitle:[NSString stringWithFormat:@"%02d",model.white5.intValue] forState:UIControlStateNormal];
    [_butt6 setTitle:[NSString stringWithFormat:@"%02d",model.powerball.intValue] forState:UIControlStateNormal];
}

@end

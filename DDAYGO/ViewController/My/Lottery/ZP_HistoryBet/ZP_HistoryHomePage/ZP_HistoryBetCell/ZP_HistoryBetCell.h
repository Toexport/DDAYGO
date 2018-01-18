//
//  ZP_HistoryBetCell.h
//  DDAYGO
//
//  Created by Summer on 2017/11/30.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZP_HistoryModel.h"
@interface ZP_HistoryBetCell : UITableViewCell
@property (nonatomic, strong) NSNumber * pollid;
@property (weak, nonatomic) IBOutlet UILabel * DateLabel;
@property (weak, nonatomic) IBOutlet UILabel *YYY;
@property (weak, nonatomic) IBOutlet UILabel *MM;
@property (weak, nonatomic) IBOutlet UILabel *Day;
@property (weak, nonatomic) IBOutlet UILabel * DateCodeLabel;
@property (weak, nonatomic) IBOutlet UIButton * button1;
@property (weak, nonatomic) IBOutlet UIButton * button2;
@property (weak, nonatomic) IBOutlet UIButton * button3;
@property (weak, nonatomic) IBOutlet UIButton * button4;
@property (weak, nonatomic) IBOutlet UIButton * button5;
@property (weak, nonatomic) IBOutlet UIButton * button6;

- (void)HistoryBet:(ZP_HistoryModel *)model;
@end

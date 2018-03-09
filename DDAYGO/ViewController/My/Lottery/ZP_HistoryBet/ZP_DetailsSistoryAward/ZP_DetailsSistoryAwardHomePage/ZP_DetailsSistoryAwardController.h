//
//  ZP_DetailsSistoryAwardController.h
//  DDAYGO
//
//  Created by Summer on 2017/12/1.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PromptBoxView.h"
@interface ZP_DetailsSistoryAwardController : PromptBoxView
@property (weak, nonatomic) IBOutlet UIScrollView *BackgroundScrollView; // 背景
@property (weak, nonatomic) IBOutlet UIView * TitleView; // 标题view
@property (weak, nonatomic) IBOutlet UILabel * AmountLabel;

@property (weak, nonatomic) IBOutlet UILabel * WinningNumbersLabel;
@property (weak, nonatomic) IBOutlet UILabel * NperLabel;
@property (weak, nonatomic) IBOutlet UILabel * DatesLabel;
// 中奖号码的View
@property (weak, nonatomic) IBOutlet UIView * butView;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;


//奖项
@property (weak, nonatomic) IBOutlet UILabel * prizeLabel;
@property (weak, nonatomic) IBOutlet UILabel * prizeLabel1;
@property (weak, nonatomic) IBOutlet UILabel * prizeLabel2;
@property (weak, nonatomic) IBOutlet UILabel * prizeLabel3;
@property (weak, nonatomic) IBOutlet UILabel * prizeLabel4;
@property (weak, nonatomic) IBOutlet UILabel * prizeLabel5;

//对中奖号数
@property (weak, nonatomic) IBOutlet UILabel * winningNumbLabel;
@property (weak, nonatomic) IBOutlet UILabel * winningNumbLabel1;
@property (weak, nonatomic) IBOutlet UILabel * winningNumbLabel2;
@property (weak, nonatomic) IBOutlet UILabel * winningNumbLabel3;
@property (weak, nonatomic) IBOutlet UILabel * winningNumbLabel4;
@property (weak, nonatomic) IBOutlet UILabel * winningNumbLabel5;

//奖项金额
@property (weak, nonatomic) IBOutlet UILabel * currentPeriodLabel;
@property (weak, nonatomic) IBOutlet UILabel * currentPeriodLabel1;
@property (weak, nonatomic) IBOutlet UILabel * currentPeriodLabel2;
@property (weak, nonatomic) IBOutlet UILabel * currentPeriodLabel3;
@property (weak, nonatomic) IBOutlet UILabel * currentPeriodLabel4;
@property (weak, nonatomic) IBOutlet UILabel * currentPeriodLabel5;

//中奖数
@property (weak, nonatomic) IBOutlet UILabel * winnersNumLabel;
@property (weak, nonatomic) IBOutlet UILabel * winnersNumLabel1;
@property (weak, nonatomic) IBOutlet UILabel * winnersNumLabel2;
@property (weak, nonatomic) IBOutlet UILabel * winnersNumLabel3;
@property (weak, nonatomic) IBOutlet UILabel * winnersNumLabel4;
@property (weak, nonatomic) IBOutlet UILabel * winnersNumLabel5;

//赏金金额
@property (weak, nonatomic) IBOutlet UILabel * bountyLabel;
@property (weak, nonatomic) IBOutlet UILabel * bountyLabel1;
@property (weak, nonatomic) IBOutlet UILabel * bountyLabel2;
@property (weak, nonatomic) IBOutlet UILabel * bountyLabel3;
@property (weak, nonatomic) IBOutlet UILabel * bountyLabel4;
@property (weak, nonatomic) IBOutlet UILabel * bountyLabel5;
// 金额view
@property (weak, nonatomic) IBOutlet UIView *bounctyView;
// 本期下注号码
@property (weak, nonatomic) IBOutlet UILabel *OrderNumberLabel;

@property (weak, nonatomic) IBOutlet UITableView * tableview;
@property (strong ,nonatomic) NSNumber * pollid;

@property (weak, nonatomic) IBOutlet UILabel * promptLabel;

@end

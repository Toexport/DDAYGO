//
//  LotteryController.h
//  DDAYGO
//
//  Created by Summer on 2017/11/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LotteryController : UIViewController
//@property (nonatomic, strong) UIButton * Pickbuttom;  //领取按钮
//@property (nonatomic, strong) UILabel * NumberingLabel; // 编号
//@property (nonatomic, strong) UILabel * TitleLabel; // 标题

//@property (nonatomic, assign) NSInteger wirteBetCount;
//@property (nonatomic, assign) NSInteger redBetCount;

//@property (weak, nonatomic) IBOutlet UIScrollView * ScrollView;    //滚动图
@property (weak, nonatomic) IBOutlet UIView * outVIew;
//@property (weak, nonatomic) IBOutlet UILabel * MosaicGoldLabel;
@property (weak, nonatomic) IBOutlet UILabel * ymbolLabel;
@property (weak, nonatomic) IBOutlet UILabel * AmountLabel;
@property (weak, nonatomic) IBOutlet UILabel * YuanLabel;
@property (weak, nonatomic) IBOutlet UIView * AssemblageView;
@property (weak, nonatomic) IBOutlet UILabel * WinningNumbersLabel;
@property (weak, nonatomic) IBOutlet UILabel * periodsLabel;
@property (weak, nonatomic) IBOutlet UILabel * dateLabel;
//年月日
@property (weak, nonatomic) IBOutlet UILabel *NianLabel;
@property (weak, nonatomic) IBOutlet UILabel *YueLabel;
@property (weak, nonatomic) IBOutlet UILabel *RiLabel;



@property (weak, nonatomic) IBOutlet UIView * WinningNumbersView; // 中奖号码及按钮
@property (weak, nonatomic) IBOutlet UIButton * but1;
@property (weak, nonatomic) IBOutlet UIButton * but2;
@property (weak, nonatomic) IBOutlet UIButton * but3;
@property (weak, nonatomic) IBOutlet UIButton * but4;
@property (weak, nonatomic) IBOutlet UIButton * but5;
@property (weak, nonatomic) IBOutlet UIButton * but6;

// 奖项
@property (weak, nonatomic) IBOutlet UILabel * prizeLabel;
@property (weak, nonatomic) IBOutlet UILabel * prizeLabel1;
@property (weak, nonatomic) IBOutlet UILabel * prizeLabel2;
@property (weak, nonatomic) IBOutlet UILabel * prizeLabel3;
@property (weak, nonatomic) IBOutlet UILabel * prizeLabel4;
@property (weak, nonatomic) IBOutlet UILabel * prizeLabel5;

// 对中奖号数
@property (weak, nonatomic) IBOutlet UILabel * winningNumbLabel;
@property (weak, nonatomic) IBOutlet UILabel * winningNumbLabel1;
@property (weak, nonatomic) IBOutlet UILabel * winningNumbLabel2;
@property (weak, nonatomic) IBOutlet UILabel * winningNumbLabel3;
@property (weak, nonatomic) IBOutlet UILabel * winningNumbLabel4;
@property (weak, nonatomic) IBOutlet UILabel *winningNumbLabel5;

// 奖项金额
@property (weak, nonatomic) IBOutlet UILabel * currentPeriodLabel;
@property (weak, nonatomic) IBOutlet UILabel * currentPeriodLabel1;
@property (weak, nonatomic) IBOutlet UILabel * currentPeriodLabel2;
@property (weak, nonatomic) IBOutlet UILabel * currentPeriodLabel3;
@property (weak, nonatomic) IBOutlet UILabel * currentPeriodLabel4;
@property (weak, nonatomic) IBOutlet UILabel * currentPeriodLabel5;

// 中奖数
@property (weak, nonatomic) IBOutlet UILabel * winnersNumLabel;
@property (weak, nonatomic) IBOutlet UILabel * winnersNumLabel1;
@property (weak, nonatomic) IBOutlet UILabel * winnersNumLabel2;
@property (weak, nonatomic) IBOutlet UILabel * winnersNumLabel3;
@property (weak, nonatomic) IBOutlet UILabel * winnersNumLabel4;
@property (weak, nonatomic) IBOutlet UILabel * winnersNumLabel5;

// 赏金金额
@property (weak, nonatomic) IBOutlet UILabel * bountyLabel;
@property (weak, nonatomic) IBOutlet UILabel * bountyLabel1;
@property (weak, nonatomic) IBOutlet UILabel * bountyLabel2;
@property (weak, nonatomic) IBOutlet UILabel * bountyLabel3;
@property (weak, nonatomic) IBOutlet UILabel * bountyLabel4;
@property (weak, nonatomic) IBOutlet UILabel * bountyLabel5;

//
@property (weak, nonatomic) IBOutlet UIView *bounctyView;
// 订单号码
@property (weak, nonatomic) IBOutlet UILabel * OrderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel * XiazhushuliangLabel;

@property (weak, nonatomic) IBOutlet UIView *BenQIView;
@property (weak, nonatomic) IBOutlet UIButton *checkMoreBtn;
@property (weak, nonatomic) IBOutlet UIButton *lingjiangBtn;

@property (weak, nonatomic) IBOutlet UILabel * dingdanhaoLabel;
@property (weak, nonatomic) IBOutlet UILabel * SymbolLabel;
@property (weak, nonatomic) IBOutlet UIButton *butt1;
@property (weak, nonatomic) IBOutlet UIButton *butt2;
@property (weak, nonatomic) IBOutlet UIButton *butt3;
@property (weak, nonatomic) IBOutlet UIButton *butt4;
@property (weak, nonatomic) IBOutlet UIButton *butt5;
@property (weak, nonatomic) IBOutlet UIButton *butt6;
@property (weak, nonatomic) IBOutlet UILabel * tishiLabel;



@end

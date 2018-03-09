//
//  ZP_InstructionController.h
//  DDAYGO
//
//  Created by Summer on 2017/11/30.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PromptBoxView.h"
@interface ZP_InstructionController : PromptBoxView
@property (strong, nonatomic) IBOutlet UIScrollView *ZP_InstrucScrollView;
//@property (strong, nonatomic) IBOutlet UITableView * tableview;


// 奖项
@property (weak, nonatomic) IBOutlet UILabel *prizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *prizeLabel1;
@property (weak, nonatomic) IBOutlet UILabel *prizeLabel2;
@property (weak, nonatomic) IBOutlet UILabel *prizeLabel3;
@property (weak, nonatomic) IBOutlet UILabel *prizeLabel4;
@property (weak, nonatomic) IBOutlet UILabel *prizeLabel5;

//  对奖号数
@property (weak, nonatomic) IBOutlet UILabel *winningNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *winningNumLabel1;
@property (weak, nonatomic) IBOutlet UILabel *winningNumLabel2;
@property (weak, nonatomic) IBOutlet UILabel *winningNumLabel3;
@property (weak, nonatomic) IBOutlet UILabel *winningNumLabel4;
@property (weak, nonatomic) IBOutlet UILabel *winningNumLabel5;

//  中奖人
@property (weak, nonatomic) IBOutlet UILabel *winnerLabel;
@property (weak, nonatomic) IBOutlet UILabel *winnerLabel1;
@property (weak, nonatomic) IBOutlet UILabel *winnerLabel2;
@property (weak, nonatomic) IBOutlet UILabel *winnerLabel3;
@property (weak, nonatomic) IBOutlet UILabel *winnerLabel4;
@property (weak, nonatomic) IBOutlet UILabel *winnerLabel5;

//介绍人&红利
@property (weak, nonatomic) IBOutlet UILabel *referAndBonusLabel;
@property (weak, nonatomic) IBOutlet UILabel *referAndBonusLabel1;
@property (weak, nonatomic) IBOutlet UILabel *referAndBonusLabel2;
@property (weak, nonatomic) IBOutlet UILabel *referAndBonusLabel3;
@property (weak, nonatomic) IBOutlet UILabel *referAndBonusLabel4;
@property (weak, nonatomic) IBOutlet UILabel *referAndBonusLabel5;


// 文字介绍
@property (weak, nonatomic) IBOutlet UILabel *TextIntroduceLabel5;
@property (weak, nonatomic) IBOutlet UILabel *TextIntroduceLabel1;
@property (weak, nonatomic) IBOutlet UILabel *TextIntroduceLabel2;
@property (weak, nonatomic) IBOutlet UILabel *TextIntroduceLabel3;
@property (weak, nonatomic) IBOutlet UILabel *TextIntroduceLabel4;
@property (weak, nonatomic) IBOutlet UILabel *TextIntroduceLabel6;
@property (weak, nonatomic) IBOutlet UILabel *TextIntroduceLabel7;





@end

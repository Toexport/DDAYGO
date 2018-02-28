//
//  ZP_InstructionController.m
//  DDAYGO
//
//  Created by Summer on 2017/11/30.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_InstructionController.h"
#import "ZP_MyTool.h"
#import "PrefixHeader.pch"
#import "ZP_InstructionBetModel.h"
#import "NSString+Additions.h"
@interface ZP_InstructionController ()
@property (nonatomic, strong) NSMutableDictionary * prizeDic;
@end

@implementation ZP_InstructionController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self AllData];
    [self international];
}

- (void)initUI {
   self.title = NSLocalizedString(@"Roll up", nil);
}
// 國際化
- (void) international {
    self.winningNumLabel1.text = MyLocal(@"5 white +1 red ball");
    self.winningNumLabel2.text = MyLocal(@"Five white balls");
    self.winningNumLabel3.text = MyLocal(@"Four white balls");
    self.winningNumLabel4.text = MyLocal(@"Three white balls");
    self.winningNumLabel5.text = MyLocal(@"1 white +1 red ball");
    self.TextIntroduceLabel5.text = MyLocal(@"TextIntroduceLabel5");
    self.TextIntroduceLabel2.text = MyLocal(@"TextIntroduceLabel2");
    self.TextIntroduceLabel3.text = MyLocal(@"TextIntroduceLabel3");
    self.TextIntroduceLabel6.text = MyLocal(@"TextIntroduceLabel6");
    self.TextIntroduceLabel7.text = MyLocal(@"TextIntroduceLabel7");
    
    
}

- (void)AllData {
//    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    dic[@"token"] = Token;
    [ZP_MyTool requestLotterynow:Token uccess:^(id obj) {
        ZPLog(@"%@",obj);
//        NSMutableDictionary * dic = obj[@"lotterywin"];
        ZP_InstructionBetModel * model = [ZP_InstructionBetModel mj_objectWithKeyValues:obj];
        self.prizeDic = obj;
        [self initWithINstruction:model];
    } failure:^(NSError *error) {
        ZPLog(@"%@",error);
    }];
}

- (void)initWithINstruction:(ZP_InstructionBetModel *)model {
    
    NSArray * arr =  [InstructionBetModel mj_objectArrayWithKeyValuesArray:model.lotterywin];
    InstructionBetModel * model1 = arr[0];
    _referAndBonusLabel1.text = [model1.winamount stringValue].creatPirceString;
    
    InstructionBetMode2 * model2 = arr[1];
    _referAndBonusLabel2.text = [model2.winamount stringValue].creatPirceString;
    
    InstructionBetMode3 * model3 = arr[2];
    _referAndBonusLabel3.text = [model3.winamount stringValue].creatPirceString;
    
    InstructionBetMode4 * model4 = arr[3];
    _referAndBonusLabel4.text = [model4.winamount stringValue].creatPirceString;
    
    InstructionBetMode5 * model5 = arr[4];
    _referAndBonusLabel5.text = [model5.winamount stringValue].creatPirceString;
    
}

@end

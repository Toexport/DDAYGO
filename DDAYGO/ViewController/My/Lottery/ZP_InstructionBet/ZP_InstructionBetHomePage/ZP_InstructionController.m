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
@interface ZP_InstructionController ()
@property (nonatomic, strong) NSMutableDictionary * prizeDic;
@end

@implementation ZP_InstructionController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self AllData];
}

- (void)initUI {
   self.title = NSLocalizedString(@"玩轉促銷彩", nil);

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
    _referAndBonusLabel1.text = [model1.winamount stringValue];
    
    InstructionBetMode2 * model2 = arr[1];
    _referAndBonusLabel2.text = [model2.winamount stringValue];
    
    InstructionBetMode3 * model3 = arr[2];
    _referAndBonusLabel3.text = [model3.winamount stringValue];
    
    InstructionBetMode4 * model4 = arr[3];
    _referAndBonusLabel4.text = [model4.winamount stringValue];
    
    InstructionBetMode5 * model5 = arr[4];
    _referAndBonusLabel5.text = [model5.winamount stringValue];
    
}

@end

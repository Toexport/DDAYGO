//
//  tableHeadView1.m
//  DDAYGO
//
//  Created by Summer on 2017/11/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "tableHeadView1.h"
#import "ZP_BetHeaderModel.h"
@implementation tableHeadView1

- (void)tableHeadView1:(ZP_BetHeaderModel *)model {
    self.YearsLabel.text = [model.yyyy stringValue];
    self.MonthLabel.text = [model.mm stringValue];
    self.DyaLabel.text = [model.periods stringValue];
    if (model.lotterytime == nil) {
        return;
    }else {
        self.ItmeLanel.text = [NSString stringWithFormat:@"%@",model.lotterytime];
    }
    self.NumberLabel.text = [model.lotterycounts stringValue];
    self.AmountLabel.text = [model.poolamount stringValue];
}

@end

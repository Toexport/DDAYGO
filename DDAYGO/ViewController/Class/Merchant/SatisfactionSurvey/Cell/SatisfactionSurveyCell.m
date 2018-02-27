//
//  SatisfactionSurveyCell.m
//  DDAYGO
//
//  Created by Summer on 2018/1/19.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "SatisfactionSurveyCell.h"
#import "PrefixHeader.pch"
@implementation SatisfactionSurveyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.commodityArray = @[self.Button1,self.Button2,self.Button3,self.Button4,self.Button5];
    
}

- (void)SatisfactionSurvey:(SatisfactionSurveyModel *)model {
    self.NameLabel.text = model.realname;
    self.PinglunneirongLabel.text = model.reviewscontent;
    self.TimeLabel.text = model.createtime;
    self.FenshuLabel.text = [NSString stringWithFormat:MyLocal(@"%@points"),model.fraction];
    [self updateStartsWithtype:0 StartCount:[model.fraction integerValue]];

}

- (void)updateStartsWithtype:(NSInteger)startType StartCount:(NSInteger)startCount {
    if (startType == 0) {
        for (int i = 0; i < self.commodityArray.count; i ++) {
            UIButton *button = self.commodityArray[i];
            if (i < startCount) {
                button.hidden = NO;
            } else {
                [button setBackgroundImage:[UIImage imageNamed:@"ic_evaluate_star_normal"] forState:UIControlStateNormal];
            }
        }
    }
    }

@end

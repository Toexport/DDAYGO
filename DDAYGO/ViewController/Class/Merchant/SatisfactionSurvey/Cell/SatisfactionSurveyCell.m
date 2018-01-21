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
    
}

- (void)SatisfactionSurvey:(SatisfactionSurveyModel *)model {
    self.NameLabel.text = model.realname;
    self.PinglunneirongLabel.text = model.createtime;
}

@end

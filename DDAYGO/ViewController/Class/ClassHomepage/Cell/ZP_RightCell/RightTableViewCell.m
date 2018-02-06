//
//  RightTableViewCell.m
//  DDAYGO
//
//   Created by Login on 2017/9/7.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "RightTableViewCell.h"
#import "ZP_RightModel.h"
@implementation RightTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)updateData:(ZP_RightModel *)model {
    _contentLabel.text = model.contentLabel;
}

@end

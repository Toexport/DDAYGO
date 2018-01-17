//
//  ZP_LotterySubCell.m
//  DDAYGO
//
//  Created by Summer on 2017/12/31.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_LotterySubCell.h"
#import "ZP_LotteryHistoricalBettingNumberModel.h"
#import "ButtonsView.h"
#import "PrefixHeader.pch"
@implementation ZP_LotterySubCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:@"lotterysubcell"];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZP_Width, 35)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    _backView = backView;
}

- (void)viewWithArray:(NSMutableArray *)array{
    _backView.frame = CGRectMake(0, 0, self.frame.size.width, array.count*35);
    _backView.backgroundColor = [UIColor orangeColor];
    for (NSInteger i = 0; i<array.count; i++) {
        ZP_LotteryHistoricalBettingNumberModel3 * model = array[i];
        ButtonsView * view = [[ButtonsView alloc]initWithFrame:CGRectMake(0, i*35, ZP_Width, 35)];
        [view viewWithModel:model];
        
        [_backView addSubview:view];
    }
    
}

- (void)layoutSubviews {
    _backView.frame = CGRectMake(0, 0, self.frame.size.width, 35);
    [super layoutSubviews];
}
@end

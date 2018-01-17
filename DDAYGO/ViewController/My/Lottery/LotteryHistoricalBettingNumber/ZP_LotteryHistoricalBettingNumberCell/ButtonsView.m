//
//  ButtonsView.m
//  DDAYGO
//
//  Created by Summer on 2017/12/31.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ButtonsView.h"

@implementation ButtonsView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(8, 2.5, 30, 30);
    [button1 setBackgroundImage:[UIImage imageNamed:@"bg_white_ball_receive"] forState:UIControlStateNormal];
    [button1 setTitle:@"1" forState:UIControlStateNormal];
    [self addSubview:button1];
    _button1 = button1;
    
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(46, 2.5, 30, 30);
    [button2 setBackgroundImage:[UIImage imageNamed:@"bg_white_ball_receive"] forState:UIControlStateNormal];
    [button2 setTitle:@"1" forState:UIControlStateNormal];
    [self addSubview:button2];
    _button2 = button2;
    
    UIButton * button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(84, 2.5, 30, 30);
    [button3 setBackgroundImage:[UIImage imageNamed:@"bg_white_ball_receive"] forState:UIControlStateNormal];
    [button3 setTitle:@"1" forState:UIControlStateNormal];
    [self addSubview:button3];
    _button3 = button3;
    
    UIButton * button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    button4.frame = CGRectMake(122, 2.5, 30, 30);
    [button4 setBackgroundImage:[UIImage imageNamed:@"bg_white_ball_receive"] forState:UIControlStateNormal];
    [button4 setTitle:@"1" forState:UIControlStateNormal];
    [self addSubview:button4];
    _button4 = button4;
    
    UIButton * button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    button5.frame = CGRectMake(160, 2.5, 30, 30);
    [button5 setBackgroundImage:[UIImage imageNamed:@"bg_white_ball_receive"] forState:UIControlStateNormal];
    [button5 setTitle:@"1" forState:UIControlStateNormal];
    [self addSubview:button5];
    _button5 = button5;
    
    UIButton * button6 = [UIButton buttonWithType:UIButtonTypeCustom];
    button6.frame = CGRectMake(198, 2.5, 30, 30);
    [button6 setBackgroundImage:[UIImage imageNamed:@"bg_red_ball_receive"] forState:UIControlStateNormal];
    [button6 setTitle:@"1" forState:UIControlStateNormal];
    [button6 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button6 setTitle:[UIFont systemFontOfSize:15] forState:UIControlStateNormal];
    [self addSubview:button6];
    _button6 = button6;
}

- (void)viewWithModel:(ZP_LotteryHistoricalBettingNumberModel3 *)model {
    
    [_button1 setTitle:[model.white1 stringValue] forState:UIControlStateNormal];
    [_button2 setTitle:[model.white2 stringValue] forState:UIControlStateNormal];
    [_button3 setTitle:[model.white3 stringValue] forState:UIControlStateNormal];
    [_button4 setTitle:[model.white4 stringValue] forState:UIControlStateNormal];
    [_button5 setTitle:[model.white5 stringValue] forState:UIControlStateNormal];
    [_button6 setTitle:[model.powerball stringValue] forState:UIControlStateNormal];
}

@end

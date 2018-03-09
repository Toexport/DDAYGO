//
//  BetTableViewMyCell2.m
//  DDAYGO
//
//  Created by Summer on 2017/11/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "BetTableViewMyCell2.h"
#import "PrefixHeader.pch"
@implementation BetTableViewMyCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _butArray= [NSMutableArray array];
}

- (void)upDataButtonWith:(NSInteger )count {
    
    [self removeAllSubviews];
    NSInteger num = 0;
    for (int i = 0; i < 8; i ++) {
        for (int j = 0; j < 8; j ++){
            if (num > count) {
                return;
            }
            UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
            but.frame = CGRectMake(j * ZP_Width / 8 + (ZP_Width / 8 - 30) / 2, i * ZP_Width / 8 + (ZP_Width / 8 - 30) / 2, 30, 30);
            but.titleLabel.font = ZP_TrademarkFont;
            //            [but setTitle:[NSString stringWithFormat:@"%02ld",num + 1] forState:UIControlStateNormal];
            [but setTitle:[NSString stringWithFormat:@"%02ld",num +1] forState:UIControlStateNormal];
            [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [but setBackgroundImage:[UIImage imageNamed:@"bg_choose_whiteball_normal"] forState:UIControlStateNormal];
            
            [but setBackgroundImage:[UIImage imageNamed:@"bg_red_ball_receive"] forState:UIControlStateSelected];
            but.tag = num + 100;
            
            [self.butArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (but.tag == [obj integerValue]) {
                    but.selected = YES;
                }
            }];
            [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
            num ++;
            [self.contentView addSubview:but];
        }
    }
}

- (void)butClick:(UIButton *)btn {
    if (btn.selected) {
        btn.selected = !btn.selected;
        [self.butArray removeAllObjects];
        [self upDataButtonWith:25];
        
    } else {
        if (self.butArray.count == 1) {
            return;
        }
        btn.selected = !btn.selected;
        [_butArray addObject:[NSNumber numberWithInteger:btn.tag]];
    }
    if (self.arrayBlock) {
        self.arrayBlock(_butArray);
    }
    
}

//- (void)setButArray:(NSMutableArray *)butArray
//{
////    self.butArray = butArray;
////    [self upDataButtonWith:26];
//}

- (void)removeAllSubviews {
    
    while (self.contentView.subviews.count) {
        [self.contentView.subviews.lastObject removeFromSuperview];
    }
}

@end

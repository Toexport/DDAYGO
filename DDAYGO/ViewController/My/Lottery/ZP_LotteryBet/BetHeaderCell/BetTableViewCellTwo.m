//
//  BetTableViewCellTwo.m
//  DDAYGO
//
//  Created by Summer on 2017/11/28.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "BetTableViewCellTwo.h"
#import "PrefixHeader.pch"
@implementation BetTableViewCellTwo

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    _deleBut.layer.borderWidth = 0.5f;
//    _deleBut.layer.borderColor = [[UIColor redColor]CGColor];
}

- (void)updateCount:(NSArray *)arr {

    [self removeAllSubviews];
    CGFloat value = ZP_Width-109-30*6;
    CGFloat superHeight = self.contentView.frame.size.height;
    for (int i = 0; i < arr.count; i ++) {
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if (value > 6 * 5) {
            but.frame = CGRectMake(i * 35,(superHeight-30)/2, 30, 30);
        } else if (value > 0) {
            but.frame = CGRectMake(i * (30 + value/5),(superHeight-30)/2, 30, 30);
        } else {
            but.frame = CGRectMake(i * (30 + value/5),(superHeight-(30 + value/5))/2, (30 + value/5), (30 + value/5));
        }
        
        [but setBackgroundImage:[UIImage imageNamed:@"bg_white_ball"] forState:UIControlStateNormal];
        [but setBackgroundImage:[UIImage imageNamed:@"bg_red_ball_receive"] forState:UIControlStateSelected];
        but.titleLabel.font = ZP_TrademarkFont;
        if ([arr[i] integerValue] > 99) {
            
            [but setTitle:[NSString stringWithFormat:@"%02ld",[arr[i] integerValue] - 99] forState:UIControlStateNormal];
            but.selected = YES;
        }else{
            [but setTitle:[NSString stringWithFormat:@"%02ld",[arr[i] integerValue]] forState:UIControlStateNormal];}
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//        but.titleEdgeInsets = UIEdgeInsetsMake(2.5, 2.5, 2.5, 2.5);
        [self.contentView addSubview:but];
        
    }
   
}


- (void)removeAllSubviews {
    //[self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    while (self.contentView.subviews.count) {
        if ([self.contentView.subviews.lastObject isEqual:_deleBut]) {
            return;
        }
        if ([self.contentView.subviews.lastObject isEqual:_jiajianVIEw]) {
            return;
        }
        [self.contentView.subviews.lastObject removeFromSuperview];
    }
}

@end

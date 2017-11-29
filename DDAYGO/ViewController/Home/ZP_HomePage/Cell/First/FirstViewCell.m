//
//  FirstViewCell.m
//  DDAYGO
//
//  Created by Login on 2017/9/12.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "FirstViewCell.h"
#import "PrefixHeader.pch"
#import "UIButton+UIButtonImageWithLable.h"
@implementation FirstViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:@"First"];
    if (self) {
        self.contentView.userInteractionEnabled = YES;
    }
    return self;
}
- (void)first:(NSString *)sup {
    NSArray * arr = @[@"精选商品",@"热销商品",@"升级套餐",@"限时抢购",@"选商品",@"销商品",@"级套餐",@"更多"];
    NSArray * arrar = @[@"button_7",@"button_1",@"button_2",@"button_4",@"button_5",@"button_6",@"button_4",@"button_3"];
    NSInteger num = 0;
    for (int z = 0; z <= 1; z ++) {
        UIView * view = [UIView new];
        view.backgroundColor = ZP_Graybackground;
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(5);
            make.top.equalTo(self).offset(ZP_Width/2/2-0.5); // 高
            make.height.mas_equalTo(1); // 高
            make.width.mas_offset(ZP_Width-5);
        }];
        
        for (int i = 0; i <= 3; i ++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * ZP_Width / 4 , z * ZP_Width / 4 , ZP_Width / 4 , ZP_Width / 4 )];
            button.backgroundColor = [UIColor whiteColor];
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 5, 0);
            if (z == 0) {
                [button setTitle:arr[i] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:arrar[i]] forState:UIControlStateNormal];
            }
            if (z == 1) {
                [button setTitle:arr[i + 4] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:arrar[i + 4]] forState:UIControlStateNormal];
            }
            button.titleLabel.font = ZP_titleFont;
            [button setTitleColor:ZP_textblack forState:UIControlStateNormal];
            button.tag = num;
            [button addTarget:self action:@selector(buttonType:) forControlEvents:UIControlEventTouchUpInside];
            [button resizeWithDistance:10];
            [self.contentView addSubview:button];
            num ++;
        }
    }
    
}

- (void)buttonType:(UIButton *)sender {
    
    self.firstBlock(sender.tag);
}

@end

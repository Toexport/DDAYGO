//
//  ThirdViewCell.m
//  DDAYGO
//
//  Created by Login on 2017/9/12.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ThirdViewCell.h"
#import "PrefixHeader.pch"
@implementation ThirdViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:@"Thirdcell"];
    if (self) {
        self.contentView.userInteractionEnabled = YES;
    }
    return self;
}
- (void)Third:(NSArray *)sup {
    
    NSInteger num = 0;
    for (int z = 0; z <= 4; z ++) {
        
        for (int i = 0; i <= 1; i ++) {
            UIView * titiView =[UIView new];
            [titiView setBackgroundColor:ZP_textWite];
            [self.contentView addSubview:titiView];
            [titiView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(0);
                make.top.equalTo(self).offset(0);
                make.width.mas_equalTo(ZP_Width);
                make.height.mas_equalTo(35);
            }];
            
            ZP_GeneralLabel * Titlelabel = [ZP_GeneralLabel initWithtextLabel:_Titlelabel.text textColor:ZP_textblack font:ZP_TooBarFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
            Titlelabel.text = NSLocalizedString(@"Select erchandise ach Month", nil);
            [titiView addSubview:Titlelabel];
            [self addSubview:titiView];
            [Titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(titiView).offset(10);
                make.left.equalTo(titiView).offset(5);
            }];
            _Titlelabel = Titlelabel;
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * ZP_Width / 2, z * 35 + 35 , ZP_Width / 2, 35)];
            imageView.tag = num;
            [imageView setImage:[UIImage imageNamed:@"Third"]];
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer  * singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttonType:)];
            [imageView addGestureRecognizer:singleTap];
            [self addSubview:imageView];
            num ++;
        }
    }
}

- (void)buttonType:(UITapGestureRecognizer *)tap {
    
    self.ThirdBlock(tap.view.tag);
}

@end

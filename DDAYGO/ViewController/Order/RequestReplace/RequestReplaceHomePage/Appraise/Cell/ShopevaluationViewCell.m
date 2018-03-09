//
//  ShopevaluationViewCell.m
//  DDAYGO
//
//  Created by Login on 2017/9/25.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ShopevaluationViewCell.h"
#import "PrefixHeader.pch"
#import "UIButton+UIButtonImageWithLable.h"
@implementation ShopevaluationViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:@"shopevaluation"];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.scoreButArray = [NSMutableArray array];
    //       商家图片
    UIImageView * merchantsImage = [UIImageView new];
    merchantsImage.image = [UIImage imageNamed:@"ic_evaluate_store"];
    [self.contentView addSubview:merchantsImage];
    [merchantsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(self).offset(5);
    }];
    _merchantsImage = merchantsImage;
    
    //         商家名字
    UILabel * merchantsLabel = [UILabel new];
    merchantsLabel.textAlignment = NSTextAlignmentLeft;
    [merchantsLabel setTextColor:ZP_Graybackground];
    merchantsLabel.textColor = [UIColor blackColor];
    merchantsLabel.font = ZP_stockFont;
    [self.contentView addSubview:merchantsLabel];
    [merchantsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.top.equalTo(self).offset(10);
    }];
    _merchantsLabel = merchantsLabel;
    
    //     横线
    UIView * view0 = [UIView new];
    view0.backgroundColor = ZP_Graybackground;
    [self.contentView addSubview:view0];
    [view0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(self).offset(35);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(ZP_Width);
    }];
    
    //    店铺评分
    UITextField * Storeratingstext = [UITextField new];
    Storeratingstext.textAlignment = NSTextAlignmentLeft;
    Storeratingstext.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    Storeratingstext.textColor = ZP_TypefaceColor;
    Storeratingstext.font = ZP_titleFont;
    Storeratingstext.delegate = self;
    Storeratingstext.placeholder = MyLocal(@"Are you satisfied with the service of the store?");
    [self.contentView addSubview:Storeratingstext];
    [Storeratingstext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(50);
        make.right.equalTo(self).offset(-15);
    }];
    _Storeratingstext = Storeratingstext;
    
    //    横线
    UIView * view1 = [UIView new];
    view1.backgroundColor = ZP_Graybackground;
    [self.contentView addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-50);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(ZP_Width);
    }];
    
    //    选择按钮
    UIButton * Anonymousbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [Anonymousbutton setTitle:MyLocal(@"anonymous") forState:UIControlStateNormal];
    Anonymousbutton.titleLabel.font = ZP_TooBarFont;
    [Anonymousbutton setTitleColor:ZP_TypefaceColor forState:UIControlStateNormal];
    Anonymousbutton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [Anonymousbutton setImage:[UIImage imageNamed:@"ic_Shopping_Choice_normal"] forState:UIControlStateNormal];
    [Anonymousbutton setImage:[UIImage imageNamed:@"ic_Shopping_Choice_pressed"] forState:UIControlStateSelected];
    Anonymousbutton.layer.masksToBounds = YES;
    Anonymousbutton.layer.cornerRadius = Anonymousbutton.frame.size.height/2;
    Anonymousbutton.layer.borderColor = [UIColor clearColor].CGColor;
    Anonymousbutton.layer.borderWidth = 1;
    [Anonymousbutton addTarget:self action:@selector(Anonymous:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:Anonymousbutton];
    [Anonymousbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(- 10);
        make.bottom.equalTo(self).offset(-15);
        make.width.mas_offset(80);
        make.height.mas_offset(20);
    }];
    _Anonymousbutton = Anonymousbutton;
    //    文字提示
    UILabel * PromptingLabel = [UILabel new];
    PromptingLabel.textAlignment = NSTextAlignmentLeft;
    PromptingLabel.textColor = ZP_TypefaceColor;
    PromptingLabel.font = ZP_TrademarkFont;
    PromptingLabel.text = NSLocalizedString(@"Your comments will be written anonymously.", nil);
    [self.contentView addSubview:PromptingLabel];
    [PromptingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self).offset(-15);
        
    }];
    
}
//   按钮
- (void)Shopevaluation:(NSArray *)Shopevaluation {
    NSInteger num = 0;
    for (int x = 0; x <= 0; x ++) {
        for (int i = 0; i <= 4; i ++) {
            UIButton * scoreBut = [UIButton buttonWithType:UIButtonTypeCustom];
            scoreBut.frame = CGRectMake(i * ZP_Width / 14 + 150, x * ZP_Width / 14 + 10 , ZP_Width / 14 - 65, 15);
            [scoreBut setImage:[UIImage imageNamed:@"ic_evaluate_star_normal"] forState:UIControlStateNormal];
            [scoreBut setImage:[UIImage imageNamed:@"ic_evaluate_star_pressed"] forState:UIControlStateSelected];
            scoreBut.tag = num;
            [scoreBut addTarget:self action:@selector(buttonType:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:scoreBut];
            _scoreBut = scoreBut;
            [self.scoreButArray addObject:scoreBut];
            num ++;
        }
    }
}

- (void)buttonType:(UIButton *)sender {
    
    self.ShopevaluationBlock(sender.tag);
    for (int i =0; i < self.scoreButArray.count; i ++) {
        [self.scoreButArray[i] setSelected:i <= sender.tag];
    }
}

- (void)Anonymous:(UIButton *)sender {
    _Anonymousbutton.selected = !_Anonymousbutton.selected;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.savaData) {
        self.savaData([textField.text stringByReplacingCharactersInRange:range withString:string]);
    }
    
    return YES;
}
@end

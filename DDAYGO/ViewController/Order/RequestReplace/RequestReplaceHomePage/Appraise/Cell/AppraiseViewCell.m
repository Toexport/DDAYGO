//
//  AppraiseViewCell.m
//  DDAYGO
//
//  Created by Login on 2017/9/22.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "AppraiseViewCell.h"
#import "PrefixHeader.pch"
#import "UIButton+UIButtonImageWithLable.h"
#import "ZP_OrderModel.h"
@implementation AppraiseViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:@"appraiseViewCell"];
    if (self) {
        [self initUI];
        self.contentView.userInteractionEnabled = YES;
        
    }
    return self;
}

- (void)initUI {
    self.scoreButArray = [NSMutableArray array];
//  主图
    UIImageView * FigureImage = [UIImageView new];
    [self.contentView addSubview:FigureImage];
    [FigureImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(self).offset(5);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(40);
    }];
    _FigureImage = FigureImage;
    
//  商品评分
    UILabel * EvaluationLabel = [UILabel new];
    EvaluationLabel.textAlignment = NSTextAlignmentLeft;
    EvaluationLabel.textColor = ZP_textblack;
    EvaluationLabel.text = NSLocalizedString(@"商品評分", nil);
    EvaluationLabel.font = ZP_stockFont;
    [self.contentView addSubview:EvaluationLabel];
    [EvaluationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(50);
        make.top.equalTo(self).offset(20);
        
    }];
    _EvaluationLabel = EvaluationLabel;
    
//  横线
    UIView * Horizontalview = [UIView new];
    Horizontalview.backgroundColor = ZP_Graybackground;
    [self.contentView addSubview:Horizontalview];
    [Horizontalview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(self).offset(50);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(ZP_Width);
    }];
    
//  产品评价
    UITextField * Evaluationtext = [UITextField new];
    Evaluationtext.textAlignment = NSTextAlignmentLeft;
    Evaluationtext.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    Evaluationtext.textColor = ZP_TypefaceColor;
    Evaluationtext.font = ZP_titleFont;
    Evaluationtext.placeholder = MyLocal(@"share placeholder");
    Evaluationtext.delegate = self;
    [self.contentView addSubview:Evaluationtext];
    [Evaluationtext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(65);
        make.right.equalTo(self).offset(-15);
    }];
    _Evaluationtext = Evaluationtext;
    
    //  下划线
    UIView * Underline1 = [UIView new];
    Underline1.layer.borderWidth = 1;
    Underline1.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [self.contentView addSubview:Underline1];
    [Underline1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(0);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(ZP_Width - 5);
     }];
}

//  按钮
- (void)score:(NSArray *)score {
    NSInteger num = 0;
    for (int x = 0; x <= 0; x ++) {
        for (int i = 0; i <= 4; i ++) {
            UIButton * scoreBut = [UIButton buttonWithType:UIButtonTypeCustom];
            scoreBut.frame = CGRectMake(i * ZP_Width / 14 + 150, x * ZP_Width / 14 + 20 , ZP_Width / 14 - 65, 15);
            [scoreBut setImage:[UIImage imageNamed:@"ic_evaluate_star_normal"] forState:UIControlStateNormal];
            [scoreBut setImage:[UIImage imageNamed:@"ic_evaluate_star_pressed"] forState:UIControlStateSelected];
            scoreBut.tag = num;
            scoreBut.layer.masksToBounds = YES;
            scoreBut.layer.cornerRadius = scoreBut.frame.size.height/2;
            scoreBut.layer.borderColor = [UIColor grayColor].CGColor;
            [scoreBut addTarget:self action:@selector(buttonType:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:scoreBut];
            _scoreBut = scoreBut;
            [self.scoreButArray addObject:scoreBut];
            num ++;
        }
    }
}

- (void)buttonType:(UIButton *)sender {
    self.scoreBlock(sender.tag);
    for (int i =0; i < self.scoreButArray.count; i ++) {
        [self.scoreButArray[i] setSelected:i <= sender.tag];
    }
}

//- (void)Appraise:(NSDictionary *)dic {
//    _FigureImage.image = [UIImage imageNamed:@"Shopping"];
//}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.savaData) {
        self.savaData([textField.text stringByReplacingCharactersInRange:range withString:string]);
    }
    
    return YES;
}

@end

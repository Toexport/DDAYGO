//
//  AnonymityViewCell.m
//  DDAYGO
//
//  Created by Login on 2017/9/25.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "ZP_AnonymityViewCell.h"
#import "PrefixHeader.pch"
@implementation ZP_AnonymityViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    static NSString * AnonymityViewID = @"anonymity";
    self = [super initWithStyle:style reuseIdentifier:AnonymityViewID];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
//  匿名买家
    UILabel * AnonymousLabel = [UILabel new];
    AnonymousLabel.textAlignment = NSTextAlignmentLeft;
    AnonymousLabel.textColor = ZP_textblack;
    AnonymousLabel.font = ZP_titleFont;
    AnonymousLabel.text = MyLocal(@"Anonymous purchase");
    [self.contentView addSubview:AnonymousLabel];
    [AnonymousLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-15);
    }];
    _AnonymousLabel = AnonymousLabel;
    
//  匿名买家按钮
    UIButton * AnonymousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [AnonymousButton setImage:[UIImage imageNamed:@"ic_Shopping_Choice_normal"] forState:UIControlStateNormal];
    [AnonymousButton setImage:[UIImage imageNamed:@"ic_Shopping_Choice_pressed"] forState:UIControlStateSelected];
    AnonymousButton.layer.masksToBounds = YES;
    AnonymousButton.layer.cornerRadius = AnonymousButton.frame.size.height/2;
    AnonymousButton.layer.borderColor = [UIColor clearColor].CGColor;
    [AnonymousButton addTarget:self action:@selector(AnonymousBut:) forControlEvents:UIControlEventTouchUpInside];
    AnonymousButton.layer.borderWidth = 1;
    [self.contentView addSubview:AnonymousButton];
    [AnonymousButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self).offset(-12.f);
    }];
    _AnonymousButton = AnonymousButton;
    
}

- (void)AnonymousBut:(UIButton * )sender {
    
    sender.selected = !sender.selected;
}
@end

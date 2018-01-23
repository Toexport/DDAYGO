//
//  EditorViewCell.m
//  DDAYGO
//
//  Created by Login on 2017/9/19.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "EditorViewCell.h"
#import "PrefixHeader.pch"
@implementation EditorViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    static NSString * EditorID = @"editorViewCell";
    self = [super initWithStyle:style reuseIdentifier:EditorID];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    //  选择按钮
    UIButton * button = [UIButton new];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = button.frame.size.height/2;
    button.layer.borderColor = [UIColor clearColor].CGColor;
    button.layer.borderWidth = 1;
    [button setImage:[UIImage imageNamed:@"ic_Shopping_Choice_normal"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"ic_Shopping_Choice_pressed"] forState:UIControlStateSelected];
    [self.contentView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(self).offset(45);
    }];
    _button = button;
    
//  主图
    UIImageView * Mainfigure = [UIImageView new];
    [self.contentView addSubview:Mainfigure];
    [Mainfigure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5); // 上
        make.left.equalTo(self).offset(30);  // 左
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(90);
    }];
    _Mainfigure = Mainfigure;
    
//  标题
    ZP_GeneralLabel * titleLabel = [ZP_GeneralLabel initWithtextLabel:_titleLabel.text textColor:ZP_TypefaceColor font:ZP_stockFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self.contentView addSubview:titleLabel];
    _titleLabel = titleLabel;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Mainfigure).offset(3);
        make.left.equalTo(Mainfigure).offset(95);
        make.right.equalTo(Mainfigure).offset(ZP_Width - 35 -95);
    }];
    
    //     商品介绍
    ZP_GeneralLabel * MerchandiseIntroducedLabel = [ZP_GeneralLabel initWithtextLabel:_MerchandiseIntroducedLabel.text textColor:ZP_TypefaceColor font:ZP_stockFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    MerchandiseIntroducedLabel.lineBreakMode = NSLineBreakByWordWrapping; //文字分行
    MerchandiseIntroducedLabel.numberOfLines = 0;
    [self.contentView addSubview:MerchandiseIntroducedLabel];
    _MerchandiseIntroducedLabel = MerchandiseIntroducedLabel;
    [MerchandiseIntroducedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel).offset(17);
        make.left.equalTo(Mainfigure).offset(95);
        make.right.equalTo(Mainfigure).offset(ZP_Width - 35 - 95);
    }];
    
//  商品颜色
    ZP_GeneralLabel * descLabel = [ZP_GeneralLabel initWithtextLabel:_descLabel.text textColor:ZP_TypefaceColor font:ZP_stockFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self.contentView addSubview:descLabel];
    _descLabel = descLabel;
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Mainfigure).offset(95);
        make.top.equalTo(titleLabel).offset(35);
//        make.width.mas_offset(50);
    }];
    
//  商品尺码
    ZP_GeneralLabel * SizeLabel = [ZP_GeneralLabel initWithtextLabel:_SizeLanbel.text textColor:ZP_TypefaceColor font:ZP_stockFont textAlignment:NSTextAlignmentLeft bakcgroundColor:ZP_WhiteColor];
    [self.contentView addSubview:SizeLabel];
    _SizeLanbel = SizeLabel;
    [SizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(descLabel).offset(40);
        make.top.equalTo(descLabel).offset(0);
    //        make.width.mas_offset(25);
    }];
    
//  背景
    UIView * backgroundView = [UIView new];
    backgroundView.layer.borderWidth = 1;
    backgroundView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [self.contentView addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Mainfigure).offset(95);
        make.top.equalTo(SizeLabel).offset(20);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
    }];
    
//  减少
    UIButton * Reducebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    Reducebutton.frame = CGRectMake(0, 0, 20, 20);
    [Reducebutton setImage:[UIImage imageNamed:@"ic_shopping_less"] forState:UIControlStateNormal];
    Reducebutton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    Reducebutton.layer.borderWidth = 1;
    [Reducebutton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:Reducebutton];
    _Reducebutton = Reducebutton;
    
//  个数
    UILabel * numLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 60, 20)];
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.textColor = [UIColor blackColor];
    numLabel.text = @"0";
    numLabel.font = [UIFont systemFontOfSize:14];
    [backgroundView addSubview:numLabel];
    _numLabel = numLabel;
    
//  添加
    UIButton * addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(80, 0, 20, 20);
    [addButton setImage:[UIImage imageNamed:@"ic_shopping_add"] forState:UIControlStateNormal];
    addButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    addButton.layer.borderWidth = 1;
    [addButton addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:addButton];
    _addButton = addButton;
    
//  分割线
    UIView * view1 = [UIView new];
    view1.backgroundColor = ZP_Graybackground;
    [self.contentView addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(100);
        make.right.equalTo(self).offset(ZP_Width); //长
        make.bottom.equalTo(self).offset(0); // 高
        make.height.mas_equalTo(1); // 高
    }];
}


- (void)cellWithModel:(ZP_CartsModel *)model {
    
    [_Mainfigure sd_setImageWithURL:[NSURL URLWithString:model.defaultimg] placeholderImage:nil];;
    _titleLabel.text = model.productname;
    _MerchandiseIntroducedLabel.text = model.productremark;
    _descLabel.text = [NSString stringWithFormat:@"顏色:%@,",model.colorname];
    _SizeLanbel.text = [NSString stringWithFormat:@"尺碼:%@",model.normname];
    _numLabel.text = [NSString stringWithFormat:@"%@",model.amount];
}

- (void)buttonClick:(UIButton *)sender {

    if ([_numLabel.text integerValue] <= 1) {
        [SVProgressHUD showErrorWithStatus:@"购买数量不能少于1"];
        _numLabel.text = @"1";
        return;
    }else {
        _numLabel.text = [NSString stringWithFormat:@"%ld",[_numLabel.text integerValue]-1];
        self.btnClickBlock(_numLabel.text);
    }
}

- (void)addClick:(UIButton *)sender {
    
    _numLabel.text = [NSString stringWithFormat:@"%ld",[_numLabel.text integerValue]+1];
    self.btnClickBlock(_numLabel.text);
}

//  筛选
- (void)ScreeningBut:(UIButton *)sender {
    NSLog(@"筛选");
}

@end


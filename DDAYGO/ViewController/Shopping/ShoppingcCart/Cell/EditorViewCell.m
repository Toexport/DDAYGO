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
        make.height.mas_equalTo(120-20);
    }];
    _Mainfigure = Mainfigure;
    
//  标题
    UILabel * titleLabel = [UILabel new];
    titleLabel.textColor = ZP_textblack;
    titleLabel.lineBreakMode = UILineBreakModeWordWrap; //文字分行
    titleLabel.numberOfLines = 0;
    titleLabel.font = ZP_stockFont;
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Mainfigure).offset(8);
        make.left.equalTo(Mainfigure).offset(85);
        make.right.equalTo(Mainfigure).offset(ZP_Width -30-85);
    }];
    _titleLabel = titleLabel;
    
//  颜色
    UILabel * descLabel = [UILabel new];
    descLabel.textColor = ZP_TabBarTextColor;
    descLabel.font = ZP_stockFont;
    [self.contentView addSubview:descLabel];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Mainfigure).offset(85); // 左
        make.top.equalTo(Mainfigure).offset(45);
        make.width.mas_offset(80);
    }];
    _descLabel = descLabel;
    
//  尺码
    ZP_GeneralLabel * SizeLabel = [ZP_GeneralLabel initWithtextLabel:_SizeLanbel.text textColor:ZP_TabBarTextColor font:ZP_stockFont textAlignment: NSTextAlignmentLeft bakcgroundColor:nil];
    [self.contentView addSubview: SizeLabel];
    [SizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(descLabel).offset(100);
        make.left.equalTo(Mainfigure).offset(45);
    }];
    _SizeLanbel = SizeLabel;
    
//  筛选按钮
    UIButton * ScreeningBut = [UIButton new];
    [ScreeningBut setImage:[UIImage imageNamed:@"ic_shop_down"] forState:UIControlStateNormal];
    ScreeningBut.layer.borderColor = [UIColor clearColor].CGColor;
    ScreeningBut.layer.borderWidth = 1;
    [ScreeningBut addTarget:self action:@selector(ScreeningBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:ScreeningBut];
    [ScreeningBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(descLabel).offset(90);
        make.top.equalTo(Mainfigure).offset(45);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
//  背景
    UIView * backgroundView = [UIView new];
    backgroundView.layer.borderWidth = 1;
    backgroundView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [self.contentView addSubview:backgroundView];
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(Mainfigure).offset(85);
        make.bottom.equalTo(self).offset(-23.5);
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

//- (void)cellWithDic:(NSDictionary *)dic {
//    
//    _titleLabel.text = dic[@"title"];
//    _descLabel.text = dic[@"desc"];
//    _Mainfigure.image = [UIImage imageNamed:@"Shopping"];
//    _numLabel.text = @"0";
//    
//}
- (void)cellWithModel:(ZP_CartsModel *)model {
    
    [_Mainfigure sd_setImageWithURL:[NSURL URLWithString:model.defaultimg] placeholderImage:nil];;
    _titleLabel.text = model.productremark;
    _descLabel.text = model.colorname;
    _numLabel.text = [NSString stringWithFormat:@"%@",model.amount];
    //    _SizeLabel.text = model.normname;
    //    _PreferentialLabel.text = [NSString stringWithFormat:@"RMB:%@",model.priceamount];
    //    _PriceLabel.text = [NSString stringWithFormat:@"RMB:%@",model.productprice];
    //    _TrademarkImage.image = [UIImage imageNamed:@"ic_cp"];
    //    _TrademarkLabel.text = [NSString stringWithFormat:@"%@",model.cp];
    //    _QuantityLabel.text = [NSString stringWithFormat:@"%@",model.amount];
}

- (void)buttonClick:(UIButton *)sender {
    if ([_numLabel.text integerValue]<=0) {
        _numLabel.text = @"0";
    }else {
        _numLabel.text = [NSString stringWithFormat:@"%ld",[_numLabel.text integerValue]-1];
    }
}

- (void)addClick:(UIButton *)sender {
    
    _numLabel.text = [NSString stringWithFormat:@"%ld",[_numLabel.text integerValue]+1];
}

//  筛选
- (void)ScreeningBut:(UIButton *)sender {
    NSLog(@"筛选");
}

@end


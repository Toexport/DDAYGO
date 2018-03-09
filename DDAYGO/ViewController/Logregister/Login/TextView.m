//
//  TextView.m
//  com
//
//  Created by lwq on 2016/11/11.
//  Copyright © 2016年 com.xssd. All rights reserved.
//

#import "TextView.h"
#import "UIView+SDAutoLayout.h"
#import "PrefixHeader.pch"
@implementation TextView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self viewSetup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self viewSetup];
    }
    return self;
}

-(void)viewSetup {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = MyLocal(@"title");
    //    _titleLabel.textColor = [UIColor colorWithHexString:fontGrey];
    [_titleLabel setFont:ZP_addBtnTextdetaFont];
    [self addSubview:_titleLabel];
    _titleLabel.hidden = YES;
    
    _textField = [[UITextField alloc]init];
    _textField.secureTextEntry = NO;
    _textField.borderStyle = UITextBorderStyleNone;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;  // 一键删除文字
    //    _textField.textColor = [UIColor colorWithHexString:mainFont];
    [_textField setFont:ZP_addBtnTextdetaFont];
    [self addSubview:_textField];
    
    _functionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (_btnTitle.length == 0) {
        [_functionBtn setTitle:MyLocal(@"Get verification code") forState:UIControlStateNormal];
        _functionBtn.layer.cornerRadius             = 8.0;
    }else
    {
        [_functionBtn setTitle:_btnTitle forState:UIControlStateNormal];
    }
    
    _functionBtn.titleLabel.font = ZP_addBtnTextdetaFont;
    [_functionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_functionBtn setBackgroundColor:[UIColor colorWithHexString:@"#fda855"]];
    _functionBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self addSubview:_functionBtn];
    
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = ZP_DeepBlue;
    [self addSubview:line];
    
    
    //    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //    self.layer.borderWidth = 1;
    
    _titleLabel.sd_layout
    .leftSpaceToView(self,10)
    .topSpaceToView(self,0)
    .heightRatioToView(self,1)
    .widthIs(95);
    
    _textField.sd_layout
    .leftSpaceToView(self,10)
    .rightSpaceToView(self,0)
    .topSpaceToView(self,0)
    .heightRatioToView(self,1);
    
    _functionBtn.sd_layout
    .rightSpaceToView(self,0)
    .heightRatioToView(self,1)
    .topSpaceToView(self,-8)
    .widthIs(80);
    
    
    line.sd_layout
    .leftSpaceToView(self, 0)
    .rightSpaceToView(self, 0)
    .bottomEqualToView(self)
    .heightIs(1);
}

-(void)setBtnColour:(UIColor *)btnColour {
    _btnColour = btnColour;
    _functionBtn.backgroundColor = btnColour;
}

-(void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    _titleLabel.text = titleStr;
    _textField.placeholder = titleStr;
}

-(void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0?true:false;
}

-(void)setTextFieldBGColour:(UIColor *)textFieldBGColour {
    _textFieldBGColour = textFieldBGColour;
    [_textField setBackgroundColor:textFieldBGColour];
}

-(void)setShowBtn:(BOOL)showBtn {
    _showBtn = showBtn;
    _functionBtn.hidden = showBtn;
    if (showBtn) {
        _textField.sd_layout
        .leftSpaceToView(self,10)
        .rightSpaceToView(self,0)
        .topSpaceToView(self,0)
        .heightRatioToView(self,1);
        
        _functionBtn.sd_layout
        .rightSpaceToView(self,0)
        .heightRatioToView(self,1)
        .topSpaceToView(self,0)
        .widthIs(80);
    }else
    {
        _textField.sd_layout
        .leftSpaceToView(self,10)
        .rightSpaceToView(_functionBtn,5)
        .topSpaceToView(self,0)
        .heightRatioToView(self,1);
        
        _functionBtn.sd_layout
        .rightSpaceToView(self,0)
        .heightRatioToView(self,1)
        .topSpaceToView(self,0)
        .widthIs(80);
    }
    [self layoutSubviews];
}

-(void)setSecureTextEntry:(BOOL)secureTextEntry
{
    _secureTextEntry = secureTextEntry;
    _textField.secureTextEntry = secureTextEntry;
}

-(void)setKeyboardType:(NSInteger)keyboardType
{
    _textField.keyboardType = keyboardType;
}

-(void)setShowEyeBtn:(BOOL)showEyeBtn
{
    _showEyeBtn = showEyeBtn;
    if (showEyeBtn) {
        _textField.sd_layout
        .leftSpaceToView(self,10)
        .rightSpaceToView(_functionBtn,5)
        .topSpaceToView(self,0)
        .heightRatioToView(self,1);
        
        _functionBtn.sd_layout
        .rightSpaceToView(self,10)
        .heightRatioToView(self,1)
        .topSpaceToView(self,0)
        .widthIs(30);
        
        [_functionBtn setTitle:@"" forState:UIControlStateNormal];
        [_functionBtn setBackgroundColor:[UIColor clearColor]];
        [_functionBtn setImage:[UIImage imageNamed:@"ic_login_close.png"] forState:UIControlStateNormal];
    }
    [self layoutSubviews];
}

@end

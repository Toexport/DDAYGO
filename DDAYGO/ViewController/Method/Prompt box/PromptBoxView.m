//
//  PromptBoxView.m
//  DDAYGO
//
//  Created by Summer on 2018/3/8.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "PromptBoxView.h"
#import "PrefixHeader.pch"

@interface PromptBoxView ()
@property (nonatomic, strong) UIView * backgroundView;
@property (nonatomic, strong) UIView * titleView;
@property (nonatomic, strong) UIImageView * iconImageView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * messageLabel;

@property (nonatomic, strong) NSMutableArray * buttonArray;
@property (nonatomic, strong) NSMutableArray * buttonTitleArray;

@end

CGFloat contentViewWidth;
CGFloat contentViewHeight;

@implementation PromptBoxView
#pragma mark ---- 初始化
// 初始化
- (instancetype)init {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.backgroundColor = [UIColor clearColor];
        
        _backgroundView = [[UIView alloc]initWithFrame:self.frame];
        _backgroundView.backgroundColor = [UIColor blackColor];
        [self addSubview:_backgroundView];
    }
    return self;
}
#pragma mark ---- 初始化样式
// 初始化样式
- (instancetype)initWithTitlt:(NSString *)title icon:(UIImage *)icon message:(NSString *)message delegate:(id<PromptBoxViewDelegate>)delegate buttonTitles:(NSString *)buttonTitles, ... {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        _icon = icon;
        _title = title;
        _message = message;
        _delegate = delegate;
        _buttonArray = [NSMutableArray array];
        _buttonTitleArray = [NSMutableArray array];
        
//        在C中，当我们无法列出传递函数的所有实参的类型和数目，可以用省略号指定参数表，下面就是为了实现方法中"..."的效果
        va_list args;
        va_start(args, buttonTitles);
        if (buttonTitles) {
            [_buttonTitleArray addObject:buttonTitles];
            while (1) {
                NSString * otherButtonTitle = va_arg(args, NSString *);
                if (otherButtonTitle == nil) {
                    break;
                }else {
                    [_buttonTitleArray addObject:otherButtonTitle];
                }
            }
        }
        va_end(args);
        self.backgroundColor = [UIColor clearColor];
        
        _backgroundView = [[UIView alloc]initWithFrame:self.frame];
        _backgroundView.backgroundColor = [UIColor blackColor];
        [self addSubview:_backgroundView];
        [self initContentView];
    }
    return self;
}

#pragma mark -- 设置各类数据
- (void)setContentView:(UIView *)contentView {
    _contentView = contentView;
    _contentView.center = self.center;
    [self addSubview:_contentView];
}
- (void)setTitle:(NSString *)title {
    _title = title;
    [self initContentView];
}
- (void)setIcon:(UIImage *)icon {
    _icon = icon;
    [self initContentView];
}
- (void)setMessage:(NSString *)message {
    _message = message;
    [self initContentView];
}

#pragma mark -- 初始化设计对应的视图样式
- (void)initContentView {
    contentViewWidth = 280 * self.frame.size.width / 320;
    contentViewHeight = MARGIN_TOP;
    
    _contentView = [[UIView alloc]init];
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.layer.cornerRadius = 5.0;
    _contentView.layer.masksToBounds = YES;
    
    [self initTitleAndIcon];
    [self initMessage];
    [self initAllButtons];
    _contentView.frame = CGRectMake(0, 0, contentViewWidth, contentViewHeight);
    _contentView.center = self.center;
    [self addSubview:_contentView];
}

- (void)initTitleAndIcon {
    _titleView = [[UIView alloc]init];
    if (_icon != nil) {
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.image = _icon;
        _iconImageView.frame = CGRectMake(0, 0, 50, 50);
        [_titleView addSubview:_iconImageView];
    }
    CGSize titleSize = [self getTitleSize];
    if (_title != nil && ![_title isEqualToString:@""]) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = _title;
        _titleLabel.textColor = RGBA(28, 28, 28, 1.0);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:TITLE_FONT_SIZE];
        _titleLabel.numberOfLines = 0;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.frame = CGRectMake(_iconImageView.frame.origin.x + _iconImageView.frame.size.width + SPACE_SMALL, 1,titleSize.width , 50);
        [_titleView addSubview:_titleLabel];
    }
    
    _titleLabel.frame = CGRectMake(0, MARGIN_TOP, _iconImageView.frame.size.width + SPACE_SMALL + titleSize.width, MAX(_iconImageView.frame.size.height, 50));
    _titleView.center = CGPointMake(contentViewWidth / 2, MARGIN_TOP + _titleView.frame.size.height / 2);
    contentViewHeight += _titleView.frame.size.height;
}

- (void)initMessage {
    if (_message != nil) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.text = _message;
        _messageLabel.textColor = RGBA(120, 120, 120, 1.0);
        _messageLabel.numberOfLines = 0;
        _messageLabel.font = [UIFont systemFontOfSize:MESSAGE_FONT_SIZE];
        
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineSpacing = MESSAGE_LINE_SPACE;
        NSDictionary * attributes = @{NSParagraphStyleAttributeName:paragraphStyle};
       _messageLabel.attributedText = [[NSAttributedString alloc]initWithString:_message attributes:attributes];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        
        CGSize messageSize = [self getMessageSize];
       _messageLabel.frame = CGRectMake(MARGIN_LEFT_LARGE, _titleView.frame.origin.y + _titleView.frame.size.height + SPACE_LARGE, MAX(contentViewWidth - MARGIN_LEFT_LARGE - MARGIN_RIGHT_LARGE, messageSize.width), messageSize.height);
        [_contentView addSubview:_messageLabel];
        contentViewHeight += SPACE_LARGE + _messageLabel.frame.size.height;
    }
}

- (void)initAllButtons {
    if (_buttonTitleArray.count > 0) {
        contentViewHeight += SPACE_LARGE + 45;
       UIView * horizonSperatorView = [[UIView alloc]initWithFrame:CGRectMake(0, _messageLabel.frame.origin.y + _messageLabel.frame.size.height + SPACE_LARGE, contentViewWidth, 1)];
        horizonSperatorView.backgroundColor = RGBA(218, 218, 218, 1.0);
        [_contentView addSubview:horizonSperatorView];
        
        CGFloat buttonWidth = contentViewWidth / _buttonTitleArray.count;
        for (NSString * buttonTitle in _buttonTitleArray) {
            NSInteger index = [_buttonTitleArray indexOfObject:buttonTitle];
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(index * buttonWidth, horizonSperatorView.frame.origin.y + horizonSperatorView.frame.size.height, buttonWidth, 44)];
            button.titleLabel.font = [UIFont systemFontOfSize:BUTTON_FONT_SIZE];
            [button setTitle:buttonTitle forState:UIControlStateNormal];
            [button setTitleColor:RGBA(70, 130, 180, 1.0) forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonWithPressed:) forControlEvents:UIControlEventTouchUpInside];
            [_buttonArray addObject:button];
            [_contentView addSubview:button];
            
            if (index < _buttonTitleArray.count - 1) {
                UIView * verticalSeperatorView = [[UIView alloc]initWithFrame:CGRectMake(button.frame.origin.x + button.frame.size.width, button.frame.origin.y, 1, button.frame.size.height)];
                verticalSeperatorView.backgroundColor = RGBA(218, 218, 222, 1.0);
                [_contentView addSubview:verticalSeperatorView];
            }
        }
    }
}

#pragma mark -- 获取个控件Size大小
- (CGSize)getTitleSize {
    UIFont * font = [UIFont systemFontOfSize:TITLE_FONT_SIZE];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary * attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize size = [_title boundingRectWithSize:CGSizeMake(contentViewWidth - (MARGIN_LEFT_SMALL + MARGIN_LEFT_SMALL + _iconImageView.frame.size.width + SPACE_SMALL), 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    size.width = ceil(self.width);
    size.height = ceil(self.height);
    return size;
}

- (CGSize)getMessageSize {
    UIFont * font = [UIFont systemFontOfSize:MESSAGE_FONT_SIZE];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = MESSAGE_LINE_SPACE;
    NSDictionary * attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
     CGSize size = [_message boundingRectWithSize:CGSizeMake(contentViewWidth - (MARGIN_LEFT_LARGE + MARGIN_RIGHT_LARGE), 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    size.width = ceil(self.width);
    size.height = ceil(self.height);
    
    return size;
}

#pragma mark -- 按钮点击执行代理方法
- (void)buttonWithPressed:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        NSInteger index = [_buttonTitleArray indexOfObject:button.titleLabel.text];
        [_delegate alertView:self clickedButtonAtIndex:index];
    }
    [self hide];
}

#pragma  mark -- 显示提示框
- (void)show {
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    NSArray * windowViews = [window subviews];
    if (windowViews && [windowViews count] > 0) {
        UIView * subView = [windowViews objectAtIndex:[windowViews count] - 1];
        for (UIView * aSubView in subView.subviews) {
            [aSubView.layer removeAllAnimations];
        }
        [subView addSubview:self];
        [self showBackground];
        [self showAlertAnimation];
    }
}

#pragma mark -- 隐藏提示框
- (void)hide {
    _contentView.height = YES;
    [self hideAlertAnimation];
    [self removeFromSuperview];
}

#pragma mark -- 设置标题颜色和字体大小，默认为黑色字体，大小15
- (void)setTitleColor:(UIColor *)color fontSize:(CGFloat)size {
    if (color != nil) {
        _titleLabel.textColor = color;
    }
    if (size > 0) {
        _titleLabel.font = [UIFont systemFontOfSize:size];
    }
}

#pragma mark -- 设置内容颜色和字体大小，默认为黑色，大小13
- (void)setMessageColor:(UIColor *)color fontSize:(CGFloat)size {
    if (color != nil) {
        _messageLabel.textColor = color;
    }
    if (size > 0) {
        _messageLabel.font = [UIFont systemFontOfSize:size];
    }
}

#pragma mark -- 设置按钮字体颜色和字体大小，默认黑色，大小16
- (void)setButtonTitleColor:(UIColor *)color fontSize:(CGFloat)size atIndex:(NSInteger)index {
    UIButton * button = _buttonArray[index];
    if (color != nil) {
        [button setTitleColor:color forState:UIControlStateNormal];
    }
    if (size > 0) {
        button.titleLabel.font = [UIFont systemFontOfSize:size];
    }
}

#pragma mark -- 动画效果
- (void)showBackground {
    _backgroundView.alpha = 0;
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationDuration:0.35];
    _backgroundView.alpha = 0.6;
    [UIView commitAnimations];
}
- (void)showAlertAnimation {
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.30;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray * values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [_contentView.layer addAnimation:animation forKey:nil];
}
- (void) hideAlertAnimation {
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationDuration:0.35];
    _backgroundView.alpha = 0.0;
    [UIView commitAnimations];
}
@end

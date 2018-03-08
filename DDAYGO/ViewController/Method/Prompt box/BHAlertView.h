//
//  BHAlertView.h
//  DDAYGO
//
//  Created by Summer on 2018/3/8.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BHAlertViewDelegate;

@interface BHAlertView : UIView

@property (strong, nonatomic) UIView *contentView;//自定义内容View
@property (strong, nonatomic) UIImage *icon;//提示框图片
@property (strong, nonatomic) NSString *title;//提示框标题
@property (strong, nonatomic) NSString *message;//提示框内容
@property (weak, nonatomic) id<BHAlertViewDelegate> delegate;//代理

/***
 **初始化提示框样式
 **/
- (instancetype)initWithTitle:(NSString *)title icon:(UIImage *)icon message:(NSString *)message delegate:(id<BHAlertViewDelegate>)delegate buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/***
 **显示提示框
 **/
- (void)show;

/***
 **隐藏提示框
 **/
- (void)hide;

/***
 **设置标题的颜色和字体大小，默认为黑色，大小15
 **/
- (void)setTitleColor:(UIColor *)color fontSize:(CGFloat)size;

/***
 **设置内容的颜色和字体大小，默认为黑色，大小13
 **/
- (void)setMessageColor:(UIColor *)color fontSize:(CGFloat)size;

/***
 **设置按钮的字体颜色和字体大小，默认为黑色，大小16
 **/
- (void)setButtonTitleColor:(UIColor *)color fontSize:(CGFloat)size atIndex:(NSInteger)index;

@end

@protocol BHAlertViewDelegate <NSObject>

- (void)alertView:(BHAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

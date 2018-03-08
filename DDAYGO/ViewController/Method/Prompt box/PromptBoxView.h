//
//  PromptBoxView.h
//  DDAYGO
//
//  Created by Summer on 2018/3/8.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PromptBoxViewDelegate;

@interface PromptBoxView : UIView

@property (strong, nonatomic) UIView * contentView; //自定义内容View
@property (nonatomic, strong) UIImage * icon; // 提示框图片
@property (nonatomic, strong) NSString * title; // 提示框文字
@property (nonatomic, strong) NSString * message; // 提示框内容
@property (weak, nonatomic) id<PromptBoxViewDelegate> delegate; // 代理

/***
 **初始化提示框样式
 **/
- (instancetype)initWithTitlt:(NSString *)title icon:(UIImage *)icon message:(NSString *)message delegate:(id<PromptBoxViewDelegate>)delegate buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/***
 **显示提示框
 **/
- (void)show;

/***
 **隐藏提示框
 **/
- (void)hide;

/***
 **设置内容颜色和字体大小，默认为黑色，大小为15
 **/
- (void)setTitleColor:(UIColor *)color fontSize:(CGFloat)size;

/***
 **设置内容的颜色和字体大小，默认为黑色，大小13
 **/
- (void)setMessageColor:(UIColor *)color fontSize:(CGFloat)size;

/***
 **设置按钮的字体颜色和大小，默认为黑色，大小16
 **/
- (void) setButtonTitleColor:(UIColor *)color fontSize:(CGFloat)size atIndex:(NSInteger)index;

@end

@protocol PromptBoxViewDelegate <NSObject>

- (void)alertView:(PromptBoxView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end

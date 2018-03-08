//
//  PromptView.m
//  DDAYGO
//
//  Created by Summer on 2018/3/8.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "PromptView.h"
#import "PrefixHeader.pch"
@interface PromptView ()

@end

@implementation PromptView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self LineIsBusyMode];
}

#pragma  mark -- 互踢模式
- (void)LineIsBusyMode {
//    初始化对话框
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:MyLocal(@"Prompt") message:MyLocal(@"Your account has been logged in other places, you have been forced to go offline, please change the password as soon as possible if you are not logged in.") preferredStyle:UIAlertControllerStyleAlert];
//    确定
    _okAction = [UIAlertAction actionWithTitle:MyLocal(@"Cancel") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popToRootViewControllerAnimated:NO];
        //跳转
        if ([[[UIApplication sharedApplication] keyWindow].rootViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController * tbvc = [[UIApplication sharedApplication] keyWindow].rootViewController;
            [tbvc setSelectedIndex:0];
        }
    }];
//     取消
    _cancelAction = [UIAlertAction actionWithTitle:MyLocal(@"Determine") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popToRootViewControllerAnimated:NO];
        //跳转
        if ([[[UIApplication sharedApplication] keyWindow].rootViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController * tbvc = [[UIApplication sharedApplication] keyWindow].rootViewController;
            [tbvc setSelectedIndex:0];
        }
    }];
    [alert addAction:_okAction];
    [alert addAction:_cancelAction];
//    弹出对话框
    [self presentViewController:alert animated:true completion:nil];
}

@end

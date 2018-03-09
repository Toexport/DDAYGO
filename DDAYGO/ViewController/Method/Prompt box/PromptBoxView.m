//
//  PromptBoxView.m
//  DDAYGO
//
//  Created by Summer on 2018/3/9.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "PromptBoxView.h"
#import "PrefixHeader.pch"
@interface PromptBoxView ()

@end

@implementation PromptBoxView

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - 注销：弹出对话框
- (void) logouttt {
    // 初始化对话框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:MyLocal(@"Prompt") message:MyLocal(@"Your account has been logged in other places, you have been forced to go offline, please change the password as soon as possible if you are not logged in.") preferredStyle:UIAlertControllerStyleAlert];
    // 确定注销
    _okAction = [UIAlertAction actionWithTitle:MyLocal(@"Determine") style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        [self ClearANDJump];
    }];
    _cancelAction =[UIAlertAction actionWithTitle:MyLocal(@"Cancel") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self ClearANDJump];
    }];
    [alert addAction:_okAction];
    [alert addAction:_cancelAction];
    // 弹出对话框
    [self presentViewController:alert animated:true completion:nil];
}

//清除与跳转
- (void)ClearANDJump {
//        清除所有的数据
    Token = nil;
    DDAYGO_REMOVE_TOKEN; DDAYGO_REMOVE_SYMBOL; DDAYGO_REMOVE_COUNTRYCODE; DDAYGO_REMOVE_ICUETOKEN; DDAYGO_REMOVE_STATE; DDAYGO_REMOVE_HEADERIMAGE; DDAYGO_REMOVE_NAMELABEL; DD_ChangeStaus;
    ZPICUEToken = nil;
    [[SDImageCache sharedImageCache] clearDisk];
//        跳转到指定界面
    [self.navigationController popToRootViewControllerAnimated:NO];
    if ([[[UIApplication sharedApplication] keyWindow].rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController * tbvc = [[UIApplication sharedApplication] keyWindow].rootViewController;
        [tbvc setSelectedIndex:0];
    }
}

@end

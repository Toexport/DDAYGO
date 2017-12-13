//
//  LogregisterController.m
//  DDAYGO
//
//  Created by Login on 2017/10/17.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "LogregisterController.h"
#import "LoginController.h"
#import "RegisterController.h"
#import "PrefixHeader.pch"
#import "UINavigationBar+Awesome.h"
@interface LogregisterController ()

@end

@implementation LogregisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"登录 / 注册", nil);
    self.navigationController.navigationBar.hidden = NO;  //   隐藏navigationBar
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_WhiteColor}];   // 更改导航栏字体颜色
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

//  登录
- (IBAction)LoginAction:(id)sender {
    NSLog(@"登录");
    self.hidesBottomBarWhenPushed = YES;
    LoginController * loginViewController = [[LoginController alloc] init];
    [self.navigationController pushViewController:loginViewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.hidesBottomBarWhenPushed = YES;
}
//  注册
- (IBAction)RegAction:(id)sender {
    NSLog(@"注册");
     self.hidesBottomBarWhenPushed = YES;
    RegisterController * Register = [[RegisterController alloc] init];
    [self.navigationController pushViewController:Register animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
     self.hidesBottomBarWhenPushed = YES;
}

- (IBAction)QuickloginAction:(id)sender {
    NSLog(@"快速登录");
}

@end

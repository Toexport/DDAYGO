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
#import "ZP_QuickLoginController.h"
#import "PrefixHeader.pch"
#import "UINavigationBar+Awesome.h"

@interface LogregisterController ()
@property (weak, nonatomic) IBOutlet UIButton *ICUEQuicklogin;

@end

@implementation LogregisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Login/registration", nil);
    self.navigationController.navigationBar.hidden = NO;  //   隐藏navigationBar
    [self.navigationController.navigationBar lt_setBackgroundColor:ZP_NavigationCorlor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_WhiteColor}];   // 更改导航栏字体颜色
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    [_ICUEQuicklogin setTitle:MyLocal(@"Searchfavorite") forState:UIControlStateNormal];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(adjustStatusBar:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

//  登录
- (IBAction)LoginAction:(id)sender {
    NSLog(@"登录");
    LoginController * loginViewController = [[LoginController alloc] init];
    [self.navigationController pushViewController:loginViewController animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

//  注册
- (IBAction)RegAction:(id)sender {
    NSLog(@"注册");
    RegisterController * Register = [[RegisterController alloc] init];
    [self.navigationController pushViewController:Register animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}
// 快速登录
- (IBAction)QuickloginAction:(id)sender {
    NSLog(@"快速登录");
    ZP_QuickLoginController * Register = [[ZP_QuickLoginController alloc] init];
    [self.navigationController pushViewController:Register animated:YES];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];  // 隐藏返回按钮上的文字
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}

// 热点被接入，子类重写
- (void)adjustStatusBar:(NSNotification *)notification {
    NSValue * rectValue = [notification.userInfo objectForKey:UIApplicationStatusBarFrameUserInfoKey];
    CGRect statusRect = [rectValue CGRectValue];
    CGFloat height = statusRect.size.height;
    if (height > 20) {
        appD.window.frame = CGRectMake(0, 0, ZP_Width, ZP_height);
    }else{
        appD.window.frame = CGRectMake(0, 0, ZP_Width, ZP_height);
    }
}

@end

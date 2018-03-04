//
//  AboutDDAYGOController.m
//  DDAYGO
//
//  Created by Summer on 2018/1/17.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "AboutDDAYGOController.h"
#import "PrefixHeader.pch"
#import "RegistrationAgreementController.h"
@interface AboutDDAYGOController (){
    UIActivityIndicatorView *activityIndicator;
}

@end

@implementation AboutDDAYGOController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(adjustStatusBar:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

// UI
- (void)initUI {
    self.title = NSLocalizedString(@"About DDAYGO", nil) ;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_WhiteColor}];   // 更改导航栏字体颜色
    //此获取的版本号对应version，打印出来对应为1.2.3.4.5这样的字符串
    NSString * infodictionaray = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    ZPLog(@"%@",infodictionaray);
    self.VersionnumberLabel.text = [NSString stringWithFormat:@"%@",infodictionaray]; // 获取当前版本号
}

// 隐藏政策
- (IBAction)PrivacyPolicyBut:(id)sender {
    RegistrationAgreementController * RegistrationAgreement = [[RegistrationAgreementController alloc]init];
    RegistrationAgreement.title = MyLocal(@"Privacy policy");
    RegistrationAgreement.type = 111;
    [self.navigationController pushViewController:RegistrationAgreement animated:YES];
}

//服务条款
- (IBAction)termsServiceBut:(id)sender {
    RegistrationAgreementController * RegistrationAgreement = [[RegistrationAgreementController alloc]init];
    RegistrationAgreement.title = MyLocal(@"terms service");
    RegistrationAgreement.type = 222;
    [self.navigationController pushViewController:RegistrationAgreement animated:YES];
}

// 退换货流程
- (IBAction)ReturnProcessBut:(id)sender {
    RegistrationAgreementController * RegistrationAgreement = [[RegistrationAgreementController alloc]init];
    RegistrationAgreement.title = MyLocal(@"Return/replacement process.");
    RegistrationAgreement.type = 333;
    [self.navigationController pushViewController:RegistrationAgreement animated:YES];
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

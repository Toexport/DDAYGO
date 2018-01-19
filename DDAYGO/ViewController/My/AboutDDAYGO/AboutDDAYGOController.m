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
@interface AboutDDAYGOController ()

@end

@implementation AboutDDAYGOController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

// UI
- (void)initUI {
    self.title = NSLocalizedString(@"AboutDDAYGO", nil) ;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:ZP_WhiteColor}];   // 更改导航栏字体颜色
}
// 隐藏政策
- (IBAction)PrivacyPolicyBut:(id)sender {
    
    RegistrationAgreementController * RegistrationAgreement = [[RegistrationAgreementController alloc]init];
    [self.navigationController pushViewController:RegistrationAgreement animated:YES];
    
}

//服务条款
- (IBAction)termsServiceBut:(id)sender {
    RegistrationAgreementController * RegistrationAgreement = [[RegistrationAgreementController alloc]init];
    [self.navigationController pushViewController:RegistrationAgreement animated:YES];
}
// 退换货流程
- (IBAction)ReturnProcessBut:(id)sender {
    
}
@end

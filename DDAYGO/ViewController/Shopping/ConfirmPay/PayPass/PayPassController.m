//
//  PayPassController.m
//  DDAYGO
//
//  Created by Login on 2017/10/20.
//  Copyright © 2017年 Summer. All rights reserved.
//

#import "PayPassController.h"
#import "OrderViewController.h"
#import "PrefixHeader.pch"
@interface PayPassController ()

@end

@implementation PayPassController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =MyLocal(@"Pay success");
//    for (UIViewController * controller in self.navigationController.viewControllers) {
//        if ([controller isKindOfClass:[OrderViewController class]]) {
//            [self.navigationController popToViewController:controller animated:YES];
//        }
//    }
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(adjustStatusBar:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}
//- (void)viewWillAppear:(BOOL)animated {
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
//    [super viewWillAppear:animated];
//}
- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
    
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

//
//  RequestReplaceController.m
//  DDAYGO
//
//  Created by Summer on 2018/1/10.
//  Copyright © 2018年 Summer. All rights reserved.
//

#import "RequestReplaceController.h"
#import "RequestRefundController.h"
#import "PrefixHeader.pch"
@interface RequestReplaceController ()

@end

@implementation RequestReplaceController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(adjustStatusBar:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

// UI
- (void)initUI {
    self.title =MyLocal(@"Return/replacement");
}

// 退货退款
- (IBAction)RefundsRefunds:(id)sender {
    RequestRefundController * RequestReplace = [[RequestRefundController alloc]init];
    RequestReplace.oid = self.Oid; // 传过去的订单号
//    RequestReplace.titleStr = self.title;
    RequestReplace.type = 666;
    [self.navigationController pushViewController:RequestReplace animated:YES];
}

// 换货
- (IBAction)Exchange:(id)sender {
    RequestRefundController * RequestReplace = [[RequestRefundController alloc]init];
    RequestReplace.oid = self.Oid; // 传过去的订单号
//    RequestReplace.titleStr = self.title;
    RequestReplace.type = 555;
    [self.navigationController pushViewController:RequestReplace animated:YES];
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

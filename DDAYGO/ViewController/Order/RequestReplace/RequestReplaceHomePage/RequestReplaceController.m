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

@end
